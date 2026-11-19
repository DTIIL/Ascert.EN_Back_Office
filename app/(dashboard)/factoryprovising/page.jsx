"use client";

import { useMemo, useState } from "react";
import { useRouter } from "next/navigation";
import DataGrid from "../../../components/DataGrid";
import DateRangePicker from "../../../components/DateRangePicker";
import { factoryProvisioningData } from "../../../public/data";
import { filterRows } from "../../../lib/filterRows";
import { isWithinDateRange } from "../../../lib/dateRange";
import { StatusRenderer } from "../../../public/utils";

const columnDefs = [
  { field: "deviceId", headerName: "Device ID" },
  { field: "secureElementId", headerName: "Secure Element ID" },
  { field: "factoryId", headerName: "Factory ID" },
  { field: "currentStage", headerName: "Current Stage" },
  {
    field: "provisioningStatus",
    headerName: "Status",
    cellRenderer: StatusRenderer,
  },
  { field: "lastUpdated", headerName: "Last Updated" },
  {
    field: "Action",
    headerName: "Action",
    sortable: false,
    cellRenderer: () => <span className="view-action">View</span>,
  },
];

export default function Page() {
  const [inputSearch, setInputSearch] = useState("");
  const [startDate, setStartDate] = useState("");
  const [endDate, setEndDate] = useState("");
  const router = useRouter();

  const filteredData = useMemo(
    () =>
      filterRows(factoryProvisioningData, inputSearch, (row) =>
        isWithinDateRange(row.lastUpdated, startDate, endDate),
      ),
    [inputSearch, startDate, endDate],
  );

  return (
    <section className="section-container">
      <header className="page-head">
        <div>
          <h1>Factory Provisioning</h1>
          <p>Track every device from the factory floor to a locked state.</p>
        </div>
      </header>
      <div className="toolbar">
        <input
          type="search"
          className="custom-input"
          placeholder="Search devices, factories, or stages"
          value={inputSearch}
          aria-label="Search factory provisioning records"
          onChange={(event) => setInputSearch(event.target.value)}
        />
        <DateRangePicker
          startDate={startDate}
          endDate={endDate}
          onStartChange={setStartDate}
          onEndChange={setEndDate}
        />
      </div>
      <DataGrid
        rowData={filteredData}
        columnDefs={columnDefs}
        onRowClicked={() => router.push("/factoryprovising/detail")}
      />
    </section>
  );
}
