(function (root, factory) {
    const api = factory();
    if (typeof module === "object" && module.exports) {
        module.exports = api;
    } else {
        root.ReportDates = api;
    }
})(typeof self !== "undefined" ? self : this, function () {

    const MONTHS = {
        jan: 1, feb: 2, mar: 3, apr: 4, may: 5, jun: 6,
        jul: 7, aug: 8, sep: 9, oct: 10, nov: 11, dec: 12
    };

    // "20 Nov 2026, 12:09 AM", "20 Nov 2026" (server display format)
    const DISPLAY_PATTERN =
        /^(\d{1,2})\s+([A-Za-z]{3,9})\.?\s+(\d{4})(?:,?\s+(\d{1,2}):(\d{2})(?::(\d{2}))?(?:\s*([AaPp])\.?[Mm]\.?)?)?$/;

    const ISO_PATTERN =
        /^(\d{4})-(\d{2})-(\d{2})(?:[T\s](\d{2}):(\d{2})(?::(\d{2}))?)?/;

    const DMY_PATTERN =
        /^(\d{1,2})[\/.-](\d{1,2})[\/.-](\d{4})$/;

    function pad(value) {
        return String(value).padStart(2, "0");
    }

    function build(year, month, day, hour, minute, second) {
        if (month < 1 || month > 12 || day < 1 || day > 31
            || hour > 23 || minute > 59 || second > 59) {
            return null;
        }

        const check = new Date(Date.UTC(year, month - 1, day));
        if (check.getUTCMonth() !== month - 1 || check.getUTCDate() !== day) {
            return null;
        }

        return {
            key: year + "-" + pad(month) + "-" + pad(day),
            time: Date.UTC(year, month - 1, day, hour, minute, second)
        };
    }

    // Parse a displayed date without relying on browser Date parsing.
    function parse(value) {
        const text = (value || "").trim();

        if (!text || text === "—" || text === "-") {
            return null;
        }

        let match = text.match(DISPLAY_PATTERN);
        if (match) {
            const month = MONTHS[match[2].substring(0, 3).toLowerCase()];
            if (!month) {
                return null;
            }

            let hour = match[4] ? Number(match[4]) : 0;
            const minute = match[5] ? Number(match[5]) : 0;
            const second = match[6] ? Number(match[6]) : 0;
            const meridiem = match[7] ? match[7].toUpperCase() : "";

            if (meridiem) {
                if (hour < 1 || hour > 12) {
                    return null;
                }
                if (meridiem === "A" && hour === 12) {
                    hour = 0;
                } else if (meridiem === "P" && hour !== 12) {
                    hour += 12;
                }
            }

            return build(Number(match[3]), month, Number(match[1]), hour, minute, second);
        }

        match = text.match(ISO_PATTERN);
        if (match) {
            return build(
                Number(match[1]), Number(match[2]), Number(match[3]),
                match[4] ? Number(match[4]) : 0,
                match[5] ? Number(match[5]) : 0,
                match[6] ? Number(match[6]) : 0
            );
        }

        match = text.match(DMY_PATTERN);
        if (match) {
            return build(Number(match[3]), Number(match[2]), Number(match[1]), 0, 0, 0);
        }

        return null;
    }

    // yyyy-mm-dd for comparison with <input type="date"> values, or "".
    function toDateKey(value) {
        const parsed = parse(value);
        return parsed ? parsed.key : "";
    }

    // Comparable timestamp for chronological sorting, or null.
    function toSortValue(value) {
        const parsed = parse(value);
        return parsed ? parsed.time : null;
    }

    return {
        parse: parse,
        toDateKey: toDateKey,
        toSortValue: toSortValue
    };
});
