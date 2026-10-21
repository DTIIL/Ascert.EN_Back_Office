"use client";
import "./overview.css";
const downloadAttempts = [
  {
    id: 1,
    dateTime: "04 Sep 2026 01:02 PM",
    status: "Failed",
    caName: "ABC Certifying Authority",
    downloadedBy: "Neha Singh",
    attempt: 1,
    errorDetails: "No pre-approval for this DSC download.",
  },
  {
    id: 2,
    dateTime: "05 Sep 2026 10:44 AM",
    status: "Failed",
    caName: "ABC Certifying Authority",
    downloadedBy: "Neha Singh",
    attempt: 2,
    errorDetails:
      "Key generation refused. Ask the Subscriber to pre-approve, then check again.",
  },
  {
    id: 3,
    dateTime: "06 Sep 2026 03:18 PM",
    status: "Failed",
    caName: "ABC Certifying Authority",
    downloadedBy: "Neha Singh",
    attempt: 3,
    errorDetails: "Download failed. Certificate was not installed.",
  },
];

const DownloadHistory = () => {
  return (
    <section className="detail-section attempts-section">
      {/* <div className="detail-section-header">DSC Download Attempts</div> */}
      <div className="attempts-table-wrapper">
        <table className="attempts-table">
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
            {downloadAttempts.map((item) => (
              <tr key={item.id}>
                <td>{item.dateTime}</td>

                <td>
                  <span className="status-badge status-failed">
                    {item.status}
                  </span>
                </td>

                <td>{item.caName}</td>
                <td>{item.downloadedBy}</td>
                <td>{item.attempt}</td>
                <td className="attempt-error">{item.errorDetails}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </section>
  );
};

export default DownloadHistory;
