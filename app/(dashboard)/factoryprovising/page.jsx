/* eslint-disable react-hooks/rules-of-hooks */
"use client";
import { useMemo, useState } from "react";
import "./factoryprovisioning.css";
import { AgGridReact } from "ag-grid-react";
import {
  AllCommunityModule,
  ModuleRegistry,
  themeQuartz,
} from "ag-grid-community";
import { factoryProvisioningData } from "../../../public/data";
import { useRouter } from "next/navigation";
ModuleRegistry.registerModules([AllCommunityModule]);

const page = () => {
  const [inputSearch, setInputSearch] = useState("");
  const router = useRouter();
  const columnDefs = useMemo(
    () => [
      { field: "deviceId" },
      { field: "secureElementId" },
      { field: "factoryId" },
      { field: "currentStage" },
      { field: "provisioningStatus" },
      { field: "lastUpdated" },
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

  const filterData = useMemo(() => {
    const query = inputSearch.trim().toLowerCase();

    return factoryProvisioningData.filter((row) => {
      const matechSearch =
        !query ||
        Object.values(row).some((value) =>
          String(value ?? "")
            .toLowerCase()
            .includes(query),
        );
      return matechSearch;
    });
  }, [inputSearch]);

  const handleClick = () => {
    router.push("/factoryprovising/detail");
  };
  return (
    <section className="section">
      <div className="header-section">
        <h1>Factory Provisioning</h1>
        <span>view all factory provisioning records.</span>
      </div>
      <div className="input-wrapper">
        <input
          type="search"
          className="custom-input"
          placeholder="Search anything"
          value={inputSearch}
          onChange={(e) => setInputSearch(e.target.value)}
        />
      </div>
      <div className="ag-grid">
        <AgGridReact
          rowData={filterData}
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

export default page;
