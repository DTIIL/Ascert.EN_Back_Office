"use client";

import { useState } from "react";
import "./component.css";

const ReusableTab = ({ tabs = [], defaultActiveTab = 0, className = "" }) => {
  const [activeTab, setActiveTab] = useState(defaultActiveTab);

  if (!tabs.length) return null;

  const activeIndex = Math.min(Math.max(activeTab, 0), tabs.length - 1);

  const activeItem = tabs[activeIndex];
  const activeId = activeItem.id ?? activeIndex;

  return (
    <section className={className} style={{ width: "100%" }}>
      {/* Tab navigation */}
      <div role="tablist" aria-label="Content tabs" className="tab-div">
        {tabs.map((tab, index) => {
          const tabId = tab.id ?? index;

          return (
            <button
              key={tabId}
              id={`tab-${tabId}`}
              type="button"
              role="tab"
              aria-selected={activeIndex === index}
              aria-controls={`panel-${tabId}`}
              tabIndex={activeIndex === index ? 0 : -1}
              onClick={() => setActiveTab(index)}
              className={`tab-button ${activeIndex === index ? "active" : ""}`}
            >
              {tab.label}
            </button>
          );
        })}
      </div>

      {/* Active tab content */}
      <div
        id={`panel-${activeId}`}
        role="tabpanel"
        aria-labelledby={`tab-${activeId}`}
        className="tab-panel"
        tabIndex={0}
      >
        {activeItem.content}
      </div>
    </section>
  );
};

export default ReusableTab;
