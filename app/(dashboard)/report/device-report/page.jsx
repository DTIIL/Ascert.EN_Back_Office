/* eslint-disable react-hooks/rules-of-hooks */
"use client";
import { AgGridReact } from "ag-grid-react";
import "../report.css";
import { usePathname, useRouter } from "next/navigation";
import { useMemo, useState } from "react";
import {
  AllCommunityModule,
  ModuleRegistry,
  themeQuartz,
} from "ag-grid-community";
import { rowDataProvisioningReport } from "../../../../public/data";

ModuleRegistry.registerModules([AllCommunityModule]);

const page = () => {
  const [inputSeach, setInputSearch] = useState("");
  const [selectedValue, setSelectedValue] = useState("");
  const pathName = usePathname();
  const router = useRouter();
  const currentPathName = pathName.split("/").pop();
  const columnDefs = useMemo(
    () => [
      { field: "deviceId" },
      { field: "factoryId" },
      { field: "currentStage" },
      { field: "status" },
      {
        field: "lastUpdate",
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

  const filterData = useMemo(() => {
    const query = inputSeach.trim().toLowerCase();
    return rowDataProvisioningReport.filter((row) => {
      const matchesSearch =
        !query ||
        Object.values(row).some((value) =>
          String(value ?? "")
            .toLowerCase()
            .includes(query),
        );

      const statusValues = !selectedValue || row.status === selectedValue;
      return matchesSearch && statusValues;
    });
  }, [inputSeach, selectedValue]);

  return (
    <section className="section-container">
      <div>
        <span className="breadcrumb" onClick={() => router.push("/report")}>
          Reports
        </span>{" "}
        {">"} <span>{currentPathName}</span>
      </div>
      <div>
        <h2 style={{ margin: "0px" }}>Device Report</h2>
      </div>
      <div className="input-wrapper">
        <input
          className="custom-input"
          type="search"
          placeholder="Search Device report"
          aria-label="Search Device report"
          value={inputSeach}
          onChange={(e) => setInputSearch(e.target.value)}
        />
        <select
          className="select"
          value={selectedValue}
          onChange={(e) => setSelectedValue(e.target.value)}
        >
          <optgroup label="Status">
            <option value="">All Status</option>
            <option value="Completed">Completed</option>
            <option value="Pending">Pending</option>
            <option value="In Progress">In Progress</option>
            <option value="Failed">Failed</option>
          </optgroup>
        </select>
      </div>
      <div className="ag-grid">
        <AgGridReact
          rowData={filterData}
          columnDefs={columnDefs}
          defaultColDef={defaultColDef}
          theme={themeQuartz}
          pagination={true}
        />
      </div>
    </section>
  );
};

export default page;
