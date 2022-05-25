package com.rheinlandprivatschule.controller.user;

import com.rheinlandprivatschule.controller.BaseController;
import com.rheinlandprivatschule.model.UserCategory;
import com.rheinlandprivatschule.repository.BookDao;
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
public class CatListController extends BaseController{

    private final SystemUserDao systemUserDao;
    private final BookDao bookDao;

    @Autowired
    public CatListController(SystemUserDao systemUserDao, BookDao bookDao) {
        this.systemUserDao = systemUserDao;
        this.bookDao = bookDao;
    }

    @RequestMapping(method = RequestMethod.GET, value = "/user/catList")
    public String catList(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(systemUserDao.canSeeGeneralCategoryList(rps.getLoginUser().getUserID())) {
            List<UserCategory> userCategories = bookDao.getAllCategoryByOwner(0);
            model.addAttribute("userCategories", userCategories);
        } else {
            return "catList?err=permission";
        }

        return "catList";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/user/updateCat")
    public String updateCat(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(systemUserDao.canUpdateGeneralCategory(rps.getLoginUser().getUserID())) {
            String catii= request.getParameter("catid");
            UserCategory u=bookDao.getCategory(Integer.parseInt(catii));
            model.addAttribute("u", u);
        } else {
            return "redirect:/user/catList?err=permission";
        }

        return "updateCat";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/user/updateCat")
    public String updateCatProcess(HttpServletRequest request) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(systemUserDao.canUpdateGeneralCategory(rps.getLoginUser().getUserID())) {
            String nam= request.getParameter("txtName");
            String kh= request.getParameter("hd");

            UserCategory uc=bookDao.getCategory(Integer.parseInt(kh));
            uc.setUserCategoryName(nam);
            bookDao.updateBookCategory(uc);
        } else {
            return "redirect:/user/catList?err=permission";
        }

        return "redirect:/user/catList";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/user/newCat")
    public String newCat(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        return "newCat";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/user/newCat")
    public String newCatProcess(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(systemUserDao.canAddNewGeneralCategory(rps.getLoginUser().getUserID())) {
            String nam= request.getParameter("txtName");
            String typ= request.getParameter("typ");
            UserCategory uc=new UserCategory();
            uc.setUserCategoryName(nam);
            if(typ.equalsIgnoreCase("0")){
                uc.setOwner(0);
            }else if(typ.equalsIgnoreCase("1")){
                uc.setOwner(rps.getLoginUser().getUserID());
            }

            bookDao.addNewBookCategory(uc);
        } else {
            return "redirect:/user/catList?err=permission";
        }

        return "redirect:/user/catList";
    }
}
