package com.rheinlandprivatschule.controller;

import javax.servlet.http.HttpServletRequest;

public class BaseController {

    protected boolean loginStatement(HttpServletRequest request) {
        return request.getSession().getAttribute("loginUser") == null;
    }
}
