package com.ascert.backoffice.service;

import com.ascert.backoffice.model.UserAccount;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Component;

@Component
public class UserStore {

    private final List<UserAccount> users = new ArrayList<UserAccount>();
    private long nextId = 1L;

    public UserStore(SampleData data) {
        for (Map<String, Object> row : data.getUsers()) {
            UserAccount user = new UserAccount();
            user.setId(nextId++);
            user.setFullName(text(row.get("fullName")));
            user.setEmail(text(row.get("email")));
            user.setMobile(text(row.get("mobile")));
            user.setRole(text(row.get("role")));
            user.setStatus(text(row.get("status")));
            users.add(user);
        }
    }

    public synchronized List<UserAccount> all() {
        return new ArrayList<UserAccount>(users);
    }

    public synchronized UserAccount find(long id) {
        for (UserAccount user : users) {
            if (user.getId() == id) {
                return user;
            }
        }
        return null;
    }

    public synchronized void add(UserAccount user) {
        user.setId(nextId++);
        users.add(user);
    }

    public synchronized boolean update(UserAccount incoming) {
        UserAccount current = find(incoming.getId());
        if (current == null) {
            return false;
        }
        current.setFullName(incoming.getFullName());
        current.setEmail(incoming.getEmail());
        current.setMobile(incoming.getMobile());
        current.setRole(incoming.getRole());
        current.setStatus(incoming.getStatus());
        return true;
    }

    private static String text(Object value) {
        return value == null ? "" : String.valueOf(value);
    }
}
