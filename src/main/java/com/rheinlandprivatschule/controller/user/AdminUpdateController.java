package com.rheinlandprivatschule.controller.user;

import com.rheinlandprivatschule.controller.BaseController;
import com.rheinlandprivatschule.helper.MyDate;
import com.rheinlandprivatschule.model.Place;
import com.rheinlandprivatschule.model.SystemUser;
import com.rheinlandprivatschule.model.UserCategory;
import com.rheinlandprivatschule.model.UserType;
import com.rheinlandprivatschule.repository.BookDao;
import com.rheinlandprivatschule.repository.PlaceDao;
import com.rheinlandprivatschule.repository.RPS;
import com.rheinlandprivatschule.repository.SystemUserDao;
import com.rheinlandprivatschule.viewmodel.AdminUpdateViewModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class AdminUpdateController extends BaseController {

    private final SystemUserDao systemUserDao;
    private final BookDao bookDao;
    private final PlaceDao placeDao;

    @Autowired
    public AdminUpdateController(SystemUserDao systemUserDao, BookDao bookDao, PlaceDao placeDao) {
        this.systemUserDao = systemUserDao;
        this.bookDao = bookDao;
        this.placeDao = placeDao;
    }

    @RequestMapping(method = RequestMethod.GET, value = "/user/adminRemarksUpdate")
    public String adminRemarksUpdate(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(systemUserDao.canUpdateGeneralUserBemerkung(rps.getLoginUser().getUserID())) {
            String adminId = request.getParameter("adminid");
            if(adminId != null) {
                SystemUser systemUser = systemUserDao.getSystemUser(Integer.parseInt(adminId));
                model.addAttribute("systemUser", systemUser);
            }
        } else {
            return "redirect:/index?err=permission";
        }
        return "adminRemarksUpdate";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/user/adminRemarksUpdateProcess")
    public String adminRemarksUpdate(HttpServletRequest request) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(systemUserDao.canUpdateGeneralUserBemerkung(rps.getLoginUser().getUserID())) {
            systemUserDao.updateUserRemark(Integer.parseInt(request.getParameter("userid")), request.getParameter("text"));
        }
        return "redirect:/user/adminRemarksUpdate?adminid="+request.getParameter("userid");
    }

    @RequestMapping(method = RequestMethod.GET, value = "/user/adminUpdateForm")
    public String adminUpdateForm(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(systemUserDao.canUpdateGeneralUser(rps.getLoginUser().getUserID())) {
            List<UserCategory> categories = bookDao.getAllCategoryByOwner(0);
            List<Place> places = placeDao.getAllPlaces();
            List<UserType> userTypes = systemUserDao.getAllUserTypes();
            SystemUser systemUser = systemUserDao.getSystemUser(Integer.parseInt(request.getParameter("adminid")));
            AdminUpdateViewModel adminUpdateViewModel = new AdminUpdateViewModel(
                    ""+ MyDate.getDay(systemUser.getUserBirthDate()),
                    ""+MyDate.getMonth(systemUser.getUserBirthDate()),
                    ""+MyDate.getYear(systemUser.getUserBirthDate())
            );
            adminUpdateViewModel.setUserCategoryId(bookDao.getUserCategory(systemUser.getUserID()));

            model.addAttribute("categories", categories);
            model.addAttribute("places", places);
            model.addAttribute("userTypes", userTypes);
            model.addAttribute("systemUser", systemUser);
            model.addAttribute("adminUpdateViewModel", adminUpdateViewModel);
            request.getSession().setAttribute("padmin", systemUser);
        } else {
            return "/index?err=permission";
        }
        return "adminUpdateForm";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/user/updateAdmin")
    public String adminUpdateFormProcess(HttpServletRequest request, Model model) {
        if(loginStatement(request)) {
            return "redirect:/";
        }
        return "updateAdmin";
    }
}
