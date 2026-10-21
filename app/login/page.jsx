"use client";

import { useState } from "react";
import dtiiLogo from "../../public/assets/Icon_logo.svg";
import "./login.css";
import Image from "next/image";
import Link from "next/link";

export default function LoginPage() {
  const [showPassword, setShowPassword] = useState(false);

  return (
    <main className="login-page">
      <div className="circle circle-top-right" />
      <div className="circle circle-bottom-left" />

      <section className="login-card">
        <div className="brand">
          <span className="brand-icon">
            <Image height={20} width={20} alt="dtii_logo" src={dtiiLogo} />
          </span>
          <span className="brand-name">
            Ascert<span>.en</span>
          </span>
        </div>

        <h1>Sign in to your account</h1>
        <p className="login-description">
          Access the back office to manage users and settings.
        </p>

        <button className="sso-button" type="button">
          <span>🏛️</span>
          Continue with SSO
        </button>

        <div className="divider">
          <span />
          <p>or</p>
          <span />
        </div>

        <form className="login-form">
          <label className="input-wrapper">
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

          <label className="input-wrapper">
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
              onClick={() => setShowPassword(!showPassword)}
              aria-label={showPassword ? "Hide password" : "Show password"}
            >
              {showPassword ? "🫣" : "👁️"}
            </button>
          </label>

          <div className="form-options">
            <label className="remember-me">
              <input type="checkbox" />
              <span>Remember me</span>
            </label>

            <a href="/forgot-password">Forgot password?</a>
          </div>

          <Link href="/dashboard" className="signin-button">
            Sign in
          </Link>
        </form>
      </section>
    </main>
  );
}
