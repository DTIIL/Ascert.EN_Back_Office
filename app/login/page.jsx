"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import Image from "next/image";
import dtiiLogo from "../../public/assets/Icon_logo.svg";
import "./login.css";

export default function LoginPage() {
  const router = useRouter();
  const [showPassword, setShowPassword] = useState(false);

  const signIn = (event) => {
    event.preventDefault();
    router.push("/dashboard");
  };

  return (
    <main className="login-page">
      <section className="login-card">
        <div className="brand">
          <span className="brand-icon">
            <Image height={28} width={28} alt="" src={dtiiLogo} />
          </span>
          <span className="brand-name">
            Ascert<span>.en</span>
          </span>
        </div>

        <h1>Sign in to your account</h1>
        <p className="login-description">
          Access the back office to manage devices, users, and reports.
        </p>

        <button className="sso-button" type="button" onClick={signIn}>
          <svg viewBox="0 0 24 24" aria-hidden="true">
            <path d="M4 20V10l8-6 8 6v10" />
            <path d="M9 20v-6h6v6" />
          </svg>
          Continue with SSO
        </button>

        <div className="divider">
          <span />
          <p>or</p>
          <span />
        </div>

        <form className="login-form" onSubmit={signIn}>
          <label className="login-field">
            <svg viewBox="0 0 24 24" aria-hidden="true">
              <rect x="3" y="5" width="18" height="14" rx="2" />
              <path d="m4 7 8 6 8-6" />
            </svg>
            <input
              type="email"
              placeholder="Email address"
              aria-label="Email address"
              autoComplete="email"
              required
            />
          </label>

          <label className="login-field">
            <svg viewBox="0 0 24 24" aria-hidden="true">
              <rect x="5" y="10" width="14" height="11" rx="2" />
              <path d="M8 10V7a4 4 0 0 1 8 0v3" />
            </svg>
            <input
              type={showPassword ? "text" : "password"}
              placeholder="Password"
              aria-label="Password"
              autoComplete="current-password"
              required
            />
            <button
              className="password-toggle"
              type="button"
              onClick={() => setShowPassword((current) => !current)}
              aria-label={showPassword ? "Hide password" : "Show password"}
            >
              {showPassword ? (
                <svg viewBox="0 0 24 24" aria-hidden="true">
                  <path d="M3 3l18 18" />
                  <path d="M10.6 10.6A2 2 0 0 0 12 14a2 2 0 0 0 1.4-.6" />
                  <path d="M9.9 5.2A10.8 10.8 0 0 1 12 5c5 0 9.3 3.1 11 7.5a11.6 11.6 0 0 1-4.1 5.2" />
                  <path d="M6.1 6.1C3.8 7.6 2.1 9.8 1 12.5 2.7 16.9 7 20 12 20c1.2 0 2.3-.2 3.4-.5" />
                </svg>
              ) : (
                <svg viewBox="0 0 24 24" aria-hidden="true">
                  <path d="M2 12.5C3.7 8.1 8 5 12 5s8.3 3.1 10 7.5C20.3 16.9 16 20 12 20S3.7 16.9 2 12.5z" />
                  <circle cx="12" cy="12.5" r="2.5" />
                </svg>
              )}
            </button>
          </label>

          <div className="form-options">
            <label className="remember-me">
              <input type="checkbox" />
              <span>Remember me</span>
            </label>
            <a href="/forgot-password">Forgot password?</a>
          </div>

          <button className="signin-button" type="submit">
            Sign in
          </button>
        </form>
      </section>
    </main>
  );
}
