"use client";

import { useMemo, useState } from "react";
import { useRouter } from "next/navigation";
import DataGrid from "../../../components/DataGrid";
import { StatusRenderer } from "../../../public/utils";
import { dummyData } from "../../../public/data";
import { filterRows } from "../../../lib/filterRows";

const columnDefs = [
  { field: "qdsdId", headerName: "QDSD ID" },
  { field: "serialNumber", headerName: "Serial Number" },
  { field: "assignedUser", headerName: "Assigned User" },
  { field: "organization", headerName: "Organization" },
  { field: "pairingStatus", headerName: "Pairing", cellRenderer: StatusRenderer },
  { field: "downloadStatus", headerName: "Download", cellRenderer: StatusRenderer },
  { field: "qdsdStatus", headerName: "QDSD Status", cellRenderer: StatusRenderer },
  { field: "lastUsed", headerName: "Last Used" },
  {
    field: "Action",
    headerName: "Action",
    sortable: false,
    cellRenderer: () => <span className="view-action">View</span>,
  },
];

export default function Page() {
  const [inputSearch, setInputSearch] = useState("");
  const [selectedValue, setSelectedValue] = useState("");
  const router = useRouter();

  const filteredData = useMemo(
    () =>
      filterRows(
        dummyData,
        inputSearch,
        (row) =>
          !selectedValue ||
          row.pairingStatus === selectedValue ||
          row.downloadStatus === selectedValue ||
          row.qdsdStatus === selectedValue,
      ),
    [inputSearch, selectedValue],
  );

  return (
    <section className="section-container">
      <header className="page-head">
        <div>
          <h1>QDSD Manager</h1>
          <p>View and manage every qualified digital signing device.</p>
        </div>
      </header>

      <div className="toolbar">
        <input
          className="custom-input"
          type="search"
          placeholder="Search by ID, user, or organization"
          value={inputSearch}
          onChange={(event) => setInputSearch(event.target.value)}
          aria-label="Search QDSD records"
        />
        <select
          className="select"
          value={selectedValue}
          aria-label="Filter by status"
          onChange={(event) => setSelectedValue(event.target.value)}
        >
          <option value="">All statuses</option>
          <optgroup label="Pairing status">
            <option value="Paired">Paired</option>
            <option value="Not Paired">Not Paired</option>
          </optgroup>
          <optgroup label="Download status">
            <option value="Downloaded">Downloaded</option>
            <option value="Pending">Pending</option>
            <option value="Download Failed">Download Failed</option>
          </optgroup>
          <optgroup label="QDSD status">
            <option value="Waiting for DSC">Waiting for DSC</option>
            <option value="Suspended">Suspended</option>
            <option value="Inactive">Inactive</option>
            <option value="Ready">Ready</option>
            <option value="Error">Error</option>
          </optgroup>
        </select>
      </div>

      <DataGrid
        rowData={filteredData}
        columnDefs={columnDefs}
        onRowClicked={() => router.push("/qdsdmanager/qdsdDetails")}
      />
    </section>
  );
}
