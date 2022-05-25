package com.rheinlandprivatschule.controller.balanz;

import com.rheinlandprivatschule.controller.BaseController;
import com.rheinlandprivatschule.helper.MyDate;
import com.rheinlandprivatschule.model.SchoolLohnReport;
import com.rheinlandprivatschule.repository.CourseDao;
import com.rheinlandprivatschule.repository.LohnReportDao;
import com.rheinlandprivatschule.repository.RPS;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import javax.servlet.http.HttpServletRequest;
import java.sql.Date;

@Controller
public class TeacherReportController extends BaseController {

    private final LohnReportDao lohnReportDao;

    @Autowired
    public TeacherReportController(LohnReportDao lohnReportDao) {
        this.lohnReportDao = lohnReportDao;
    }

    @RequestMapping(value = {"/balanz/expenseReportTeacherView", "/balanz/incomeReportCourseView"}, method = RequestMethod.GET)
    public String expenseReportTeacherView(HttpServletRequest request, Model model) {
        if (this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        System.out.println();
        if (lohnReportDao.canSeeLohnRechnung(rps.getLoginUser().getUserID())) {
            String placeIDS = request.getParameter("placeID");
            if (placeIDS != null) {
                Date firstDate = MyDate.getSQLDateFromDashFormatString(request.getParameter("firstDate"), MyDate.DEUTSCH);
                Date lastDate = MyDate.getSQLDateFromDashFormatString(request.getParameter("lastDate"), MyDate.DEUTSCH);
                int placeID = Integer.parseInt(placeIDS);


                model.addAttribute("firstDate", firstDate);
                model.addAttribute("lastDate", lastDate);
                model.addAttribute("placeID", placeID);

                String[] parts = request.getRequestURL().toString().split("/");
                if(parts[parts.length - 1].equals("expenseReportTeacherView")) {
                    SchoolLohnReport reportByTeacher = lohnReportDao.getSchoolReportTeacherWise(placeID, firstDate, lastDate);
                    model.addAttribute("reportByTeacher", reportByTeacher);
                    return"expenseReportTeacherView";
                } else if (parts[parts.length - 1].equals("incomeReportCourseView")){
                    SchoolLohnReport reportByCourse=lohnReportDao.getSchoolReportCourseWise(placeID,firstDate,lastDate);
                    model.addAttribute("reportByCourse", reportByCourse);
                    model.addAttribute("courseDao", new CourseDao());
                    return"incomeReportCourseView";
                }

            } else {
                String err = lohnReportDao.getError();
                request.getSession().setAttribute("err", err);
                request.getSession().setAttribute("lin", "../map.jsp");
                return "redirect:/error";
            }
        }
        return "";
    }
}
