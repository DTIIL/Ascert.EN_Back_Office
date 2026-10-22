export const STATUS_STYLES = {
  Paired: { background: "forestgreen", color: "white" },
  "Not Paired": { background: "red", color: "white" },

  Downloaded: { background: "forestgreen", color: "white" },
  "Not Downloaded": { background: "red", color: "white" },
  "Download Failed": { background: "red", color: "white" },
  Pending: { background: "sandybrown", color: "white" },

  Ready: { background: "forestgreen", color: "white" },
  Error: { background: "red", color: "white" },
  Suspended: { background: "sandybrown", color: "white" },
  "Waiting for DSC": { background: "gray", color: "white" },
  Inactive: { background: "#DCDCDC", color: "#333" },
};
export const StatusRenderer = ({ value }) => {
  const style = STATUS_STYLES[value];

  if (!style) return value ?? "";

  return (
    <span
      style={{
        ...style,
        padding: "3px 7px",
        borderRadius: "4px",
        fontSize: "12px",
      }}
    >
      {value}
    </span>
  );
};
export const EditUserRenderer = (params) => {
  return (
    <span
      onClick={() => params.onEdit?.(params.data)}
      style={{
        padding: "3px 7px",
        borderRadius: "4px",
        fontSize: "14px",
        color: "blue",
        cursor: "pointer",
      }}
    >
      Edit
    </span>
  );
};
