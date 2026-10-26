"use client";
import { useRouter } from "next/navigation";
import "./report.css";
import {
  Download,
  FileSliders,
  FileText,
  PencilLine,
  ShieldAlert,
  Smartphone,
} from "lucide-react";

const reportSection = [
  {
    image: Smartphone,
    title: "Provisioning Report",
    body: "View provisioning records and status for all devices",
    path: "/report/provisioning-report",
  },
  {
    image: FileSliders,
    title: "QDSD Usage Report",
    body: "View QDSD usage and signing activity",
    path: "/report/qdsdusage-report",
  },
  {
    image: FileText,
    title: "Device Report",
    body: "View device and secure element details",
    path: "/report/device-report",
  },
  {
    image: ShieldAlert,
    title: "Failure Report",
    body: "View failed provisioning and usage records",
    path: "/report/failure-report",
  },
  {
    image: Download,
    title: "DSC Download Report",
    body: "DSC/token downloads with status, success, failure, and errors",
    path: "/report/dsc-download-report",
  },
  {
    image: PencilLine,
    title: "Signing Report",
    body: "Signing activity with success, failure, and error details",
    path: "/report/sign-report",
  },
];

const Page = () => {
  const router = useRouter();

  return (
    <section className="report-section">
      <div className="report-header">
        <h1>Reports</h1>
        <p>
          View and generate reports related to devices, provisioning, users, and
          usage.
        </p>
      </div>

      <div className="container">
        {reportSection.map((item) => {
          const Icon = item.image;

          return (
            <div
              key={item.title}
              onClick={() => router.push(item.path)}
              className="stat"
            >
              <div className="report-icon">
                <Icon size={26} />
                <span>{item.title}</span>
              </div>

              <div className="report-content">
                <span>{item.body}</span>
              </div>
            </div>
          );
        })}
      </div>
    </section>
  );
};

export default Page;
