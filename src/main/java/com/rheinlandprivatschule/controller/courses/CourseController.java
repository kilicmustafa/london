package com.rheinlandprivatschule.controller.courses;


import com.rheinlandprivatschule.controller.BaseController;
import com.rheinlandprivatschule.helper.MyDate;
import com.rheinlandprivatschule.model.*;
import com.rheinlandprivatschule.model.Module;
import com.rheinlandprivatschule.repository.*;
import com.rheinlandprivatschule.viewmodel.CourseListViewModel;
import com.rheinlandprivatschule.viewmodel.ReturnCourseListModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;

import org.springframework.web.bind.annotation.*;


import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

@Controller
public class CourseController extends BaseController {

    private final CourseDao courseDao;
    private final ModuleDao moduleDao;
    private final PlaceDao placeDao;
    private final TransactionDao transactionDao;
    private final StudentDao studentDao;
    private final WerbungDao werbungDao;
    private final StundDao stundDao;
    private final InsuranceDao insuranceDao;
    private final AnwesenDao anwesenDao;


    @Autowired
    public CourseController(CourseDao courseDao, ModuleDao moduleDao, PlaceDao placeDao, TransactionDao transactionDao, StudentDao studentDao, WerbungDao werbungDao, StundDao stundDao, InsuranceDao insuranceDao, AnwesenDao anwesenDao) {
        this.courseDao = courseDao;
        this.moduleDao = moduleDao;
        this.placeDao = placeDao;
        this.transactionDao = transactionDao;
        this.studentDao = studentDao;
        this.werbungDao = werbungDao;
        this.stundDao = stundDao;
        this.insuranceDao = insuranceDao;
        this.anwesenDao = anwesenDao;
    }

    @RequestMapping(method = RequestMethod.GET, value = "/courses/courseList")
    public String courseList(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }
        int logchk;

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(courseDao.canViewActiveAndFutureCourses(rps.getLoginUser().getUserID())) {
            logchk = rps.getLoginUser().getUserType();
            List<Course> coursesByPlaceActive = courseDao.getAllCoursesByPlaceActive(rps.getLoginPlace().getPlaceID());
            List<Course> coursesByPlaceFuture = courseDao.getAllCoursesByPlaceFuture(rps.getLoginPlace().getPlaceID());

            ReturnCourseListModel coursesByPlaceActiveModel = setUpCourseListViewModel(coursesByPlaceActive, logchk);
            ReturnCourseListModel coursesByPlaceFutureModel = setUpCourseListViewModel(coursesByPlaceFuture, logchk);


            model.addAttribute("coursesByPlaceActiveModel", coursesByPlaceActiveModel);
            model.addAttribute("coursesByFutureActiveModel", coursesByPlaceFutureModel);
            model.addAttribute("logchk", logchk);

            return "courseList";
        } else {
            return "courseList?error=permission";
        }
    }

    @RequestMapping(value = {"/courses/courseListAll", "/courses/courseListAll/{page}"}, method = RequestMethod.GET)
    public String courseListAll(HttpServletRequest request, @PathVariable(value = "page") String pageStr, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        int page = (StringUtils.isEmpty(pageStr)) ? 0 : Integer.parseInt(pageStr);
        model.addAttribute("isPageSent", StringUtils.isEmpty(pageStr));
        if(page > 0) {
            page = page - 1;
        }

        int logchk;

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(courseDao.canViewActiveAndFutureCourses(rps.getLoginUser().getUserID())) {
            logchk = rps.getLoginUser().getUserType();
            List<Course> allCoursesByPlace = courseDao.getAllCoursesByPlace(rps.getLoginPlace().getPlaceID(), 50, page * 50);

            ReturnCourseListModel allCoursesByPlaceModel = setUpCourseListViewModel(allCoursesByPlace, logchk);


            model.addAttribute("page", page);
            model.addAttribute("allCoursesByPlaceModel", allCoursesByPlaceModel);
            model.addAttribute("logchk", logchk);

            return "courseListAll";
        } else {
            return "courseListAll?error=permission";
        }
    }

    @GetMapping("/courses/courseReportDetail")
    public String courseReportDetail(HttpServletRequest request, Model model) {
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(!courseDao.canViewStudentListofCourse(rps.getLoginUser().getUserID())) {
            return "redirect:/index?err=permission";
        }

        model.addAttribute("cdb", courseDao);
        model.addAttribute("sdb", studentDao);
        model.addAttribute("trDB", transactionDao);
        model.addAttribute("werbungDB", werbungDao);
        model.addAttribute("stdb", stundDao);

        return "courseReportDetail";
    }

    @GetMapping("/courses/courseReportDetail2")
    public String courseReportDetail2(HttpServletRequest request, Model model) {
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(!courseDao.canViewStudentListofCourse(rps.getLoginUser().getUserID())) {
            return "redirect:/index?err=permission";
        }

        model.addAttribute("cdb", courseDao);
        model.addAttribute("sdb", studentDao);
        model.addAttribute("trDB", transactionDao);
        model.addAttribute("werbungDB", werbungDao);
        model.addAttribute("stdb", stundDao);

        return "courseReportDetail2";
    }

    @RequestMapping(value = "/courses/moduleView", method = { RequestMethod.GET, RequestMethod.POST })
    public String moduleView(HttpServletRequest request, Model model) {
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(!moduleDao.canUpdateModule(rps.getLoginUser().getUserID())) {
            return "redirect:/index?err=permission";
        }

        model.addAttribute("expdb", moduleDao);

        return "moduleView";
    }

    private ReturnCourseListModel setUpCourseListViewModel(List<Course> courses, int logchk) {
        List<CourseListViewModel> coursesModel = new ArrayList<>();
        int activeFuture = 0, totalAs = 0;
        for(Course course : courses) {
            CourseListViewModel courseListViewModel = new CourseListViewModel();
            courseListViewModel.setCourse(course);
            courseListViewModel.setActiveCount(0);
            if(logchk == 1) {
                courseListViewModel.setAnofano(courseDao.getNochOffen(course));
                activeFuture += courseListViewModel.getAnofano();
            }

            List<Student> studentList = courseDao.getAllStudentsByCourse(course.getCourseID());

            for(Student student : studentList) {
                if(student != null && student.getUserActive() == 1) {
                    courseListViewModel.setActiveCount(courseListViewModel.getActiveCount() + 1);
                }
            }

            if(course.getCourseBamfNr() == null || course.getCourseBamfNr().equals("null")) {
                courseListViewModel.setBamfActive("");
            } else {
                courseListViewModel.setBamfActive(course.getCourseBamfNr());
            }
            totalAs += courseListViewModel.getActiveCount();
            System.out.println(course.getCourseInit());
            courseListViewModel.setInit((course.getCourseInit() == null)
                    ? ""
                    : "-"+course.getCourseInit());

            coursesModel.add(courseListViewModel);
        }
        return new ReturnCourseListModel(coursesModel, activeFuture, totalAs);
    }

    @RequestMapping(method = RequestMethod.GET, value = "/courses/addCourse")
    public String addCourse(HttpServletRequest request) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        return "addCourse";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/courses/addCourseProcess")
    public String addCourseProcess(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");

        if(courseDao.canAddNewCourse(rps.getLoginUser().getUserID())){

            String hf=request.getParameter("hf");
            if(hf == null) {
                String tempVV = request.getParameter("selCo");
                Module mod = moduleDao.getModule(Integer.parseInt(tempVV));
                Vector<Place> v;
                if (Integer.parseInt(tempVV) > 0) {
                    v = placeDao.getAllPlaces();
                    request.getSession().setAttribute("definecourse", tempVV);
                    request.getSession().setAttribute("coursedes", (String) request.getParameter("txtDes"));
                    request.getSession().setAttribute("sDay", (String) request.getParameter("selSDay"));
                    request.getSession().setAttribute("sMonth", (String) request.getParameter("selSMonth"));
                    request.getSession().setAttribute("sYear", (String) request.getParameter("selSYear"));
                    request.getSession().setAttribute("eDay", (String) request.getParameter("selEDay"));
                    request.getSession().setAttribute("eMonth", (String) request.getParameter("selEMonth"));
                    request.getSession().setAttribute("eYear", (String) request.getParameter("selEYear"));
                    request.getSession().setAttribute("timing", (String) request.getParameter("txtTim"));
                    request.getSession().setAttribute("fee", (String) request.getParameter("txtFee"));
                    request.getSession().setAttribute("strengthS", (String) request.getParameter("strength"));
                    request.getSession().setAttribute("hours", (String) request.getParameter("hours"));
                    request.getSession().setAttribute("totalhours", (String) request.getParameter("totalhour"));
                    request.getSession().setAttribute("bamfnrs", (String) request.getParameter("bamfnr"));
                    request.getSession().setAttribute("dailyhours", (String) request.getParameter("dailyhour"));
                    request.getSession().setAttribute("courseinits", (String) request.getParameter("courseinit"));
                } else {
                    request.getSession().setAttribute("error", "Wählen Sie Kurs-Typ zuerst aus.");
                    return "redirect:/error";
                }
                model.addAttribute("vector", v);
                return "addCourseProcess";
            } else {
                Vector normal = new Vector();
                Vector elite = new Vector();

                String chk1[]=request.getParameterValues("chk");
                if(chk1!=null){
                    for(int ii=0;ii<chk1.length;ii++){
                        try{
                            normal.addElement((String)chk1[ii]);
                        }catch(Exception ee){
                        }
                    }
                }
                String chk2[]=request.getParameterValues("chk2");
                if(chk2!=null){
                    for(int iii=0;iii<chk2.length;iii++){
                        try{
                            elite.addElement((String)chk2[iii]);
                        }catch(Exception eee){
                        }
                    }
                }

                ///Normal Course Registration

                String coursename="Oberstufe";
                String definecourse=(String)request.getSession().getAttribute("definecourse");
                String coursedes=(String)request.getSession().getAttribute("coursedes");
                String sDay=(String)request.getSession().getAttribute("sDay");
                String sMonth=(String)request.getSession().getAttribute("sMonth");
                String sYear=(String)request.getSession().getAttribute("sYear");
                String eDay=(String)request.getSession().getAttribute("eDay");
                String eMonth=(String)request.getSession().getAttribute("eMonth");
                String eYear=(String)request.getSession().getAttribute("eYear");
                String timing=(String)request.getSession().getAttribute("timing");
                String fee=(String)request.getSession().getAttribute("fee");
                String strengthS=(String)request.getSession().getAttribute("strengthS");
                String hours=(String)request.getSession().getAttribute("hours");
                String totalhours=(String)request.getSession().getAttribute("totalhours");
                String bamfnrs=(String)request.getSession().getAttribute("bamfnrs");
                String dailyhours=(String)request.getSession().getAttribute("dailyhours");
                String courseinits=(String)request.getSession().getAttribute("courseinits");


                int coursetype=0;
                int dv=Integer.parseInt(definecourse);
                Module mod = moduleDao.getModule(dv);
                String seco="";
                coursetype=dv;
                coursename=mod.getModuleName()+" "+sMonth+" "+sYear;
                seco=mod.getModuleName()+" "+"Elite"+" "+sMonth+" "+sYear;


                int strength=Integer.parseInt(strengthS);
                if(timing.equalsIgnoreCase("Vormittag")){
                    timing="8:30-12:00";
                }else if(timing.equalsIgnoreCase("Nachmittag")){
                    timing="12:00-18:00";
                }else if(timing.equalsIgnoreCase("Abendkurs")){
                    timing="18:00-21:00";
                }

                try{

                    int ok=0;
                    java.sql.Date d1=MyDate.getSQLDateFromStrings(sDay,sMonth,sYear,MyDate.DEUTSCH);
                    java.sql.Date d2=MyDate.getSQLDateFromStrings(eDay,eMonth,eYear,MyDate.DEUTSCH);
                    Course c=new Course(0,coursename,coursedes,d1,d2,Double.parseDouble(fee),rps.getLoginPlace().getPlaceID(),timing);
                    c.setCourseStrength(strength);
                    c.setCourseHours(hours);
                    c.setCourseTotalHours(totalhours);
                    c.setCourseType(coursetype);
                    c.setCourseBamfNr(bamfnrs);
                    c.setCourseDailyHrs(dailyhours);
                    c.setCourseInit(courseinits);

                    for(int no=0;no<normal.size();no++){
                        String hg=(String)normal.elementAt(no);
                        c.setCoursePlace(Integer.parseInt(hg));
                        courseDao.addNewCourse(c);
                    }
                    for(int e=0;e<elite.size();e++){
                        String hg=(String)elite.elementAt(e);
                        c.setCoursePlace(Integer.parseInt(hg));
                        c.setCourseName(seco);
                        courseDao.addNewCourse(c);
                    }
                }catch(Exception ignored)
                {}
            }
        }

        return "redirect:/courses/courseList?courseAdded=true";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/courses/moduleList")
    public String moduleList(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(moduleDao.canSeeModuleList(rps.getLoginUser().getUserID())) {
            model.addAttribute("moduleList", moduleDao.getAllModules());
        }

        return "moduleList";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/courses/newModule")
    public String newModule(HttpServletRequest request) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        return "newModule";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/courses/newModuleProcess")
    public String newModuleProcess(HttpServletRequest request) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(moduleDao.canAddNewModule(rps.getLoginUser().getUserID())) {
            String catnameP= request.getParameter("txtName");
            if(catnameP!=null) {
                Module c = new Module();
                c.setModuleName(catnameP);
                if (moduleDao.addModule(c)) {
                    return "redirect:/courses/moduleList";
                } else {
                    return "redirect:/courses/newModule?operation=failed";
                }
            }
        }

        return "redirect:/courses/moduleList";
    }


    @RequestMapping(value = "/courses/integration", method = { RequestMethod.GET, RequestMethod.POST })
    public String integration(Model model, @SessionAttribute("handler") RPS rps) {
        if(!courseDao.canViewCourseAttendanceList(rps.getLoginUser().getUserID())) {
            return "redirect:/index?err=permission";
        }

        model.addAttribute("adb", anwesenDao);
        model.addAttribute("cdb", courseDao);
        model.addAttribute("insuranceDB", insuranceDao);
        model.addAttribute("rps", rps);

        return "integration";
    }

    @GetMapping("/courses/anwesen")
    public String anwesen(Model model, @SessionAttribute("handler") RPS rps) {
        if(!courseDao.canViewCourseAttendanceList(rps.getLoginUser().getUserID())) {
            return "redirect:/index?err=permission";
        }

        model.addAttribute("adb", anwesenDao);
        model.addAttribute("cdb", courseDao);
        model.addAttribute("insuranceDB", insuranceDao);
        return "anwesen";
    }

    @GetMapping("/courses/anwesenD")
    public String anwesenD(Model model, @SessionAttribute("handler") RPS rps) {
        if(!courseDao.canPrintCourseAttendanceList(rps.getLoginUser().getUserID())) {
            return "redirect:/index?err=permission";
        }

        model.addAttribute("cdb", courseDao);
        model.addAttribute("insuranceDB", insuranceDao);
        return "anwesenD";
    }

    @RequestMapping(value = "/courses/anwesenSelection", method = { RequestMethod.GET, RequestMethod.POST })
    public String anwesenSelection(Model model, @SessionAttribute("handler") RPS rps) {
        if(!courseDao.canUpdateCourseAttendanceList(rps.getLoginUser().getUserID())) {
            return "redirect:/index?err=permission";
        }
        model.addAttribute("adb", anwesenDao);
        model.addAttribute("cdb", courseDao);
        return "anwesenSelection";
    }

    @RequestMapping(value = "/courses/anwesensave", method = { RequestMethod.GET, RequestMethod.POST })
    public String anwesensave(Model model, @SessionAttribute("handler") RPS rps) {
        if(!courseDao.canSaveStudentList(rps.getLoginUser().getUserID())) {
            return "redirect:/index?err=permission";
        }
        model.addAttribute("adb", anwesenDao);
        model.addAttribute("cdb", courseDao);
        return "anwesensave";
    }

    @RequestMapping(value = "/courses/stlohnDetail", method = { RequestMethod.GET, RequestMethod.POST })
    public String stLohnDetail(Model model) {
        model.addAttribute("courseDao", courseDao);
        model.addAttribute("stundDao", stundDao);
        return "stLohnDetailCourses";
    }

    @RequestMapping(value = "/courses/printRegistrationFormula1", method = { RequestMethod.GET, RequestMethod.POST })
    public String printRegistrationFormula1(Model model) {
        model.addAttribute("studentDao", studentDao);
        return "printRegistrationFormula1";
    }

    @RequestMapping(value = "/courses/printIntAuszahlung", method = { RequestMethod.GET, RequestMethod.POST })
    public String printIntAuszahlung(Model model) {
        model.addAttribute("adb", anwesenDao);
        model.addAttribute("courseDao", courseDao);
        return "printIntAuszahlung";
    }

    @RequestMapping(value = "/courses/registerPrintFormula1", method = { RequestMethod.GET, RequestMethod.POST })
    public String registerPrintFormula1() {
        return "registerPrintFormula1";
    }

    @RequestMapping(value = "/courses/printFirstRegistration", method = { RequestMethod.GET, RequestMethod.POST })
    public String registerPrintFormula1(Model model) {
        model.addAttribute("adb", anwesenDao);
        model.addAttribute("courseDao", courseDao);
        model.addAttribute("transactionDao", transactionDao);
        return "printFirstRegistration";
    }

    @RequestMapping(value = "/courses/onlyRemark", method = { RequestMethod.GET, RequestMethod.POST })
    public String onlyRemark(Model model) {
        model.addAttribute("studentDao", studentDao);
        return "onlyRemarkCourses";
    }

    @RequestMapping(value = "/courses/updateCourseForm", method = { RequestMethod.GET, RequestMethod.POST })
    public String updateCourseForm(@SessionAttribute("handler") RPS rps, Model model) {
        if(!courseDao.canUpdateAndViewCourseDetail(rps.getLoginUser().getUserID())) return "redirect:/index?err=permission";
        model.addAttribute("courseDao", courseDao);

        return "updateCourseForm";
    }

    @RequestMapping(value = "/courses/updateCourse", method = { RequestMethod.GET, RequestMethod.POST })
    public String updateCourse(@SessionAttribute("handler") RPS rps, Model model) {
        if(!courseDao.canUpdateAndViewCourseDetail(rps.getLoginUser().getUserID())) return "redirect:/index?err=permission";
        model.addAttribute("courseDao", courseDao);

        return "updateCourse";
    }
}
