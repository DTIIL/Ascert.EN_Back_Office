(function () {
  document.querySelectorAll("[data-user-menu]").forEach(function (menu) {
    var button = menu.querySelector("[data-user-toggle]");
    var panel = menu.querySelector("[data-user-panel]");
    if (!button || !panel) return;

    button.addEventListener("click", function () {
      var open = panel.hasAttribute("hidden");
      if (open) panel.removeAttribute("hidden");
      else panel.setAttribute("hidden", "");
      button.setAttribute("aria-expanded", open ? "true" : "false");
    });

    document.addEventListener("mousedown", function (event) {
      if (!menu.contains(event.target)) {
        panel.setAttribute("hidden", "");
        button.setAttribute("aria-expanded", "false");
      }
    });
  });

  var loginForm = document.getElementById("loginForm");
  if (loginForm) {
    bindValidatedForm(loginForm, [
      {
        input: document.getElementById("email"),
        error: document.getElementById("email-error"),
        field: document.querySelector("#loginForm .login-field[for='email']"),
        message: function (value) {
          if (!value.trim()) return "Please enter your email address";
          if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value.trim())) {
            return "Please enter a valid email address";
          } 
          return "";
        },
      },
      {
        input: document.getElementById("password"),
        error: document.getElementById("password-error"),
        field: document.querySelector("#loginForm .login-field[for='password']"),
        message: function (value) {
          if (!value.trim()) return "Please enter your password";
          return "";
        },
      },
    ]);
  }

  var userForm = document.getElementById("userForm");
  if (userForm) {
    bindValidatedForm(userForm, [
      fieldRule("fullName", function (value) {
        if (!value.trim()) return "Please enter the full name";
        return "";
      }),
      fieldRule("email", function (value) {
        if (!value.trim()) return "Please enter an email address";
        if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value.trim())) {
          return "Please enter a valid email address";
        }
        return "";
      }),
      fieldRule("mobile", function (value) {
        if (!value.trim()) return "Please enter a mobile number";
        if (!/^\d{10}$/.test(value.replace(/\D/g, ""))) {
          return "Please enter a valid mobile number";
        }
        return "";
      }),
      fieldRule("role", function (value) {
        if (!value) return "Please select a role";
        return "";
      }),
      fieldRule("status", function (value) {
        if (!value) return "Please select a status";
        return "";
      }),
    ]);
  }

  var passwordToggle = document.getElementById("passwordToggle");
  if (passwordToggle) {
    passwordToggle.addEventListener("click", function () {
      var input = document.getElementById("password");
      if (!input) return;
      var show = input.type === "password";
      input.type = show ? "text" : "password";
      passwordToggle.setAttribute("aria-label", show ? "Hide password" : "Show password");
      var open = document.getElementById("eyeOpen");
      var shut = document.getElementById("eyeShut");
      if (open) open.hidden = show;
      if (shut) shut.hidden = !show;
    });
  }

  document.querySelectorAll("[data-password-toggle]").forEach(function (button) {
    var input = document.getElementById(button.getAttribute("data-password-toggle"));
    if (!input) return;
    button.addEventListener("click", function () {
      var show = input.type === "password";
      input.type = show ? "text" : "password";
      button.setAttribute("aria-label", show ? "Hide password" : "Show password");
      var open = button.querySelector("[data-eye-open]");
      var shut = button.querySelector("[data-eye-shut]");
      if (open) open.hidden = show;
      if (shut) shut.hidden = !show;
    });
  });

  document.querySelectorAll("[data-tabs]").forEach(function (root) {
    var buttons = Array.prototype.slice.call(root.querySelectorAll("[role='tab']"));
    var panels = Array.prototype.slice.call(root.querySelectorAll("[role='tabpanel']"));

    function activate(index) {
      buttons.forEach(function (button, i) {
        var on = i === index;
        button.classList.toggle("active", on);
        button.setAttribute("aria-selected", on ? "true" : "false");
        button.tabIndex = on ? 0 : -1;
      });
      panels.forEach(function (panel, i) {
        if (i === index) panel.removeAttribute("hidden");
        else panel.setAttribute("hidden", "");
      });
    }

    buttons.forEach(function (button, i) {
      button.addEventListener("click", function () {
        activate(i);
      });
    });
    if (buttons.length) activate(0);
  });

  document.querySelectorAll("[data-pref]").forEach(function (button) {
    button.addEventListener("click", function () {
      var on = button.getAttribute("aria-pressed") !== "true";
      button.setAttribute("aria-pressed", on ? "true" : "false");
      button.classList.toggle("on", on);
      var input = document.getElementById(button.getAttribute("data-pref"));
      if (input) input.value = on ? "true" : "false";
      var save = document.getElementById("save-prefs");
      if (save) save.textContent = "Save preferences";
    });
  });

  document.querySelectorAll(".data-grid").forEach(function (root) {
    var table = root.querySelector("table");
    if (!table || !table.tBodies[0]) return;

    var all = Array.prototype.slice.call(table.tBodies[0].querySelectorAll("tr.data-row"));
    var info = root.querySelector(".grid-pager-info");
    var sizeSelect = root.querySelector(".grid-page-size");
    var empty = root.querySelector(".grid-empty");
    var prev = root.querySelector("[data-page='prev']");
    var next = root.querySelector("[data-page='next']");
    var page = 0;
    var pageSize = sizeSelect ? Number(sizeSelect.value) : 12;
    var sortIndex = null;
    var sortDir = 1;
    var query = "";
    var status = "";

    function cellText(tr) {
      return Array.prototype.map
        .call(tr.cells, function (cell) {
          return cell.hasAttribute("data-search-ignore") ? "" : cell.innerText;
        })
        .join(" ")
        .toLowerCase();
    }

    function matches(tr) {
      if (query && cellText(tr).indexOf(query) === -1) return false;
      if (!status) return true;
      var bag = (tr.getAttribute("data-filter") || "").split("|");
      return bag.indexOf(status) !== -1;
    }

    function render() {
      var matched = [];
      var rest = [];
      all.forEach(function (tr) {
        (matches(tr) ? matched : rest).push(tr);
      });

      if (sortIndex != null) {
        matched.sort(function (a, b) {
          var av = a.cells[sortIndex] ? a.cells[sortIndex].innerText.trim() : "";
          var bv = b.cells[sortIndex] ? b.cells[sortIndex].innerText.trim() : "";
          return av.localeCompare(bv, undefined, { numeric: true }) * sortDir;
        });
      }

      var body = table.tBodies[0];
      matched.concat(rest).forEach(function (tr) {
        body.appendChild(tr);
      });

      var pages = Math.max(1, Math.ceil(matched.length / pageSize));
      if (page > pages - 1) page = pages - 1;
      if (page < 0) page = 0;

      matched.forEach(function (tr, i) {
        var visible = i >= page * pageSize && i < (page + 1) * pageSize;
        if (visible) tr.removeAttribute("hidden");
        else tr.setAttribute("hidden", "");
      });
      rest.forEach(function (tr) {
        tr.setAttribute("hidden", "");
      });

      if (empty) {
        if (matched.length === 0) empty.removeAttribute("hidden");
        else empty.setAttribute("hidden", "");
      }
      if (info) {
        var start = matched.length === 0 ? 0 : page * pageSize + 1;
        var end = Math.min(matched.length, (page + 1) * pageSize);
        info.textContent = start + "–" + end + " of " + matched.length;
      }
      if (prev) prev.disabled = page === 0;
      if (next) next.disabled = page >= pages - 1;
    }

    root.applyFilter = function (nextQuery, nextStatus) {
      query = (nextQuery || "").trim().toLowerCase();
      status = nextStatus || "";
      page = 0;
      render();
    };

    if (sizeSelect) {
      sizeSelect.addEventListener("change", function () {
        pageSize = Number(sizeSelect.value) || 12;
        page = 0;
        render();
      });
    }
    if (prev) {
      prev.addEventListener("click", function () {
        page -= 1;
        render();
      });
    }
    if (next) {
      next.addEventListener("click", function () {
        page += 1;
        render();
      });
    }

    Array.prototype.forEach.call(table.querySelectorAll("thead th"), function (th, index) {
      if (th.hasAttribute("data-nosort")) return;
      th.addEventListener("click", function () {
        if (sortIndex === index) sortDir *= -1;
        else {
          sortIndex = index;
          sortDir = 1;
        }
        render();
      });
    });

    table.addEventListener("click", function (event) {
      if (event.target.closest("a, button")) return;
      var tr = event.target.closest("tr.data-row");
      if (tr && tr.getAttribute("data-href")) {
        window.location.href = tr.getAttribute("data-href");
      }
    });

    render();
  });

  function fieldRule(id, message) {
    return {
      input: document.getElementById(id),
      error: document.getElementById(id + "-error"),
      message: message,
    };
  }

  function bindValidatedForm(form, rules) {
    function show(rule, text) {
      if (!rule.input || !rule.error) return;
      rule.error.textContent = text;
      var target = rule.field || rule.input;
      target.classList.toggle("is-invalid", Boolean(text));
      if (text) {
        rule.input.setAttribute("aria-invalid", "true");
        rule.input.setAttribute("aria-describedby", rule.error.id);
      } else {
        rule.input.removeAttribute("aria-invalid");
        rule.input.removeAttribute("aria-describedby");
      }
    }

    function check(rule) {
      var text = rule.message(rule.input ? rule.input.value : "");
      show(rule, text);
      return !text;
    }

    rules.forEach(function (rule) {
      if (!rule.input) return;
      if (rule.error && rule.error.textContent.trim()) {
        show(rule, rule.error.textContent.trim());
      }
      var eventName = rule.input.tagName === "SELECT" ? "change" : "input";
      rule.input.addEventListener(eventName, function () {
        check(rule);
      });
      rule.input.addEventListener("blur", function () {
        check(rule);
      });
    });

    form.addEventListener("submit", function (event) {
      var firstInvalid = null;
      rules.forEach(function (rule) {
        if (!check(rule) && !firstInvalid) firstInvalid = rule.input;
      });
      if (firstInvalid) {
        event.preventDefault();
        firstInvalid.focus();
      }
    });
  }

  document.querySelectorAll("[data-grid-search], [data-grid-status]").forEach(function (control) {
    var selector = control.getAttribute("data-grid-search") || control.getAttribute("data-grid-status");
    var eventName = control.getAttribute("data-grid-search") != null ? "input" : "change";
    control.addEventListener(eventName, function () {
      var root = document.querySelector(selector);
      if (!root || !root.applyFilter) return;
      var search = document.querySelector('[data-grid-search="' + selector + '"]');
      var status = document.querySelector('[data-grid-status="' + selector + '"]');
      root.applyFilter(search ? search.value : "", status ? status.value : "");
    });
  });
})();
