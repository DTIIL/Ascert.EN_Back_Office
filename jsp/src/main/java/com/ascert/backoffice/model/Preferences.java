package com.ascert.backoffice.model;

import java.io.Serializable;

public class Preferences implements Serializable {

    private static final long serialVersionUID = 1L;

    private boolean email = true;
    private boolean digest;
    private boolean sessionLock = true;

    public boolean isEmail() {
        return email;
    }

    public void setEmail(boolean email) {
        this.email = email;
    }

    public boolean isDigest() {
        return digest;
    }

    public void setDigest(boolean digest) {
        this.digest = digest;
    }

    public boolean isSessionLock() {
        return sessionLock;
    }

    public void setSessionLock(boolean sessionLock) {
        this.sessionLock = sessionLock;
    }
}
