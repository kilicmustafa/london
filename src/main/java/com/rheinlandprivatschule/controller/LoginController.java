package com.rheinlandprivatschule.controller;

import com.rheinlandprivatschule.model.Place;
import com.rheinlandprivatschule.model.SystemUser;
import com.rheinlandprivatschule.repository.LoginDao;
import com.rheinlandprivatschule.repository.PlaceDao;
import com.rheinlandprivatschule.repository.RPS;
import com.rheinlandprivatschule.repository.SystemUserDao;
import com.rheinlandprivatschule.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import javax.servlet.http.HttpServletRequest;

@Controller
public class LoginController extends BaseController {

    private final AuthService authService;
    private final SystemUserDao systemUserDao;
    private final LoginDao loginDao;

    @Autowired
    public LoginController(AuthService authService, SystemUserDao systemUserDao, LoginDao loginDao) {
        this.authService = authService;
        this.systemUserDao = systemUserDao;
        this.loginDao = loginDao;
    }


    @RequestMapping(value = {"/", "/login"}, method = RequestMethod.GET)
    public String login(HttpServletRequest request) {
        if(!loginStatement(request)) {
            return "redirect:/index";
        }
        return "login";
    }


    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String loginPost(HttpServletRequest request) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if(username == null || password == null) {
            return "redirect:login?fail=missingparameters";
        } else {
            int userID = authService.userAuth(username, password);
            if(userID > -1) {
                request.getSession().setAttribute("loginUser", userID);
                SystemUser systemUser = systemUserDao.loginUser(username, password);
                if(systemUser.getUserID() > 0 && systemUser.getUserPassword().equals(password)) {
                    boolean exist=loginDao.isExist(systemUser.getUserID());
                    System.out.println("Exist: " + exist);
                    System.out.println("getStatusResult: " + loginDao.getStatus());
                    if(exist && loginDao.getStatus() == 0) {
                        String city="1";
                        String display="";
                        if(loginDao.getLoggedCity()!=0){
                            city=""+loginDao.getLoggedCity();
                        }
                        Place cityplace=(new PlaceDao()).getPlace(Integer.parseInt(city));
                        display="Ihre letzte Anmeldezeit ist "+loginDao.getLoginDate()+" "+loginDao.getLoginTime();
                        loginDao.login(systemUser.getUserID(),Integer.parseInt(city));

                        RPS rps=new RPS();
                        rps.setLoginUser(systemUser);
                        rps.setLoginPlace(cityplace);
                        request.getSession().setAttribute("handler",rps);
                        request.getSession().setAttribute("loginUserFullName", rps.getLoginUser().getUserFirstName() + " " + rps.getLoginUser().getUserLastName());
                        request.getSession().setAttribute("display",display);
                    }
                }
                return "redirect:/verifyHours";
            }
            return "redirect:/login?fail=true";
        }
    }

    @RequestMapping(method = RequestMethod.GET, value = "logout")
    public String logout(HttpServletRequest request) {
        loginDao.logout(Integer.parseInt(String.valueOf(request.getSession().getAttribute("loginUser"))), loginDao.getLoggedCity());
        request.getSession().removeAttribute("handler");
        request.getSession().removeAttribute("loginUserFullName");
        request.getSession().removeAttribute("display");
        request.getSession().removeAttribute("loginUser");
        return "redirect:/";
    }

    @GetMapping("/verifyHours")
    public String verifyHours(Model model) {
        model.addAttribute("sdb", systemUserDao);
        model.addAttribute("loginDao", loginDao);
        return "verifyHours";
    }

}
