import Charts from "./charts/Charts";
import "./dashboard.css";
const page = () => {
  return (
    <section className="dashboard-section">
      <div>
        <div className="page-head">
          <div>
            <span>Dashboard</span>
            <p>Welcome back, {`User's Name`}!</p>
          </div>
        </div>
        <div className="stats">
          <div className="stat">
            <div className="label">
              <span className="dot" style={{ background: "#3b82f6" }}></span>{" "}
              Total Users
            </div>
            <b>120</b>
          </div>
          <div className="stat">
            <div className="label">
              <span className="dot" style={{ background: "#22c55e" }}></span>{" "}
              Active Users
            </div>
            <b>100</b>
          </div>
          <div className="stat">
            <div className="label">
              <span className="dot" style={{ background: "#f59e0b" }}></span>{" "}
              Pending Users
            </div>
            <b>5</b>
          </div>
          <div className="stat">
            <div className="label">
              <span className="dot" style={{ background: "#ef4444" }}></span>{" "}
              Suspended Users
            </div>
            <b>15</b>
          </div>
        </div>
      </div>
      <div>
        <Charts />
      </div>
      <div>
        <div className="stats">
          <div className="stat">
            <div className="label">
              <span className="dot" style={{ background: "#3b82f6" }}></span>{" "}
              Paired QDSD
            </div>
            <b>90</b>
          </div>
          <div className="stat">
            <div className="label">
              <span className="dot" style={{ background: "#22c55e" }}></span>{" "}
              Waiting for DSC
            </div>
            <b>23</b>
          </div>
          <div className="stat">
            <div className="label">
              <span className="dot" style={{ background: "#f59e0b" }}></span>{" "}
              Download failed
            </div>
            <b>23</b>
          </div>
          <div className="stat">
            <div className="label">
              <span className="dot" style={{ background: "#ef4444" }}></span>{" "}
              Ready
            </div>
            <b>50</b>
          </div>
        </div>
      </div>
    </section>
  );
};

export default page;
