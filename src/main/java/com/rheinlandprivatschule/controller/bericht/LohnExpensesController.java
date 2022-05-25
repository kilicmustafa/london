package com.rheinlandprivatschule.controller.bericht;

import com.rheinlandprivatschule.controller.BaseController;
import com.rheinlandprivatschule.helper.MyDate;
import com.rheinlandprivatschule.model.SchoolLohnReport;
import com.rheinlandprivatschule.repository.LohnReportDao;
import com.rheinlandprivatschule.repository.PlaceDao;
import com.rheinlandprivatschule.repository.RPS;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;


import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import java.util.Vector;

@Controller
public class LohnExpensesController extends BaseController {

    private final LohnReportDao lohnReportDao;
    private final PlaceDao placeDao;

    @Autowired
    public LohnExpensesController(LohnReportDao lohnReportDao, PlaceDao placeDao) {
        this.lohnReportDao = lohnReportDao;
        this.placeDao = placeDao;
    }

    @RequestMapping(value = "/bericht/lohnExpenses", method = RequestMethod.GET)
    public String lohnExpenses(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");

        if(lohnReportDao.canSeeLohnRechnung(rps.getLoginUser().getUserID())) {
            java.sql.Date firstDate= MyDate.getFirstCurrentMonthDate();
            java.sql.Date lastDate=MyDate.getLastCurrentMonthDate();

            int dayO=Integer.parseInt(MyDate.getDay(firstDate));
            int yearO=Integer.parseInt(MyDate.getYear(firstDate));
            String monthO=MyDate.getMonth(firstDate);

            int day =Integer.parseInt(MyDate.getDay(lastDate));
            int year=Integer.parseInt(MyDate.getYear(firstDate));
            String month=MyDate.getMonth(firstDate);

            SchoolLohnReport reportByTeacher = new SchoolLohnReport();
            SchoolLohnReport reportByCourse=new SchoolLohnReport();

            reportByTeacher.setTeacherReports(new Vector());
            reportByTeacher.setCourseReports(new Vector());
            reportByCourse.setTeacherReports(new Vector());
            reportByCourse.setCourseReports(new Vector());


            model.addAttribute("day0", dayO);
            model.addAttribute("month0", monthO);
            model.addAttribute("year0", yearO);

            model.addAttribute("day", day);
            model.addAttribute("month", month);
            model.addAttribute("year", year);

            model.addAttribute("cityV", placeDao.getAllPlaces());

            model.addAttribute("placeID", 0);

            model.addAttribute("reportByTeacher", reportByTeacher);
            model.addAttribute("reportByCourse", reportByCourse);
        } else {
            return "redirect:/index?err=permission";
        }

        return "lohnExpenses";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/bericht/lohnExpenses")
    public String lohnExpensesProcess(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");

        if(lohnReportDao.canSeeLohnRechnung(rps.getLoginUser().getUserID())) {
            java.sql.Date firstDate=MyDate.getSQLDateFromStrings((String)request.getParameter("selSDay"),(String)request.getParameter("selSMonth"),(String)request.getParameter("selSYear"),MyDate.DEUTSCH);
            int dayO=Integer.parseInt(MyDate.getDay(firstDate));
            int yearO=Integer.parseInt(MyDate.getYear(firstDate));
            String monthO=MyDate.getMonth(firstDate);
            java.sql.Date lastDate=MyDate.getSQLDateFromStrings((String)request.getParameter("selEDay"),(String)request.getParameter("selEMonth"),(String)request.getParameter("selEYear"),MyDate.DEUTSCH);
            int day =Integer.parseInt(MyDate.getDay(lastDate));
            int year=Integer.parseInt(MyDate.getYear(lastDate));
            String month=MyDate.getMonth(lastDate);
            int placeID=Integer.parseInt(request.getParameter("selPlace"));

            SchoolLohnReport reportByTeacher=lohnReportDao.getSchoolReportTeacherWise(placeID,firstDate,lastDate);
            SchoolLohnReport reportByCourse=lohnReportDao.getSchoolReportCourseWise(placeID,firstDate,lastDate);


            model.addAttribute("day0", dayO);
            model.addAttribute("month0", monthO);
            model.addAttribute("year0", yearO);

            model.addAttribute("day", day);
            model.addAttribute("month", month);
            model.addAttribute("year", year);

            model.addAttribute("cityV", placeDao.getAllPlaces());

            model.addAttribute("placeID", placeID);

            model.addAttribute("reportByTeacher", reportByTeacher);
            model.addAttribute("reportByCourse", reportByCourse);
        } else {
            return "redirect:/index?err=permission";
        }

        return "lohnExpenses";
    }
}
