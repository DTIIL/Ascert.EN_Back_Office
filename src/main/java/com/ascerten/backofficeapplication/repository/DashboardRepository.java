
package com.ascerten.backofficeapplication.repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Repository;
import com.ascerten.backofficeapplication.enums.SubscriberStatus;
import com.ascerten.backofficeapplication.enums.SigningStatus;

import java.util.List;

@Repository
public class DashboardRepository {

    @PersistenceContext
    private EntityManager entityManager;

    // Subscriber statistics

    public Object[] getSubscriberCounts() {

        String sql = """
        SELECT
            COUNT(*) AS total_users,
            COUNT(*) FILTER (WHERE status = :activeStatus) AS active_users,
            COUNT(*) FILTER (WHERE status = :inactiveStatus) AS inactive_users,
            COUNT(*) FILTER (WHERE status = :pendingStatus) AS pending_users
        FROM subscriber_details
        """;

        return (Object[]) entityManager
                .createNativeQuery(sql)
                .setParameter("activeStatus", SubscriberStatus.ACTIVE.getCode())
                .setParameter("inactiveStatus", SubscriberStatus.INACTIVE.getCode())
                .setParameter("pendingStatus", SubscriberStatus.PENDING.getCode())
                .getSingleResult();
    }

    // QDSD pipeline statistics
    // The QDSD status rules must stay identical to QdsdManagerRepository.getQdsdList,
    // so these counts match the QDSD Manager "QDSD Status" filter
    // (Waiting for DSC, Error, Ready).
    public Object[] getQdsdPipelineCounts() {

        String sql = """
            WITH qdsd_state AS (
                SELECT
                    ms.status AS pairing_status,

                    CASE
                        WHEN ms.status = 'Suspended' THEN 'Suspended'
                        WHEN ms.status = 'Lost' THEN 'Lost'
                        WHEN q.lifecycle IN ('ACTIVE', 'BOUND', 'READY')
                             AND cert.status = 1 THEN 'Ready'
                        WHEN q.lifecycle IN ('ACTIVE', 'BOUND', 'READY')
                             AND latest_action.action_name = 'DSC Download Failed'
                            THEN 'Error'
                        WHEN q.lifecycle IN ('ACTIVE', 'BOUND', 'READY') THEN 'Waiting for DSC'
                        ELSE q.lifecycle
                    END AS qdsd_status

                FROM qdsd_details q

                JOIN master_qdsd_status ms
                    ON ms.id = q.status

                LEFT JOIN LATERAL (
                    SELECT c.status
                    FROM qdsd_downloaded_certificates c
                    WHERE c.qdsd_id = q.id
                    ORDER BY c.downloaded_date DESC NULLS LAST, c.id DESC
                    LIMIT 1
                ) cert ON TRUE

                LEFT JOIN LATERAL (
                    SELECT a.action_name
                    FROM qdsd_action_log l
                    JOIN master_qdsd_action a
                        ON a.id = l.action_id
                    WHERE l.qdsd_id = q.id
                      AND a.action_name IN (
                          'DSC Download Approval Requested',
                          'DSC Download Approved',
                          'DSC Download Declined',
                          'DSC Download Started',
                          'DSC Installed',
                          'DSC Download Failed',
                          'DSC Download Approval Expired'
                      )
                    ORDER BY l.created_date DESC NULLS LAST, l.id DESC
                    LIMIT 1
                ) latest_action ON TRUE
            )
            SELECT
                COUNT(*) FILTER (WHERE pairing_status = 'Paired'),
                COUNT(*) FILTER (WHERE qdsd_status = 'Waiting for DSC'),
                COUNT(*) FILTER (WHERE qdsd_status = 'Error'),
                COUNT(*) FILTER (WHERE qdsd_status = 'Ready')
            FROM qdsd_state
            """;

        return (Object[]) entityManager
                .createNativeQuery(sql)
                .getSingleResult();
    }

    // Rolling window of the last :days days including today, in India time.
    // window_start/window_end are the matching timestamptz bounds.
    private static final String LAST_N_DAYS = """
            WITH bounds AS (
                SELECT
                    (now() AT TIME ZONE 'Asia/Kolkata')::date AS today
            ),
            window_range AS (
                SELECT
                    CAST(today - (CAST(:days AS integer) - 1) AS timestamp)
                        AT TIME ZONE 'Asia/Kolkata' AS window_start,
                    CAST(today + 1 AS timestamp) AT TIME ZONE 'Asia/Kolkata' AS window_end,
                    today
                FROM bounds
            ),
            days AS (
                SELECT generate_series(
                    CAST(today - (CAST(:days AS integer) - 1) AS timestamp),
                    CAST(today AS timestamp),
                    INTERVAL '1 day'
                )::date AS day
                FROM window_range
            ),
            """;

    // Up to 7 days are labelled with the weekday (Wed); longer ranges use the
    // date (18 Nov) so the labels stay unique.
    private static final String DAILY_TOTALS = """
            SELECT
                CASE
                    WHEN CAST(:days AS integer) <= 7 THEN to_char(days.day, 'Dy')
                    ELSE to_char(days.day, 'DD Mon')
                END,
                COALESCE(counts.total, 0)
            FROM days
            LEFT JOIN counts
                ON days.day = counts.day
            ORDER BY days.day
            """;

    // Daily QDSD action counts for the last N days
    // This chart continues to use qdsd_action_log
    public List<Object[]> getWeeklyActionCounts(String actionName, int days) {

        String sql = LAST_N_DAYS + """
            counts AS (
                SELECT
                    (l.created_date AT TIME ZONE 'Asia/Kolkata')::date AS day,
                    COUNT(*) AS total
                FROM qdsd_action_log l
                JOIN master_qdsd_action a
                    ON a.id = l.action_id
                CROSS JOIN window_range w
                WHERE a.action_name = :actionName
                  AND l.created_date >= w.window_start
                  AND l.created_date < w.window_end
                GROUP BY 1
            )
            """ + DAILY_TOTALS;

        return entityManager
                .createNativeQuery(sql)
                .setParameter("actionName", actionName)
                .setParameter("days", days)
                .getResultList();
    }

    // Daily successful signing counts for the last N days
    // Uses qdsd_signing_details
    public List<Object[]> getWeeklySignatureCounts(int days) {

        String sql = LAST_N_DAYS + """
            counts AS (
                SELECT
                    (sd.signed_date AT TIME ZONE 'Asia/Kolkata')::date AS day,
                    COUNT(*) AS total
                FROM qdsd_signing_details sd
                CROSS JOIN window_range w
                WHERE sd.status = :successStatus
                  AND sd.signed_date IS NOT NULL
                  AND sd.signed_date >= w.window_start
                  AND sd.signed_date < w.window_end
                GROUP BY 1
            )
            """ + DAILY_TOTALS;

        return entityManager
                .createNativeQuery(sql)
                .setParameter("successStatus", SigningStatus.SUCCESS.getCode())
                .setParameter("days", days)
                .getResultList();
    }

    // Daily failed signing counts for the last N days
    // Uses qdsd_signing_details; same rule as the Failure Report signing rows
    public List<Object[]> getWeeklyFailureCounts(int days) {

        String sql = LAST_N_DAYS + """
            counts AS (
                SELECT
                    (sd.created_date AT TIME ZONE 'Asia/Kolkata')::date AS day,
                    COUNT(*) AS total
                FROM qdsd_signing_details sd
                CROSS JOIN window_range w
                WHERE sd.status = :failureStatus
                  AND sd.failure_reason IS NOT NULL
                  AND sd.created_date >= w.window_start
                  AND sd.created_date < w.window_end
                GROUP BY 1
            )
            """ + DAILY_TOTALS;

        return entityManager
                .createNativeQuery(sql)
                .setParameter("failureStatus", SigningStatus.FAILURE.getCode())
                .setParameter("days", days)
                .getResultList();
    }
}
