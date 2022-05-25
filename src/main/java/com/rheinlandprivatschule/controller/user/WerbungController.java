package com.rheinlandprivatschule.controller.user;

import com.rheinlandprivatschule.controller.BaseController;
import com.rheinlandprivatschule.model.Werbung;
import com.rheinlandprivatschule.repository.RPS;
import com.rheinlandprivatschule.repository.WerbungDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class WerbungController extends BaseController {

    private final WerbungDao werbungDao;

    @Autowired
    public WerbungController(WerbungDao werbungDao) {
        this.werbungDao = werbungDao;
    }

    @RequestMapping(method = RequestMethod.GET, value = "/user/werbungList")
    public String werbungList(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }
        String userid = request.getParameter("userid");

        Werbung adminWerbung=werbungDao.getWerbung(werbungDao.getAdminWerbung(Integer.parseInt(userid)));
        String currentWerbung=adminWerbung.getWerbungName();
        int parent=0;
        if(request.getParameter("cmd") != null) {
            String wid= request.getParameter("werbung");
            werbungDao.updateRelationToAdmin(Integer.parseInt(userid), Integer.parseInt(wid));
            return "redirect:/user/adminRemarksF?adminid=" + userid;
        } else {
            String parentS=request.getParameter("parent");
            if(parentS!=null){
                parent=Integer.parseInt(parentS);
            }
            List<Werbung> werbungList=werbungDao.getAllWerbungs(parent);
            model.addAttribute("werbungList", werbungList);
            model.addAttribute("currentWerbung", currentWerbung);
            model.addAttribute("userid", userid);
        }
        return "werbungList";
    }
}
