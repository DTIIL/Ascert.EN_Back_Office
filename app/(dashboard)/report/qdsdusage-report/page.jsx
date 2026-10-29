import ReportView from "../../../../components/ReportView";
import { rowDataProvisioningReport } from "../../../../public/data";

export default function Page() {
  return (
    <ReportView
      title="QDSD Usage Report"
      placeholder="Search QDSD usage report"
      rows={rowDataProvisioningReport}
    />
  );
}
