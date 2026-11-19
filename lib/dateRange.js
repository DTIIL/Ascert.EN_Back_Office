const MONTHS = {
  jan: 0,
  feb: 1,
  mar: 2,
  apr: 3,
  may: 4,
  jun: 5,
  jul: 6,
  aug: 7,
  sep: 8,
  oct: 9,
  nov: 10,
  dec: 11,
};

export function parseDisplayDate(value) {
  if (!value) return null;

  const match = String(value)
    .trim()
    .match(
      /^(\d{1,2})\s+([A-Za-z]{3})\s+(\d{4})(?:\s+(\d{1,2}):(\d{2})\s*(AM|PM))?/i,
    );

  if (!match) {
    const parsed = new Date(value);
    return Number.isNaN(parsed.getTime()) ? null : parsed;
  }

  const month = MONTHS[match[2].toLowerCase()];
  if (month === undefined) return null;

  let hours = match[4] ? Number(match[4]) : 0;
  const minutes = match[5] ? Number(match[5]) : 0;
  const meridiem = match[6]?.toUpperCase();
  if (meridiem === "PM" && hours < 12) hours += 12;
  if (meridiem === "AM" && hours === 12) hours = 0;

  return new Date(
    Number(match[3]),
    month,
    Number(match[1]),
    hours,
    minutes,
    0,
    0,
  );
}

export function dateBound(isoDate, endOfDay) {
  if (!isoDate) return null;
  const [year, month, day] = isoDate.split("-").map(Number);
  if (!year || !month || !day) return null;
  return endOfDay
    ? new Date(year, month - 1, day, 23, 59, 59, 999)
    : new Date(year, month - 1, day, 0, 0, 0, 0);
}

export function isWithinDateRange(value, startDate, endDate) {
  const from = dateBound(startDate, false);
  const to = dateBound(endDate, true);
  if (!from && !to) return true;

  const updated = parseDisplayDate(value);
  if (!updated) return false;
  if (from && updated < from) return false;
  if (to && updated > to) return false;
  return true;
}
