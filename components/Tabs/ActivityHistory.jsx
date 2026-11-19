"use client";

import { useMemo, useState } from "react";
import DateRangePicker from "../DateRangePicker";
import { isWithinDateRange } from "../../lib/dateRange";
import "./overview.css";

const activityHistory = [
  {
    id: 1,
    time: "04 Sep 2026 01:02 PM",
    actor: "Ravi kumar",
    action: "Paired",
    Details: "QDSD Pair to this subscriber",
  },
  {
    id: 2,
    time: "04 Sep 2026 01:02 PM",
    actor: "Ravi kumar",
    action: "DSC Downloded",
    Details: "Certificate installed from ABC certifying Authority",
  },
  {
    id: 3,
    time: "04 Sep 2026 01:02 PM",
    actor: "Ravi kumar",
    action: "Signed",
    Details: "Aggreement.pdf signed",
  },
];

const ActivityHistory = () => {
  const [startDate, setStartDate] = useState("");
  const [endDate, setEndDate] = useState("");
  const rows = useMemo(
    () =>
      activityHistory.filter((item) =>
        isWithinDateRange(item.time, startDate, endDate),
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
          <thead className="attempts-table">
            <tr>
              <th>Time</th>
              <th>Actor</th>
              <th>Action</th>
              <th>Details</th>
            </tr>
          </thead>
          <tbody>
            {rows.map((item) => (
              <tr key={item.id}>
                <td>{item.time}</td>
                <td>{item.actor}</td>
                <td>{item.action}</td>
                <td>{item.Details}</td>
              </tr>
            ))}
            {rows.length === 0 ? (
              <tr>
                <td colSpan={4}>No records match this date range.</td>
              </tr>
            ) : null}
          </tbody>
        </table>
      </div>
    </section>
  );
};

export default ActivityHistory;
