"use client";

import Link from "next/link";
import {
  Download,
  FileSliders,
  FileText,
  PencilLine,
  ShieldAlert,
  Smartphone,
} from "lucide-react";
import "./report.css";

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
    body: "DSC and token downloads with success, failure, and errors",
    path: "/report/dsc-download-report",
  },
  {
    image: PencilLine,
    title: "Signing Report",
    body: "Signing activity with success, failure, and error details",
    path: "/report/sign-report",
  },
];

export default function Page() {
  return (
    <section className="report-section">
      <header className="page-head">
        <div>
          <h1>Reports</h1>
          <p>
            View records for devices, provisioning, downloads, and signing.
          </p>
        </div>
      </header>

      <div className="report-grid">
        {reportSection.map((item) => {
          const Icon = item.image;

          return (
            <Link key={item.path} href={item.path} className="report-card">
              <span className="report-icon">
                <Icon size={20} />
                {item.title}
              </span>
              <span className="report-content">{item.body}</span>
            </Link>
          );
        })}
      </div>
    </section>
  );
}
