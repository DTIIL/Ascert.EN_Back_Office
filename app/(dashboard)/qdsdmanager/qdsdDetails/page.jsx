"use client";
import { useRouter } from "next/navigation";
import "./qdsdDetails.css";
import ReusableTab from "../../../../components/ReusableTab";
import Overview from "../../../../components/Tabs/Overview";
import DownloadHistory from "../../../../components/Tabs/DownloadHistory";
import SigningHistory from "../../../../components/Tabs/SigningHistory";
import ErrorLogs from "../../../../components/Tabs/ErrorLogs";
import ActivityHistory from "../../../../components/Tabs/ActivityHistory";
const page = () => {
  // eslint-disable-next-line react-hooks/rules-of-hooks
  const router = useRouter();

  const handleBack = () => {
    router.push("/qdsdmanager");
  };

  const tabs = [
    {
      id: "Overview",
      label: "Overview",
      content: (
        <div>
          <Overview />
        </div>
      ),
    },
    {
      id: "Download History",
      label: "Download History",
      content: (
        <div>
          <DownloadHistory />
        </div>
      ),
    },
    {
      id: "Signing History",
      label: "Signing History",
      content: (
        <div>
          <SigningHistory />
        </div>
      ),
    },
    {
      id: "Error Logs",
      label: "Error Logs",
      content: (
        <div>
          <ErrorLogs />
        </div>
      ),
    },
    {
      id: "Activity History",
      label: "Activity History",
      content: (
        <div>
          <ActivityHistory />
        </div>
      ),
    },
  ];

  return (
    <section style={{ display: "grid", gap: "14px" }}>
      <div className="grid">
        <span className="back-btn" onClick={handleBack}>
          ← Back to QDSD Manager
        </span>
        <span className="title">QDSD Details</span>
      </div>
      <div className="flex stat">
        <div className="grid">
          <span className="sub-title">QDSD ID</span>
          <span>*******</span>
        </div>

        <div className="grid">
          <span className="sub-title">Serial Number</span>
          <span>*******</span>
        </div>
        <div className="grid">
          <span className="sub-title">Assigned User</span>
          <span>*******</span>
        </div>
        <div className="grid">
          <span className="sub-title">Organization</span>
          <span>*******</span>
        </div>
        <div className="grid">
          <span className="sub-title">Pairing Status</span>
          <span>*******</span>
        </div>
        <div className="grid">
          <span className="sub-title">Download Status</span>
          <span>*******</span>
        </div>
        <div className="grid">
          <span className="sub-title">QDSD Status</span>
          <span>*******</span>
        </div>
      </div>
      <div>
        <ReusableTab tabs={tabs} defaultActiveTab={0} />
      </div>
    </section>
  );
};

export default page;
