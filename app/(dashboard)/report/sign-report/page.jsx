import ReportView from "../../../../components/ReportView";
import { rowDataProvisioningReport } from "../../../../public/data";

export default function Page() {
  return (
    <ReportView
      title="Signing Report"
      placeholder="Search signing report"
      rows={rowDataProvisioningReport}
    />
  );
}
