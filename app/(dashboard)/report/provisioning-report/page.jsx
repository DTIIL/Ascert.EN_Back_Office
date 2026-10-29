import ReportView from "../../../../components/ReportView";
import { rowDataProvisioningReport } from "../../../../public/data";

export default function Page() {
  return (
    <ReportView
      title="Provisioning Report"
      placeholder="Search provisioning report"
      rows={rowDataProvisioningReport}
    />
  );
}
