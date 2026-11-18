
package com.ascerten.backofficeapplication.controller;

import com.ascerten.backofficeapplication.dto.QdsdManagerResponse;
import com.ascerten.backofficeapplication.dto.QdsdDetailsResponse;
import com.ascerten.backofficeapplication.dto.DownloadHistoryResponse;
import com.ascerten.backofficeapplication.dto.SigningHistoryResponse;
import com.ascerten.backofficeapplication.dto.ErrorLogResponse;
import com.ascerten.backofficeapplication.dto.ActivityHistoryResponse;
import com.ascerten.backofficeapplication.service.QdsdManagerService;

import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Set;
import java.util.Locale;
import java.util.stream.Collectors;

@Controller
public class QdsdManagerController {

    private static final int PAGE_SIZE = 12;

    private static final Set<String> PAIRING_STATUSES = Set.of(
            "Paired",
            "Not Paired"
    );

    private static final Set<String> DOWNLOAD_STATUSES = Set.of(
            "Downloaded",
            "Pending",
            "Download Failed"
    );

    private static final Set<String> QDSD_STATUSES = Set.of(
            "Ready",
            "Waiting for DSC",
            "Error",
            "MANUFACTURING"
    );

    private final QdsdManagerService qdsdManagerService;

    public QdsdManagerController(QdsdManagerService qdsdManagerService) {
        this.qdsdManagerService = qdsdManagerService;
    }

    // QDSD Manager List Page
    @GetMapping("/qdsdmanager")
    public String qdsdManager(
            HttpSession session,
            Model model,

            @RequestParam(defaultValue = "") String search,

            @RequestParam(required = false)
            String pairingStatus,

            @RequestParam(required = false)
            String downloadStatus,

            @RequestParam(required = false)
            String qdsdStatus,

            @RequestParam(defaultValue = "1") int page) {

        // Get logged-in user details from session
        model.addAttribute(
                "userName",
                session.getAttribute("loggedInUserName")
        );

        model.addAttribute(
                "userRole",
                session.getAttribute("loggedInRoleName")
        );

        // Validate selected filter values
        String selectedPairingStatus =
                validateStatus(pairingStatus, PAIRING_STATUSES);

        String selectedDownloadStatus =
                validateStatus(downloadStatus, DOWNLOAD_STATUSES);

        String selectedQdsdStatus =
                validateStatus(qdsdStatus, QDSD_STATUSES);

        // Fetch all QDSD records
        List<QdsdManagerResponse> qdsdList =
                qdsdManagerService.getQdsdList();

        // Normalize search text
        String searchTerm = search == null
                ? ""
                : search.trim().toLowerCase(Locale.ROOT);

        // Search filtering
        if (!searchTerm.isEmpty()) {

            qdsdList = qdsdList.stream()
                    .filter(qdsd ->
                            contains(qdsd.getQdsdId(), searchTerm)
                                    || contains(qdsd.getSerialNumber(), searchTerm)
                                    || contains(qdsd.getAssignedUser(), searchTerm)
                                    || contains(qdsd.getOrganization(), searchTerm)
                    )
                    .collect(Collectors.toList());
        }

        // Pairing status filtering
        if (selectedPairingStatus != null) {

            qdsdList = qdsdList.stream()
                    .filter(qdsd ->
                            selectedPairingStatus.equalsIgnoreCase(
                                    qdsd.getPairingStatus()
                            )
                    )
                    .collect(Collectors.toList());
        }

        // Download status filtering
        if (selectedDownloadStatus != null) {

            qdsdList = qdsdList.stream()
                    .filter(qdsd ->
                            selectedDownloadStatus.equalsIgnoreCase(
                                    qdsd.getDownloadStatus()
                            )
                    )
                    .collect(Collectors.toList());
        }

        // QDSD status filtering
        if (selectedQdsdStatus != null) {

            qdsdList = qdsdList.stream()
                    .filter(qdsd ->
                            selectedQdsdStatus.equalsIgnoreCase(
                                    qdsd.getQdsdStatus()
                            )
                    )
                    .collect(Collectors.toList());
        }

        // Calculate pagination after applying all filters
        int totalRecords = qdsdList.size();

        int totalPages = (totalRecords + PAGE_SIZE - 1) / PAGE_SIZE;

        // Prevent invalid page numbers
        if (totalPages == 0) {
            page = 1;
        } else {
            page = Math.max(1, Math.min(page, totalPages));
        }

        int start = (page - 1) * PAGE_SIZE;
        int end = Math.min(start + PAGE_SIZE, totalRecords);

        List<QdsdManagerResponse> paginatedList =
                qdsdList.subList(start, end);

        // Add data to JSP
        model.addAttribute("qdsdList", paginatedList);
        model.addAttribute("totalRecords", totalRecords);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);

        model.addAttribute("searchTerm", search);

        // Preserve selected radio-button values
        model.addAttribute(
                "selectedPairingStatus",
                selectedPairingStatus
        );

        model.addAttribute(
                "selectedDownloadStatus",
                selectedDownloadStatus
        );

        model.addAttribute(
                "selectedQdsdStatus",
                selectedQdsdStatus
        );

        return "qdsdmanager";
    }

    // QDSD Details Page
    @GetMapping("/qdsdmanager/details/{id}")
    public String qdsdDetails(
            @PathVariable Long id,
            HttpSession session,
            Model model) {

        // Get logged-in user details from session
        model.addAttribute(
                "userName",
                session.getAttribute("loggedInUserName")
        );

        model.addAttribute(
                "userRole",
                session.getAttribute("loggedInRoleName")
        );

        // Fetch QDSD details using database ID
        QdsdDetailsResponse qdsdDetails =
                qdsdManagerService.getQdsdDetails(id);

        // Handle nonexistent QDSD record
        if (qdsdDetails == null) {
            return "redirect:/qdsdmanager?error=notFound";
        }

        // Fetch Download History
        List<DownloadHistoryResponse> downloadHistory =
                qdsdManagerService.getDownloadHistory(id);

        // Fetch Signing History
        List<SigningHistoryResponse> signingHistory =
                qdsdManagerService.getSigningHistory(id);

        // Fetch Error Logs
        List<ErrorLogResponse> errorLogs =
                qdsdManagerService.getErrorLogs(id);

        // Fetch Activity History
        List<ActivityHistoryResponse> activityHistory =
                qdsdManagerService.getActivityHistory(id);

        // Add data to JSP
        model.addAttribute("qdsdDetails", qdsdDetails);
        model.addAttribute("downloadHistory", downloadHistory);
        model.addAttribute("signingHistory", signingHistory);
        model.addAttribute("errorLogs", errorLogs);
        model.addAttribute("activityHistory", activityHistory);

        return "qdsdmanager-details";
    }

    // Validate one selected status against allowed values
    private String validateStatus(
            String selectedStatus,
            Set<String> allowedStatuses) {

        if (selectedStatus == null || selectedStatus.isBlank()) {
            return null;
        }

        String trimmedStatus = selectedStatus.trim();

        return allowedStatuses.stream()
                .filter(status -> status.equalsIgnoreCase(trimmedStatus))
                .findFirst()
                .orElse(null);
    }

    // Check whether a field contains the search text
    private boolean contains(String value, String searchTerm) {

        return value != null
                && value.toLowerCase(Locale.ROOT).contains(searchTerm);
    }
}
