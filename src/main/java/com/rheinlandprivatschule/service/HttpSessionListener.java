package com.rheinlandprivatschule.service;

import com.rheinlandprivatschule.repository.LoginDao;

import javax.servlet.http.HttpSessionEvent;

public class HttpSessionListener implements javax.servlet.http.HttpSessionListener {

    private LoginDao loginDao;

    public HttpSessionListener() {
        this.loginDao = new LoginDao();
    }

    @Override
    public void sessionCreated(HttpSessionEvent httpSessionEvent) {

    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        if(se.getSession().getAttribute("loginUser") != null) {
            loginDao.logout(Integer.parseInt(String.valueOf(se.getSession().getAttribute("loginUser"))), loginDao.getLoggedCity());
        }
    }
}
