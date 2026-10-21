import "./overview.css";
const errorLogs = [
  {
    id: 1,
    dateTime: "04 Sep 2026 01:02 PM",
    source: "Download",
    code: "NO_PREAPPROVAL",
    message: "NO Pre approval for this DSC Download",
    Details: "CA Page styed open.subscriber had no pre approved",
  },
  {
    id: 2,
    dateTime: "04 Sep 2026 01:02 PM",
    source: "Download",
    code: "KEYGEN_REFUSED",
    message: "key generation refused",
    Details: "Ask the subscriber to pre-approve then check again",
  },
  {
    id: 3,
    dateTime: "04 Sep 2026 01:02 PM",
    source: "Download",
    code: "DOWNLOAD_FAILED",
    message: "Download failed.certificate was not installed",
    Details: "three attempts QDSD status error",
  },
  {
    id: 4,
    dateTime: "04 Sep 2026 01:02 PM",
    source: "Signing",
    code: "NO_DSC",
    message: "No DSC yet",
    Details: "Signing request Contract.pdf was not completed",
  },
];
const ErrorLogs = () => {
  return (
    <section className="detail-section attempt-section">
      <div className="attempts-table-wrapper">
        <table className="attempts-table">
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
            {errorLogs.map((item) => (
              <tr key={item.id}>
                <td>{item.dateTime}</td>
                <td>{item.source}</td>
                <td>{item.code}</td>
                <td>{item.message}</td>
                <td>{item.Details}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </section>
  );
};

export default ErrorLogs;
