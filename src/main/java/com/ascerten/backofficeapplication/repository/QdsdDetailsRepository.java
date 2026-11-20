
package com.ascerten.backofficeapplication.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.ascerten.backofficeapplication.dto.ReportRowProjection;
import com.ascerten.backofficeapplication.dto.QdsdReportProjection;
import com.ascerten.backofficeapplication.entity.QdsdDetails;

@Repository
public interface QdsdDetailsRepository
        extends JpaRepository<QdsdDetails, Long> {

    @EntityGraph(attributePaths = {"status"})
    List<QdsdDetails> findAllByOrderByCreatedDateDesc();

    @EntityGraph(attributePaths = {"status"})
    Optional<QdsdDetails> findByQdsdId(String qdsdId);


    // QDSD Report
    @Query(value = """
            SELECT
                qd.id AS "qdsdRecordId",
                qd.qdsd_id AS "qdsdId",
                md.device_id AS "deviceId",
                md.device_model AS "deviceModel",
                qd.lifecycle AS "lifecycle",
                mqs.status AS "qdsdStatus",
                TO_CHAR(
                    COALESCE(qd.updated_date, qd.created_date)
                        AT TIME ZONE 'Asia/Kolkata',
                    'DD Mon YYYY, HH12:MI AM'
                ) AS "lastUpdate"
            FROM public.qdsd_details qd
            LEFT JOIN public.mobile_device_details md
                ON qd.mobile_device_id = md.id
            LEFT JOIN public.master_qdsd_status mqs
                ON qd.status = mqs.id
            ORDER BY qd.created_date DESC
            """, nativeQuery = true)
    List<QdsdReportProjection> findQdsdReport();


    // QDSD Usage Report
    @Query(value = """
        SELECT
            al.id AS "recordId",
            qd.qdsd_id AS "qdsdId",
            md.device_id AS "deviceId",
            md.device_model AS "deviceModel",
            mqa.action_name AS "actionName",
            TO_CHAR(
                al.created_date AT TIME ZONE 'Asia/Kolkata',
                'DD Mon YYYY, HH12:MI AM'
            ) AS "eventDate",
            NULL::varchar AS "status",
            NULL::varchar AS "subscriberName",
            NULL::varchar AS "organization",
            NULL::varchar AS "serialNumber",
            NULL::varchar AS "certificateType",
            NULL::varchar AS "transactionId",
            NULL::varchar AS "documentName",
            NULL::varchar AS "signingPlatform",
            NULL::varchar AS "signedDate",
            NULL::varchar AS "failureReason"
        FROM public.qdsd_action_log al
        JOIN public.master_qdsd_action mqa
            ON al.action_id = mqa.id
        LEFT JOIN public.qdsd_details qd
            ON al.qdsd_id = qd.id
        LEFT JOIN public.mobile_device_details md
            ON qd.mobile_device_id = md.id
        ORDER BY al.created_date DESC
        """, nativeQuery = true)
    List<ReportRowProjection> findQdsdUsageReport();


    // Device Report
    @Query(value = """
        SELECT
            md.id AS "recordId",
            qd.qdsd_id AS "qdsdId",
            md.device_id AS "deviceId",
            md.device_model AS "deviceModel",
            sd.name AS "subscriberName",
            sd.organization_name AS "organization",
            TO_CHAR(
                md.created_date AT TIME ZONE 'Asia/Kolkata',
                'DD Mon YYYY, HH12:MI AM'
            ) AS "eventDate",
            CASE md.status
                WHEN 1 THEN 'Active'
                WHEN 0 THEN 'Revoked'
                ELSE CAST(md.status AS varchar)
            END AS "status",
            NULL::varchar AS "actionName",
            NULL::varchar AS "serialNumber",
            NULL::varchar AS "certificateType",
            NULL::varchar AS "transactionId",
            NULL::varchar AS "documentName",
            NULL::varchar AS "signingPlatform",
            NULL::varchar AS "signedDate",
            NULL::varchar AS "failureReason"
        FROM public.mobile_device_details md
        LEFT JOIN public.subscriber_details sd
            ON md.subscriber_id = sd.id
        LEFT JOIN LATERAL (
            SELECT q.qdsd_id
            FROM public.qdsd_details q
            WHERE q.mobile_device_id = md.id
            ORDER BY q.created_date DESC
            LIMIT 1
        ) qd ON TRUE
        ORDER BY md.created_date DESC
        """, nativeQuery = true)
    List<ReportRowProjection> findDeviceReport();


    // Failure Report
    @Query(value = """
        SELECT
            al.id AS "recordId",
            qd.qdsd_id AS "qdsdId",
            md.device_id AS "deviceId",
            md.device_model AS "deviceModel",
            mqa.action_name AS "actionName",
            TO_CHAR(
                al.created_date AT TIME ZONE 'Asia/Kolkata',
                'DD Mon YYYY, HH12:MI AM'
            ) AS "eventDate",
            'Failure event'::varchar AS "status",
            NULL::varchar AS "subscriberName",
            NULL::varchar AS "organization",
            NULL::varchar AS "serialNumber",
            NULL::varchar AS "certificateType",
            NULL::varchar AS "transactionId",
            NULL::varchar AS "documentName",
            NULL::varchar AS "signingPlatform",
            NULL::varchar AS "signedDate",
            COALESCE(dsc.failure_reason, sig.failure_reason) AS "failureReason",
            al.created_date AS sort_date
        FROM public.qdsd_action_log al
        JOIN public.master_qdsd_action mqa
            ON al.action_id = mqa.id
        LEFT JOIN public.qdsd_details qd
            ON al.qdsd_id = qd.id
        LEFT JOIN public.mobile_device_details md
            ON qd.mobile_device_id = md.id
        LEFT JOIN LATERAL (
            SELECT NULLIF(
                       (regexp_match(
                           convert_from(c.envelope, 'UTF8'),
                           '(^|\\n)failure_reason=([^\\n]*)'
                       ))[2],
                       ''
                   ) AS failure_reason
            FROM public.qdsd_command c
            WHERE c.qdsd_id = al.qdsd_id
              AND c.kind = 'DSC'
              AND c.created_date <= al.created_date
            ORDER BY c.created_date DESC, c.id DESC
            LIMIT 1
        ) dsc ON mqa.action_name = 'DSC Download Failed'
        LEFT JOIN LATERAL (
            SELECT sd.failure_reason
            FROM public.qdsd_signing_details sd
            WHERE sd.qdsd_id = al.qdsd_id
              AND sd.status = 24
              AND sd.created_date <= al.created_date
            ORDER BY sd.created_date DESC, sd.id DESC
            LIMIT 1
        ) sig ON mqa.action_name = 'Signing Failed'
        WHERE mqa.action_name IN (
            'Pairing Failed',
            'Pairing Request Expired',
            'Pairing Declined',
            'DSC Download Failed',
            'Signing Failed'
        )

        UNION ALL

        SELECT
            qs.id AS "recordId",
            qd.qdsd_id AS "qdsdId",
            md.device_id AS "deviceId",
            md.device_model AS "deviceModel",
            'Signing failure'::varchar AS "actionName",
            TO_CHAR(
                qs.created_date AT TIME ZONE 'Asia/Kolkata',
                'DD Mon YYYY, HH12:MI AM'
            ) AS "eventDate",
            CAST(qs.status AS varchar) AS "status",
            qs.requester_name AS "subscriberName",
            qs.organization AS "organization",
            NULL::varchar AS "serialNumber",
            NULL::varchar AS "certificateType",
            qs.transaction_id AS "transactionId",
            qs.doc_name AS "documentName",
            qs.signing_platform AS "signingPlatform",
            NULL::varchar AS "signedDate",
            qs.failure_reason AS "failureReason",
            qs.created_date AS sort_date
        FROM public.qdsd_signing_details qs
        JOIN public.qdsd_details qd
            ON qs.qdsd_id = qd.id
        LEFT JOIN public.mobile_device_details md
            ON qd.mobile_device_id = md.id
        WHERE qs.failure_reason IS NOT NULL
        ORDER BY sort_date DESC
        """, nativeQuery = true)
    List<ReportRowProjection> findFailureReport();


    // DSC Download Report
    @Query(value = """
        WITH downloaded_certificates AS (
            SELECT
                cert.id,
                cert.qdsd_id,
                cert.serial_number,
                cert.certificate_type,
                cert.downloaded_date
            FROM public.qdsd_downloaded_certificates cert
            WHERE cert.status = 1
        ),

        failed_downloads AS (
            SELECT
                al.id AS action_record_id,
                al.qdsd_id,
                al.created_date
            FROM public.qdsd_action_log al
            JOIN public.master_qdsd_action mqa
                ON al.action_id = mqa.id
            WHERE mqa.action_name = 'DSC Download Failed'
        )

        SELECT
            cert.id AS "recordId",
            qd.qdsd_id AS "qdsdId",
            md.device_id AS "deviceId",
            md.device_model AS "deviceModel",
            cert.serial_number AS "serialNumber",
            cert.certificate_type AS "certificateType",
            'Downloaded'::varchar AS "status",
            TO_CHAR(
                cert.downloaded_date AT TIME ZONE 'Asia/Kolkata',
                'DD Mon YYYY, HH12:MI AM'
            ) AS "eventDate",
            NULL::varchar AS "subscriberName",
            NULL::varchar AS "organization",
            NULL::varchar AS "actionName",
            NULL::varchar AS "transactionId",
            NULL::varchar AS "documentName",
            NULL::varchar AS "signingPlatform",
            NULL::varchar AS "signedDate",
            NULL::varchar AS "failureReason",
            cert.downloaded_date AS sort_date
        FROM downloaded_certificates cert
        JOIN public.qdsd_details qd
            ON cert.qdsd_id = qd.id
        LEFT JOIN public.mobile_device_details md
            ON qd.mobile_device_id = md.id

        UNION ALL

        SELECT
            fd.action_record_id AS "recordId",
            qd.qdsd_id AS "qdsdId",
            md.device_id AS "deviceId",
            md.device_model AS "deviceModel",
            NULL::varchar AS "serialNumber",
            NULL::varchar AS "certificateType",
            'Download Failed'::varchar AS "status",
            TO_CHAR(
                fd.created_date AT TIME ZONE 'Asia/Kolkata',
                'DD Mon YYYY, HH12:MI AM'
            ) AS "eventDate",
            NULL::varchar AS "subscriberName",
            NULL::varchar AS "organization",
            'DSC Download Failed'::varchar AS "actionName",
            NULL::varchar AS "transactionId",
            NULL::varchar AS "documentName",
            NULL::varchar AS "signingPlatform",
            NULL::varchar AS "signedDate",
            NULL::varchar AS "failureReason",
            fd.created_date AS sort_date
        FROM failed_downloads fd
        JOIN public.qdsd_details qd
            ON fd.qdsd_id = qd.id
        LEFT JOIN public.mobile_device_details md
            ON qd.mobile_device_id = md.id

        ORDER BY sort_date DESC NULLS LAST
        """, nativeQuery = true)
    List<ReportRowProjection> findDscDownloadReport();


    // Signing Report
    @Query(value = """
        SELECT
            qs.id AS "recordId",
            qd.qdsd_id AS "qdsdId",
            md.device_id AS "deviceId",
            md.device_model AS "deviceModel",
            qs.transaction_id AS "transactionId",
            qs.doc_name AS "documentName",
            qs.signing_platform AS "signingPlatform",
            CAST(qs.status AS varchar) AS "status",
            TO_CHAR(
                qs.signed_date AT TIME ZONE 'Asia/Kolkata',
                'DD Mon YYYY, HH12:MI AM'
            ) AS "signedDate",
            TO_CHAR(
                qs.created_date AT TIME ZONE 'Asia/Kolkata',
                'DD Mon YYYY, HH12:MI AM'
            ) AS "eventDate",
            qs.requester_name AS "subscriberName",
            qs.organization AS "organization",
            qs.failure_reason AS "failureReason",
            NULL::varchar AS "actionName",
            NULL::varchar AS "serialNumber",
            NULL::varchar AS "certificateType"
        FROM public.qdsd_signing_details qs
        JOIN public.qdsd_details qd
            ON qs.qdsd_id = qd.id
        LEFT JOIN public.mobile_device_details md
            ON qd.mobile_device_id = md.id
        ORDER BY qs.created_date DESC
        """, nativeQuery = true)
    List<ReportRowProjection> findSigningReport();

}
