import "./globals.css";
import { IBM_Plex_Sans } from "next/font/google";
import localFont from "next/font/local";

const plex = IBM_Plex_Sans({
  subsets: ["latin"],
  weight: ["400", "500", "600", "700"],
  variable: "--font-plex",
  display: "swap",
});
const ancorli = localFont({
  src: "../public/fonts/Ancorli.otf",
  variable: "--font-ancorli",
  display: "swap",
});

export const metadata = {
  title: "Ascert.EN | Qualified Digital Signing",
  description:
    "Back office for Ascert.en qualified digital signing. Manage devices, users, provisioning, and reports.",
};
export default function RootLayout({ children }: LayoutProps<"/">) {
  return (
    <html lang="en" className={`${plex.variable} ${ancorli.variable}`}>
      <body>
        <main>{children}</main>
      </body>
    </html>
  );
}
