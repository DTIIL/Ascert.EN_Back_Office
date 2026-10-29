"use client";
import { useEffect, useRef, useState } from "react";
import "./user.css";

const emptyUser = {
  fullName: "",
  email: "",
  mobile: "",
  role: "",
  status: "Active",
};

const AddUser = ({ setIsVisible, onCreate, onUpdate, user }) => {
  const isEdit = Boolean(user);
  const formRef = useRef(null);
  const [details, setDetails] = useState(() =>
    user ? { ...emptyUser, ...user } : emptyUser,
  );

  useEffect(() => {
    formRef.current?.scrollIntoView({ behavior: "smooth", block: "start" });
  }, []);

  const handleChange = (e) => {
    const { name, value } = e.target;

    setDetails((prev) => ({
      ...prev,
      [name]: value,
    }));
  };

  const handleSubmit = (e) => {
    e.preventDefault();

    if (isEdit) {
      onUpdate?.({
        ...user,
        ...details,
        id: user.id,
      });
    } else {
      onCreate?.({
        ...details,
        id: Date.now(),
      });
    }

    setDetails(emptyUser);
    setIsVisible(false);
  };

  const handleCancel = () => {
    setDetails(emptyUser);
    setIsVisible(false);
  };

  return (
    <section className="add-user-component" ref={formRef}>
      <div>
        <h1>{isEdit ? "Update User" : "Add User"}</h1>
        <span>
          {isEdit
            ? "Update the selected user details"
            : "Create new user with basic details"}
        </span>
      </div>

      <form className="width-100" onSubmit={handleSubmit}>
        <div className="flex-space-between">
          <div className="grid width-50">
            <label htmlFor="fullName">Full Name</label>
            <input
              id="fullName"
              name="fullName"
              type="text"
              placeholder="Enter full name"
              value={details.fullName}
              onChange={handleChange}
              required
            />
          </div>

          <div className="grid width-50">
            <label htmlFor="email">Email Address</label>
            <input
              id="email"
              name="email"
              type="email"
              placeholder="Enter email address"
              value={details.email}
              onChange={handleChange}
              required
            />
          </div>
        </div>

        <div className="flex-space-between">
          <div className="grid">
            <label htmlFor="mobile">Mobile Number</label>
            <input
              id="mobile"
              name="mobile"
              type="tel"
              placeholder="Enter mobile number"
              value={details.mobile}
              onChange={handleChange}
              required
            />
          </div>

          <div className="grid">
            <label htmlFor="role">Role</label>
            <select
              id="role"
              name="role"
              value={details.role}
              onChange={handleChange}
              required
            >
              <option value="" disabled>
                Select role
              </option>
              <option value="Admin">Admin</option>
              <option value="Manager">Manager</option>
              <option value="Editor">Editor</option>
              <option value="User">User</option>
            </select>
          </div>

          <div className="grid">
            <label htmlFor="status">Status</label>
            <select
              id="status"
              name="status"
              value={details.status}
              onChange={handleChange}
              required
            >
              <option value="Active">Active</option>
              <option value="Inactive">Inactive</option>
              <option value="Pending">Pending</option>
            </select>
          </div>
        </div>

        <div className="btn-container">
          <button type="button" className="btn btn-secondary" onClick={handleCancel}>
            Cancel
          </button>

          <button type="submit" className="btn btn-primary">
            {isEdit ? "Update user" : "Create user"}
          </button>
        </div>
      </form>
    </section>
  );
};

export default AddUser;
