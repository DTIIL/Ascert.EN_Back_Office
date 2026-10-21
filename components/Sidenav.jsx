"use client";
import Link from "next/link";
import { usePathname } from "next/navigation";

const NAV_ITEMS = [
  {
    href: "/dashboard",
    label: "Dashboard",
    icon: (
      <svg viewBox="0 0 24 24" aria-hidden="true">
        <rect x="3" y="3" width="8" height="8" rx="1.5" />
        <rect x="13" y="3" width="8" height="5" rx="1.5" />
        <rect x="13" y="10" width="8" height="11" rx="1.5" />
        <rect x="3" y="13" width="8" height="8" rx="1.5" />
      </svg>
    ),
  },
  {
    href: "/qdsdmanager",
    label: "QDSD Manager",
    icon: (
      <svg viewBox="0 0 24 24" aria-hidden="true">
        <rect x="6" y="3" width="12" height="18" rx="2" />
        <path d="M10 7h4M10 11h4M10 15h2" />
      </svg>
    ),
  },
  {
    href: "/factoryprovising",
    label: "Factory Provisioning",
    icon: (
      <svg viewBox="0 0 24 24" aria-hidden="true">
        <path d="M3 20V10l5 3V10l5 3V8l8 4v8H3z" />
        <path d="M7 20v-3h3v3M14 20v-3h3v3" />
      </svg>
    ),
  },

  {
    href: "/user",
    label: "Users",
    icon: (
      <svg viewBox="0 0 24 24" aria-hidden="true">
        <circle cx="9" cy="8" r="3" />
        <path d="M3.5 19c.6-3 2.8-4.5 5.5-4.5s4.9 1.5 5.5 4.5" />
        <circle cx="17" cy="9" r="2.2" />
        <path d="M16.2 14.6c2 .4 3.5 1.6 4.3 4.4" />
      </svg>
    ),
  },
  {
    href: "/report",
    label: "Reports",
    icon: (
      <svg viewBox="0 0 24 24" aria-hidden="true">
        <path d="M6 3h8l4 4v14H6z" />
        <path d="M14 3v5h5M9 13h6M9 17h4" />
      </svg>
    ),
  },
  {
    href: "/settings",
    label: "Settings",
    icon: (
      <svg viewBox="0 0 24 24" aria-hidden="true">
        <circle cx="12" cy="12" r="3" />
        <path d="M12 3.5v2.2M12 18.3v2.2M4.8 6.2l1.6 1.6M17.6 16.2l1.6 1.6M3.5 12h2.2M18.3 12h2.2M4.8 17.8l1.6-1.6M17.6 7.8l1.6-1.6" />
      </svg>
    ),
  },
];

const Sidenav = () => {
  const pathname = usePathname();

  return (
    <nav className="sidenav" aria-label="Main">
      <ul className="sidenav-list">
        {NAV_ITEMS.map((item) => {
          const isActive =
            pathname === item.href || pathname.startsWith(`${item.href}/`);

          return (
            <li key={item.href}>
              <Link
                href={item.href}
                className={`sidenav-link${isActive ? " active" : ""}`}
                aria-current={isActive ? "page" : undefined}
              >
                {item.icon}
                <span>{item.label}</span>
              </Link>
            </li>
          );
        })}
      </ul>
    </nav>
  );
};

export default Sidenav;
