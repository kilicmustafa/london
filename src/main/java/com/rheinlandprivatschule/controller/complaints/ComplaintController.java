package com.rheinlandprivatschule.controller.complaints;

import com.rheinlandprivatschule.controller.BaseController;
import com.rheinlandprivatschule.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

@Controller
public class ComplaintController extends BaseController {

    private PlaceDao placeDao;
    private TransactionDao transactionDao;
    private SystemUserDao systemUserDao;
    private StudentComplaintDao studentComplaintDao;
    private ComplaintDao complaintDao;
    private StudentDao studentDao;

    @Autowired
    public ComplaintController(PlaceDao placeDao, TransactionDao transactionDao, SystemUserDao systemUserDao, StudentComplaintDao studentComplaintDao, ComplaintDao complaintDao, StudentDao studentDao) {
        this.placeDao = placeDao;
        this.transactionDao = transactionDao;
        this.systemUserDao = systemUserDao;
        this.studentComplaintDao = studentComplaintDao;
        this.complaintDao = complaintDao;
        this.studentDao = studentDao;
    }

    @RequestMapping(value = "/complaints/searchComplaint", method = RequestMethod.GET)
    public String searchComplaint(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(transactionDao.canSeeBericht(rps.getLoginUser().getUserID())) {
            model.addAttribute("handler", rps);
            model.addAttribute("placeDao", placeDao);
            model.addAttribute("transactionDao", transactionDao);
            model.addAttribute("systemUserDao", systemUserDao);

            return "searchComplaint";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/complaints/showComplaint", method = { RequestMethod.GET, RequestMethod.POST })
    public String showComplaint(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(studentComplaintDao.canSeeComplaintList(rps.getLoginUser().getUserID())) {
            model.addAttribute("handler", rps);
            model.addAttribute("placeDao", placeDao);
            model.addAttribute("trdb", studentComplaintDao);
            model.addAttribute("systemUserDao", systemUserDao);

            return "showComplaint";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/complaints/complaintList")
    public String complaintList(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(complaintDao.canSeeComplaintList(rps.getLoginUser().getUserID())) {
            model.addAttribute("handler", rps);
            model.addAttribute("placeDao", placeDao);
            model.addAttribute("complaintDao", complaintDao);

            return "complaintList";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/complaints/showComplaintN", method = { RequestMethod.GET, RequestMethod.POST })
    public String showComplaintN(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(studentComplaintDao.canSeeComplaintList(rps.getLoginUser().getUserID())) {
            model.addAttribute("handler", rps);
            model.addAttribute("placeDao", placeDao);
            model.addAttribute("trdb", studentComplaintDao);
            model.addAttribute("systemUserDao", systemUserDao);

            return "showComplaintN";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/complaints/newComplaint", method = { RequestMethod.GET, RequestMethod.POST })
    public String newComplaint(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(complaintDao.canAddNewComplaints(rps.getLoginUser().getUserID())) {
            model.addAttribute("complaintDao", complaintDao);
            return "newComplaint";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/complaints/complaintView", method = { RequestMethod.GET, RequestMethod.POST })
    public String complaintView(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(complaintDao.canUpdateComplaint(rps.getLoginUser().getUserID())) {
            model.addAttribute("complaintDao", complaintDao);

            return "complaintView";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/complaints/changeComplaintStatus", method = { RequestMethod.GET, RequestMethod.POST })
    public String changeComplaintStatus(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(complaintDao.canUpdateComplaint(rps.getLoginUser().getUserID())) {
            model.addAttribute("complaintDao", complaintDao);

            return "changeComplaintStatus";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/complaints/studentComplaintView", method = { RequestMethod.GET, RequestMethod.POST })
    public String studentComplaintView(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(studentComplaintDao.canSeeComplaintList(rps.getLoginUser().getUserID())) {
            model.addAttribute("studentComplaintDao", studentComplaintDao);
            model.addAttribute("complaintDao", complaintDao);
            model.addAttribute("studentDao", studentDao);

            return "studentComplaintView";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/complaints/changeStudentCompStatus")
    public String changeStudentCompStatus(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(studentComplaintDao.canSeeComplaintList(rps.getLoginUser().getUserID())) {
            model.addAttribute("studentComplaintDao", studentComplaintDao);
            return "changeStudentCompStatus";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/complaints/studentComplaintList")
    public String studentComplaintList(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(studentComplaintDao.canSeeComplaintList(rps.getLoginUser().getUserID())) {
            model.addAttribute("studentComplaintDao", studentComplaintDao);
            model.addAttribute("complaintDao", complaintDao);
            model.addAttribute("studentDao", studentDao);
            model.addAttribute("systemUserDao", systemUserDao);
            model.addAttribute("placeDao", placeDao);

            return "studentComplaintList";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/complaints/changeStudentCompStatusSearch", method = { RequestMethod.GET, RequestMethod.POST })
    public String changeStudentCompStatusSearch(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(studentComplaintDao.canSeeComplaintList(rps.getLoginUser().getUserID())) {
            model.addAttribute("studentComplaintDao", studentComplaintDao);
            return "changeStudentCompStatusSearch";
        }

        return "redirect:/index?err=permission";
    }
}
