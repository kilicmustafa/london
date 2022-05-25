package com.rheinlandprivatschule.controller.vocabultrainer;

import com.rheinlandprivatschule.controller.BaseController;
import com.rheinlandprivatschule.repository.RPS;
import com.rheinlandprivatschule.repository.VocabulDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;


import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

@Controller
public class SpracheController extends BaseController {

    private final VocabulDao vocabulDao;

    @Autowired
    public SpracheController(VocabulDao vocabulDao) {
        this.vocabulDao = vocabulDao;
    }

    @RequestMapping(value = "/vocabultrainer/sprach", method = { RequestMethod.GET, RequestMethod.POST })
    public String sprach(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(vocabulDao.canUpdateLanguage(rps.getLoginUser().getUserID())) {
            model.addAttribute("vocabulDao", vocabulDao);
            return "sprach";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/vocabultrainer/updateSprach")
    public String updateSprach(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(vocabulDao.canUpdateLanguage(rps.getLoginUser().getUserID())) {
            model.addAttribute("vocabulDao", vocabulDao);
            return "updateSprach";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/vocabultrainer/lecture")
    public String lecture(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(vocabulDao.canSeeLectures(rps.getLoginUser().getUserID())) {
            model.addAttribute("vocabulDao", vocabulDao);
            return "lecture";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/vocabultrainer/lectureDetail")
    public String lectureDetail(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(vocabulDao.canWorkWithLecture(rps.getLoginUser().getUserID())) {
            model.addAttribute("vocabulDao", vocabulDao);
            return "lectureDetail";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/vocabultrainer/deleteWord")
    public String deleteWord(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(vocabulDao.canWorkWithLecture(rps.getLoginUser().getUserID())) {
            model.addAttribute("vocabulDao", vocabulDao);
            return "deleteWord";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/vocabultrainer/newWord", method = { RequestMethod.GET, RequestMethod.POST })
    public String newWord(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(vocabulDao.canUpdateLanguage(rps.getLoginUser().getUserID())) {
            model.addAttribute("vocabulDao", vocabulDao);
            return "newWord";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/vocabultrainer/updateLan", method = { RequestMethod.GET, RequestMethod.POST })
    public String updateLan(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(vocabulDao.canUpdateLanguage(rps.getLoginUser().getUserID())) {
            model.addAttribute("vocabulDao", vocabulDao);
            return "updateLan";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/vocabultrainer/update", method = { RequestMethod.GET, RequestMethod.POST })
    public String update(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(vocabulDao.canWorkWithLecture(rps.getLoginUser().getUserID())) {
            model.addAttribute("vocabulDao", vocabulDao);
            return "update";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/vocabultrainer/translateLan", method = { RequestMethod.GET, RequestMethod.POST })
    public String translateLan(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(vocabulDao.canWorkWithLecture(rps.getLoginUser().getUserID())) {
            model.addAttribute("vocabulDao", vocabulDao);
            return "translateLan";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/vocabultrainer/wizard", method = { RequestMethod.GET, RequestMethod.POST })
    public String wizard(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(vocabulDao.canWorkWithLecture(rps.getLoginUser().getUserID())) {
            model.addAttribute("vocabulDao", vocabulDao);
            return "wizard";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/vocabultrainer/newSprach", method = { RequestMethod.GET, RequestMethod.POST })
    public String newSprach(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(vocabulDao.canAddNewLanguage(rps.getLoginUser().getUserID())) {
            model.addAttribute("vocabulDao", vocabulDao);
            return "newSprach";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/vocabultrainer/newLecture", method = { RequestMethod.GET, RequestMethod.POST })
    public String newLecture(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(vocabulDao.canAddNewLecture(rps.getLoginUser().getUserID())) {
            model.addAttribute("vocabulDao", vocabulDao);
            return "newLecture";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/vocabultrainer/updateLecture", method = { RequestMethod.GET, RequestMethod.POST })
    public String updateLecture(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(vocabulDao.canUpdateLecture(rps.getLoginUser().getUserID())) {
            model.addAttribute("vocabulDao", vocabulDao);
            return "updateLecture";
        }

        return "redirect:/index?err=permission";
    }
}
