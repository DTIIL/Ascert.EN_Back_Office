"use client";

import { useCallback, useMemo, useState } from "react";
import DataGrid from "../../../components/DataGrid";
import AddUser from "./AddUser";
import { dummyUsers } from "../../../public/data";
import { EditUserRenderer, StatusRenderer } from "../../../public/utils";
import { filterRows } from "../../../lib/filterRows";
import "./user.css";

export default function Page() {
  const [inputSearch, setInputSearch] = useState("");
  const [isVisible, setIsVisible] = useState(false);
  const [userData, setUserData] = useState(() =>
    dummyUsers.map((user, index) => ({
      ...user,
      id: index + 1,
    })),
  );
  const [editingUser, setEditingUser] = useState(null);

  const closeForm = () => {
    setEditingUser(null);
    setIsVisible(false);
  };

  const handleCreateUser = (newUser) => {
    setUserData((prev) => [...prev, newUser]);
    setEditingUser(null);
  };

  const handleEditUser = useCallback((user) => {
    setEditingUser(user);
    setIsVisible(true);
  }, []);

  const handleUpdateUser = (updatedUser) => {
    setUserData((prev) =>
      prev.map((user) => (user.id === updatedUser.id ? updatedUser : user)),
    );
    setEditingUser(null);
  };

  const columnDefs = useMemo(
    () => [
      { field: "fullName", headerName: "Full Name" },
      { field: "email", headerName: "Email" },
      { field: "mobile", headerName: "Mobile" },
      { field: "role", headerName: "Role" },
      { field: "status", headerName: "Status", cellRenderer: StatusRenderer },
      {
        headerName: "Action",
        sortable: false,
        cellRenderer: EditUserRenderer,
        cellRendererParams: {
          onEdit: handleEditUser,
        },
      },
    ],
    [handleEditUser],
  );

  const filteredData = useMemo(
    () => filterRows(userData, inputSearch),
    [inputSearch, userData],
  );

  const handleVisibleClick = () => {
    if (isVisible && !editingUser) {
      closeForm();
      return;
    }

    setEditingUser(null);
    setIsVisible(true);
  };

  return (
    <section className="section-container">
      {isVisible && (
        <AddUser
          key={editingUser?.id ?? "new"}
          setIsVisible={closeForm}
          onCreate={handleCreateUser}
          onUpdate={handleUpdateUser}
          user={editingUser}
        />
      )}

      <div className="header-component">
        <div>
          <h1>Users</h1>
          <p className="page-subtitle">Manage people, roles, and access.</p>
        </div>
        <button className="btn btn-primary" type="button" onClick={handleVisibleClick}>
          {isVisible && !editingUser ? "Close" : "Add user"}
        </button>
      </div>

      <div className="toolbar">
        <input
          className="custom-input"
          type="search"
          placeholder="Search by name, email, or role"
          value={inputSearch}
          onChange={(event) => setInputSearch(event.target.value)}
          aria-label="Search users"
        />
      </div>

      <DataGrid
        rowData={filteredData}
        columnDefs={columnDefs}
        getRowId={(params) => String(params.data.id)}
      />
    </section>
  );
}
