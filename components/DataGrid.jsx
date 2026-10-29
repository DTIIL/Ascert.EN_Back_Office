"use client";

import { themeQuartz } from "ag-grid-community";
import { AgGridReact } from "ag-grid-react";

const gridTheme = themeQuartz.withParams({
  fontFamily: "inherit",
  fontSize: 13,
  headerFontSize: 12,
  headerFontWeight: 600,
  headerBackgroundColor: "#f6f8fc",
  headerTextColor: "#4a5875",
  foregroundColor: "#1d1d1b",
  backgroundColor: "#ffffff",
  oddRowBackgroundColor: "#fbfcfe",
  borderColor: "#e6ebf2",
  rowHoverColor: "#f3f7ff",
  accentColor: "#005df8",
  cellHorizontalPadding: 14,
  wrapperBorderRadius: 12,
});

const defaultColDef = {
  flex: 1,
  minWidth: 120,
  sortable: true,
  resizable: true,
  suppressHeaderMenuButton: true,
};

export default function DataGrid({
  rowData,
  columnDefs,
  onRowClicked,
  getRowId,
}) {
  return (
    <div className="ag-grid">
      <AgGridReact
        theme={gridTheme}
        rowData={rowData}
        columnDefs={columnDefs}
        defaultColDef={defaultColDef}
        pagination
        paginationPageSize={12}
        paginationPageSizeSelector={[12, 24, 48]}
        animateRows={false}
        rowHeight={46}
        headerHeight={44}
        onRowClicked={onRowClicked}
        getRowId={getRowId}
        overlayNoRowsTemplate="No records match your search."
      />
    </div>
  );
}
