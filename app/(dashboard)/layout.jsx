import Header from "../../components/Header";
import Sidenav from "../../components/Sidenav";
import GridProvider from "../../components/GridProvider";

export default function DashboardLayout({ children }) {
  return (
    <section className="app-shell">
      <Header />
      <div className="app-body">
        <Sidenav />
        <GridProvider>
          <div className="app-content">{children}</div>
        </GridProvider>
      </div>
    </section>
  );
}
