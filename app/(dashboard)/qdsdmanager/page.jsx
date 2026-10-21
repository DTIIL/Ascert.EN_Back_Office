"use client";

import { useState, useMemo } from "react";
import { AgGridReact } from "ag-grid-react";
import {
  AllCommunityModule,
  ModuleRegistry,
  themeQuartz,
} from "ag-grid-community";
import { dummyData } from "../../../public/data";
import "./qdsdmanager.css";
import { StatusRenderer } from "../../../public/utils";
import { useRouter } from "next/navigation";

ModuleRegistry.registerModules([AllCommunityModule]);

const Page = () => {
  const [inputSearch, setInputSearch] = useState("");
  const [selectedValue, setSelectedValue] = useState("");
  const router = useRouter();

  const columnDefs = useMemo(
    () => [
      { field: "qdsdId" },
      { field: "serialNumber" },
      { field: "assignedUser" },
      { field: "organization" },
      {
        field: "pairingStatus",
        cellRenderer: StatusRenderer,
      },
      {
        field: "downloadStatus",
        cellRenderer: StatusRenderer,
      },
      {
        field: "qdsdStatus",
        cellRenderer: StatusRenderer,
      },
      {
        field: "lastUsed",
      },
      {
        field: "Action",
        cellRenderer: () => <span className="view-action">View</span>,
      },
    ],
    [],
  );

  const defaultColDef = useMemo(
    () => ({
      flex: 1,
      minWidth: 100,
      sortable: true,
    }),
    [],
  );

  const filteredData = useMemo(() => {
    const query = inputSearch.trim().toLowerCase();

    return dummyData.filter((row) => {
      const matchesSearch =
        !query ||
        Object.values(row).some((value) =>
          String(value ?? "")
            .toLowerCase()
            .includes(query),
        );

      const matchesStatus =
        !selectedValue ||
        row.pairingStatus === selectedValue ||
        row.downloadStatus === selectedValue ||
        row.qdsdStatus === selectedValue;

      return matchesSearch && matchesStatus;
    });
  }, [inputSearch, selectedValue]);

  const handleChange = (event) => {
    setSelectedValue(event.target.value);
  };

  const handleClick = () => {
    router.push("/qdsdmanager/qdsdDetails");
  };

  return (
    <section className="grid gap-10">
      <div>
        <h2>QDSD Manager</h2>
        <span>View and manage all QDSDs</span>
      </div>

      <div className="input-wrapper">
        <input
          className="custom-input"
          type="search"
          placeholder="Search anything..."
          value={inputSearch}
          onChange={(e) => setInputSearch(e.target.value)}
          aria-label="Search QDSD records"
        />
        <select
          className="select"
          value={selectedValue}
          onChange={handleChange}
        >
          <optgroup label="Pairing Status">
            <option value="">All Status</option>
            <option value="Paired">Paired</option>
            <option value="Not Paired">Not Paired</option>
          </optgroup>
          <optgroup label="Download Status">
            <option value="Downloaded">Downloaded</option>
            <option value="Pending">Pending</option>
            <option value="Download Failed">Download Failed</option>
          </optgroup>
          <optgroup label="QDSD Status">
            <option value="Waiting for DSC">Waiting for DSC</option>
            <option value="Suspended">Suspended</option>
            <option value="Inactive">Inactive</option>
            <option value="Ready">Ready</option>
            <option value="Error">Error</option>
          </optgroup>
        </select>
      </div>

      <div style={{ height: "calc(100vh - 260px)", width: "100%" }}>
        <AgGridReact
          rowData={filteredData}
          columnDefs={columnDefs}
          defaultColDef={defaultColDef}
          theme={themeQuartz}
          pagination={true}
          onRowClicked={handleClick}
        />
      </div>
    </section>
  );
};

export default Page;
