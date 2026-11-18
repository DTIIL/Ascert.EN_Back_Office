<nav class="sidenav" aria-label="Main">
  <p class="sidenav-label">Workspace</p>
  <ul class="sidenav-list">
    <li>
      <a class="sidenav-link${fn:startsWith(currentPath, '/dashboard') ? ' active' : ''}"
         href="${ctx}/dashboard"
         aria-current="${fn:startsWith(currentPath, '/dashboard') ? 'page' : 'false'}">
        <svg viewBox="0 0 24 24" aria-hidden="true">
          <rect x="3" y="3" width="8" height="8" rx="1.5" />
          <rect x="13" y="3" width="8" height="5" rx="1.5" />
          <rect x="13" y="10" width="8" height="11" rx="1.5" />
          <rect x="3" y="13" width="8" height="8" rx="1.5" />
        </svg>
        <span>Dashboard</span>
      </a>
    </li>
    <li>
      <a class="sidenav-link${fn:startsWith(currentPath, '/qdsdmanager') ? ' active' : ''}"
         href="${ctx}/qdsdmanager"
         aria-current="${fn:startsWith(currentPath, '/qdsdmanager') ? 'page' : 'false'}">
        <svg viewBox="0 0 24 24" aria-hidden="true">
          <rect x="6" y="3" width="12" height="18" rx="2" />
          <path d="M10 7h4M10 11h4M10 15h2" />
        </svg>
        <span>QDSD Manager</span>
      </a>
    </li>
    <li>
      <a class="sidenav-link${fn:startsWith(currentPath, '/factoryprovising') ? ' active' : ''}"
         href="${ctx}/factoryprovising"
         aria-current="${fn:startsWith(currentPath, '/factoryprovising') ? 'page' : 'false'}">
        <svg viewBox="0 0 24 24" aria-hidden="true">
          <path d="M3 20V10l5 3V10l5 3V8l8 4v8H3z" />
          <path d="M7 20v-3h3v3M14 20v-3h3v3" />
        </svg>
        <span>Factory Provisioning</span>
      </a>
    </li>
    <li>
      <a class="sidenav-link${currentPath == '/user' || fn:startsWith(currentPath, '/user/') ? ' active' : ''}"
         href="${ctx}/user"
         aria-current="${currentPath == '/user' || fn:startsWith(currentPath, '/user/') ? 'page' : 'false'}">
        <svg viewBox="0 0 24 24" aria-hidden="true">
          <circle cx="9" cy="8" r="3" />
          <path d="M3.5 19c.6-3 2.8-4.5 5.5-4.5s4.9 1.5 5.5 4.5" />
          <circle cx="17" cy="9" r="2.2" />
          <path d="M16.2 14.6c2 .4 3.5 1.6 4.3 4.4" />
        </svg>
        <span>Users</span>
      </a>
    </li>
    <li>
      <a class="sidenav-link${fn:startsWith(currentPath, '/report') ? ' active' : ''}"
         href="${ctx}/report"
         aria-current="${fn:startsWith(currentPath, '/report') ? 'page' : 'false'}">
        <svg viewBox="0 0 24 24" aria-hidden="true">
          <path d="M6 3h8l4 4v14H6z" />
          <path d="M14 3v5h5M9 13h6M9 17h4" />
        </svg>
        <span>Reports</span>
      </a>
    </li>
    <li>
      <a class="sidenav-link${fn:startsWith(currentPath, '/settings') ? ' active' : ''}"
         href="${ctx}/settings"
         aria-current="${fn:startsWith(currentPath, '/settings') ? 'page' : 'false'}">
        <svg viewBox="0 0 24 24" aria-hidden="true">
          <circle cx="12" cy="12" r="3" />
          <path d="M12 3.5v2.2M12 18.3v2.2M4.8 6.2l1.6 1.6M17.6 16.2l1.6 1.6M3.5 12h2.2M18.3 12h2.2M4.8 17.8l1.6-1.6M17.6 7.8l1.6-1.6" />
        </svg>
        <span>Settings</span>
      </a>
    </li>
  </ul>
</nav>
