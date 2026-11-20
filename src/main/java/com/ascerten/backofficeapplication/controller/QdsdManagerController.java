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


import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Objects;
import java.util.stream.Collectors;


@Controller
public class QdsdManagerController {

    private static final int PAGE_SIZE = 12;


    // Values produced by the download_status CASE in QdsdManagerRepository
    private static final List<String> DOWNLOAD_STATUSES = List.of(
            "Downloaded",
            "Pending",
            "Download Failed"
    );


    // Values produced by the qdsd_status CASE in QdsdManagerRepository;
    // any other value is the raw lifecycle and is added from the data.
    private static final List<String> DERIVED_QDSD_STATUSES = List.of(
            "Ready",
            "Waiting for DSC",
            "Error",
            "Suspended",
            "Lost"
    );

    static final String INVALID_DATE_MESSAGE =
            "Enter dates as YYYY-MM-DD. The invalid date was not applied.";

    static final String DATE_RANGE_MESSAGE =
            "From Date cannot be later than To Date. The date filter was not applied.";


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
            @RequestParam(required = false) String pairingStatus,
            @RequestParam(required = false) String downloadStatus,
            @RequestParam(required = false) String qdsdStatus,
            @RequestParam(required = false) String fromDate,
            @RequestParam(required = false) String toDate,
            @RequestParam(required = false) String page) {

        // Get logged-in user details from session
        model.addAttribute("userName", session.getAttribute("loggedInUserName"));
        model.addAttribute("userRole", session.getAttribute("loggedInRoleName"));

        // Fetch all QDSD records
        List<QdsdManagerResponse> qdsdList = qdsdManagerService.getQdsdList();

        // Build filter options from the database and the loaded records
        List<String> pairingStatusOptions = qdsdManagerService.getPairingStatuses();
        List<String> qdsdStatusOptions = buildQdsdStatusOptions(qdsdList);

        // Validate selected filter values
        String selectedPairingStatus = validateStatus(pairingStatus, pairingStatusOptions);
        String selectedDownloadStatus = validateStatus(downloadStatus, DOWNLOAD_STATUSES);
        String selectedQdsdStatus = validateStatus(qdsdStatus, qdsdStatusOptions);

        // Validate date filters
        LocalDate parsedFromDate = parseDate(fromDate);
        LocalDate parsedToDate = parseDate(toDate);

        boolean invalidDate = (hasText(fromDate) && parsedFromDate == null)
                || (hasText(toDate) && parsedToDate == null);

        String dateError = null;
        boolean applyDateFilter = true;

        if (invalidDate) {
            dateError = INVALID_DATE_MESSAGE;
        }

        if (parsedFromDate != null
                && parsedToDate != null
                && parsedFromDate.isAfter(parsedToDate)) {

            dateError = DATE_RANGE_MESSAGE;
            applyDateFilter = false;
        }

        LocalDate filterFromDate = applyDateFilter ? parsedFromDate : null;
        LocalDate filterToDate = applyDateFilter ? parsedToDate : null;

        // Normalize search text
        String searchTerm = search == null ? "" : search.trim().toLowerCase(Locale.ROOT);

        // Search filtering
        if (!searchTerm.isEmpty()) {
            qdsdList = qdsdList.stream()
                    .filter(qdsd -> contains(qdsd.getQdsdId(), searchTerm)
                            || contains(qdsd.getSerialNumber(), searchTerm)
                            || contains(qdsd.getAssignedUser(), searchTerm)
                            || contains(qdsd.getOrganization(), searchTerm))
                    .collect(Collectors.toList());
        }

        // Pairing status filtering
        if (selectedPairingStatus != null) {
            qdsdList = qdsdList.stream()
                    .filter(qdsd -> selectedPairingStatus.equalsIgnoreCase(qdsd.getPairingStatus()))
                    .collect(Collectors.toList());
        }

        // Download status filtering
        if (selectedDownloadStatus != null) {
            qdsdList = qdsdList.stream()
                    .filter(qdsd -> selectedDownloadStatus.equalsIgnoreCase(qdsd.getDownloadStatus()))
                    .collect(Collectors.toList());
        }

        // QDSD status filtering
        if (selectedQdsdStatus != null) {
            qdsdList = qdsdList.stream()
                    .filter(qdsd -> selectedQdsdStatus.equalsIgnoreCase(qdsd.getQdsdStatus()))
                    .collect(Collectors.toList());
        }

        // Last Used date filtering (inclusive)
        if (filterFromDate != null || filterToDate != null) {
            qdsdList = qdsdList.stream()
                    .filter(qdsd -> {
                        LocalDate lastUsedDate = qdsd.getLastUsedDate();

                        // No Last Used date means the record does not match a date filter
                        if (lastUsedDate == null) {
                            return false;
                        }

                        if (filterFromDate != null && lastUsedDate.isBefore(filterFromDate)) {
                            return false;
                        }

                        if (filterToDate != null && lastUsedDate.isAfter(filterToDate)) {
                            return false;
                        }

                        return true;
                    })
                    .collect(Collectors.toList());
        }


        // Calculate pagination after applying all filters
        int totalRecords = qdsdList.size();
        int totalPages = (totalRecords + PAGE_SIZE - 1) / PAGE_SIZE;


        // Prevent invalid page numbers
        int currentPage = parsePage(page);

        if (totalPages == 0) {
            currentPage = 1;
        } else {
            currentPage = Math.max(1, Math.min(currentPage, totalPages));
        }


        int start = (currentPage - 1) * PAGE_SIZE;
        int end = Math.min(start + PAGE_SIZE, totalRecords);


        List<QdsdManagerResponse> paginatedList = qdsdList.subList(start, end);


        // Add data to JSP
        model.addAttribute("qdsdList", paginatedList);
        model.addAttribute("totalRecords", totalRecords);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("pageSize", PAGE_SIZE);

        model.addAttribute("searchTerm", search);

        // Preserve valid date input so the user can correct the range
        model.addAttribute("fromDate", parsedFromDate != null ? parsedFromDate.toString() : "");
        model.addAttribute("toDate", parsedToDate != null ? parsedToDate.toString() : "");
        model.addAttribute("dateError", dateError);

        // Filter options
        model.addAttribute("pairingStatusOptions", pairingStatusOptions);
        model.addAttribute("downloadStatusOptions", DOWNLOAD_STATUSES);
        model.addAttribute("qdsdStatusOptions", qdsdStatusOptions);

        // Preserve selected radio-button values
        model.addAttribute("selectedPairingStatus", selectedPairingStatus);
        model.addAttribute("selectedDownloadStatus", selectedDownloadStatus);
        model.addAttribute("selectedQdsdStatus", selectedQdsdStatus);

        return "qdsdmanager";
    }


    // QDSD Details Page
    @GetMapping("/qdsdmanager/details/{id}")
    public String qdsdDetails(
            @PathVariable Long id,
            HttpSession session,
            Model model) {

        // Get logged-in user details from session
        model.addAttribute("userName", session.getAttribute("loggedInUserName"));
        model.addAttribute("userRole", session.getAttribute("loggedInRoleName"));

        // Fetch QDSD details using database ID
        QdsdDetailsResponse qdsdDetails = qdsdManagerService.getQdsdDetails(id);

        // Handle nonexistent QDSD record
        if (qdsdDetails == null) {
            return "redirect:/qdsdmanager?error=notFound";
        }

        // Fetch Download History
        List<DownloadHistoryResponse> downloadHistory = qdsdManagerService.getDownloadHistory(id);

        // Fetch Signing History
        List<SigningHistoryResponse> signingHistory = qdsdManagerService.getSigningHistory(id);

        // Fetch Error Logs
        List<ErrorLogResponse> errorLogs = qdsdManagerService.getErrorLogs(id);

        // Fetch Activity History
        List<ActivityHistoryResponse> activityHistory = qdsdManagerService.getActivityHistory(id);

        // Add data to JSP
        model.addAttribute("qdsdDetails", qdsdDetails);
        model.addAttribute("downloadHistory", downloadHistory);
        model.addAttribute("signingHistory", signingHistory);
        model.addAttribute("errorLogs", errorLogs);
        model.addAttribute("activityHistory", activityHistory);

        return "qdsdmanager-details";
    }


    // Derived statuses first, then any raw lifecycle values present in the data
    private List<String> buildQdsdStatusOptions(List<QdsdManagerResponse> qdsdList) {

        List<String> options = new ArrayList<>(DERIVED_QDSD_STATUSES);

        qdsdList.stream()
                .map(QdsdManagerResponse::getQdsdStatus)
                .filter(Objects::nonNull)
                .filter(status -> !status.isBlank())
                .filter(status -> options.stream().noneMatch(status::equalsIgnoreCase))
                .distinct()
                .sorted(String.CASE_INSENSITIVE_ORDER)
                .forEach(options::add);

        return options;
    }


    // Parse yyyy-MM-dd; returns null for blank or invalid input
    private LocalDate parseDate(String value) {

        if (!hasText(value)) {
            return null;
        }

        try {
            return LocalDate.parse(value.trim());
        } catch (DateTimeParseException exception) {
            return null;
        }
    }


    // Parse the page number; invalid input falls back to the first page
    private int parsePage(String value) {

        if (!hasText(value)) {
            return 1;
        }

        try {
            return Integer.parseInt(value.trim());
        } catch (NumberFormatException exception) {
            return 1;
        }
    }


    private boolean hasText(String value) {
        return value != null && !value.isBlank();
    }


    // Validate one selected status against allowed values
    private String validateStatus(String selectedStatus, List<String> allowedStatuses) {

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
        return value != null && value.toLowerCase(Locale.ROOT).contains(searchTerm);
    }
}
