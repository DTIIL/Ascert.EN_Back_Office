/* eslint-disable react-hooks/rules-of-hooks */
"use client";
import "./user.css";
import { AgGridReact } from "ag-grid-react";
import { useCallback, useMemo, useState } from "react";
import {
  themeQuartz,
  AllCommunityModule,
  ModuleRegistry,
} from "ag-grid-community";
import AddUser from "./AddUser";
import { dummyUsers } from "../../../public/data";
import { EditUserRenderer } from "../../../public/utils";

ModuleRegistry.registerModules([AllCommunityModule]);

const page = () => {
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
      { field: "fullName" },
      { field: "email" },
      { field: "mobile" },
      { field: "role" },
      { field: "status" },
      {
        headerName: "Action",
        cellRenderer: EditUserRenderer,
        cellRendererParams: {
          onEdit: handleEditUser,
        },
      },
    ],
    [handleEditUser],
  );

  const defaultColDef = useMemo(
    () => ({
      flex: 1,
      minWidth: 100,
      sortable: true,
    }),
    [],
  );

  const filteredData = useMemo(() => {
    const query = inputSearch.trim().toLowerCase();

    return userData.filter((row) => {
      const matchesSearch =
        !query ||
        Object.values(row).some((value) =>
          String(value ?? "")
            .toLowerCase()
            .includes(query),
        );

      return matchesSearch;
    });
  }, [inputSearch, userData]);

  const handleVisibleClick = () => {
    if (isVisible && !editingUser) {
      closeForm();
      return;
    }

    setEditingUser(null);
    setIsVisible(true);
  };

  return (
    <section className="grid gap-10">
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
          <h2>User</h2>
          <span>Manage users,roles and access</span>
        </div>
        <div>
          <button className="button-9" onClick={handleVisibleClick}>
            + Add User
          </button>
        </div>
      </div>
      <div className="input-wrapper">
        <input
          className="custom-input"
          type="search"
          placeholder="Search users,roles and access"
          value={inputSearch}
          onChange={(e) => setInputSearch(e.target.value)}
          aria-label="Search QDSD records"
        />
      </div>

      <div className="ag-grid">
        <AgGridReact
          rowData={filteredData}
          columnDefs={columnDefs}
          defaultColDef={defaultColDef}
          theme={themeQuartz}
          pagination={true}
          // onRowClicked={handleEditUser}
          getRowId={(params) => String(params.data.id)}
        />
      </div>
    </section>
  );
};

export default page;
