"use client";

import Link from "next/link";
import { useMemo, useState } from "react";
import DataGrid from "./DataGrid";
import { StatusRenderer } from "../public/utils";
import { filterRows } from "../lib/filterRows";

const STATUS_OPTIONS = ["Completed", "Pending", "In Progress", "Failed"];

const columnDefs = [
  { field: "deviceId", headerName: "Device ID" },
  { field: "factoryId", headerName: "Factory ID" },
  { field: "currentStage", headerName: "Current Stage" },
  { field: "status", headerName: "Status", cellRenderer: StatusRenderer },
  { field: "lastUpdate", headerName: "Last Update" },
];

export default function ReportView({ title, placeholder, rows }) {
  const [query, setQuery] = useState("");
  const [status, setStatus] = useState("");

  const filtered = useMemo(
    () =>
      filterRows(rows, query, (row) => !status || row.status === status),
    [rows, query, status],
  );

  return (
    <section className="section-container">
      <nav className="crumbs" aria-label="Breadcrumb">
        <Link href="/report">Reports</Link>
        <span aria-hidden="true">/</span>
        <span>{title}</span>
      </nav>
      <header className="page-head">
        <div>
          <h1>{title}</h1>
          <p>Filter the records below, or return to the report catalogue.</p>
        </div>
      </header>
      <div className="toolbar">
        <input
          className="custom-input"
          type="search"
          placeholder={placeholder}
          aria-label={placeholder}
          value={query}
          onChange={(event) => setQuery(event.target.value)}
        />
        <select
          className="select"
          value={status}
          aria-label="Filter by status"
          onChange={(event) => setStatus(event.target.value)}
        >
          <option value="">All statuses</option>
          {STATUS_OPTIONS.map((option) => (
            <option key={option} value={option}>
              {option}
            </option>
          ))}
        </select>
      </div>
      <DataGrid rowData={filtered} columnDefs={columnDefs} />
    </section>
  );
}
