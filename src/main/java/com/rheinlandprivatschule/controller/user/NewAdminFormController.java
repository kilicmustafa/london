package com.rheinlandprivatschule.controller.user;

import com.rheinlandprivatschule.controller.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import javax.servlet.http.HttpServletRequest;

@Controller
public class NewAdminFormController extends BaseController {

    @RequestMapping(method = RequestMethod.GET, value = "user/newAdminForm")
    public String newAdminForm(HttpServletRequest request) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }
        return "newAdminForm";
    }

    @RequestMapping(method = RequestMethod.POST, value = "user/registerAdmin")
    public String newAdminProcess(HttpServletRequest request) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        return "registerAdmin";
    }
}
