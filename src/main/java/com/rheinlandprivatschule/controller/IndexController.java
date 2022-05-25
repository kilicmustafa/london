package com.rheinlandprivatschule.controller;

import com.rheinlandprivatschule.model.Place;
import com.rheinlandprivatschule.repository.LoginDao;
import com.rheinlandprivatschule.repository.PlaceDao;
import com.rheinlandprivatschule.repository.RPS;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import javax.servlet.http.HttpServletRequest;

@Controller
public class IndexController extends BaseController {


    private final PlaceDao placeDao;
    private final LoginDao loginDao;

    @Autowired
    public IndexController(PlaceDao placeDao, LoginDao loginDao) {
        this.placeDao = placeDao;
        this.loginDao = loginDao;
    }

    @RequestMapping(method = RequestMethod.GET, value = "/index")
    public String index(HttpServletRequest req, Model model) {
        if(loginStatement(req)) {
            return "redirect:/";
        }
        RPS rps = (RPS) req.getSession().getAttribute("handler");
        model.addAttribute("rps", rps);
        return "index";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/changeCity")
    public String changeCity(HttpServletRequest request) {
        if(loginStatement(request)) {
            return "redirect:/";
        }
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        String cityid= request.getParameter("select");
        Place place = placeDao.getPlace(Integer.parseInt(cityid));
        rps.setLoginPlace(place);
        loginDao.changeCity(rps.getLoginUser().getUserID(), place.getPlaceID());
        return "redirect:/index";
    }
}
