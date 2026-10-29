import dynamic from "next/dynamic";
import "./dashboard.css";

const Charts = dynamic(() => import("./charts/Charts"), {
  loading: () => <div className="chart-skeleton" aria-hidden="true" />,
});

const USER_STATS = [
  { label: "Total users", value: "120", hint: "Every account on the platform", color: "#005df8" },
  { label: "Active users", value: "100", hint: "Signed in during this cycle", color: "#1e6b3c" },
  { label: "Pending users", value: "5", hint: "Waiting for approval", color: "#e8a33d" },
  { label: "Suspended users", value: "15", hint: "Access currently blocked", color: "#b42318" },
];

const DEVICE_STATS = [
  { label: "Paired QDSD", value: "90", hint: "Devices linked to a user", color: "#005df8" },
  { label: "Waiting for DSC", value: "23", hint: "Certificate still pending", color: "#1e6b3c" },
  { label: "Download failed", value: "23", hint: "Needs a retry or support", color: "#e8a33d" },
  { label: "Ready", value: "50", hint: "Available for signing", color: "#b42318" },
];

function StatGrid({ items }) {
  return (
    <div className="stats">
      {items.map((item) => (
        <article className="stat" key={item.label}>
          <div className="label">
            <span className="dot" style={{ background: item.color }} />
            {item.label}
          </div>
          <b>{item.value}</b>
          <p className="stat-hint">{item.hint}</p>
        </article>
      ))}
    </div>
  );
}

export default function Page() {
  return (
    <section className="dashboard-section">
      <header className="page-head">
        <div>
          <h1>Dashboard</h1>
          <p>Welcome back, John Doe. Here is what needs attention today.</p>
        </div>
      </header>
      <StatGrid items={USER_STATS} />
      <Charts />
      <h2 className="section-label">QDSD pipeline</h2>
      <StatGrid items={DEVICE_STATS} />
    </section>
  );
}
