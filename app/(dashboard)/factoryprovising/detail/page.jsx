/* eslint-disable react-hooks/rules-of-hooks */
"use client";

import { useMemo } from "react";
import { AgGridReact } from "ag-grid-react";
import { useRouter } from "next/navigation";
import "../factoryprovisioning.css";

const details1 = [
  {
    name: "Device Id",
    body: "DTIIOO1",
  },
  {
    name: "Secure Element Id",
    body: "SE****A821",
  },
  {
    name: "Factory Id",
    body: "FACT-0001",
  },
  {
    name: "Current Stage",
    body: "Personalize and Lock",
  },
  {
    name: "Provisioning Status",
    body: "Complete",
  },
];
const details2 = [
  {
    id: 1,
    title: "Build and Idendity",
    status: "Completed",
  },
  {
    id: 2,
    title: "Register with cloud",
    status: "Completed",
  },
  {
    id: 3,
    title: "Personalise and lock",
    status: "Completed",
  },
];

const deviceInfo = [
  { label: "Device ID", value: "DTI0001" },
  { label: "Factory ID", value: "FACT-001" },
  { label: "Serial Number", value: "SN12345678" },
  { label: "Secure Element ID", value: "SE****A821" },
  { label: "Device State", value: "UNASSIGNED" },
];

const keyDetails = [
  {
    label: "Device Public Key",
    value: "3F:2A:9C:7D:4E:11:B8:6C",
    verified: true,
  },
  { label: "QC Data", value: "Available" },
  { label: "Binding Number", value: "0" },
  { label: "Counter", value: "0" },
  { label: "Keygen Counter", value: "0" },
];

const stageData = [
  {
    stage: "1. Build and identify",
    status: "Completed",
    completedAt: "12 Sep 2026 09:10 AM",
    details: "Firmware loaded, debug ports locked. Key pair generated.",
  },
  {
    stage: "2. Register with the cloud",
    status: "Completed",
    completedAt: "12 Sep 2026 09:15 AM",
    details:
      "Device registered over factory mTLS. Vendor attestation verified. Device certificate issued.",
  },
  {
    stage: "3. Personalise and lock",
    status: "Completed",
    completedAt: "12 Sep 2026 09:20 AM",
    details:
      "Device certificate and DTI command key written, counters initialised and device locked.",
  },
];

const eventData = [
  {
    timestamp: "12 Sep 2026 09:10 AM",
    stage: "1. Build and identify",
    event: "Load signed firmware",
    result: "Success",
    details: "Firmware version 1.0.3 loaded.",
  },
  {
    timestamp: "12 Sep 2026 09:10 AM",
    stage: "1. Build and identify",
    event: "Lock debug ports",
    result: "Success",
    details: "Debug ports locked.",
  },
  {
    timestamp: "12 Sep 2026 09:12 AM",
    stage: "1. Build and identify",
    event: "Generate device key pair",
    result: "Success",
    details: "Key pair generated in SE.",
  },
  {
    timestamp: "12 Sep 2026 09:15 AM",
    stage: "2. Register with the cloud",
    event: "Register device",
    result: "Success",
    details: "Registered over factory mTLS.",
  },
  {
    timestamp: "12 Sep 2026 09:16 AM",
    stage: "2. Register with the cloud",
    event: "Verify vendor attestation",
    result: "Success",
    details: "Attestation verified.",
  },
];

const StatusBadge = (props) => (
  <span
    className={`grid-status ${
      props.value === "Success" ? "success" : "completed"
    }`}
  >
    {props.value}
  </span>
);

const page = () => {
  const router = useRouter();

  const stageColumnDefs = useMemo(
    () => [
      {
        field: "stage",
        headerName: "Stage",
        flex: 1.1,
        minWidth: 180,
      },
      {
        field: "status",
        headerName: "Status",
        width: 110,
        cellRenderer: StatusBadge,
      },
      {
        field: "completedAt",
        headerName: "Completed At",
        flex: 1,
        minWidth: 175,
      },
      {
        field: "details",
        headerName: "Details",
        flex: 2.5,
        minWidth: 280,
        wrapText: true,
        autoHeight: true,
      },
    ],
    [],
  );

  const eventColumnDefs = useMemo(
    () => [
      {
        field: "timestamp",
        headerName: "Timestamp",
        flex: 1,
        minWidth: 175,
      },
      {
        field: "stage",
        headerName: "Stage",
        flex: 1.1,
        minWidth: 180,
      },
      {
        field: "event",
        headerName: "Event",
        flex: 1,
        minWidth: 175,
      },
      {
        field: "result",
        headerName: "Result",
        width: 110,
        cellRenderer: StatusBadge,
      },
      {
        field: "details",
        headerName: "Details",
        flex: 1.3,
        minWidth: 190,
        wrapText: true,
        autoHeight: true,
      },
    ],
    [],
  );

  const defaultColDef = useMemo(
    () => ({
      sortable: true,
      resizable: true,
      filter: true,
    }),
    [],
  );

  return (
    <section className="factory-details-page">
      <div className="detail-header-section">
        <span className="back-to-dashboard" onClick={() => router.back()}>
          {"< Back to Provisioning Dashboard"}
        </span>

        <span>Last update 12 Sep 2026 10:24 AM</span>
      </div>

      <div className="factory-page-title">
        <h1>Factory Provisioning Details</h1>
      </div>
      <div style={{ overflowY: "scroll", height: "calc(100vh - 200px)" }}>
        <div className="stat">
          <div className="flex">
            {details1.map((item, index) => (
              <div className="content" key={index}>
                <span>{item.name}</span>
                <span className="body-span">{item.body}</span>
              </div>
            ))}
          </div>
          <div className="flex">
            {details2.map((item, index) => (
              <div className="content" key={index}>
                <span className="circle">{item.id}</span>
                <span className="body-span">{item.title}</span>
                <span className="status">{item.status}</span>
              </div>
            ))}
          </div>
        </div>

        {/* Device Information and Key Details */}
        <div className="device-overview-grid">
          <section className="detail-section">
            <div className="detail-section-header">Device Information</div>

            <div className="device-info-content">
              {deviceInfo.map((item) => (
                <div className="device-info-item" key={item.label}>
                  <span className="info-label">{item.label}</span>
                  <span className="info-value">{item.value}</span>
                </div>
              ))}
            </div>
          </section>

          <section className="detail-section">
            <div className="detail-section-header">Key Details</div>

            <div className="key-details-content">
              {keyDetails.map((item) => (
                <div className="key-details-item" key={item.label}>
                  <span className="info-label">{item.label}</span>

                  <span className="info-value key-value">
                    {item.value}

                    {item.verified && (
                      <span className="grid-status completed">Verified</span>
                    )}
                  </span>
                </div>
              ))}
            </div>
          </section>
        </div>

        {/* Provisioning Stages */}
        <section className="detail-section table-section">
          <div className="detail-section-header">Provisioning Stages</div>

          <div className="provisioning-grid ag-theme-alpine">
            <AgGridReact
              rowData={stageData}
              columnDefs={stageColumnDefs}
              defaultColDef={defaultColDef}
              domLayout="autoHeight"
              suppressCellFocus={true}
              animateRows={true}
              getRowId={(params) => params.data.stage}
            />
          </div>
        </section>

        {/* Provisioning Events */}
        <section className="detail-section table-section">
          <div className="detail-section-header">Provisioning Events</div>

          <div className="provisioning-grid ag-theme-alpine">
            <AgGridReact
              rowData={eventData}
              columnDefs={eventColumnDefs}
              defaultColDef={defaultColDef}
              domLayout="autoHeight"
              suppressCellFocus={true}
              animateRows={true}
              getRowId={(params) =>
                `${params.data.timestamp}-${params.data.event}`
              }
            />
          </div>
        </section>
      </div>
    </section>
  );
};

export default page;
