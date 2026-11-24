package com.ascerten.backofficeapplication.repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class QdsdManagerRepository {

    @PersistenceContext
    private EntityManager entityManager;

    // Common date format: DD Mon YYYY, HH12:MI AM

    // Fetch QDSD Manager records
    public List<Object[]> getQdsdList() {

        String sql = """
            SELECT
                q.id,
                q.qdsd_id,
                cert.serial_number,
                s.name AS assigned_user,
                s.organization_name,
                ms.status AS pairing_status,

                CASE
                    WHEN cert.status = 1 THEN 'Downloaded'
                    WHEN latest_action.action_name = 'DSC Download Failed'
                        THEN 'Download Failed'
                    ELSE 'Pending'
                END AS download_status,

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
                END AS qdsd_status,

                TO_CHAR(
                    last_login.last_activity_at AT TIME ZONE 'Asia/Kolkata',
                    'DD Mon YYYY, HH12:MI AM'
                ) AS last_activity_at,

                CAST(
                    last_login.last_activity_at AT TIME ZONE 'Asia/Kolkata'
                    AS date
                ) AS last_activity_date

            FROM qdsd_details q

            JOIN master_qdsd_status ms
                ON ms.id = q.status

            LEFT JOIN mobile_device_details m
                ON m.id = q.mobile_device_id

            LEFT JOIN subscriber_details s
                ON s.id = m.subscriber_id

            LEFT JOIN LATERAL (
                SELECT
                    c.serial_number,
                    c.status
                FROM qdsd_downloaded_certificates c
                WHERE c.qdsd_id = q.id
                ORDER BY c.downloaded_date DESC NULLS LAST, c.id DESC
                LIMIT 1
            ) cert ON TRUE

            LEFT JOIN LATERAL (
                SELECT
                    a.action_name
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

            LEFT JOIN LATERAL (
                SELECT
                    MAX(login.last_activity_at) AS last_activity_at
                FROM qdsd_login login
                WHERE login.qdsd_id = q.id
            ) last_login ON TRUE

            ORDER BY q.id DESC
            """;

        return entityManager
                .createNativeQuery(sql)
                .getResultList();
    }


    // Fetch active pairing statuses from master_qdsd_status
    public List<String> getActivePairingStatuses() {

        String sql = """
            SELECT ms.status
            FROM master_qdsd_status ms
            WHERE ms.active = 1
            ORDER BY ms.id
            """;

        List<?> results = entityManager
                .createNativeQuery(sql)
                .getResultList();

        return results.stream()
                .map(String::valueOf)
                .toList();
    }


    // Fetch individual QDSD details
    public Object[] getQdsdDetailsById(Long id) {

        String sql = """
            SELECT
                q.id,
                q.qdsd_id,

                TO_CHAR(
                    q.created_date AT TIME ZONE 'Asia/Kolkata',
                    'DD Mon YYYY, HH12:MI AM'
                ) AS created_date,

                TO_CHAR(
                    q.updated_date AT TIME ZONE 'Asia/Kolkata',
                    'DD Mon YYYY, HH12:MI AM'
                ) AS updated_date,

                CAST(q.created_ip AS varchar),
                q.lifecycle,
                CAST(q.firmware_version AS varchar),
                CAST(q.binding_no AS varchar),
                CAST(q.policy_no_in_force AS varchar),
                CAST(q.keygen_counter AS varchar),
                CAST(q.sign_counter AS varchar),
                CAST(q.session_logged_in AS varchar),

                ms.status AS pairing_status,

                m.device_id,
                m.device_model,
                m.device_version,
                m.app_version,

                TO_CHAR(
                    m.created_date AT TIME ZONE 'Asia/Kolkata',
                    'DD Mon YYYY, HH12:MI AM'
                ) AS device_registered_date,

                s.name AS assigned_user,
                s.email_id,
                s.mobile_e164,
                s.organization_name,

                registration.requester_name,
                registration.organization AS registration_organization,
                registration.requested_hostname,
                CAST(registration.status AS varchar) AS registration_status,

                TO_CHAR(
                    registration.created_date AT TIME ZONE 'Asia/Kolkata',
                    'DD Mon YYYY, HH12:MI AM'
                ) AS pairing_requested_date,

                TO_CHAR(
                    registration.expires_at AT TIME ZONE 'Asia/Kolkata',
                    'DD Mon YYYY, HH12:MI AM'
                ) AS pairing_expiry_date,

                cert.serial_number,
                cert.certificate_type,
                CAST(cert.status AS varchar) AS certificate_status,

                TO_CHAR(
                    cert.downloaded_date AT TIME ZONE 'Asia/Kolkata',
                    'DD Mon YYYY, HH12:MI AM'
                ) AS downloaded_date,

                cert.downloaded_os,

                TO_CHAR(
                    cert.valid_from AT TIME ZONE 'Asia/Kolkata',
                    'DD Mon YYYY, HH12:MI AM'
                ) AS valid_from,

                TO_CHAR(
                    cert.valid_to AT TIME ZONE 'Asia/Kolkata',
                    'DD Mon YYYY, HH12:MI AM'
                ) AS valid_to,

                cert.issuer_name,
                cert.subscriber_name,
                CAST(cert.key_slot AS varchar),
                CAST(cert.keygen_seq AS varchar),

                CASE
                    WHEN cert.status = 1 THEN 'Downloaded'
                    WHEN latest_action.action_name = 'DSC Download Failed'
                        THEN 'Download Failed'
                    ELSE 'Pending'
                END AS download_status,

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

            LEFT JOIN mobile_device_details m
                ON m.id = q.mobile_device_id

            LEFT JOIN subscriber_details s
                ON s.id = m.subscriber_id

            LEFT JOIN LATERAL (
                SELECT
                    r.requester_name,
                    r.organization,
                    r.requested_hostname,
                    r.status,
                    r.created_date,
                    r.expires_at
                FROM qdsd_mobile_registration r
                WHERE r.qdsd_id = q.id
                ORDER BY r.created_date DESC NULLS LAST, r.id DESC
                LIMIT 1
            ) registration ON TRUE

            LEFT JOIN LATERAL (
                SELECT
                    c.serial_number,
                    c.certificate_type,
                    c.status,
                    c.downloaded_date,
                    c.downloaded_os,
                    c.valid_from,
                    c.valid_to,
                    c.issuer_name,
                    c.subscriber_name,
                    c.key_slot,
                    c.keygen_seq
                FROM qdsd_downloaded_certificates c
                WHERE c.qdsd_id = q.id
                ORDER BY c.downloaded_date DESC NULLS LAST, c.id DESC
                LIMIT 1
            ) cert ON TRUE

            LEFT JOIN LATERAL (
                SELECT
                    a.action_name
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

            WHERE q.id = :id
            """;

        List<?> results = entityManager
                .createNativeQuery(sql)
                .setParameter("id", id)
                .getResultList();

        if (results.isEmpty()) {
            return null;
        }

        return (Object[]) results.get(0);
    }


    // Fetch Download History for an individual QDSD
    // Includes successful and failed download workflow events.
    //
    // An attempt starts with an approval request, or with a download start
    // that was not preceded by a request/approval (pre-approved or approval
    // not required). Each attempt is stored by the Cloud API as one
    // qdsd_command row (kind 'DSC') whose envelope holds key=value lines
    // such as ca_name, requester_name, certificate_id and failure_reason.
    public List<Object[]> getDownloadHistoryByQdsdId(Long qdsdId) {

        String sql = """
            WITH download_events AS (

                SELECT
                    l.id,
                    l.qdsd_id,
                    l.created_date,
                    a.action_name,

                    LAG(a.action_name) OVER (
                        PARTITION BY l.qdsd_id
                        ORDER BY l.created_date ASC, l.id ASC
                    ) AS previous_action

                FROM qdsd_action_log l

                JOIN master_qdsd_action a
                    ON a.id = l.action_id

                WHERE l.qdsd_id = :qdsdId
                  AND a.action_name IN (
                      'DSC Download Approval Requested',
                      'DSC Download Approved',
                      'DSC Download Declined',
                      'DSC Download Started',
                      'DSC Installed',
                      'DSC Download Failed',
                      'DSC Download Approval Expired'
                  )
            ),

            numbered_events AS (

                SELECT
                    id,
                    qdsd_id,
                    created_date,
                    action_name,

                    SUM(
                        CASE
                            WHEN previous_action IS NULL THEN 1
                            WHEN action_name = 'DSC Download Approval Requested' THEN 1
                            WHEN action_name = 'DSC Download Started'
                                 AND previous_action NOT IN (
                                     'DSC Download Approval Requested',
                                     'DSC Download Approved'
                                 ) THEN 1
                            ELSE 0
                        END
                    ) OVER (
                        PARTITION BY qdsd_id
                        ORDER BY created_date ASC, id ASC
                    ) AS attempt_number

                FROM download_events
            )

            SELECT
                e.id,

                TO_CHAR(
                    e.created_date AT TIME ZONE 'Asia/Kolkata',
                    'DD Mon YYYY, HH12:MI AM'
                ) AS created_date,

                e.action_name AS status,

                COALESCE(
                    attempt.ca_name,
                    attempt_cert.issuer_name,
                    installed_cert.issuer_name
                ) AS ca_name,

                COALESCE(
                    attempt_cert.subscriber_name,
                    installed_cert.subscriber_name,
                    attempt.requester_name
                ) AS downloaded_by,

                e.attempt_number,

                CASE
                    WHEN e.action_name = 'DSC Download Failed'
                        THEN attempt.failure_reason
                END AS error_details

            FROM numbered_events e

            LEFT JOIN LATERAL (
                SELECT
                    NULLIF((regexp_match(fields.envelope_text, '(^|\\n)ca_name=([^\\n]*)'))[2], '')
                        AS ca_name,
                    NULLIF((regexp_match(fields.envelope_text, '(^|\\n)requester_name=([^\\n]*)'))[2], '')
                        AS requester_name,
                    NULLIF((regexp_match(fields.envelope_text, '(^|\\n)failure_reason=([^\\n]*)'))[2], '')
                        AS failure_reason,
                    NULLIF((regexp_match(fields.envelope_text, '(^|\\n)certificate_id=([0-9]+)'))[2], '')
                        AS certificate_id
                FROM qdsd_command c
                CROSS JOIN LATERAL (
                    SELECT convert_from(c.envelope, 'UTF8') AS envelope_text
                ) fields
                WHERE c.qdsd_id = e.qdsd_id
                  AND c.kind = 'DSC'
                  AND c.created_date <= e.created_date
                ORDER BY
                    c.created_date DESC,
                    c.id DESC
                LIMIT 1
            ) attempt ON TRUE

            LEFT JOIN qdsd_downloaded_certificates attempt_cert
                ON attempt_cert.id = CAST(attempt.certificate_id AS bigint)
               AND attempt_cert.qdsd_id = e.qdsd_id

            LEFT JOIN LATERAL (
                SELECT
                    c.issuer_name,
                    c.subscriber_name
                FROM qdsd_downloaded_certificates c
                WHERE c.qdsd_id = e.qdsd_id
                  AND c.downloaded_date IS NOT NULL
                  AND c.downloaded_date <= e.created_date
                ORDER BY
                    c.downloaded_date DESC,
                    c.id DESC
                LIMIT 1
            ) installed_cert ON e.action_name = 'DSC Installed'

            ORDER BY
                e.created_date DESC,
                e.id DESC
            """;

        return entityManager
                .createNativeQuery(sql)
                .setParameter("qdsdId", qdsdId)
                .getResultList();
    }


    // Fetch actual Signing History from qdsd_signing_details
    public List<Object[]> getSigningHistoryByQdsdId(Long qdsdId) {

        String sql = """
            SELECT
                sd.id,

                TO_CHAR(
                    COALESCE(sd.signed_date, sd.created_date)
                        AT TIME ZONE 'Asia/Kolkata',
                    'DD Mon YYYY, HH12:MI AM'
                ) AS signed_at,

                sd.doc_name AS document,
                CAST(sd.status AS varchar) AS status,
                sd.requester_name AS signed_by,
                sd.failure_reason AS error_details

            FROM qdsd_signing_details sd

            WHERE sd.qdsd_id = :qdsdId

            ORDER BY
                COALESCE(sd.signed_date, sd.created_date) DESC,
                sd.id DESC
            """;

        return entityManager
                .createNativeQuery(sql)
                .setParameter("qdsdId", qdsdId)
                .getResultList();
    }


    // Fetch Error Logs for an individual QDSD
    public List<Object[]> getErrorLogsByQdsdId(Long qdsdId) {

        String sql = """
            SELECT
                l.id,

                TO_CHAR(
                    l.created_date AT TIME ZONE 'Asia/Kolkata',
                    'DD Mon YYYY, HH12:MI AM'
                ) AS created_date,

                a.action_name AS status,
                CAST(l.created_ip AS varchar) AS ip_address,
                l.host_details

            FROM qdsd_action_log l

            JOIN master_qdsd_action a
                ON a.id = l.action_id

            WHERE l.qdsd_id = :qdsdId
              AND a.action_name IN (
                  'DSC Download Failed',
                  'Signing Failed'
              )

            ORDER BY
                l.created_date DESC,
                l.id DESC
            """;

        return entityManager
                .createNativeQuery(sql)
                .setParameter("qdsdId", qdsdId)
                .getResultList();
    }


    // Fetch Activity History for an individual QDSD
    public List<Object[]> getActivityHistoryByQdsdId(Long qdsdId) {

        String sql = """
            SELECT
                l.id,

                TO_CHAR(
                    l.created_date AT TIME ZONE 'Asia/Kolkata',
                    'DD Mon YYYY, HH12:MI AM'
                ) AS created_date,

                a.action_name AS activity,
                CAST(l.created_ip AS varchar) AS ip_address,
                l.host_details

            FROM qdsd_action_log l

            JOIN master_qdsd_action a
                ON a.id = l.action_id

            WHERE l.qdsd_id = :qdsdId

            ORDER BY
                l.created_date DESC,
                l.id DESC
            """;

        return entityManager
                .createNativeQuery(sql)
                .setParameter("qdsdId", qdsdId)
                .getResultList();
    }

}