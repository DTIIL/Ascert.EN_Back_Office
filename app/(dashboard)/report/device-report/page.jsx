import ReportView from "../../../../components/ReportView";
import { rowDataProvisioningReport } from "../../../../public/data";

export default function Page() {
  return (
    <ReportView
      title="Device Report"
      placeholder="Search device report"
      rows={rowDataProvisioningReport}
    />
  );
}
