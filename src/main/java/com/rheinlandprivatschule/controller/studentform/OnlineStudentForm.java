package com.rheinlandprivatschule.controller.studentform;

import com.rheinlandprivatschule.repository.StudentDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class OnlineStudentForm {

    private final StudentDao studentDao;

    @Autowired
    public OnlineStudentForm(StudentDao studentDao) {
        this.studentDao = studentDao;
    }

    @RequestMapping(value = "/onlineStudentForm", method = RequestMethod.GET)
    public String getOnlineStudentForm(Model model) {
        model.addAttribute("studentDao", studentDao);
        return "onlineStudentForm";
    }

    @RequestMapping(value = "/registerOnlineStudent", method = RequestMethod.POST)
    public String registerOnlineStudent(Model model) {
        model.addAttribute("studentDao", studentDao);
        return "registerOnlineStudent";
    }

    @RequestMapping(value = "/info", method = RequestMethod.GET)
    public String info() {
        return "info";
    }

    @RequestMapping(value = "/currentLocation", method = RequestMethod.GET)
    public String currentLocation(Model model) {
        return "currentLocationOnline";
    }

    @RequestMapping(value = "/makeVertrag", method = RequestMethod.POST)
    public String makeVertrag(Model model) {
        model.addAttribute("studentDao", studentDao);
        return "makeVertragnOnline";
    }

    @RequestMapping(value = "/makeVertrag2", method = RequestMethod.POST)
    public String makeVertrag2(Model model) {
        model.addAttribute("studentDao", studentDao);
        return "makeVertrag2Online";
    }

    @RequestMapping(value = "/vertragPlan", method = RequestMethod.POST)
    public String vertragPlan() {
        return "vertragPlanOnline";
    }

    @RequestMapping(value = "/vertragFinal", method = RequestMethod.POST)
    public String vertragFinal(Model model) {
        model.addAttribute("studentDao", studentDao);
        return "vertragFinalOnline";
    }

    @RequestMapping(value = "/printVertrag", method = RequestMethod.GET)
    public String printVertrag() {
        return "printVertragOnline";
    }

    @RequestMapping(value = "/printVertrag1", method = RequestMethod.GET)
    public String printVertrag1() {
        return "printVertrag1Online";
    }

    @RequestMapping(value = "/registerVerFee", method = RequestMethod.GET)
    public String registerVerFee() {
        return "registerVerFeeOnline";
    }
}
