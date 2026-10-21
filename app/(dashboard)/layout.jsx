import Header from "../../components/Header";
import Sidenav from "../../components/Sidenav";

export default function RootLayout({ children }) {
  return (
    <section className="app-shell">
      <Header />
      <div className="app-body">
        <Sidenav />
        <div className="app-content">{children}</div>
      </div>
    </section>
  );
}
