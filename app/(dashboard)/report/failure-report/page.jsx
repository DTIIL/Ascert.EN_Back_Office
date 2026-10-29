import ReportView from "../../../../components/ReportView";
import { rowDataProvisioningReport } from "../../../../public/data";

export default function Page() {
  return (
    <ReportView
      title="Failure Report"
      placeholder="Search failure report"
      rows={rowDataProvisioningReport}
    />
  );
}
