import React from "react";
import "./overview.css";

const signedHistory = [
  {
    id: 1,
    dateTime: "04 Sep 2026 01:02 PM",
    document:'contract.pdf',
    status: "Failed",
    signedBy: "ABC Certifying Authority",
    errorDetails: "No pre-approval for this DSC download.",
  },
];

const SigningHistory = () => {
  return (
    <section className="detail-section attempts-section">
      <div className="attempts-table-wrapper">
        <table className="attempts-table">
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
            {signedHistory.map((item) => (
              <tr key={item.id}>
                <td>{item.dateTime}</td>
                <td>{item.document}</td>
                <td>
                  <span className="status-badge status-failed">
                    {item.status}
                  </span>
                </td>
                <td>{item.signedBy}</td>
                <td className="attempt-error">{item.errorDetails}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </section>
  );
};

export default SigningHistory;
