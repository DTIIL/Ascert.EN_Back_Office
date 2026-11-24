<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="date-range" role="group" aria-label="Filter by date">
  <label class="date-field">
    <span>From</span>
    <input
      class="custom-input date-input"
      type="date"
      aria-label="Start date"
      data-grid-from="${fn:escapeXml(param.grid)}"
    />
  </label>
  <label class="date-field">
    <span>To</span>
    <input
      class="custom-input date-input"
      type="date"
      aria-label="End date"
      data-grid-to="${fn:escapeXml(param.grid)}"
    />
  </label>
</div>
<button type="button" class="btn btn-secondary" data-grid-clear="${fn:escapeXml(param.grid)}" hidden>
  Clear dates
</button>
