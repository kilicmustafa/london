package com.rheinlandprivatschule.controller.inventor;

import com.rheinlandprivatschule.controller.BaseController;
import com.rheinlandprivatschule.repository.InventorDao;
import com.rheinlandprivatschule.repository.PlaceDao;
import com.rheinlandprivatschule.repository.RPS;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

@Controller
public class InventorController extends BaseController {

    private final InventorDao inventorDao;
    private final PlaceDao placeDao;

    @Autowired
    public InventorController(InventorDao inventorDao, PlaceDao placeDao) {
        this.inventorDao = inventorDao;
        this.placeDao = placeDao;
    }

    @RequestMapping(method = RequestMethod.GET, value = "/inventor/inventorReport")
    public String inventorReport(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(inventorDao.canWorkWithInventorCategory(rps.getLoginUser().getUserID())) {
            model.addAttribute("inventorDao", inventorDao);
            model.addAttribute("placeDao", placeDao);
            return "inventorReport";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/inventor/inventorCatList")
    public String inventorCatList(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(inventorDao.canWorkWithInventorCategory(rps.getLoginUser().getUserID())) {
            model.addAttribute("inventorDao", inventorDao);
            return "inventorCatList";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/inventor/viewInventorCat", method = { RequestMethod.GET, RequestMethod.POST })
    public String viewInventorCat(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(inventorDao.canWorkWithInventorCategory(rps.getLoginUser().getUserID())) {
            model.addAttribute("inventorDao", inventorDao);
            model.addAttribute("placeDao", placeDao);
            return "viewInventorCat";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/inventor/newInventorCat", method = { RequestMethod.GET, RequestMethod.POST })
    public String newInventorCat(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(inventorDao.canWorkWithInventorCategory(rps.getLoginUser().getUserID())) {
            model.addAttribute("inventorDao", inventorDao);
            model.addAttribute("placeDao", placeDao);
            return "newInventorCat";
        }

        return "redirect:/index?err=permission";
    }
}
