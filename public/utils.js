const TONE = {
  success: { background: "#e7f6ee", color: "#17693a" },
  warning: { background: "#fff4e5", color: "#9a5b00" },
  danger: { background: "#fdecec", color: "#b42318" },
  neutral: { background: "#eef1f6", color: "#3d4a63" },
  info: { background: "#e7f0ff", color: "#0b4fc4" },
};

export const STATUS_STYLES = {
  Paired: TONE.success,
  Downloaded: TONE.success,
  Ready: TONE.success,
  Active: TONE.success,
  Completed: TONE.success,
  Complete: TONE.success,
  Success: TONE.success,
  Valid: TONE.success,

  Pending: TONE.warning,
  Suspended: TONE.warning,
  "In Progress": TONE.warning,
  "Waiting for DSC": TONE.neutral,

  "Not Paired": TONE.danger,
  "Not Downloaded": TONE.danger,
  "Download Failed": TONE.danger,
  Error: TONE.danger,
  Failed: TONE.danger,

  Inactive: TONE.neutral,
};

export const StatusRenderer = ({ value }) => {
  const style = STATUS_STYLES[value];

  if (!style) return value ?? "";

  return (
    <span className="status-pill" style={style}>
      {value}
    </span>
  );
};

export const EditUserRenderer = (params) => {
  return (
    <button
      type="button"
      className="text-action"
      onClick={() => params.onEdit?.(params.data)}
    >
      Edit
    </button>
  );
};
