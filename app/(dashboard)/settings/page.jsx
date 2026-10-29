"use client";

import { useState } from "react";
import "./settings.css";

const PREFERENCES = [
  {
    id: "email",
    label: "Email alerts",
    help: "Provisioning failures and DSC download errors",
  },
  {
    id: "digest",
    label: "Daily digest",
    help: "A morning summary of signing activity",
  },
  {
    id: "session",
    label: "Session lock",
    help: "Ask for a password again after 15 minutes idle",
  },
];

export default function Page() {
  const [prefs, setPrefs] = useState({
    email: true,
    digest: false,
    session: true,
  });
  const [saved, setSaved] = useState(false);

  const toggle = (id) => {
    setSaved(false);
    setPrefs((current) => ({ ...current, [id]: !current[id] }));
  };

  return (
    <section className="settings-page">
      <header className="page-head">
        <div>
          <h1>Settings</h1>
          <p>Account details and how this workspace notifies you.</p>
        </div>
      </header>

      <div className="settings-grid">
        <article className="settings-card">
          <h2>Profile</h2>
          <dl>
            <div>
              <dt>Name</dt>
              <dd>John Doe</dd>
            </div>
            <div>
              <dt>Role</dt>
              <dd>Admin</dd>
            </div>
            <div>
              <dt>Workspace</dt>
              <dd>Ascert.en Back Office</dd>
            </div>
          </dl>
        </article>

        <article className="settings-card">
          <h2>Preferences</h2>
          <ul>
            {PREFERENCES.map((item) => (
              <li key={item.id}>
                <div>
                  <strong>{item.label}</strong>
                  <span>{item.help}</span>
                </div>
                <button
                  type="button"
                  className={`switch${prefs[item.id] ? " on" : ""}`}
                  aria-pressed={prefs[item.id]}
                  onClick={() => toggle(item.id)}
                >
                  <span />
                </button>
              </li>
            ))}
          </ul>
          <button
            type="button"
            className="btn btn-primary"
            onClick={() => setSaved(true)}
          >
            {saved ? "Saved" : "Save preferences"}
          </button>
        </article>
      </div>
    </section>
  );
}
