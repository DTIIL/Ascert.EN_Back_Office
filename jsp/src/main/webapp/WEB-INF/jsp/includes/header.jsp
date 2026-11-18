<header class="header-container">
  <div class="flex-item-center gap-10">
    <img src="${ctx}/assets/Icon_logo.svg" width="32" height="32" alt="Ascert.en logo" />
    <div class="heading">
      <span class="brand-title">Ascert.en</span>
      <span class="brand-subtitle">Back Office</span>
    </div>
  </div>

  <div class="user-menu" data-user-menu>
    <button
      type="button"
      class="user-chip"
      data-user-toggle
      aria-expanded="false"
      aria-haspopup="menu"
    >
      <img src="${ctx}/assets/person_logo.svg" width="32" height="32" alt="" />
      <div class="heading">
        <span class="user-name">John Doe</span>
        <span class="user-role">Admin</span>
      </div>
    </button>
    <div class="logout-container" data-user-panel role="menu" hidden>
      <form method="post" action="${ctx}/logout">
        <button type="submit" class="logout-btn-minimal" role="menuitem">Log Out</button>
      </form>
    </div>
  </div>
</header>
