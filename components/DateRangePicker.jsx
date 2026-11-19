"use client";

export default function DateRangePicker({
  startDate,
  endDate,
  onStartChange,
  onEndChange,
}) {
  return (
    <>
      <div className="date-range" role="group" aria-label="Filter by date">
        <label className="date-field">
          <span>From</span>
          <input
            className="custom-input date-input"
            type="date"
            aria-label="Start date"
            value={startDate}
            max={endDate || undefined}
            onChange={(event) => onStartChange(event.target.value)}
          />
        </label>
        <label className="date-field">
          <span>To</span>
          <input
            className="custom-input date-input"
            type="date"
            aria-label="End date"
            value={endDate}
            min={startDate || undefined}
            onChange={(event) => onEndChange(event.target.value)}
          />
        </label>
      </div>
      {startDate || endDate ? (
        <button
          type="button"
          className="btn btn-secondary"
          onClick={() => {
            onStartChange("");
            onEndChange("");
          }}
        >
          Clear dates
        </button>
      ) : null}
    </>
  );
}
