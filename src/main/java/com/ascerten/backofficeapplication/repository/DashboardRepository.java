
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
    public Object[] getQdsdPipelineCounts() {

        String sql = """
            SELECT

                -- Paired QDSDs
                (
                    SELECT COUNT(*)
                    FROM qdsd_details q
                    JOIN master_qdsd_status s
                        ON s.id = q.status
                    WHERE s.status = 'Paired'
                ),

                -- DSC approval requests
                (
                    SELECT COUNT(DISTINCT l.qdsd_id)
                    FROM qdsd_action_log l
                    JOIN master_qdsd_action a
                        ON a.id = l.action_id
                    WHERE a.action_name = 'DSC Download Approval Requested'
                ),

                -- DSC download failures
                (
                    SELECT COUNT(DISTINCT l.qdsd_id)
                    FROM qdsd_action_log l
                    JOIN master_qdsd_action a
                        ON a.id = l.action_id
                    WHERE a.action_name = 'DSC Download Failed'
                ),

                -- Active downloaded certificates
                (
                    SELECT COUNT(DISTINCT qdsd_id)
                    FROM qdsd_downloaded_certificates
                    WHERE status = 1
                )
            """;

        return (Object[]) entityManager
                .createNativeQuery(sql)
                .getSingleResult();
    }

    // Weekly QDSD Activity counts
    // This chart continues to use qdsd_action_log
    public List<Object[]> getWeeklyActionCounts(String actionName) {

        String sql = """
            WITH days AS (
                SELECT generate_series(
                    date_trunc('week', CURRENT_DATE) - INTERVAL '7 days',
                    date_trunc('week', CURRENT_DATE) - INTERVAL '1 day',
                    INTERVAL '1 day'
                )::date AS day
            ),
            counts AS (
                SELECT
                    l.created_date::date AS day,
                    COUNT(*) AS total
                FROM qdsd_action_log l
                JOIN master_qdsd_action a
                    ON a.id = l.action_id
                WHERE a.action_name = :actionName
                  AND l.created_date >= date_trunc('week', CURRENT_DATE) - INTERVAL '7 days'
                  AND l.created_date < date_trunc('week', CURRENT_DATE)
                GROUP BY l.created_date::date
            )
            SELECT
                to_char(days.day, 'Dy'),
                COALESCE(counts.total, 0)
            FROM days
            LEFT JOIN counts
                ON days.day = counts.day
            ORDER BY days.day
            """;

        return entityManager
                .createNativeQuery(sql)
                .setParameter("actionName", actionName)
                .getResultList();
    }

    // Weekly successful signing counts
    // Uses qdsd_signing_details
    public List<Object[]> getWeeklySignatureCounts() {

        String sql = """
            WITH days AS (
                SELECT generate_series(
                    date_trunc('week', CURRENT_DATE) - INTERVAL '7 days',
                    date_trunc('week', CURRENT_DATE) - INTERVAL '1 day',
                    INTERVAL '1 day'
                )::date AS day
            ),
            counts AS (
                SELECT
                    signed_date::date AS day,
                    COUNT(*) AS total
                FROM qdsd_signing_details
                WHERE status = :successStatus
                  AND signed_date IS NOT NULL
                  AND signed_date >= date_trunc('week', CURRENT_DATE) - INTERVAL '7 days'
                  AND signed_date < date_trunc('week', CURRENT_DATE)
                GROUP BY signed_date::date
            )
            SELECT
                to_char(days.day, 'Dy'),
                COALESCE(counts.total, 0)
            FROM days
            LEFT JOIN counts
                ON days.day = counts.day
            ORDER BY days.day
            """;

        return entityManager
                .createNativeQuery(sql)
                .setParameter("successStatus", SigningStatus.SUCCESS.getCode())
                .getResultList();
    }

    // Weekly failed signing counts
    // Uses qdsd_signing_details
    public List<Object[]> getWeeklyFailureCounts() {

        String sql = """
            WITH days AS (
                SELECT generate_series(
                    date_trunc('week', CURRENT_DATE) - INTERVAL '7 days',
                    date_trunc('week', CURRENT_DATE) - INTERVAL '1 day',
                    INTERVAL '1 day'
                )::date AS day
            ),
            counts AS (
                SELECT
                    created_date::date AS day,
                    COUNT(*) AS total
                FROM qdsd_signing_details
                WHERE status = :failureStatus
                  AND failure_reason IS NOT NULL
                  AND created_date >= date_trunc('week', CURRENT_DATE) - INTERVAL '7 days'
                  AND created_date < date_trunc('week', CURRENT_DATE)
                GROUP BY created_date::date
            )
            SELECT
                to_char(days.day, 'Dy'),
                COALESCE(counts.total, 0)
            FROM days
            LEFT JOIN counts
                ON days.day = counts.day
            ORDER BY days.day
            """;

        return entityManager
                .createNativeQuery(sql)
                .setParameter("failureStatus", SigningStatus.FAILURE.getCode())
                .getResultList();
    }
}
