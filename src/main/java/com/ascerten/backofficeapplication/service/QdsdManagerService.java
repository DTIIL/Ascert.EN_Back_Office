
package com.ascerten.backofficeapplication.service;

import com.ascerten.backofficeapplication.dto.QdsdManagerResponse;
import com.ascerten.backofficeapplication.dto.QdsdDetailsResponse;
import com.ascerten.backofficeapplication.dto.DownloadHistoryResponse;
import com.ascerten.backofficeapplication.dto.SigningHistoryResponse;
import com.ascerten.backofficeapplication.dto.ErrorLogResponse;
import com.ascerten.backofficeapplication.dto.ActivityHistoryResponse;
import com.ascerten.backofficeapplication.repository.QdsdManagerRepository;

import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@Service
public class QdsdManagerService {

    private final QdsdManagerRepository qdsdManagerRepository;

    private static final DateTimeFormatter DATE_FORMAT =
            DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a");

    public QdsdManagerService(QdsdManagerRepository qdsdManagerRepository) {
        this.qdsdManagerRepository = qdsdManagerRepository;
    }

    // Fetch QDSD Manager records
    public List<QdsdManagerResponse> getQdsdList() {

        List<Object[]> results =
                qdsdManagerRepository.getQdsdList();

        List<QdsdManagerResponse> qdsdList = new ArrayList<>();

        for (Object[] row : results) {

            Long id = toLong(row[0]);

            String qdsdId = toStringValue(row[1]);
            String serialNumber = toStringValue(row[2]);
            String assignedUser = toStringValue(row[3]);
            String organization = toStringValue(row[4]);
            String pairingStatus = toStringValue(row[5]);
            String downloadStatus = toStringValue(row[6]);
            String qdsdStatus = toStringValue(row[7]);

            String lastUsed = formatDate(row[8]);

            QdsdManagerResponse response =
                    new QdsdManagerResponse(
                            id,
                            qdsdId,
                            serialNumber,
                            assignedUser,
                            organization,
                            pairingStatus,
                            downloadStatus,
                            qdsdStatus,
                            lastUsed
                    );

            qdsdList.add(response);
        }

        return qdsdList;
    }

    // Fetch individual QDSD details
    public QdsdDetailsResponse getQdsdDetails(Long id) {

        Object[] row = qdsdManagerRepository.getQdsdDetailsById(id);

        if (row == null) {
            return null;
        }

        return new QdsdDetailsResponse(
                toLong(row[0]),
                toStringValue(row[1]),
                formatDate(row[2]),
                formatDate(row[3]),
                toStringValue(row[4]),
                toStringValue(row[5]),
                toStringValue(row[6]),
                toStringValue(row[7]),
                toStringValue(row[8]),
                toStringValue(row[9]),
                toStringValue(row[10]),
                toStringValue(row[11]),

                toStringValue(row[12]),

                toStringValue(row[13]),
                toStringValue(row[14]),
                toStringValue(row[15]),
                toStringValue(row[16]),
                formatDate(row[17]),

                toStringValue(row[18]),
                toStringValue(row[19]),
                toStringValue(row[20]),
                toStringValue(row[21]),

                toStringValue(row[22]),
                toStringValue(row[23]),
                toStringValue(row[24]),
                toStringValue(row[25]),
                formatDate(row[26]),
                formatDate(row[27]),

                toStringValue(row[28]),
                toStringValue(row[29]),
                toStringValue(row[30]),
                formatDate(row[31]),
                toStringValue(row[32]),
                formatDate(row[33]),
                formatDate(row[34]),
                toStringValue(row[35]),
                toStringValue(row[36]),
                toStringValue(row[37]),
                toStringValue(row[38]),

                // Calculated status fields
                toStringValue(row[39]),
                toStringValue(row[40])
        );
    }

    // Fetch Download History for an individual QDSD
    public List<DownloadHistoryResponse> getDownloadHistory(Long qdsdId) {

        List<Object[]> results =
                qdsdManagerRepository.getDownloadHistoryByQdsdId(qdsdId);

        List<DownloadHistoryResponse> historyList = new ArrayList<>();

        for (Object[] row : results) {

            DownloadHistoryResponse response =
                    new DownloadHistoryResponse(
                            toLong(row[0]),
                            formatDate(row[1]),
                            toStringValue(row[2]),
                            toStringValue(row[3]),
                            toStringValue(row[4]),
                            toLong(row[5]),
                            toStringValue(row[6])
                    );

            historyList.add(response);
        }

        return historyList;
    }

    // Fetch Error Logs for an individual QDSD
    public List<ErrorLogResponse> getErrorLogs(Long qdsdId) {

        List<Object[]> results =
                qdsdManagerRepository.getErrorLogsByQdsdId(qdsdId);

        List<ErrorLogResponse> errorLogList = new ArrayList<>();

        for (Object[] row : results) {

            ErrorLogResponse response =
                    new ErrorLogResponse(
                            toLong(row[0]),
                            formatDate(row[1]),
                            toStringValue(row[2]),
                            toStringValue(row[3]),
                            toStringValue(row[4])
                    );

            errorLogList.add(response);
        }

        return errorLogList;
    }

    // Fetch actual Signing History for an individual QDSD
    // Repository must return 6 columns in the same order as this mapping.
    public List<SigningHistoryResponse> getSigningHistory(Long qdsdId) {

        List<Object[]> results =
                qdsdManagerRepository.getSigningHistoryByQdsdId(qdsdId);

        List<SigningHistoryResponse> historyList = new ArrayList<>();

        for (Object[] row : results) {

            SigningHistoryResponse response =
                    new SigningHistoryResponse(
                            toLong(row[0]),
                            formatDate(row[1]),
                            toStringValue(row[2]),
                            toStringValue(row[3]),
                            toStringValue(row[4]),
                            toStringValue(row[5])
                    );

            historyList.add(response);
        }

        return historyList;
    }

    // Fetch Activity History for an individual QDSD
    public List<ActivityHistoryResponse> getActivityHistory(Long qdsdId) {

        List<Object[]> results =
                qdsdManagerRepository.getActivityHistoryByQdsdId(qdsdId);

        List<ActivityHistoryResponse> activityList = new ArrayList<>();

        for (Object[] row : results) {

            ActivityHistoryResponse response =
                    new ActivityHistoryResponse(
                            toLong(row[0]),
                            formatDate(row[1]),
                            toStringValue(row[2]),
                            toStringValue(row[3]),
                            toStringValue(row[4])
                    );

            activityList.add(response);
        }

        return activityList;
    }

    // Convert Object to Long
    private Long toLong(Object value) {

        return value != null
                ? ((Number) value).longValue()
                : null;
    }

    // Convert Object to String
    private String toStringValue(Object value) {

        return value != null ? value.toString() : null;
    }

    // Format date values
    private String formatDate(Object value) {

        if (value == null) {
            return null;
        }

        if (value instanceof Timestamp timestamp) {
            return timestamp.toLocalDateTime().format(DATE_FORMAT);
        }

        if (value instanceof LocalDateTime dateTime) {
            return dateTime.format(DATE_FORMAT);
        }

        if (value instanceof OffsetDateTime dateTime) {
            return dateTime.format(DATE_FORMAT);
        }

        if (value instanceof ZonedDateTime dateTime) {
            return dateTime.format(DATE_FORMAT);
        }

        return value.toString();
    }
}
