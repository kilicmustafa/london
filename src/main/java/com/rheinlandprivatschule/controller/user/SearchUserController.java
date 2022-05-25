package com.rheinlandprivatschule.controller.user;

import com.rheinlandprivatschule.controller.BaseController;
import com.rheinlandprivatschule.model.SystemUser;
import com.rheinlandprivatschule.repository.RPS;
import com.rheinlandprivatschule.repository.SystemUserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class SearchUserController extends BaseController {

    private final SystemUserDao systemUserDao;

    @Autowired
    public SearchUserController(SystemUserDao systemUserDao) {
        this.systemUserDao = systemUserDao;
    }

    @RequestMapping(method = RequestMethod.GET, value = "/user/searchUser")
    public String searchUser(HttpServletRequest request) {
        if(loginStatement(request)) {
            return "redirect:/";
        }

        return "searchUser";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/user/searchUser")
    public String searchUserProcess(HttpServletRequest request, Model model) {
        if (loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        String keyWord = "";
        String criterionString = "1";
        int criterion = 1;
        boolean all = false;

        if (systemUserDao.canSearchUser(rps.getLoginUser().getUserID())) {
            String cmd = request.getParameter("cmd");
            if (cmd != null) {
                criterionString = request.getParameter("selCriteria");
                keyWord = request.getParameter("txtKeyWord");
                criterion = Integer.parseInt(criterionString);

                String flagS = request.getParameter("alle");
                if (flagS != null) {
                    all = true;
                }
                List<SystemUser> users = systemUserDao.searchSystemUsersByCriteria(criterion, keyWord, all);

                model.addAttribute("users", users);
            }
        }
        return "searchUser";
    }
}
