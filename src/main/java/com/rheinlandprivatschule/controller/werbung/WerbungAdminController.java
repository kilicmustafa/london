package com.rheinlandprivatschule.controller.werbung;

import com.rheinlandprivatschule.controller.BaseController;
import com.rheinlandprivatschule.repository.InsuranceDao;
import com.rheinlandprivatschule.repository.RPS;
import com.rheinlandprivatschule.repository.StudentDao;
import com.rheinlandprivatschule.repository.WerbungDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

@Controller
public class WerbungAdminController extends BaseController {

    private final WerbungDao werbungDao;
    private final InsuranceDao insuranceDao;
    private StudentDao studentDao;

    @Autowired
    public WerbungAdminController(WerbungDao werbungDao, InsuranceDao insuranceDao) {
        this.werbungDao = werbungDao;
        this.insuranceDao = insuranceDao;
    }

    @RequestMapping(method = RequestMethod.GET, value = "/werbung/werbungList")
    public String werbungList(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(werbungDao.canSeeWerbungList(rps.getLoginUser().getUserID())) {
            model.addAttribute("werbungDao", werbungDao);
            return "adminWerbungList";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/werbung/werbungStudentList", method = { RequestMethod.GET, RequestMethod.POST })
    public String werbungStudentList(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(werbungDao.canSeeWerbungStudents(rps.getLoginUser().getUserID())) {
            model.addAttribute("werbungDao", werbungDao);
            model.addAttribute("studentDao", studentDao);
            return "werbungStudentList";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/werbung/changeWerbungStatus", method = { RequestMethod.GET, RequestMethod.POST })
    public String changeWerbungStatus(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(werbungDao.canSeeWerbungStudents(rps.getLoginUser().getUserID())) {
            String status= request.getParameter("status");
            String studentid= request.getParameter("userid");
            String werbungid= request.getParameter("wid");

            if(werbungDao.setStudentStatus(Integer.parseInt(studentid),Integer.parseInt(status))){
                return "redirect:/werbung/werbungStudentList?wid="+werbungid;
            }
            String err=werbungDao.getError();
            request.getSession().setAttribute("err",err);
            request.getSession().setAttribute("lin","werbungStudentList?wid="+werbungid);
            return "redirect:/werbung/error";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/werbung/changeActualStatus", method = { RequestMethod.GET, RequestMethod.POST })
    public String changeActualStatus(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(werbungDao.canSeeWerbungStudents(rps.getLoginUser().getUserID())) {
            String status="0";
            String werbungid="0";
            String parent="0";

            if(werbungDao.setWerbungStatus(Integer.parseInt(werbungid),Integer.parseInt(status))){
                return "redirect:/werbung/werbungList?parent="+parent;
            }
            String err=werbungDao.getError();
            request.getSession().setAttribute("err",err);
            request.getSession().setAttribute("lin","werbungList?parent="+parent);
            return "redirect:/werbung/error";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/insurance/insuranceList")
    public String insuranceList(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(insuranceDao.canSeeInsuranceList(rps.getLoginUser().getUserID())) {
            model.addAttribute("insuranceDao", insuranceDao);
            return "adminInsuranceList";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/insurance/insuranceStudentList")
    public String insuranceStudentList(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(insuranceDao.canSeeInsuranceStudents(rps.getLoginUser().getUserID())) {
            model.addAttribute("insuranceDao", insuranceDao);
            return "insuranceStudentList";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/insurance/newInsurance", method = { RequestMethod.GET, RequestMethod.POST })
    public String newInsurance(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(insuranceDao.canAddNewInsurance(rps.getLoginUser().getUserID())) {
            model.addAttribute("insuranceDao", insuranceDao);
            return "newInsurance";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/insurance/viewInsurance", method = { RequestMethod.GET, RequestMethod.POST })
    public String viewInsurance(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(insuranceDao.canUpdateInsurance(rps.getLoginUser().getUserID())) {
            model.addAttribute("insuranceDao", insuranceDao);
            return "viewInsurance";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/werbung/newWerbung", method = { RequestMethod.GET, RequestMethod.POST })
    public String newWerbung(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(werbungDao.canAddNewWerbung(rps.getLoginUser().getUserID())) {
            model.addAttribute("werbungDao", werbungDao);
            return "newWerbung";
        }

        return "redirect:/index?err=permission";
    }
}
