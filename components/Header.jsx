"use client";

import Image from "next/image";
import dtiiLogo from "../public/assets/Icon_logo.svg";
import userPhoto from "../public/assets/person_logo.svg";
import { useEffect, useRef, useState } from "react";
import { useRouter } from "next/navigation";

const Header = () => {
  const [isHide, setIsHide] = useState(false);
  const router = useRouter();
  const menuRef = useRef(null);

  // Close dropdown when clicking outside
  useEffect(() => {
    const handleClickOutside = (event) => {
      if (menuRef.current && !menuRef.current.contains(event.target)) {
        setIsHide(false);
      }
    };

    document.addEventListener("mousedown", handleClickOutside);

    return () => {
      document.removeEventListener("mousedown", handleClickOutside);
    };
  }, []);

  const handleLogout = () => {
    setIsHide(false);

    // Clear your authentication token/session here if required.
    router.replace("/login");
  };

  return (
    <header className="header-container">
      <div className="flex-item-center gap-10">
        <Image alt="Ascert.en logo" src={dtiiLogo} height={32} width={32} />

        <div className="heading">
          <span className="brand-title">Ascert.en</span>
          <span className="brand-subtitle">Back Office</span>
        </div>
      </div>

      <div className="user-menu" ref={menuRef}>
        <button
          type="button"
          className="user-chip"
          onClick={() => setIsHide((prev) => !prev)}
          aria-expanded={isHide}
          aria-haspopup="menu"
        >
          <Image src={userPhoto} alt="" width={32} height={32} />

          <div className="heading">
            <span className="user-name">John Doe</span>
            <span className="user-role">Admin</span>
          </div>
        </button>

        {isHide && (
          <div className="logout-container" role="menu">
            <button
              type="button"
              onClick={handleLogout}
              className="logout-btn-minimal"
              role="menuitem"
            >
              Log Out
            </button>
          </div>
        )}
      </div>
    </header>
  );
};

export default Header;
