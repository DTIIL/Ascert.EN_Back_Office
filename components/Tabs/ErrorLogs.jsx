"use client";

import { useMemo, useState } from "react";
import DateRangePicker from "../DateRangePicker";
import { isWithinDateRange } from "../../lib/dateRange";
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
  const [startDate, setStartDate] = useState("");
  const [endDate, setEndDate] = useState("");
  const rows = useMemo(
    () =>
      errorLogs.filter((item) =>
        isWithinDateRange(item.dateTime, startDate, endDate),
      ),
    [startDate, endDate],
  );

  return (
    <section className="detail-section attempt-section">
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
              <th>Time</th>
              <th>Source</th>
              <th>Code</th>
              <th>Message</th>
              <th>Details</th>
            </tr>
          </thead>
          <tbody>
            {rows.map((item) => (
              <tr key={item.id}>
                <td>{item.dateTime}</td>
                <td>{item.source}</td>
                <td>{item.code}</td>
                <td>{item.message}</td>
                <td>{item.Details}</td>
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

export default ErrorLogs;
