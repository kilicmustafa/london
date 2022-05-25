package com.rheinlandprivatschule.controller.user;

import com.rheinlandprivatschule.controller.BaseController;
import com.rheinlandprivatschule.helper.MyCurrency;
import com.rheinlandprivatschule.helper.MyDate;
import com.rheinlandprivatschule.model.SystemUser;
import com.rheinlandprivatschule.model.TeacherLohn;
import com.rheinlandprivatschule.repository.RPS;
import com.rheinlandprivatschule.repository.SystemUserDao;
import com.rheinlandprivatschule.repository.TeacherLohnDao;
import com.rheinlandprivatschule.viewmodel.AdminLohnUpdateViewModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import javax.servlet.http.HttpServletRequest;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

@Controller
public class StundenlohnController extends BaseController {

    private final SystemUserDao systemUserDao;
    private final TeacherLohnDao teacherLohnDao;

    @Autowired
    public StundenlohnController(SystemUserDao systemUserDao, TeacherLohnDao teacherLohnDao) {
        this.systemUserDao = systemUserDao;
        this.teacherLohnDao = teacherLohnDao;
    }

    @RequestMapping(method = RequestMethod.GET, value = "/user/adminLohnUpdate")
    public String adminLohnUpdate(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)){
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(systemUserDao.canUpdateGeneralUserLohn(rps.getLoginUser().getUserID())) {
            String adminid= request.getParameter("adminid");
            SystemUser systemUser = systemUserDao.getSystemUser(Integer.parseInt(adminid));
            double lohn = systemUser.getUserStundenLohn();
            String strLohn = MyCurrency.getDisplayString(lohn);
            int userid = systemUser.getUserID();


            int dayO=Integer.parseInt(MyDate.getDay(MyDate.getFirstCurrentMonthDate()));
            int yearO=Integer.parseInt(MyDate.getYear(MyDate.getFirstCurrentMonthDate()));
            String monthO=MyDate.getMonth(MyDate.getFirstCurrentMonthDate());

            List<TeacherLohn> privateLohnList = teacherLohnDao.getAllTeacherLohn(userid, TeacherLohnDao.PRIVATELOHN);
            List<TeacherLohn> groupLohnList = teacherLohnDao.getAllTeacherLohn(userid, TeacherLohnDao.GROUPLOHN);


            model.addAttribute("day", dayO);
            model.addAttribute("month", monthO);
            model.addAttribute("year", yearO);

            List<AdminLohnUpdateViewModel> forPrivate = new ArrayList<>();
            List<AdminLohnUpdateViewModel> forGroup = new ArrayList<>();
            for(TeacherLohn teacherLohn : privateLohnList) {
                forPrivate.add(fillAdminLohnUpdateViewModel(teacherLohn));
            }

            for(TeacherLohn teacherLohn : groupLohnList) {
                forGroup.add(fillAdminLohnUpdateViewModel(teacherLohn));
            }


            model.addAttribute("privateLohnList", forPrivate);
            model.addAttribute("groupLohnList", forGroup);
            model.addAttribute("userid", userid);
            request.getSession().setAttribute("reus",systemUser);
        } else {
            return "redirect:/?err=permission";
        }

        return "adminLohnUpdate";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/user/adminLohnUpdate")
    public String adminLohnUpdateProcess(HttpServletRequest request) {
        String generalLohnS= request.getParameter("txtLohn");
        if(generalLohnS!=null) {
            SystemUser u = (SystemUser) request.getSession().getAttribute("reus");

            Date firstDate = MyDate.getSQLDateFromStrings(request.getParameter("selSDay"), request.getParameter("selSMonth"), request.getParameter("selSYear"), MyDate.DEUTSCH);

            String tempSelEDay = request.getParameter("selEDay");
            String tempSelEMonth = request.getParameter("selEMonth");
            String tempSelEYear = request.getParameter("selEYear");
            Date lastDate;
            if (tempSelEDay.equalsIgnoreCase("-") || tempSelEMonth.equalsIgnoreCase("-") || tempSelEYear.equalsIgnoreCase("-")) {
                lastDate = null;
            } else {
                lastDate = MyDate.getSQLDateFromStrings(tempSelEDay, tempSelEMonth, tempSelEYear, MyDate.DEUTSCH);
            }
            double generalLohn = MyCurrency.getDoubleValue(generalLohnS);
            String selectTypeS = request.getParameter("selectType");
            int selectType = Integer.parseInt(selectTypeS);
            boolean result = teacherLohnDao.addNewTeacherLohn(u.getUserID(), firstDate, lastDate, generalLohn, selectType);

            if(!result) {
                return "redirect:/user/adminLohnUpdate?adminid=" + request.getParameter("userid") + "&error=invalidDate";
            }

            request.getSession().setAttribute("reus", null);
        }
        return "redirect:/user/adminLohnUpdate?adminid=" + request.getParameter("userid");
    }

    @RequestMapping(method = RequestMethod.GET, value = "/user/deleteLohn")
    public String deleteLohn(HttpServletRequest request) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }
        return "deleteLohn";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/user/adminLohnUpdate1")
    public String adminLohnUpdate1(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        int dayO=0;
        int yearO=0;
        String monthO="0";
        int day =0;
        int year=0;
        String month="0";
        String lohnPay="0";
        int userIDN=0;
        int lohnType=0;
        String startdate="";
        String enddate="";
        double lohn=0.0;
        String strLohn="0,0";
        TeacherLohn teacherLohn;

        if(systemUserDao.canUpdateGeneralUserLohn(rps.getLoginUser().getUserID())){
            String userid=(String)request.getParameter("userid");
            if(userid!=null){
                startdate=(String)request.getParameter("sdate");
                enddate=(String)request.getParameter("edate");
                String lohnTypeS=(String)request.getParameter("ltype");
                lohnPay=(String)request.getParameter("lohnpay");

                userIDN=Integer.parseInt(userid);
                java.sql.Date firstDate=MyDate.getSQLDateFromDashFormatString(startdate,MyDate.DEUTSCH);
                //lastDate=null;
                if(enddate != null){
                    java.sql.Date lastDate=MyDate.getSQLDateFromDashFormatString(enddate,MyDate.DEUTSCH);
                    if(Integer.parseInt(MyDate.getYear(lastDate))>2003){
                        day=Integer.parseInt(MyDate.getDay(lastDate));
                        month=MyDate.getMonth(lastDate);
                        year=Integer.parseInt(MyDate.getYear(lastDate));
                    }
                }
                lohnType=Integer.parseInt(lohnTypeS);

                teacherLohn=teacherLohnDao.getTeacherLohn(userIDN, lohnType, firstDate);

                dayO=Integer.parseInt(MyDate.getDay(firstDate));
                monthO=MyDate.getMonth(firstDate);
                yearO=Integer.parseInt(MyDate.getYear(firstDate));
                model.addAttribute("day0", dayO);
                model.addAttribute("month0", monthO);
                model.addAttribute("year0", yearO);
                model.addAttribute("day", day);
                model.addAttribute("month", month);
                model.addAttribute("year", year);
                model.addAttribute("userIDN", userIDN);
                model.addAttribute("lohnType", lohnType);
                model.addAttribute("startdate", startdate);
                model.addAttribute("enddate", enddate);
                model.addAttribute("lohnPay", lohnPay);
            }else{
                String userid1=(String)request.getParameter("hidID");
                String startDay=(String)request.getParameter("selSDay");
                String startMonth=(String)request.getParameter("selSMonth");
                String startYear=(String)request.getParameter("selSYear");
                String endDay=(String)request.getParameter("selEDay");
                String endMonth=(String)request.getParameter("selEMonth");
                String endYear=(String)request.getParameter("selEYear");
                String lohn1=(String)request.getParameter("txtLohn");
                String hlohnType=(String)request.getParameter("hlohntype");

                java.sql.Date start=MyDate.getSQLDateFromStrings(startDay,startMonth,startYear,MyDate.DEUTSCH);
                java.sql.Date end=MyDate.getSQLDateFromStrings(endDay,endMonth,endYear,MyDate.DEUTSCH);

                TeacherLohn tlohn=new TeacherLohn();

                tlohn.setUserID(Integer.parseInt(userid1));
                tlohn.setStartDate(start);
                tlohn.setEndDate(end);
                tlohn.setTeacherLohn(Double.parseDouble(lohn1));
            }
        }

        return "adminLohnUpdate1";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/user/updateLohn")
    public String updateLohn(HttpServletRequest request) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }
        return "updateLohn";
    }

    private AdminLohnUpdateViewModel fillAdminLohnUpdateViewModel(TeacherLohn teacherLohn) {
        String loopEndDate = "-";
        if(teacherLohn.getEndDate() != null && (teacherLohn.getEndDate().after(teacherLohn.getStartDate()))){
            loopEndDate = MyDate.formateDate(teacherLohn.getEndDate(),MyDate.NUMERIC,MyDate.DEUTSCH);
        }
        return new AdminLohnUpdateViewModel(
                teacherLohn,
                MyDate.formateDate(teacherLohn.getStartDate(),MyDate.NUMERIC,MyDate.DEUTSCH),
                loopEndDate,
                MyCurrency.getDisplayString(teacherLohn.getTeacherLohn())
        );
    }
}
