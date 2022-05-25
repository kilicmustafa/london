package com.rheinlandprivatschule.controller.stundenplan;

import com.rheinlandprivatschule.controller.BaseController;
import com.rheinlandprivatschule.helper.MyDate;
import com.rheinlandprivatschule.model.SystemUser;
import com.rheinlandprivatschule.repository.PlaceDao;
import com.rheinlandprivatschule.repository.RPS;
import com.rheinlandprivatschule.repository.StundDao;
import com.rheinlandprivatschule.repository.SystemUserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import javax.servlet.http.HttpServletRequest;
import java.sql.Date;
import java.util.List;

@Controller
public class StundenLohnController extends BaseController {

    private final StundDao stundDao;
    private final SystemUserDao systemUserDao;
    private final PlaceDao placeDao;

    @Autowired
    public StundenLohnController(StundDao stundDao, SystemUserDao systemUserDao, PlaceDao placeDao) {
        this.stundDao = stundDao;
        this.systemUserDao = systemUserDao;
        this.placeDao = placeDao;
    }


    @RequestMapping(method = RequestMethod.GET, value = "/stundenplan/stlohnEmployee")
    public String stlohnEmployee(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");

        if(stundDao.canSeeStundenlohn(rps.getLoginUser().getUserID())){
            Date d=MyDate.getCurrentSQLDate();
            String monthO=MyDate.getMonth(d);
            int yearO=Integer.parseInt(MyDate.getYear(d));
            //tea=(new rps.systemuser.SystemUserDB()).getAllSystemUserByPlace(myPlace.getPlaceID(),4);
            List<SystemUser> tea= systemUserDao.getAllEmployees(rps.getLoginPlace().getPlaceID(),2,4);

            model.addAttribute("month0", monthO);
            model.addAttribute("year0", yearO);
            model.addAttribute("tea", tea);
        }else{
            return "redirect:/index?err=permission";
        }

        return "stlohnEmployee";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/stundenplan/stlohnDetailEmployee")
    public String stlohnDetailEmployee(HttpServletRequest request) {

        return "stlohnDetailEmployee";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/stundenplan/stlohn")
    public String stlohn(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(stundDao.canSeeStundenlohn(rps.getLoginUser().getUserID())) {
            model.addAttribute("stundDao", stundDao);
            model.addAttribute("systemUserDao", systemUserDao);
            return "stlohn";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/stundenplan/stlohnDetail")
    public String stlohnDetail(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(stundDao.canSeeStundenlohn(rps.getLoginUser().getUserID())) {
            model.addAttribute("stundDao", stundDao);
            model.addAttribute("systemUserDao", systemUserDao);
            model.addAttribute("placeDao", placeDao);
            return "stlohnDetail";
        }

        return "redirect:/index?err=permission";
    }
}
