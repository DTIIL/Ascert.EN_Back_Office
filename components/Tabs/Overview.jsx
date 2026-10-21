"use client";
import "./overview.css";
const sections = [
  {
    title: "Basic Information",
    columns: [
      [
        { label: "QDSD ID", value: "****7A31" },
        { label: "Serial Number", value: "SN12345678" },
        { label: "Assigned User", value: "Ravi Kumar" },
        { label: "User Email", value: "ravi.kumar@abc.com" },
        { label: "User Mobile", value: "+91 98765 43210" },
      ],
      [
        { label: "Organization", value: "ABC Pvt Ltd" },
        { label: "QDSD Status", value: "Ready", status: "success" },
        { label: "Created Date", value: "15 Aug 2026 11:30 AM" },
        { label: "Last Used", value: "12 Sep 2026 10:24 AM" },
      ],
    ],
  },
  {
    title: "Pairing Information",
    columns: [
      [
        {
          label: "Pairing Status",
          value: "Paired",
          status: "success",
        },
        { label: "Paired Date & Time", value: "15 Aug 2026 11:35 AM" },
        { label: "Last Pairing Attempt", value: "15 Aug 2026 11:35 AM" },
      ],
      [
        { label: "Paired Device", value: "Samsung Galaxy S23" },
        { label: "Paired By", value: "Ravi Kumar" },
      ],
    ],
  },
  {
    title: "DSC / Download Information",
    columns: [
      [
        {
          label: "Download Status",
          value: "Downloaded",
          status: "success",
        },
        { label: "Download Date & Time", value: "16 Aug 2026 09:20 AM" },
        { label: "Downloaded By", value: "Ravi Kumar" },
      ],
      [
        { label: "CA Name", value: "ABC Certifying Authority" },
        { label: "Certificate Validity", value: "16 Aug 2026 – 16 Aug 2028" },
        { label: "Download Attempts", value: "1" },
      ],
    ],
  },
  {
    title: "Certificate Details",
    columns: [
      [
        { label: "Certificate Serial Number", value: "AB12CD34EF56" },
        { label: "Subject Name", value: "Ravi Kumar" },
        { label: "Issuer", value: "ABC Certifying Authority" },
      ],
      [
        { label: "Valid From", value: "16 Aug 2026 09:20 AM" },
        { label: "Valid To", value: "16 Aug 2028 09:20 AM" },
        {
          label: "Certificate Status",
          value: "Valid",
          status: "success",
        },
      ],
    ],
  },
];
function DetailItem({ label, value, status }) {
  return (
    <div className="detail-row">
      <span className="detail-label">{label}</span>
      <div className="detail-value">
        {status ? (
          <span className={`status-badge status-${status}`}>{value}</span>
        ) : (
          value
        )}
      </div>
    </div>
  );
}

function DetailSection({ title, columns }) {
  return (
    <section className="detail-section">
      <div className="detail-section-header">{title}</div>
      <div className="detail-section-body">
        {columns.map((item, index) => (
          <div className="detail-column" key={`${title}-${index}`}>
            {item.map((item) => (
              <DetailItem key={item.label} {...item} />
            ))}
          </div>
        ))}
      </div>
    </section>
  );
}
const Overview = () => {
  return (
    <main className="qdsd-details-page">
      {sections.map((section) => (
        <DetailSection key={section.title} {...section} />
      ))}
    </main>
  );
};

export default Overview;
