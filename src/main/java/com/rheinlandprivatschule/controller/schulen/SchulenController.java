package com.rheinlandprivatschule.controller.schulen;

import com.rheinlandprivatschule.controller.BaseController;
import com.rheinlandprivatschule.model.Place;
import com.rheinlandprivatschule.repository.PlaceDao;
import com.rheinlandprivatschule.repository.RPS;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class SchulenController extends BaseController{

    private final PlaceDao placeDao;

    @Autowired
    public SchulenController(PlaceDao placeDao) {
        this.placeDao = placeDao;
    }

    @RequestMapping(method = RequestMethod.GET, value = "/school/schoolList")
    public String schoolList(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(placeDao.canSeeSchoolList(rps.getLoginUser().getUserID())) {
            List<Place> places = placeDao.getAllPlaces();
            model.addAttribute("places", places);
        } else {
            return "redirect:/index?err=permission";
        }

        return "schoolList";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/school/updateSchoolForm")
    public String updateSchoolForm(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(placeDao.canUpdateSchool(rps.getLoginUser().getUserID())) {
            String placeid= request.getParameter("placeid");
            int id = Integer.parseInt(placeid);
            List<Place> places = placeDao.getAllPlaces();
            for (Place place : places) {
                if(place.getPlaceID() == id) {
                    model.addAttribute("place", place);
                    request.getSession().setAttribute("pschool",place);
                }
            }
        } else {
            return "redirect:/index?err=permission";
        }

        return "updateSchoolForm";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/school/updateSchool")
    public String updateSchoolProcess(HttpServletRequest request) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }
        return "updateSchool";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/school/addSchoolForm")
    public String addSchoolForm(HttpServletRequest request) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(!placeDao.canAddNewSchool(rps.getLoginUser().getUserID())) {
            return "redirect:/index?err=permission";
        }

        return "addSchoolForm";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/school/addSchool")
    public String addSchoolProcess(HttpServletRequest request) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }
        return "addSchool";
    }
}
