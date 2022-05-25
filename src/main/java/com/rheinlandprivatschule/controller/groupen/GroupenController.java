package com.rheinlandprivatschule.controller.groupen;

import com.rheinlandprivatschule.controller.BaseController;
import com.rheinlandprivatschule.repository.GroupDao;
import com.rheinlandprivatschule.repository.RPS;
import com.rheinlandprivatschule.repository.StudentDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

@Controller
public class GroupenController extends BaseController {

    private final GroupDao groupDao;
    private final StudentDao studentDao;

    @Autowired
    public GroupenController(GroupDao groupDao, StudentDao studentDao) {
        this.groupDao = groupDao;
        this.studentDao = studentDao;
    }

    @RequestMapping(method = RequestMethod.GET, value = "/groupen/groupList")
    public String groupList(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(groupDao.canSeeGroupList(rps.getLoginUser().getUserID())) {
            model.addAttribute("groupDao", groupDao);
            return "groupList";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/groupen/changeActualStatus")
    public String changeActualStatus(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(groupDao.canSeeGroupList(rps.getLoginUser().getUserID())) {
            model.addAttribute("groupDao", groupDao);
            return "changeActualStatus";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/groupen/newGroup", method = { RequestMethod.GET, RequestMethod.POST })
    public String newGroup(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(groupDao.canAddNewGroup(rps.getLoginUser().getUserID())) {
            model.addAttribute("groupDao", groupDao);
            return "newGroup";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/groupen/viewGroup", method = { RequestMethod.GET, RequestMethod.POST })
    public String viewGroup(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(groupDao.canUpdateGroup(rps.getLoginUser().getUserID())) {
            model.addAttribute("groupDao", groupDao);
            return "viewGroup";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/groupen/changeGroupStatus")
    public String changeGroupStatus(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(groupDao.canSeeGroupStudents(rps.getLoginUser().getUserID())) {
            model.addAttribute("groupDao", groupDao);
            return "changeGroupStatus";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/groupen/groupStudentList")
    public String groupStudentList(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(groupDao.canSeeGroupStudents(rps.getLoginUser().getUserID())) {
            model.addAttribute("groupDao", groupDao);
            model.addAttribute("studentDao", studentDao);
            return "groupStudentList";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/groupen/deleteStudent")
    public String deleteStudent(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(groupDao.canSeeGroupStudents(rps.getLoginUser().getUserID())) {
            model.addAttribute("groupDao", groupDao);
            return "deleteStudent";
        }

        return "redirect:/index?err=permission";
    }
}
