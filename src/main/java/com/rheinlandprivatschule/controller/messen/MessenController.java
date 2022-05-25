package com.rheinlandprivatschule.controller.messen;

import com.rheinlandprivatschule.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@Controller
public class MessenController {

    private final MesseDao messeDao;
    private final MesseStudentDao messeStudentDao;
    private final ConsultantDao consultantDao;
    private final ConsultantStudentDao consultantStudentDao;

    @Autowired
    public MessenController(MesseDao messeDao, MesseStudentDao messeStudentDao, ConsultantDao consultantDao, ConsultantStudentDao consultantStudentDao) {
        this.messeDao = messeDao;
        this.messeStudentDao = messeStudentDao;
        this.consultantDao = consultantDao;
        this.consultantStudentDao = consultantStudentDao;
    }

    @RequestMapping(method = RequestMethod.GET, value = "/werbung/messeList")
    public String messeList(HttpServletRequest request, Model model) {
        RPS rps = (RPS) request.getSession().getAttribute("handler");

        if(messeDao.canSeeMesseList(rps.getLoginUser().getUserID())) {
            model.addAttribute("messeDao", messeDao);
            model.addAttribute("messeStudentDao", messeStudentDao);
            return "messeList";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/werbung/messeUpdateForm")
    public String messeUpdateForm(HttpServletRequest request, Model model) {
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        
        if(messeDao.canUpdateMesse(rps.getLoginUser().getUserID())) {
            model.addAttribute("messeDao", messeDao);
            model.addAttribute("messeStudentDao", messeStudentDao);
            return "messeUpdateForm";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/werbung/updateMesse")
    public String updateMesse(HttpServletRequest request, Model model) {
        RPS rps = (RPS) request.getSession().getAttribute("handler");

        if(messeDao.canUpdateMesse(rps.getLoginUser().getUserID())) {
            model.addAttribute("messeDao", messeDao);
            model.addAttribute("messeStudentDao", messeStudentDao);
            return "updateMesse";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/werbung/messeStudentUpdateForm")
    public String messeStudentUpdateForm(HttpServletRequest request, Model model) {
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(messeStudentDao.canUpdateStudentMesse(rps.getLoginUser().getUserID())) {
            model.addAttribute("messeStudentDao", messeStudentDao);
            return "messeStudentUpdateForm";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/werbung/updateMesseStudent")
    public String updateMesseStudent(HttpServletRequest request, Model model) {
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(messeStudentDao.canUpdateStudentMesse(rps.getLoginUser().getUserID())) {
            model.addAttribute("messeStudentDao", messeStudentDao);
            return "updateMesseStudent";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/werbung/messeTelephoneListe")
    public String messeTelephoneListe(HttpServletRequest request, Model model) {
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(messeDao.canUpdateMesse(rps.getLoginUser().getUserID())) {
            model.addAttribute("messeDao", messeDao);
            model.addAttribute("messeStudentDao", messeStudentDao);

            return "messeTelephoneListe";
        }
        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/werbung/messeTelephoneListeInt")
    public String messeTelephoneListeInt(HttpServletRequest request, Model model) {
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(messeDao.canUpdateMesse(rps.getLoginUser().getUserID())) {
            model.addAttribute("messeDao", messeDao);
            model.addAttribute("messeStudentDao", messeStudentDao);

            return "messeTelephoneListeInt";
        }
        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/werbung/messeTelephoneListeN")
    public String messeTelephoneListeN(HttpServletRequest request, Model model) {
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(messeDao.canUpdateMesse(rps.getLoginUser().getUserID())) {
            model.addAttribute("messeDao", messeDao);
            model.addAttribute("messeStudentDao", messeStudentDao);

            return "messeTelephoneListeN";
        }
        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/werbung/newMesseStudentForm")
    public String newMesseStudentForm(HttpServletRequest request, Model model) {
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(messeStudentDao.canAddNewStudentMesse(rps.getLoginUser().getUserID())) {
            model.addAttribute("messeStudentDao", messeStudentDao);
            return "newMesseStudentForm";
        }
        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/werbung/newMesseForm")
    public String newMesseForm(HttpServletRequest request, Model model) {
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(messeDao.canAddNewMesse(rps.getLoginUser().getUserID())) {
            model.addAttribute("messeDao", messeDao);
            return "newMesseForm";
        }
        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/werbung/registerMesse")
    public String registerMesse(HttpServletRequest request, Model model) {
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(messeDao.canAddNewMesse(rps.getLoginUser().getUserID())) {
            model.addAttribute("messeDao", messeDao);
            return "registerMesse";
        }
        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/werbung/registerMesseStudent")
    public String registerMesseStudent(HttpServletRequest request, Model model) {
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(messeStudentDao.canAddNewStudentMesse(rps.getLoginUser().getUserID())) {
            model.addAttribute("messeStudentDao", messeStudentDao);
            return "registerMesseStudent";
        }
        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/werbung/consultantList")
    public String consultantList(HttpServletRequest request, Model model) {
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(consultantDao.canSeeConsultantList(rps.getLoginUser().getUserID())) {
            model.addAttribute("consultantDao", consultantDao);
            model.addAttribute("consultantStudentDao", consultantStudentDao);
            return "consultantList";
        }
        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/werbung/consultantUpdateForm")
    public String consultantUpdateForm(HttpServletRequest request, Model model) {
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(consultantDao.canUpdateConsultant(rps.getLoginUser().getUserID())) {
            model.addAttribute("consultantDao", consultantDao);
            model.addAttribute("consultantStudentDao", consultantStudentDao);
            return "consultantUpdateForm";
        }
        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/werbung/deleteConsultant")
    public String consultantDelete(HttpServletRequest request) {
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(consultantDao.canUpdateConsultant(rps.getLoginUser().getUserID())) {
            int consultantid = Integer.parseInt(request.getParameter("consultantid"));
            int studentid = Integer.parseInt(request.getParameter("studentid"));

            consultantStudentDao.deleteStudentConsultant(studentid);
            return "redirect:/werbung/consultantUpdateForm?consultantid="+consultantid;
        }
        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/werbung/updateConsultant")
    public String updateConsultant(HttpServletRequest request, Model model) {
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(consultantDao.canUpdateConsultant(rps.getLoginUser().getUserID())) {
            model.addAttribute("consultantDao", consultantDao);
            model.addAttribute("consultantStudentDao", consultantStudentDao);
            return "updateConsultant";
        }
        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/werbung/consultantTelephoneListe")
    public String consultantTelephoneListe(HttpServletRequest request, Model model) {
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(consultantDao.canUpdateConsultant(rps.getLoginUser().getUserID())) {
            model.addAttribute("consultantDao", consultantDao);
            model.addAttribute("consultantStudentDao", consultantStudentDao);
            return "consultantTelephoneListe";
        }
        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/werbung/consultantStudentUpdateForm")
    public String consultantStudentUpdateForm(HttpServletRequest request, Model model) {
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(consultantStudentDao.canUpdateStudentConsultant(rps.getLoginUser().getUserID())) {
            model.addAttribute("consultantStudentDao", consultantStudentDao);
            return "consultantStudentUpdateForm";
        }
        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/werbung/updateConsultantStudent")
    public String updateConsultantStudent(HttpServletRequest request, Model model) {
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(consultantStudentDao.canUpdateStudentConsultant(rps.getLoginUser().getUserID())) {
            model.addAttribute("consultantStudentDao", consultantStudentDao);
            return "updateConsultantStudent";
        }
        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/werbung/consultantTelephoneListeN")
    public String consultantTelephoneListeN(HttpServletRequest request, Model model) {
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(consultantDao.canUpdateConsultant(rps.getLoginUser().getUserID())) {
            model.addAttribute("consultantDao", consultantDao);
            model.addAttribute("consultantStudentDao", consultantStudentDao);
            return "consultantTelephoneListeN";
        }
        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/werbung/consultantTelephoneListeInt")
    public String consultantTelephoneListeInt(HttpServletRequest request, Model model) {
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(consultantDao.canUpdateConsultant(rps.getLoginUser().getUserID())) {
            model.addAttribute("consultantDao", consultantDao);
            model.addAttribute("consultantStudentDao", consultantStudentDao);
            return "consultantTelephoneListeInt";
        }
        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/werbung/newConsultantStudentForm")
    public String newConsultantStudentForm(HttpServletRequest request, Model model) {
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(consultantStudentDao.canAddNewStudentConsultant(rps.getLoginUser().getUserID())) {
            model.addAttribute("consultantStudentDao", consultantStudentDao);
            return "newConsultantStudentForm";
        }
        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/werbung/registerConsultantStudent")
    public String registerConsultantStudent(HttpServletRequest request, Model model) {
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(consultantStudentDao.canAddNewStudentConsultant(rps.getLoginUser().getUserID())) {
            model.addAttribute("consultantStudentDao", consultantStudentDao);
            return "registerConsultantStudent";
        }
        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/werbung/EmailView", method = { RequestMethod.GET, RequestMethod.POST })
    public String EmailView(HttpServletRequest request, Model model) {
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        model.addAttribute("rps", rps);
        return "emailview";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/werbung/newConsultantForm")
    public String newConsultantForm(HttpServletRequest request, Model model) {
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(consultantDao.canAddNewConsultant(rps.getLoginUser().getUserID())) {
            model.addAttribute("consultantDao", consultantDao);
            return "newConsultantForm";
        }
        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/werbung/registerConsultant")
    public String registerConsultant(HttpServletRequest request, Model model) {
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(consultantDao.canAddNewConsultant(rps.getLoginUser().getUserID())) {
            model.addAttribute("consultantDao", consultantDao);
            return "registerConsultant";
        }
        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/werbung/messeInterestedListe")
    public String messeInterestedListe(HttpServletRequest request, Model model) {
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(messeDao.canUpdateMesse(rps.getLoginUser().getUserID())) {
            model.addAttribute("messeDao", messeDao);
            model.addAttribute("messeStudentDao", messeStudentDao);
            return "messeInterestedListe";
        }
        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/werbung/messeEmailList", method = { RequestMethod.GET, RequestMethod.POST })
    public String messeEmailList(HttpServletRequest request, Model model) {
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(messeDao.canUpdateMesse(rps.getLoginUser().getUserID())) {
            model.addAttribute("messeDao", messeDao);
            model.addAttribute("messeStudentDao", messeStudentDao);
            return "messeEmailList";
        }
        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/werbung/consultantEmailList")
    public String consultantEmailList(HttpServletRequest request, Model model) {
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(consultantDao.canUpdateConsultant(rps.getLoginUser().getUserID())) {
            model.addAttribute("consultantDao", consultantDao);
            model.addAttribute("consultantStudentDao", consultantStudentDao);

            return "consultantEmailList";
        }
        return "redirect:/index?err=permission";
    }
}
