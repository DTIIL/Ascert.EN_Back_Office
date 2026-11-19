"use client";

import { useMemo, useState } from "react";
import DateRangePicker from "../DateRangePicker";
import { isWithinDateRange } from "../../lib/dateRange";
import "./overview.css";

const signedHistory = [
  {
    id: 1,
    dateTime: "04 Sep 2026 01:02 PM",
    document: "contract.pdf",
    status: "Failed",
    signedBy: "ABC Certifying Authority",
    errorDetails: "No pre-approval for this DSC download.",
  },
];

const SigningHistory = () => {
  const [startDate, setStartDate] = useState("");
  const [endDate, setEndDate] = useState("");
  const rows = useMemo(
    () =>
      signedHistory.filter((item) =>
        isWithinDateRange(item.dateTime, startDate, endDate),
      ),
    [startDate, endDate],
  );

  return (
    <section className="detail-section attempts-section">
      <div className="toolbar table-date-toolbar">
        <DateRangePicker
          startDate={startDate}
          endDate={endDate}
          onStartChange={setStartDate}
          onEndChange={setEndDate}
        />
      </div>
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
            {rows.map((item) => (
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
            {rows.length === 0 ? (
              <tr>
                <td colSpan={5}>No records match this date range.</td>
              </tr>
            ) : null}
          </tbody>
        </table>
      </div>
    </section>
  );
};

export default SigningHistory;
