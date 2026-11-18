<%@ include file="/WEB-INF/jsp/includes/shell-open.jsp" %>
<section class="dashboard-section">
  <header class="page-head">
    <div>
      <h1>Dashboard</h1>
      <p>Welcome back, John Doe. Here is what needs attention today.</p>
    </div>
  </header>

  <div class="stats">
    <article class="stat">
      <div class="label"><span class="dot" style="background:#005df8"></span>Total users</div>
      <b>120</b>
      <p class="stat-hint">Every account on the platform</p>
    </article>
    <article class="stat">
      <div class="label"><span class="dot" style="background:#1e6b3c"></span>Active users</div>
      <b>100</b>
      <p class="stat-hint">Signed in during this cycle</p>
    </article>
    <article class="stat">
      <div class="label"><span class="dot" style="background:#e8a33d"></span>Pending users</div>
      <b>5</b>
      <p class="stat-hint">Waiting for approval</p>
    </article>
    <article class="stat">
      <div class="label"><span class="dot" style="background:#b42318"></span>Suspended users</div>
      <b>15</b>
      <p class="stat-hint">Access currently blocked</p>
    </article>
  </div>

  <div class="chart-grid">
    <article class="chart-card">
      <h2>QDSD activity</h2>
      <div class="chart-canvas"><canvas id="chart-activity"></canvas></div>
    </article>
    <article class="chart-card">
      <h2>Signatures</h2>
      <div class="chart-canvas"><canvas id="chart-signatures"></canvas></div>
    </article>
    <article class="chart-card">
      <h2>Failures</h2>
      <div class="chart-canvas"><canvas id="chart-failures"></canvas></div>
    </article>
  </div>

  <h2 class="section-label">QDSD pipeline</h2>
  <div class="stats">
    <article class="stat">
      <div class="label"><span class="dot" style="background:#005df8"></span>Paired QDSD</div>
      <b>90</b>
      <p class="stat-hint">Devices linked to a user</p>
    </article>
    <article class="stat">
      <div class="label"><span class="dot" style="background:#1e6b3c"></span>Waiting for DSC</div>
      <b>23</b>
      <p class="stat-hint">Certificate still pending</p>
    </article>
    <article class="stat">
      <div class="label"><span class="dot" style="background:#e8a33d"></span>Download failed</div>
      <b>23</b>
      <p class="stat-hint">Needs a retry or support</p>
    </article>
    <article class="stat">
      <div class="label"><span class="dot" style="background:#b42318"></span>Ready</div>
      <b>50</b>
      <p class="stat-hint">Available for signing</p>
    </article>
  </div>
</section>
<script src="${ctx}/assets/js/chart.umd.min.js"></script>
<script>
  (function () {
    if (!window.Chart) return;
    var days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    var charts = [
      { id: "chart-activity", color: "#005df8", data: [12, 19, 8, 15, 22, 10, 5] },
      { id: "chart-signatures", color: "#e8a33d", data: [30, 28, 34, 22, 40, 18, 12] },
      { id: "chart-failures", color: "#b42318", data: [2, 1, 4, 1, 3, 0, 1] }
    ];
    charts.forEach(function (chart) {
      var canvas = document.getElementById(chart.id);
      if (!canvas) return;
      new Chart(canvas, {
        type: "bar",
        data: {
          labels: days,
          datasets: [{
            data: chart.data,
            backgroundColor: chart.color,
            borderRadius: 6,
            maxBarThickness: 22
          }]
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          animation: { duration: 350 },
          plugins: { legend: { display: false }, tooltip: { displayColors: false } },
          scales: {
            x: { grid: { display: false }, ticks: { color: "#4a5875", font: { size: 11 } } },
            y: {
              beginAtZero: true,
              ticks: { color: "#4a5875", font: { size: 11 }, precision: 0 },
              grid: { color: "#eef2f7" }
            }
          }
        }
      });
    });
  })();
</script>
<%@ include file="/WEB-INF/jsp/includes/shell-close.jsp" %>
