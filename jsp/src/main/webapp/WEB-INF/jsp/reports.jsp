<%@ include file="/WEB-INF/jsp/includes/shell-open.jsp" %>
<section class="report-section">
  <header class="page-head">
    <div>
      <h1>Reports</h1>
      <p>View records for devices, provisioning, downloads, and signing.</p>
    </div>
  </header>
  <div class="report-grid">
    <a class="report-card" href="${ctx}/report/provisioning-report">
      <span class="report-icon">
        <svg viewBox="0 0 24 24" aria-hidden="true"><rect x="7" y="2" width="10" height="20" rx="2" /><path d="M11 18h2" /></svg>
        Provisioning Report
      </span>
      <span class="report-content">View provisioning records and status for all devices</span>
    </a>
    <a class="report-card" href="${ctx}/report/qdsdusage-report">
      <span class="report-icon">
        <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z" /><path d="M14 2v6h6M8 13h8M8 17h5" /></svg>
        QDSD Usage Report
      </span>
      <span class="report-content">View QDSD usage and signing activity</span>
    </a>
    <a class="report-card" href="${ctx}/report/device-report">
      <span class="report-icon">
        <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z" /><path d="M14 2v6h6M8 13h8M8 17h8" /></svg>
        Device Report
      </span>
      <span class="report-content">View device and secure element details</span>
    </a>
    <a class="report-card" href="${ctx}/report/failure-report">
      <span class="report-icon">
        <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 3l8 4v5c0 5-3.4 7.6-8 9-4.6-1.4-8-4-8-9V7z" /><path d="M12 8v4M12 16h.01" /></svg>
        Failure Report
      </span>
      <span class="report-content">View failed provisioning and usage records</span>
    </a>
    <a class="report-card" href="${ctx}/report/dsc-download-report">
      <span class="report-icon">
        <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 3v12" /><path d="M7 11l5 5 5-5" /><path d="M5 21h14" /></svg>
        DSC Download Report
      </span>
      <span class="report-content">DSC and token downloads with success, failure, and errors</span>
    </a>
    <a class="report-card" href="${ctx}/report/sign-report">
      <span class="report-icon">
        <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 20h9" /><path d="M16.5 3.5a2.1 2.1 0 0 1 3 3L8 18l-4 1 1-4z" /></svg>
        Signing Report
      </span>
      <span class="report-content">Signing activity with success, failure, and error details</span>
    </a>
  </div>
</section>
<%@ include file="/WEB-INF/jsp/includes/shell-close.jsp" %>
