
package com.ascerten.backofficeapplication.service;

import com.ascerten.backofficeapplication.dto.DashboardResponse;
import com.ascerten.backofficeapplication.repository.DashboardRepository;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class DashboardService {

    private final DashboardRepository dashboardRepository;

    public DashboardService(DashboardRepository dashboardRepository) {
        this.dashboardRepository = dashboardRepository;
    }

    public DashboardResponse getDashboardData() {

        // Fetch subscriber statistics
        Object[] users = dashboardRepository.getSubscriberCounts();

        // Fetch QDSD pipeline statistics
        Object[] qdsds = dashboardRepository.getQdsdPipelineCounts();

        // Fetch weekly chart data
        List<Object[]> activityRows =
                dashboardRepository.getWeeklyActionCounts("QDSD Paired");

        List<Object[]> signatureRows =
                dashboardRepository.getWeeklySignatureCounts();

        List<Object[]> failureRows =
                dashboardRepository.getWeeklyFailureCounts();

        // Prepare chart data
        List<String> labels = new ArrayList<>();
        List<Long> activity = new ArrayList<>();
        List<Long> signatures = new ArrayList<>();
        List<Long> failures = new ArrayList<>();

        for (int i = 0; i < activityRows.size(); i++) {

            labels.add((String) activityRows.get(i)[0]);

            activity.add(
                    ((Number) activityRows.get(i)[1]).longValue()
            );

            signatures.add(
                    ((Number) signatureRows.get(i)[1]).longValue()
            );

            failures.add(
                    ((Number) failureRows.get(i)[1]).longValue()
            );
        }

        // Create dashboard response
        return new DashboardResponse(

                // Subscriber statistics
                ((Number) users[0]).longValue(),
                ((Number) users[1]).longValue(),
                ((Number) users[2]).longValue(),
                ((Number) users[3]).longValue(),

                // QDSD pipeline statistics
                ((Number) qdsds[0]).longValue(),
                ((Number) qdsds[1]).longValue(),
                ((Number) qdsds[2]).longValue(),
                ((Number) qdsds[3]).longValue(),

                // Weekly chart data
                labels,
                activity,
                signatures,
                failures
        );
    }
}
