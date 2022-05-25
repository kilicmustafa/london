package com.rheinlandprivatschule.controller.stundenplan;

import com.rheinlandprivatschule.controller.BaseController;
import com.rheinlandprivatschule.helper.MyDate;
import com.rheinlandprivatschule.model.Course;
import com.rheinlandprivatschule.model.StundenDetail;
import com.rheinlandprivatschule.model.StundenPlan;
import com.rheinlandprivatschule.model.SystemUser;
import com.rheinlandprivatschule.repository.CourseDao;
import com.rheinlandprivatschule.repository.RPS;
import com.rheinlandprivatschule.repository.StundDao;
import com.rheinlandprivatschule.repository.SystemUserDao;
import com.rheinlandprivatschule.viewmodel.StSheetViewModel;
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
public class StundenPlanController extends BaseController {

    private final StundDao stundDao;
    private final SystemUserDao systemUserDao;

    @Autowired
    public StundenPlanController(StundDao stundDao, SystemUserDao systemUserDao) {
        this.stundDao = stundDao;
        this.systemUserDao = systemUserDao;
    }

    @RequestMapping(method = RequestMethod.GET, value = "/stundenplan/stSheet")
    public String stSheet(HttpServletRequest request, Model model) {
        if (this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if (stundDao.canSeeStundenplan(rps.getLoginUser().getUserID())) {
            String weekS = (String) request.getParameter("week");
            int week = 0;
            int trackN = 1;
            int trackP = -1;
            try {
                week = Integer.parseInt(weekS);
                int wee1 = week;
                int wee2 = week;
                wee1++;
                wee2--;
                trackN = wee1;
                trackP = wee2;

            } catch (Exception e) {
            }
            String bv = "";
            if (week == 0) {
                bv = "(Aktiv Woche)";
            }
            String hd1 = MyDate.formateDate(MyDate.getWeekFirstDateFuture(week, MyDate.DEUTSCH), MyDate.ALPHANUMERIC, MyDate.DEUTSCH);
            String hd2 = MyDate.formateDate(MyDate.getWeekLastDateFuture(week, MyDate.DEUTSCH), MyDate.ALPHANUMERIC, MyDate.DEUTSCH);
            model.addAttribute("hd1", hd1);
            model.addAttribute("hd2", hd2);
            model.addAttribute("bv", bv);
            java.sql.Date preDateS = MyDate.getSQLDateFromStrings(MyDate.getDay(MyDate.getWeekFirstDateFuture(week, MyDate.DEUTSCH)), MyDate.getMonth(MyDate.getWeekFirstDateFuture(week, MyDate.DEUTSCH)), MyDate.getYear(MyDate.getWeekFirstDateFuture(week, MyDate.DEUTSCH)), MyDate.DEUTSCH);
            java.sql.Date preDateE = MyDate.getSQLDateFromStrings(MyDate.getDay(MyDate.getWeekLastDateFuture(week, MyDate.DEUTSCH)), MyDate.getMonth(MyDate.getWeekLastDateFuture(week, MyDate.DEUTSCH)), MyDate.getYear(MyDate.getWeekLastDateFuture(week, MyDate.DEUTSCH)), MyDate.DEUTSCH);

            String monday = MyDate.getDateForHint(preDateS, 0, MyDate.DEUTSCH);
            String tuesday = MyDate.getDateForHint(preDateS, 1, MyDate.DEUTSCH);
            String wednessday = MyDate.getDateForHint(preDateS, 2, MyDate.DEUTSCH);
            String thursday = MyDate.getDateForHint(preDateS, 3, MyDate.DEUTSCH);
            String friday = MyDate.getDateForHint(preDateS, 4, MyDate.DEUTSCH);
            model.addAttribute("monday", monday);
            model.addAttribute("tuesday", tuesday);
            model.addAttribute("wednessday", wednessday);
            model.addAttribute("thursday", thursday);
            model.addAttribute("friday", friday);
            model.addAttribute("trackP", trackP);
            model.addAttribute("trackN", trackN);


            Vector v = (new CourseDao()).getAllCoursesByPlaceActive(rps.getLoginPlace().getPlaceID(), preDateS, preDateE);
            for (int g = 0; g < v.size(); g++) {
                Course cf = (Course) v.elementAt(g);
                if (!stundDao.isCourseExist(cf.getCourseID())) {
                    stundDao.addCoursePlan(cf.getCourseID(), week);
                } else if (!stundDao.isCourseExist(cf.getCourseID(), week)) {
                    stundDao.addCoursePlanSyncronized(cf.getCourseID(), week);
                }
            }
            Vector v1 = new Vector();
            Vector v2 = new Vector();
            Vector v3 = new Vector();
            for (int za = 0; za < v.size(); za++) {
                Course cr = (Course) v.elementAt(za);
                if (cr.getCourseTiming().equalsIgnoreCase("8:30-12:00")) {
                    v1.addElement(cr);
                } else if (cr.getCourseTiming().equalsIgnoreCase("12:00-18:00")) {
                    v2.addElement(cr);
                } else if (cr.getCourseTiming().equalsIgnoreCase("18:00-21:00")) {
                    v3.addElement(cr);
                }
            }

            List<StSheetViewModel> stSheetViewModelList1 = new ArrayList<>();
            for (int d = 0; d < v1.size(); d++) {
                Course c = (Course) v1.elementAt(d);
                StundenPlan sp = stundDao.getCoursePlanForWeek(c.getCourseID(), week);
                String t1Temp = "";
                String t2Temp = "";
                String t3Temp = "";
                String t4Temp = "";
                String t5Temp = "";
                if (stundDao.canCourseComeInPlan(sp.getDate1(), c.getCourseStartDate(), c.getCourseEndDate())) {
                    t1Temp = sp.getTeacher1Name();
                }
                if (stundDao.canCourseComeInPlan(sp.getDate2(), c.getCourseStartDate(), c.getCourseEndDate())) {
                    t2Temp = sp.getTeacher2Name();
                }
                if (stundDao.canCourseComeInPlan(sp.getDate3(), c.getCourseStartDate(), c.getCourseEndDate())) {
                    t3Temp = sp.getTeacher3Name();
                }
                if (stundDao.canCourseComeInPlan(sp.getDate4(), c.getCourseStartDate(), c.getCourseEndDate())) {
                    t4Temp = sp.getTeacher4Name();
                }
                if (stundDao.canCourseComeInPlan(sp.getDate5(), c.getCourseStartDate(), c.getCourseEndDate())) {
                    t5Temp = sp.getTeacher5Name();
                }
                stSheetViewModelList1.add(new StSheetViewModel(
                        c, t1Temp, t2Temp, t3Temp, t4Temp, t5Temp,
                        sp));
            }

            List<StSheetViewModel> stSheetViewModelList2 = new ArrayList<>();
            for (int d = 0; d < v2.size(); d++) {
                Course c = (Course) v2.elementAt(d);
                StundenPlan sp = stundDao.getCoursePlanForWeek(c.getCourseID(), week);
                String t1Temp = "";
                String t2Temp = "";
                String t3Temp = "";
                String t4Temp = "";
                String t5Temp = "";
                if (stundDao.canCourseComeInPlan(sp.getDate1(), c.getCourseStartDate(), c.getCourseEndDate())) {
                    t1Temp = sp.getTeacher1Name();
                }
                if (stundDao.canCourseComeInPlan(sp.getDate2(), c.getCourseStartDate(), c.getCourseEndDate())) {
                    t2Temp = sp.getTeacher2Name();
                }
                if (stundDao.canCourseComeInPlan(sp.getDate3(), c.getCourseStartDate(), c.getCourseEndDate())) {
                    t3Temp = sp.getTeacher3Name();
                }
                if (stundDao.canCourseComeInPlan(sp.getDate4(), c.getCourseStartDate(), c.getCourseEndDate())) {
                    t4Temp = sp.getTeacher4Name();
                }
                if (stundDao.canCourseComeInPlan(sp.getDate5(), c.getCourseStartDate(), c.getCourseEndDate())) {
                    t5Temp = sp.getTeacher5Name();
                }
                stSheetViewModelList2.add(new StSheetViewModel(
                        c, t1Temp, t2Temp, t3Temp, t4Temp, t5Temp,
                        sp));
            }

            List<StSheetViewModel> stSheetViewModelList3 = new ArrayList<>();
            for (int d = 0; d < v3.size(); d++) {
                Course c = (Course) v3.elementAt(d);
                StundenPlan sp = stundDao.getCoursePlanForWeek(c.getCourseID(), week);
                String t1Temp = "";
                String t2Temp = "";
                String t3Temp = "";
                String t4Temp = "";
                String t5Temp = "";
                if (stundDao.canCourseComeInPlan(sp.getDate1(), c.getCourseStartDate(), c.getCourseEndDate())) {
                    t1Temp = sp.getTeacher1Name();
                }
                if (stundDao.canCourseComeInPlan(sp.getDate2(), c.getCourseStartDate(), c.getCourseEndDate())) {
                    t2Temp = sp.getTeacher2Name();
                }
                if (stundDao.canCourseComeInPlan(sp.getDate3(), c.getCourseStartDate(), c.getCourseEndDate())) {
                    t3Temp = sp.getTeacher3Name();
                }
                if (stundDao.canCourseComeInPlan(sp.getDate4(), c.getCourseStartDate(), c.getCourseEndDate())) {
                    t4Temp = sp.getTeacher4Name();
                }
                if (stundDao.canCourseComeInPlan(sp.getDate5(), c.getCourseStartDate(), c.getCourseEndDate())) {
                    t5Temp = sp.getTeacher5Name();
                }
                stSheetViewModelList3.add(new StSheetViewModel(
                        c, t1Temp, t2Temp, t3Temp, t4Temp, t5Temp,
                        sp));
            }

            model.addAttribute("stSheetViewModelList1", stSheetViewModelList1);
            model.addAttribute("stSheetViewModelList2", stSheetViewModelList2);
            model.addAttribute("stSheetViewModelList3", stSheetViewModelList3);
        } else {
            return "redirect:/index";
        }

        return "stSheet";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/stundenplan/teacherSelection")
    public String teacherSelection(HttpServletRequest request, Model model) {
        if (this.loginStatement(request)) {
            return "redirect:/";
        }
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if (stundDao.canWorkWithStundenplan(rps.getLoginUser().getUserID())) {
            String da = (String) request.getParameter("d");
            String cid = (String) request.getParameter("cid");
            String mtid = (String) request.getParameter("tid");


            List<SystemUser> refine = new ArrayList<>();
            Vector tea = new Vector();

            String tname = "";
            boolean forSingleElement = false;
            int hours = 0;
            int hours1 = 0;
            int teacherStunden = 0;
            int teacherStunden1 = 0;
            int nochHours = 0;
            String totalHours = "0";
            int completedHours = 0;
            String desc = "";
            String limitDate = "";

            if (cid != null) {
                request.getSession().setAttribute("coid", cid);
                request.getSession().setAttribute("coda", da);
                request.getSession().setAttribute("cotid", mtid);

                tea = systemUserDao.getAllDSHLehrerByPlace(rps.getLoginPlace().getPlaceID(), 4, 3);

                int cidN = Integer.parseInt(cid);
                Course cc = (new CourseDao()).getCourse(cidN);

                StundenPlan sp = stundDao.getCoursePlanForSingleDate(cidN, MyDate.getSQLDateFromDashFormatString(da, MyDate.DEUTSCH));
                tname = sp.getTeacher1Name();
                totalHours = "" + cc.getCourseTotalHours();
                completedHours = stundDao.getTotalStundenTillDate(cidN, MyDate.getSQLDateFromDashFormatString(da, MyDate.DEUTSCH));
                //if(sp.getStunden1()>0){
                hours = sp.getStunden1();
                hours1 = sp.getStunden1();
                //}
                //else{
                //hours =Integer.parseInt(cc.getCourseDailyHrs());
                //hours1 = Integer.parseInt(cc.getCourseDailyHrs());
                //}

                //if(sp.getTeacherStunden1()>0){
                teacherStunden = sp.getTeacherStunden1();
                teacherStunden1 = sp.getTeacherStunden1();
                //}
                //else{
                //teacherStunden =Integer.parseInt(cc.getCourseDailyHrs());
                //teacherStunden1 = Integer.parseInt(cc.getCourseDailyHrs());
                //}
                desc = sp.getDescription1();
                if (desc == null) {
                    desc = "";
                }
                nochHours = Integer.parseInt(totalHours) - completedHours;
                limitDate = MyDate.formateDate(MyDate.getSQLDateFromDashFormatString(da, MyDate.DEUTSCH), MyDate.NUMERIC, MyDate.DEUTSCH);
                if (sp.getStundenStatus1() == 1) {
                    forSingleElement = true;
                }

                /*Syncronizing Teachers*/
                if (cc.getCourseTiming().equalsIgnoreCase("8:30-12:00")) {
                    if (hours == 0) {
                        if (sp.getStundenStatus1() != 1) {
                            hours = Integer.parseInt(cc.getCourseDailyHrs());
                            teacherStunden = Integer.parseInt(cc.getCourseDailyHrs());
                        }
                    }
                    for (int j = 0; j < tea.size(); j++) {
                        SystemUser temp = (SystemUser) tea.elementAt(j);
                        if ((!stundDao.isAlreadyBusy(temp.getUserID(), "8:30-12:00", MyDate.getSQLDateFromDashFormatString(da, MyDate.DEUTSCH))) || (temp.getUserID() == sp.getTeacher1ID())) {
                            refine.add(temp);
                        }
                    }
                } else if (cc.getCourseTiming().equalsIgnoreCase("12:00-18:00")) {
                    if (hours == 0) {
                        if (sp.getStundenStatus1() != 1) {
                            hours = Integer.parseInt(cc.getCourseDailyHrs());
                            teacherStunden = Integer.parseInt(cc.getCourseDailyHrs());
                        }
                    }
                    for (int j = 0; j < tea.size(); j++) {
                        SystemUser temp = (SystemUser) tea.elementAt(j);
                        if ((!stundDao.isAlreadyBusy(temp.getUserID(), "12:00-18:00", MyDate.getSQLDateFromDashFormatString(da, MyDate.DEUTSCH))) || (temp.getUserID() == sp.getTeacher1ID())) {
                            refine.add(temp);
                        }
                    }
                } else if (cc.getCourseTiming().equalsIgnoreCase("18:00-21:00")) {
                    if (hours == 0) {
                        if (sp.getStundenStatus1() != 1) {
                            hours = Integer.parseInt(cc.getCourseDailyHrs());
                            teacherStunden = Integer.parseInt(cc.getCourseDailyHrs());
                        }
                    }
                    for (int j = 0; j < tea.size(); j++) {
                        SystemUser temp = (SystemUser) tea.elementAt(j);
                        if ((!stundDao.isAlreadyBusy(temp.getUserID(), "18:00-21:00", MyDate.getSQLDateFromDashFormatString(da, MyDate.DEUTSCH))) || (temp.getUserID() == sp.getTeacher1ID())) {
                            refine.add(temp);
                        }
                    }
                }
                model.addAttribute("refine", refine);
                model.addAttribute("forSingleElement", forSingleElement);
                model.addAttribute("hours", hours);
                model.addAttribute("teacherStunden", teacherStunden);
                model.addAttribute("desc", desc);
                model.addAttribute("totalHours", totalHours);
                model.addAttribute("limitDate", limitDate);
                model.addAttribute("completedHours", completedHours);
                model.addAttribute("nochHours", nochHours);
                model.addAttribute("tname", tname);
            } else {

            }
        }

        return "teacherSelection";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/stundenplan/teacherSelection")
    public String teacherSelectionProcess(HttpServletRequest request) {
        int hours = 0;
        /*Updating StundenPlan*/
        String tempCo = (String) request.getSession().getAttribute("coid");
        String tempDa = (String) request.getSession().getAttribute("coda");
        String tempTI = (String) request.getSession().getAttribute("cotid");

        Course c = (new CourseDao()).getCourse(Integer.parseInt(tempCo));

        if (c.getCourseTiming().equalsIgnoreCase("8:30-12:00")) {

            String tid = (String) request.getParameter("select");
            String stunden = (String) request.getParameter("txtStd");
            String always = (String) request.getParameter("checkbox");
            String tempTS = (String) request.getParameter("txtTea");
            String tempDESC = (String) request.getParameter("txtDesc");
            int newTeacherStunden = 0;
            int alwaysStatus = 0;
            try {
                int tidT = Integer.parseInt(tid);
                if (always != null) {
                    alwaysStatus = 1;
                    hours = Integer.parseInt(stunden);
                    newTeacherStunden = Integer.parseInt(tempTS);
                    if (tidT == 0) {
                        newTeacherStunden = 0;
                    }
                } else {
                    hours = Integer.parseInt(c.getCourseDailyHrs());
                    ;
                    newTeacherStunden = Integer.parseInt(c.getCourseDailyHrs());
                    ;
                    if (tidT == 0) {
                        hours = 0;
                        newTeacherStunden = 0;
                    }
                }
                stundDao.updateStundenPlan(MyDate.getSQLDateFromDashFormatString(tempDa, MyDate.DEUTSCH), c.getCourseID(), tidT, hours, alwaysStatus, newTeacherStunden, tempDESC);
            } catch (Exception eeee) {
            }
        } else if (c.getCourseTiming().equalsIgnoreCase("12:00-18:00")) {
            String tid = (String) request.getParameter("select");
            String stunden = (String) request.getParameter("txtStd");
            String always = (String) request.getParameter("checkbox");
            String tempTS = (String) request.getParameter("txtTea");
            String tempDESC = (String) request.getParameter("txtDesc");
            int newTeacherStunden = 0;
            int alwaysStatus = 0;
            try {
                int tidT = Integer.parseInt(tid);
                if (always != null) {
                    alwaysStatus = 1;
                    hours = Integer.parseInt(stunden);
                    newTeacherStunden = Integer.parseInt(tempTS);
                    if (tidT == 0) {
                        newTeacherStunden = 0;
                    }
                } else {
                    hours = Integer.parseInt(c.getCourseDailyHrs());
                    ;
                    newTeacherStunden = Integer.parseInt(c.getCourseDailyHrs());
                    if (tidT == 0) {
                        hours = 0;
                        newTeacherStunden = 0;
                    }
                }

                stundDao.updateStundenPlan(MyDate.getSQLDateFromDashFormatString(tempDa, MyDate.DEUTSCH), c.getCourseID(), tidT, hours, alwaysStatus, newTeacherStunden, tempDESC);
            } catch (Exception eeee) {
            }

        } else if (c.getCourseTiming().equalsIgnoreCase("18:00-21:00")) {
            String tid = (String) request.getParameter("select");
            String stunden = (String) request.getParameter("txtStd");
            String always = (String) request.getParameter("checkbox");
            String tempTS = (String) request.getParameter("txtTea");
            String tempDESC = (String) request.getParameter("txtDesc");
            int newTeacherStunden = 0;
            int alwaysStatus = 0;
            try {
                int tidT = Integer.parseInt(tid);
                if (always != null) {
                    alwaysStatus = 1;
                    hours = Integer.parseInt(stunden);
                    newTeacherStunden = Integer.parseInt(tempTS);
                    if (tidT == 0) {
                        newTeacherStunden = 0;
                    }
                } else {
                    hours = Integer.parseInt(c.getCourseDailyHrs());
                    ;
                    newTeacherStunden = 3;
                    if (tidT == 0) {
                        hours = 0;
                        newTeacherStunden = 0;
                    }
                }

                stundDao.updateStundenPlan(MyDate.getSQLDateFromDashFormatString(tempDa, MyDate.DEUTSCH), c.getCourseID(), tidT, hours, alwaysStatus, newTeacherStunden, tempDESC);
            } catch (Exception eeee) {
            }
        }
        return "";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/stundenplan/selectStufe")
    public String selectStufe(HttpServletRequest request) {
        if (this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if (stundDao.canWorkWithStundenDetails(rps.getLoginUser().getUserID())) {
            stundDao.makeSureRecordExist(1);
            stundDao.makeSureRecordExist(2);
            stundDao.makeSureRecordExist(3);
            stundDao.makeSureRecordExist(4);
            stundDao.makeSureRecordExist(5);
        } else {
            return "redirect:/index?err=permission";
        }

        return "selectStufe";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/stundenplan/remarksForm")
    public String remarksForm(HttpServletRequest request, Model model) {
        if (this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if (stundDao.canWorkWithStundenDetails(rps.getLoginUser().getUserID())) {
            String stufeS = (String) request.getParameter("stufe");
            String stufeName = "";
            int stufe = Integer.parseInt(stufeS);
            if (stufe == 1) {
                stufeName = "Grundstufe I";
            } else if (stufe == 2) {
                stufeName = "Grundstufe II";
            } else if (stufe == 3) {
                stufeName = "Mittelstufe I";
            } else if (stufe == 4) {
                stufeName = "Mittelstufe II";
            } else if (stufe == 5) {
                stufeName = "Oberstufe";
            }
            Vector<StundenDetail> tea = stundDao.getStundenDetails(stufe);
            model.addAttribute("tea", tea);
            model.addAttribute("stufe", stufe);
            model.addAttribute("stufeName", stufeName);
        }

        return "remarksForm";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/stundenplan/remarksForm")
    public String remarksFormProcess(HttpServletRequest request) {
        if (this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        int stfN = 0;
        if (stundDao.canWorkWithStundenDetails(rps.getLoginUser().getUserID())) {
            Vector stundenDetails = new Vector();
            String stfS = request.getParameter("stufe");
            stfN = Integer.parseInt(stfS);

            for (int i = 0; i < 250; i++) {
                String descr = request.getParameter((i + 1) + "");
                StundenDetail stundenDetail = new StundenDetail();
                stundenDetail.setStundenValue(i + 1);
                stundenDetail.setStufeValue(stfN);
                stundenDetail.setStundenDetail(descr);
                stundenDetails.addElement(stundenDetail);
            }
            stundDao.updateStundenDetail(stundenDetails);
        }
        return "redirect:/stundenplan/remarksForm?stufe=" + stfN;
    }
}
