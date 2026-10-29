export function filterRows(rows, query, extra) {
  const normalized = query.trim().toLowerCase();

  if (!normalized && !extra) return rows;

  return rows.filter((row) => {
    const matchesSearch =
      !normalized ||
      Object.values(row).some((value) =>
        String(value ?? "")
          .toLowerCase()
          .includes(normalized),
      );

    return matchesSearch && (extra ? extra(row) : true);
  });
}
