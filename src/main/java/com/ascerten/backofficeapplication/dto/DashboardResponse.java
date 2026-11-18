
package com.ascerten.backofficeapplication.dto;

import java.util.List;

public class DashboardResponse {

    private long totalUsers;
    private long activeUsers;
    private long inactiveUsers;
    private long pendingUsers;

    private long pairedQdsd;
    private long waitingForDsc;
    private long downloadFailed;
    private long ready;

    private List<String> chartLabels;
    private List<Long> qdsdActivity;
    private List<Long> signatures;
    private List<Long> failures;

    public DashboardResponse(
            long totalUsers,
            long activeUsers,
            long inactiveUsers,
            long pendingUsers,
            long pairedQdsd,
            long waitingForDsc,
            long downloadFailed,
            long ready,
            List<String> chartLabels,
            List<Long> qdsdActivity,
            List<Long> signatures,
            List<Long> failures) {

        this.totalUsers = totalUsers;
        this.activeUsers = activeUsers;
        this.inactiveUsers = inactiveUsers;
        this.pendingUsers = pendingUsers;

        this.pairedQdsd = pairedQdsd;
        this.waitingForDsc = waitingForDsc;
        this.downloadFailed = downloadFailed;
        this.ready = ready;

        this.chartLabels = chartLabels;
        this.qdsdActivity = qdsdActivity;
        this.signatures = signatures;
        this.failures = failures;
    }

    public long getTotalUsers() {
        return totalUsers;
    }

    public long getActiveUsers() {
        return activeUsers;
    }

    public long getInactiveUsers() {
        return inactiveUsers;
    }

    public long getPendingUsers() {
        return pendingUsers;
    }

    public long getPairedQdsd() {
        return pairedQdsd;
    }

    public long getWaitingForDsc() {
        return waitingForDsc;
    }

    public long getDownloadFailed() {
        return downloadFailed;
    }

    public long getReady() {
        return ready;
    }

    public List<String> getChartLabels() {
        return chartLabels;
    }

    public List<Long> getQdsdActivity() {
        return qdsdActivity;
    }

    public List<Long> getSignatures() {
        return signatures;
    }

    public List<Long> getFailures() {
        return failures;
    }
}
