package com.rheinlandprivatschule.controller.mahnung;

import com.rheinlandprivatschule.controller.BaseController;
import com.rheinlandprivatschule.repository.MahnungDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;


import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

@Controller
public class MahnungController extends BaseController {

    private MahnungDao mahnungDao;

    public MahnungController() {
        this.mahnungDao = new MahnungDao();
    }

    @RequestMapping(method = RequestMethod.GET, value = "/mahnung/mahnunglist")
    public String mahnungList(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        model.addAttribute("mdb", mahnungDao);

        return "mahnunglist";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/mahnung/nor")
    public String nor(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        model.addAttribute("mdb", mahnungDao);

        return "nor";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/mahnung/printMahnung")
    public String printMahnung(HttpServletRequest request) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        return "printMahnung";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/mahnung/send")
    public String send(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        model.addAttribute("mdb", mahnungDao);

        return "send";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/mahnung/unklarcatlistass")
    public String unklarcatlistass(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        model.addAttribute("mdb", mahnungDao);

        return "unklarcatlistass";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/mahnung/unklar")
    public String unklar(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        model.addAttribute("mdb", mahnungDao);

        return "unklar";
    }

    @RequestMapping(value = "/mahnung/mahnungIntervals", method = {RequestMethod.GET, RequestMethod.POST})
    public String mahnungIntervals(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        model.addAttribute("mdb", mahnungDao);

        return "mahnungIntervals";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/mahnung/unklarcatlist")
    public String unklarcatlist(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        model.addAttribute("mdb", mahnungDao);

        return "unklarcatlist";
    }

    @RequestMapping(value = "/mahnung/newCat", method = {RequestMethod.GET, RequestMethod.POST})
    public String newCat(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        model.addAttribute("mdb", mahnungDao);

        return "mahnungNewCat";
    }

    @RequestMapping(value = "/mahnung/unklarlist", method = RequestMethod.GET)
    public String unklarlist(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        model.addAttribute("mdb", mahnungDao);

        return "unklarlist";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/mahnung/klar")
    public String klar(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        model.addAttribute("mdb", mahnungDao);

        return "klar";
    }

    @RequestMapping(value = "/mahnung/catView", method = {RequestMethod.GET, RequestMethod.POST})
    public String catView(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        model.addAttribute("mdb", mahnungDao);

        return "mahnungCatView";
    }

    @RequestMapping(value = "/mahnung/kasolist", method = RequestMethod.GET)
    public String kassolist(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        model.addAttribute("mdb", mahnungDao);

        return "kasolist";
    }

    @RequestMapping(value = "/mahnung/versendlist", method = RequestMethod.GET)
    public String versendlist(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        model.addAttribute("mdb", mahnungDao);

        return "versendlist";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/mahnung/sendInKaso")
    public String sendInKaso(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        model.addAttribute("mdb", mahnungDao);

        return "sendInKaso";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/mahnung/mahnunglistwd")
    public String mahnunglistwd(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        model.addAttribute("mdb", mahnungDao);

        return "mahnunglistwd";
    }
}
