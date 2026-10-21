"use client";

import { Bar } from "react-chartjs-2";
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  BarElement,
  Title,
  Tooltip,
  Legend,
} from "chart.js";

ChartJS.register(
  CategoryScale,
  LinearScale,
  BarElement,
  Title,
  Tooltip,
  Legend,
);

function Charts() {
  const data = {
    labels: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
    datasets: [
      {
        label: "QDSD",
        data: [12, 19, 8, 15, 22, 10, 5],
        backgroundColor: "rgba(54, 162, 235, 0.6)",
        borderColor: "rgb(54, 162, 235)",
        borderWidth: 1,
        barThickness: 20, // Fixed width in pixels (optional)
        maxBarThickness: 20, // Max pixel width limit
        barPercentage: 0.8, // Width of the bar relative to category
        categoryPercentage: 0.9, // Width of the category
      },
    ],
  };

  const options = {
    responsive: true,
    plugins: {
      legend: {
        position: "top",
      },
      title: {
        display: true,
        text: "QDSD Weekly report",
      },
    },
  };

  return (
    <>
      <div className="chart-height-width">
        <Bar data={data} options={options} />
        <Bar data={data} options={options} />
        <Bar data={data} options={options} />
      </div>
    </>
  );
}

export default Charts;
