<%@ include file="/WEB-INF/jsp/includes/shell-open.jsp" %>
<section style="display:grid;gap:14px">
  <div class="grid">
    <a class="back-btn" href="${ctx}/qdsdmanager">Back to QDSD Manager</a>
    <h1 class="title">QDSD Details</h1>
  </div>
  <div class="summary-strip">
    <div class="grid"><span class="sub-title">QDSD ID</span><span>*******</span></div>
    <div class="grid"><span class="sub-title">Serial Number</span><span>*******</span></div>
    <div class="grid"><span class="sub-title">Assigned User</span><span>*******</span></div>
    <div class="grid"><span class="sub-title">Organization</span><span>*******</span></div>
    <div class="grid"><span class="sub-title">Pairing Status</span><span>*******</span></div>
    <div class="grid"><span class="sub-title">Download Status</span><span>*******</span></div>
    <div class="grid"><span class="sub-title">QDSD Status</span><span>*******</span></div>
  </div>

  <div data-tabs>
    <div role="tablist" aria-label="Content tabs" class="tab-div">
      <button type="button" role="tab" id="tab-overview" class="tab-button active" aria-selected="true">Overview</button>
      <button type="button" role="tab" id="tab-download" class="tab-button" aria-selected="false" tabindex="-1">Download History</button>
      <button type="button" role="tab" id="tab-signing" class="tab-button" aria-selected="false" tabindex="-1">Signing History</button>
      <button type="button" role="tab" id="tab-errors" class="tab-button" aria-selected="false" tabindex="-1">Error Logs</button>
      <button type="button" role="tab" id="tab-activity" class="tab-button" aria-selected="false" tabindex="-1">Activity History</button>
    </div>

    <div id="panel-overview" role="tabpanel" aria-labelledby="tab-overview" class="tab-panel">
      <main class="qdsd-details-page">
        <section class="detail-section">
          <div class="detail-section-header">Basic Information</div>
          <div class="detail-section-body">
            <div class="detail-column">
              <div class="detail-row"><span class="detail-label">QDSD ID</span><div class="detail-value">****7A31</div></div>
              <div class="detail-row"><span class="detail-label">Serial Number</span><div class="detail-value">SN12345678</div></div>
              <div class="detail-row"><span class="detail-label">Assigned User</span><div class="detail-value">Ravi Kumar</div></div>
              <div class="detail-row"><span class="detail-label">User Email</span><div class="detail-value">ravi.kumar@abc.com</div></div>
              <div class="detail-row"><span class="detail-label">User Mobile</span><div class="detail-value">+91 98765 43210</div></div>
            </div>
            <div class="detail-column">
              <div class="detail-row"><span class="detail-label">Organization</span><div class="detail-value">ABC Pvt Ltd</div></div>
              <div class="detail-row"><span class="detail-label">QDSD Status</span><div class="detail-value"><span class="status-badge status-success">Ready</span></div></div>
              <div class="detail-row"><span class="detail-label">Created Date</span><div class="detail-value">15 Aug 2026 11:30 AM</div></div>
              <div class="detail-row"><span class="detail-label">Last Used</span><div class="detail-value">12 Sep 2026 10:24 AM</div></div>
            </div>
          </div>
        </section>
        <section class="detail-section">
          <div class="detail-section-header">Pairing Information</div>
          <div class="detail-section-body">
            <div class="detail-column">
              <div class="detail-row"><span class="detail-label">Pairing Status</span><div class="detail-value"><span class="status-badge status-success">Paired</span></div></div>
              <div class="detail-row"><span class="detail-label">Paired Date &amp; Time</span><div class="detail-value">15 Aug 2026 11:35 AM</div></div>
              <div class="detail-row"><span class="detail-label">Last Pairing Attempt</span><div class="detail-value">15 Aug 2026 11:35 AM</div></div>
            </div>
            <div class="detail-column">
              <div class="detail-row"><span class="detail-label">Paired Device</span><div class="detail-value">Samsung Galaxy S23</div></div>
              <div class="detail-row"><span class="detail-label">Paired By</span><div class="detail-value">Ravi Kumar</div></div>
            </div>
          </div>
        </section>
        <section class="detail-section">
          <div class="detail-section-header">DSC / Download Information</div>
          <div class="detail-section-body">
            <div class="detail-column">
              <div class="detail-row"><span class="detail-label">Download Status</span><div class="detail-value"><span class="status-badge status-success">Downloaded</span></div></div>
              <div class="detail-row"><span class="detail-label">Download Date &amp; Time</span><div class="detail-value">16 Aug 2026 09:20 AM</div></div>
              <div class="detail-row"><span class="detail-label">Downloaded By</span><div class="detail-value">Ravi Kumar</div></div>
            </div>
            <div class="detail-column">
              <div class="detail-row"><span class="detail-label">CA Name</span><div class="detail-value">ABC Certifying Authority</div></div>
              <div class="detail-row"><span class="detail-label">Certificate Validity</span><div class="detail-value">16 Aug 2026 – 16 Aug 2028</div></div>
              <div class="detail-row"><span class="detail-label">Download Attempts</span><div class="detail-value">1</div></div>
            </div>
          </div>
        </section>
        <section class="detail-section">
          <div class="detail-section-header">Certificate Details</div>
          <div class="detail-section-body">
            <div class="detail-column">
              <div class="detail-row"><span class="detail-label">Certificate Serial Number</span><div class="detail-value">AB12CD34EF56</div></div>
              <div class="detail-row"><span class="detail-label">Subject Name</span><div class="detail-value">Ravi Kumar</div></div>
              <div class="detail-row"><span class="detail-label">Issuer</span><div class="detail-value">ABC Certifying Authority</div></div>
            </div>
            <div class="detail-column">
              <div class="detail-row"><span class="detail-label">Valid From</span><div class="detail-value">16 Aug 2026 09:20 AM</div></div>
              <div class="detail-row"><span class="detail-label">Valid To</span><div class="detail-value">16 Aug 2028 09:20 AM</div></div>
              <div class="detail-row"><span class="detail-label">Certificate Status</span><div class="detail-value"><span class="status-badge status-success">Valid</span></div></div>
            </div>
          </div>
        </section>
      </main>
    </div>

    <div id="panel-download" role="tabpanel" aria-labelledby="tab-download" class="tab-panel" hidden>
      <section class="detail-section attempts-section">
        <div class="toolbar table-date-toolbar" data-date-filter="#download-table">
          <jsp:include page="/WEB-INF/jsp/includes/date-range.jsp">
            <jsp:param name="grid" value="#download-table" />
          </jsp:include>
        </div>
        <div class="attempts-table-wrapper">
          <table class="attempts-table" id="download-table">
            <thead>
              <tr>
                <th>Date &amp; time</th>
                <th>Status</th>
                <th>CA name</th>
                <th>Downloaded by</th>
                <th>Attempt</th>
                <th>Error details</th>
              </tr>
            </thead>
            <tbody>
              <tr data-date="04 Sep 2026 01:02 PM">
                <td>04 Sep 2026 01:02 PM</td>
                <td><span class="status-badge status-failed">Failed</span></td>
                <td>ABC Certifying Authority</td>
                <td>Neha Singh</td>
                <td>1</td>
                <td class="attempt-error">No pre-approval for this DSC download.</td>
              </tr>
              <tr data-date="05 Sep 2026 10:44 AM">
                <td>05 Sep 2026 10:44 AM</td>
                <td><span class="status-badge status-failed">Failed</span></td>
                <td>ABC Certifying Authority</td>
                <td>Neha Singh</td>
                <td>2</td>
                <td class="attempt-error">Key generation refused. Ask the Subscriber to pre-approve, then check again.</td>
              </tr>
              <tr data-date="06 Sep 2026 03:18 PM">
                <td>06 Sep 2026 03:18 PM</td>
                <td><span class="status-badge status-failed">Failed</span></td>
                <td>ABC Certifying Authority</td>
                <td>Neha Singh</td>
                <td>3</td>
                <td class="attempt-error">Download failed. Certificate was not installed.</td>
              </tr>
              <tr class="date-empty" hidden>
                <td colspan="6">No records match this date range.</td>
              </tr>
            </tbody>
          </table>
        </div>
      </section>
    </div>

    <div id="panel-signing" role="tabpanel" aria-labelledby="tab-signing" class="tab-panel" hidden>
      <section class="detail-section attempts-section">
        <div class="toolbar table-date-toolbar" data-date-filter="#signing-table">
          <jsp:include page="/WEB-INF/jsp/includes/date-range.jsp">
            <jsp:param name="grid" value="#signing-table" />
          </jsp:include>
        </div>
        <div class="attempts-table-wrapper">
          <table class="attempts-table" id="signing-table">
            <thead>
              <tr>
                <th>Signed at</th>
                <th>Document</th>
                <th>Status</th>
                <th>Signed By</th>
                <th>Error Details</th>
              </tr>
            </thead>
            <tbody>
              <tr data-date="04 Sep 2026 01:02 PM">
                <td>04 Sep 2026 01:02 PM</td>
                <td>contract.pdf</td>
                <td><span class="status-badge status-failed">Failed</span></td>
                <td>ABC Certifying Authority</td>
                <td class="attempt-error">No pre-approval for this DSC download.</td>
              </tr>
              <tr class="date-empty" hidden>
                <td colspan="5">No records match this date range.</td>
              </tr>
            </tbody>
          </table>
        </div>
      </section>
    </div>

    <div id="panel-errors" role="tabpanel" aria-labelledby="tab-errors" class="tab-panel" hidden>
      <section class="detail-section attempt-section">
        <div class="toolbar table-date-toolbar" data-date-filter="#error-table">
          <jsp:include page="/WEB-INF/jsp/includes/date-range.jsp">
            <jsp:param name="grid" value="#error-table" />
          </jsp:include>
        </div>
        <div class="attempts-table-wrapper">
          <table class="attempts-table" id="error-table">
            <thead>
              <tr>
                <th>Time</th>
                <th>Source</th>
                <th>Code</th>
                <th>Message</th>
                <th>Details</th>
              </tr>
            </thead>
            <tbody>
              <tr data-date="04 Sep 2026 01:02 PM">
                <td>04 Sep 2026 01:02 PM</td>
                <td>Download</td>
                <td>NO_PREAPPROVAL</td>
                <td>NO Pre approval for this DSC Download</td>
                <td>CA Page styed open.subscriber had no pre approved</td>
              </tr>
              <tr data-date="04 Sep 2026 01:02 PM">
                <td>04 Sep 2026 01:02 PM</td>
                <td>Download</td>
                <td>KEYGEN_REFUSED</td>
                <td>key generation refused</td>
                <td>Ask the subscriber to pre-approve then check again</td>
              </tr>
              <tr data-date="04 Sep 2026 01:02 PM">
                <td>04 Sep 2026 01:02 PM</td>
                <td>Download</td>
                <td>DOWNLOAD_FAILED</td>
                <td>Download failed.certificate was not installed</td>
                <td>three attempts QDSD status error</td>
              </tr>
              <tr data-date="04 Sep 2026 01:02 PM">
                <td>04 Sep 2026 01:02 PM</td>
                <td>Signing</td>
                <td>NO_DSC</td>
                <td>No DSC yet</td>
                <td>Signing request Contract.pdf was not completed</td>
              </tr>
              <tr class="date-empty" hidden>
                <td colspan="5">No records match this date range.</td>
              </tr>
            </tbody>
          </table>
        </div>
      </section>
    </div>

    <div id="panel-activity" role="tabpanel" aria-labelledby="tab-activity" class="tab-panel" hidden>
      <section class="detail-section attempt-section">
        <div class="toolbar table-date-toolbar" data-date-filter="#activity-table">
          <jsp:include page="/WEB-INF/jsp/includes/date-range.jsp">
            <jsp:param name="grid" value="#activity-table" />
          </jsp:include>
        </div>
        <div class="attempts-table-wrapper">
          <table class="attempts-table" id="activity-table">
            <thead>
              <tr>
                <th>Time</th>
                <th>Actor</th>
                <th>Action</th>
                <th>Details</th>
              </tr>
            </thead>
            <tbody>
              <tr data-date="04 Sep 2026 01:02 PM">
                <td>04 Sep 2026 01:02 PM</td>
                <td>Ravi kumar</td>
                <td>Paired</td>
                <td>QDSD Pair to this subscriber</td>
              </tr>
              <tr data-date="04 Sep 2026 01:02 PM">
                <td>04 Sep 2026 01:02 PM</td>
                <td>Ravi kumar</td>
                <td>DSC Downloded</td>
                <td>Certificate installed from ABC certifying Authority</td>
              </tr>
              <tr data-date="04 Sep 2026 01:02 PM">
                <td>04 Sep 2026 01:02 PM</td>
                <td>Ravi kumar</td>
                <td>Signed</td>
                <td>Aggreement.pdf signed</td>
              </tr>
              <tr class="date-empty" hidden>
                <td colspan="4">No records match this date range.</td>
              </tr>
            </tbody>
          </table>
        </div>
      </section>
    </div>
  </div>
</section>
<%@ include file="/WEB-INF/jsp/includes/shell-close.jsp" %>
