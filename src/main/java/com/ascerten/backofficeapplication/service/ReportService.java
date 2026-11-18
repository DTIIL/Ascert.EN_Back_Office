
package com.ascerten.backofficeapplication.service;

import com.ascerten.backofficeapplication.dto.QdsdReportProjection;
import com.ascerten.backofficeapplication.dto.ReportRowProjection;
import com.ascerten.backofficeapplication.repository.QdsdDetailsRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReportService {

    private final QdsdDetailsRepository qdsdDetailsRepository;

    public ReportService(QdsdDetailsRepository qdsdDetailsRepository) {
        this.qdsdDetailsRepository = qdsdDetailsRepository;
    }

    public List<QdsdReportProjection> getQdsdReport() {
        return qdsdDetailsRepository.findQdsdReport();
    }

    public List<ReportRowProjection> getQdsdUsageReport() {
        return qdsdDetailsRepository.findQdsdUsageReport();
    }

    public List<ReportRowProjection> getDeviceReport() {
        return qdsdDetailsRepository.findDeviceReport();
    }

    public List<ReportRowProjection> getFailureReport() {
        return qdsdDetailsRepository.findFailureReport();
    }

    public List<ReportRowProjection> getDscDownloadReport() {
        return qdsdDetailsRepository.findDscDownloadReport();
    }

    public List<ReportRowProjection> getSigningReport() {
        return qdsdDetailsRepository.findSigningReport();
    }
}
