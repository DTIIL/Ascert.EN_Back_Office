import ReportView from "../../../../components/ReportView";
import { rowDataProvisioningReport } from "../../../../public/data";

export default function Page() {
  return (
    <ReportView
      title="DSC Download Report"
      placeholder="Search DSC download report"
      rows={rowDataProvisioningReport}
    />
  );
}
