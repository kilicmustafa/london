package com.rheinlandprivatschule;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class LoginHandler extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        final String path =  request.getRequestURI().substring(request.getContextPath().length());
        System.out.println("PATH: " + path);
        if(request.getSession().getAttribute("loginUser") == null
                && !path.equals("/")
                && !path.equals("/login")
                && !path.startsWith("/resources")
                && !path.startsWith("/certificate")
                && !path.startsWith("/studentBilder/image")
                && !path.startsWith("/onlineStudentForm")
                && !path.startsWith("/registerOnlineStudent")
                && !path.startsWith("/info")
                && !path.startsWith("/currentLocation")
                && !path.startsWith("/makeVertrag")
                && !path.startsWith("/makeVertrag2")
                && !path.startsWith("/vertragPlan")
                && !path.startsWith("/vertragFinal")
                && !path.startsWith("/printVertrag")
                && !path.startsWith("/printVertrag1")
                && !path.startsWith("/registerVerFee")
                && !path.startsWith("/courseRegistration")
                && !path.startsWith("/teilnahme")) {
            System.out.println("must login");
            response.sendRedirect("/login");
            return false;
        }

        return super.preHandle(request, response, handler);
    }
}
