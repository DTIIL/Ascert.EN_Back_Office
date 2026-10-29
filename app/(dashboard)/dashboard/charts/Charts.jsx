"use client";

import { useMemo } from "react";
import { Bar } from "react-chartjs-2";
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  BarElement,
  Tooltip,
} from "chart.js";

ChartJS.register(CategoryScale, LinearScale, BarElement, Tooltip);

const DAYS = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

const CHARTS = [
  {
    title: "QDSD activity",
    color: "#005df8",
    data: [12, 19, 8, 15, 22, 10, 5],
  },
  {
    title: "Signatures",
    color: "#e8a33d",
    data: [30, 28, 34, 22, 40, 18, 12],
  },
  {
    title: "Failures",
    color: "#b42318",
    data: [2, 1, 4, 1, 3, 0, 1],
  },
];

const options = {
  responsive: true,
  maintainAspectRatio: false,
  animation: { duration: 350 },
  plugins: {
    legend: { display: false },
    tooltip: { displayColors: false },
  },
  scales: {
    x: {
      grid: { display: false },
      ticks: { color: "#4a5875", font: { size: 11 } },
    },
    y: {
      beginAtZero: true,
      ticks: { color: "#4a5875", font: { size: 11 }, precision: 0 },
      grid: { color: "#eef2f7" },
    },
  },
};

function Charts() {
  const charts = useMemo(
    () =>
      CHARTS.map((chart) => ({
        title: chart.title,
        data: {
          labels: DAYS,
          datasets: [
            {
              data: chart.data,
              backgroundColor: chart.color,
              borderRadius: 6,
              maxBarThickness: 22,
            },
          ],
        },
      })),
    [],
  );

  return (
    <div className="chart-grid">
      {charts.map((chart) => (
        <article className="chart-card" key={chart.title}>
          <h2>{chart.title}</h2>
          <div className="chart-canvas">
            <Bar data={chart.data} options={options} />
          </div>
        </article>
      ))}
    </div>
  );
}

export default Charts;
