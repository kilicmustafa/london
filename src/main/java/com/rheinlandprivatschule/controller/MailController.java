package com.rheinlandprivatschule.controller;

import com.rheinlandprivatschule.repository.RPS;
import com.rheinlandprivatschule.repository.SystemUserDao;
import com.rheinlandprivatschule.service.SendMail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

@Controller
public class MailController extends BaseController {

    private final SystemUserDao systemUserDao;

    @Autowired
    public MailController(SystemUserDao systemUserDao) {
        this.systemUserDao = systemUserDao;
    }


    @RequestMapping(value = {"/user/mailComposer"}, method = {RequestMethod.GET, RequestMethod.POST})
    public String mailComposer(HttpServletRequest request, Model model) {
        if(loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");

        if(systemUserDao.canSendEmail(rps.getLoginUser().getUserID())) {
            String[] toList = request.getParameterValues("checkbox");
            List<String> toVector = new ArrayList<>();
            StringBuilder to= new StringBuilder();
            StringBuilder list = new StringBuilder();
            if(toList != null) {
                int track = 1;
                for (String aToList : toList) {
                    if (track == 1) {
                        to.append(aToList);
                        track++;
                    } else {
                        to.append(",");
                        to.append(aToList);
                    }
                    toVector.add(aToList);
                }
            } else {
                String singleemail= request.getParameter("singleemail");
                if(singleemail == null) {
                    singleemail = (String) request.getSession().getAttribute("singleemail");
                }
                toVector.add(singleemail);
                to.append(singleemail);
            }
            model.addAttribute("toVector", toVector);
            model.addAttribute("subb", "Nachricht von "+rps.getLoginUser().getUserFirstName()+" "+
                    rps.getLoginUser().getUserLastName());
            Vector vb = (Vector) request.getAttribute("filelist");
            String what=request.getParameter("what");
            if(vb!=null && what!=null){
                for(int ii=0;ii<vb.size();ii++){
                    if(ii==0){
                        list = new StringBuilder((String) vb.elementAt(ii));
                    }else{
                        list.append(",").append((String) vb.elementAt(ii));
                    }
                }
            }
            model.addAttribute("to", to);
            model.addAttribute("list", list);
        } else {
            return "redirect:/user/mailComposer?err=permission";
        }

        return "mailComposer";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/**/sendMail")
    public String sendMail(HttpServletRequest request, Model model) {
        if(loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");

        if(systemUserDao.canSendEmail(rps.getLoginUser().getUserID())) {
            String too= request.getParameter("too");
            String subject= request.getParameter("subject");
            String text= request.getParameter("text");

            SendMail sm = new SendMail();
            if(too!=null)
            {sm.setTo(too);}
            if(subject!=null)
            {sm.setSubject(subject);}
            if(text!=null)
            {sm.setText(text);}
            Vector vv=(Vector)request.getAttribute("filelist");
            request.setAttribute("filelist",vv);
            if(vv!=null){
                sm.setFiles(vv);
            }else{
                sm.setFiles(new Vector());
            }

            /*java.net.URL url = Thread.currentThread().getContextClassLoader().getResource("/tempattach/");
            String patthh=request.getRealPath(request.getServletPath());
            patthh=patthh.substring(0,patthh.lastIndexOf("rheinlandprivatschule")-1);
            patthh=patthh+"/attachment/";
            sm.setRelativePath(patthh);*/

            if(!sm.sendMail()){
                String err="Scheitern Sie daran, Post Zu senden ..Systeme.. : "+sm.getErrorMessage();
                request.setAttribute("err",err);
                request.setAttribute("lin","../map.jsp");
                return "redirect:/error";
            }

            model.addAttribute("too", too.split(","));
        } else {
            return "redirect:/user/mailComposer?err=permission";
        }


        return "sendMail";
    }
}
