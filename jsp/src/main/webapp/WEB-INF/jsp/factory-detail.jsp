<%@ include file="/WEB-INF/jsp/includes/shell-open.jsp" %>
<section class="factory-details-page">
  <div class="detail-header-section">
    <a class="back-to-dashboard" href="${ctx}/factoryprovising">Back to provisioning</a>
    <span>Last update 12 Sep 2026 10:24 AM</span>
  </div>

  <div class="factory-page-title">
    <h1>Factory Provisioning Details</h1>
  </div>

  <div class="summary-card">
    <div class="flex">
      <div class="content"><span>Device Id</span><span class="body-span">DTIIOO1</span></div>
      <div class="content"><span>Secure Element Id</span><span class="body-span">SE****A821</span></div>
      <div class="content"><span>Factory Id</span><span class="body-span">FACT-0001</span></div>
      <div class="content"><span>Current Stage</span><span class="body-span">Personalize and Lock</span></div>
      <div class="content"><span>Provisioning Status</span><span class="body-span">Complete</span></div>
    </div>
    <div class="flex">
      <div class="content">
        <span class="circle">1</span>
        <span class="body-span">Build and Idendity</span>
        <span class="status">Completed</span>
      </div>
      <div class="content">
        <span class="circle">2</span>
        <span class="body-span">Register with cloud</span>
        <span class="status">Completed</span>
      </div>
      <div class="content">
        <span class="circle">3</span>
        <span class="body-span">Personalise and lock</span>
        <span class="status">Completed</span>
      </div>
    </div>
  </div>

  <div class="device-overview-grid">
    <section class="detail-section">
      <div class="detail-section-header">Device Information</div>
      <div class="device-info-content">
        <div class="device-info-item"><span class="info-label">Device ID</span><span class="info-value">DTI0001</span></div>
        <div class="device-info-item"><span class="info-label">Factory ID</span><span class="info-value">FACT-001</span></div>
        <div class="device-info-item"><span class="info-label">Serial Number</span><span class="info-value">SN12345678</span></div>
        <div class="device-info-item"><span class="info-label">Secure Element ID</span><span class="info-value">SE****A821</span></div>
        <div class="device-info-item"><span class="info-label">Device State</span><span class="info-value">UNASSIGNED</span></div>
      </div>
    </section>
    <section class="detail-section">
      <div class="detail-section-header">Key Details</div>
      <div class="key-details-content">
        <div class="key-details-item">
          <span class="info-label">Device Public Key</span>
          <span class="info-value key-value">3F:2A:9C:7D:4E:11:B8:6C <span class="grid-status completed">Verified</span></span>
        </div>
        <div class="key-details-item"><span class="info-label">QC Data</span><span class="info-value">Available</span></div>
        <div class="key-details-item"><span class="info-label">Binding Number</span><span class="info-value">0</span></div>
        <div class="key-details-item"><span class="info-label">Counter</span><span class="info-value">0</span></div>
        <div class="key-details-item"><span class="info-label">Keygen Counter</span><span class="info-value">0</span></div>
      </div>
    </section>
  </div>

  <section class="detail-section table-section">
    <div class="detail-section-header">Provisioning Stages</div>
    <div class="provisioning-grid">
      <table>
        <thead>
          <tr>
            <th>Stage</th>
            <th>Status</th>
            <th>Completed At</th>
            <th>Details</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>1. Build and identify</td>
            <td><span class="grid-status completed">Completed</span></td>
            <td>12 Sep 2026 09:10 AM</td>
            <td>Firmware loaded, debug ports locked. Key pair generated.</td>
          </tr>
          <tr>
            <td>2. Register with the cloud</td>
            <td><span class="grid-status completed">Completed</span></td>
            <td>12 Sep 2026 09:15 AM</td>
            <td>Device registered over factory mTLS. Vendor attestation verified. Device certificate issued.</td>
          </tr>
          <tr>
            <td>3. Personalise and lock</td>
            <td><span class="grid-status completed">Completed</span></td>
            <td>12 Sep 2026 09:20 AM</td>
            <td>Device certificate and DTI command key written, counters initialised and device locked.</td>
          </tr>
        </tbody>
      </table>
    </div>
  </section>

  <section class="detail-section table-section">
    <div class="detail-section-header">Provisioning Events</div>
    <div class="provisioning-grid">
      <table>
        <thead>
          <tr>
            <th>Timestamp</th>
            <th>Stage</th>
            <th>Event</th>
            <th>Result</th>
            <th>Details</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>12 Sep 2026 09:10 AM</td>
            <td>1. Build and identify</td>
            <td>Load signed firmware</td>
            <td><span class="grid-status success">Success</span></td>
            <td>Firmware version 1.0.3 loaded.</td>
          </tr>
          <tr>
            <td>12 Sep 2026 09:10 AM</td>
            <td>1. Build and identify</td>
            <td>Lock debug ports</td>
            <td><span class="grid-status success">Success</span></td>
            <td>Debug ports locked.</td>
          </tr>
          <tr>
            <td>12 Sep 2026 09:12 AM</td>
            <td>1. Build and identify</td>
            <td>Generate device key pair</td>
            <td><span class="grid-status success">Success</span></td>
            <td>Key pair generated in SE.</td>
          </tr>
          <tr>
            <td>12 Sep 2026 09:15 AM</td>
            <td>2. Register with the cloud</td>
            <td>Register device</td>
            <td><span class="grid-status success">Success</span></td>
            <td>Registered over factory mTLS.</td>
          </tr>
          <tr>
            <td>12 Sep 2026 09:16 AM</td>
            <td>2. Register with the cloud</td>
            <td>Verify vendor attestation</td>
            <td><span class="grid-status success">Success</span></td>
            <td>Attestation verified.</td>
          </tr>
        </tbody>
      </table>
    </div>
  </section>
</section>
<%@ include file="/WEB-INF/jsp/includes/shell-close.jsp" %>
