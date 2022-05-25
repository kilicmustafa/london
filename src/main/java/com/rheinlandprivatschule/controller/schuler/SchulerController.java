package com.rheinlandprivatschule.controller.schuler;

import com.rheinlandprivatschule.controller.BaseController;
import com.rheinlandprivatschule.helper.MyDate;
import com.rheinlandprivatschule.model.*;
import com.rheinlandprivatschule.repository.*;
import com.rheinlandprivatschule.viewmodel.FromAgenturenViewModel;
import com.rheinlandprivatschule.viewmodel.NotOnlinePaidViewModel;
import com.rheinlandprivatschule.viewmodel.NotRegisterViewModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;

import org.springframework.web.bind.annotation.*;


import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Controller
public class SchulerController extends BaseController {

    private final StudentDao studentDao;
    private final AgentDao agentDao;
    private final IdentityDao identityDao;
    private final CourseDao courseDao;

    @Autowired
    public SchulerController(StudentDao studentDao, AgentDao agentDao, IdentityDao identityDao, CourseDao courseDao) {
        this.studentDao = studentDao;
        this.agentDao = agentDao;
        this.identityDao = identityDao;
        this.courseDao = courseDao;
    }

    @RequestMapping(value = {"/schuler/notregister", "/schuler/notregister/{page}"}, method = RequestMethod.GET)
    public String getNotRegister(HttpServletRequest request, @PathVariable(value = "page") String pageStr, Model model) {
        if(loginStatement(request)) {
            return "redirect:/";
        }

        int page = (StringUtils.isEmpty(pageStr)) ? 0 : Integer.parseInt(pageStr);
        model.addAttribute("isPageSent", StringUtils.isEmpty(pageStr));
        if(page > 0) {
            page = page - 1;
        }

        int userID = (int) request.getSession().getAttribute("loginUser");
        model.addAttribute("page", page);

        String list1 = "0";
        String list2 = "0";
        String list3 = "0";

        if (request.getSession().getAttribute("isListsSet") == null || !((boolean) request.getSession().getAttribute("isListsSet"))) {
            String[] lists = studentDao.getLists();
            request.getSession().setAttribute("list1", lists[0]);
            request.getSession().setAttribute("list2", lists[1]);
            request.getSession().setAttribute("list3", lists[2]);
            list1 = lists[0];
            list2 = lists[1];
            list3 = lists[2];
            request.getSession().setAttribute("isListsSet", true);
        } else {
            list1 = (String) request.getSession().getAttribute("list1");
            list2 = (String) request.getSession().getAttribute("list1");
            list3 = (String) request.getSession().getAttribute("list1");
        }

        ArrayList<Student> students = studentDao.getAllStudentsNotRegisterBetweenIndices(userID, 50, page*50, list1, list2, list3);
        ArrayList<NotRegisterViewModel> notRegisterViewModels = new ArrayList<>();

        for(Student s : students) {
            NotRegisterViewModel notRegisterViewModel = new NotRegisterViewModel();
            notRegisterViewModel.setStudent(s);
            notRegisterViewModel.setRegDate(MyDate.formateDate(s.getUserRegDate(), MyDate.NUMERIC, MyDate.DEUTSCH));
            notRegisterViewModels.add(notRegisterViewModel);
        }
        model.addAttribute("notregisterUsers", notRegisterViewModels);
        return "notregister";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/schuler/fromagenturen")
    public  String getFromAgenturen(HttpServletRequest request, Model model) {
        if(loginStatement(request)) {
            return "redirect:/";
        }

        ArrayList<AgentStudent> vec;
        int userID = (int) request.getSession().getAttribute("loginUser");
        //model.addAttribute("onlinenotpaid", studentDao.getAllOnlineNotPaid(userID));
        //model.addAttribute("onlinenotregister", studentDao.getOnlineStudentWithoutReg(userID));
        if(studentDao.canSeeAgentStudents(userID)){
            vec=agentDao.getAllAgentStudents();
            ArrayList<FromAgenturenViewModel> fromAgenturenViewModels = new ArrayList<>();
            for(int i = 0; i < vec.size(); i++) {
                AgentStudent agentStudent = vec.get(i);
                FromAgenturenViewModel fromAgenturenViewModel = new FromAgenturenViewModel();
                fromAgenturenViewModel.setAgentStudent(agentStudent);
                fromAgenturenViewModel.setCity(agentDao.getStudentPreferredCity(agentStudent.getStudentID()));
                String uni="Nein";
                if(agentStudent.isUniversity()==1){
                    uni="Ja";
                }
                String wohnung="Nein";
                if(agentStudent.isResidence()==1){
                    wohnung="Ja";
                }
                String arrivaldate="";
                if(agentStudent.getTravel()!=null){
                    arrivaldate=MyDate.formateDate(agentStudent.getTravel(),MyDate.NUMERIC,MyDate.DEUTSCH);
                }
                String agentDetail="";
                if(agentStudent.getStudentDetail()!=null){
                    agentDetail=agentStudent.getStudentDetail();
                }

                fromAgenturenViewModel.setRegistrationDate(MyDate.formateDate(agentStudent.getRegistrationDate(), MyDate.NUMERIC, MyDate.DEUTSCH));
                fromAgenturenViewModel.setUni(uni);
                fromAgenturenViewModel.setWohnung(wohnung);
                fromAgenturenViewModel.setArrivalDate(arrivaldate);
                fromAgenturenViewModel.setAgentDetail(agentDetail);
                fromAgenturenViewModels.add(fromAgenturenViewModel);
            }
            model.addAttribute("fromAgenturenViewModels", fromAgenturenViewModels);
        }

        return "fromagenturen";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/schuler/showStudentDetail")
    public String showStudentDetail(HttpServletRequest request, Model model) {
        if(loginStatement(request)) {
            return "redirect:/";
        }
        if(request.getParameter("userid") == null || request.getParameter("userid").equals("")) {
            return "redirect:/index";
        }
        Student student = studentDao.getStudentInformation(Integer.parseInt(request.getParameter("userid")),
                (Integer) request.getSession().getAttribute("loginUser"));
        ArrayList<Country> countries = studentDao.getAllCountries();
        ArrayList<Identity> identities = studentDao.getAllIdentities();
        model.addAttribute("student", student);

        model.addAttribute("birthDay", Integer.parseInt(MyDate.getDay(student.getUserBirthDate())));
        model.addAttribute("birthMont", MyDate.getMonth(student.getUserBirthDate()));
        model.addAttribute("birthYear", Integer.parseInt(MyDate.getYear(student.getUserBirthDate())));
        model.addAttribute("gradingDay", Integer.parseInt(MyDate.getDay(student.getUserGradingDate())));
        model.addAttribute("gradingMont", MyDate.getMonth(student.getUserGradingDate()));
        model.addAttribute("gradingYear", Integer.parseInt(MyDate.getYear(student.getUserGradingDate())));
        model.addAttribute("concDay", Integer.parseInt(MyDate.getDay(student.getUserConclusion())));
        model.addAttribute("concMont", MyDate.getMonth(student.getUserConclusion()));
        model.addAttribute("concYear", Integer.parseInt(MyDate.getYear(student.getUserConclusion())));
        model.addAttribute("concCourseDay", Integer.parseInt(MyDate.getDay(student.getUserConcCourse())));
        model.addAttribute("concCourseMont", MyDate.getMonth(student.getUserConcCourse()));
        model.addAttribute("concCourseYear", Integer.parseInt(MyDate.getYear(student.getUserConcCourse())));
        model.addAttribute("countries", countries);
        model.addAttribute("identities", identities);
        return "showStudentDetail";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/schuler/updateStudent")
    public String updateStudent(HttpServletRequest request, Model model) {
        if(loginStatement(request)) {
            return "redirect:/";
        }
        Student student = new Student();
        student.setUserID(Integer.parseInt(request.getParameter("hiddenField")));
        student.setUserFirstName(request.getParameter("txtFirstName"));
        student.setUserLastName(request.getParameter("txtLastName"));
        student.setUserBirthDate(MyDate.getSQLDateFromStrings(request.getParameter("selDay"), request.getParameter("selMonth"),request.getParameter("selYear"),MyDate.DEUTSCH));
        student.setUserGender(Integer.parseInt(request.getParameter("rdGender")));
        student.setUserBirthPlace(request.getParameter("txtBirthPlace"));
        student.setUserNationality(request.getParameter("txtNationality"));
        student.setUserCO(request.getParameter("txtCO"));
        student.setUserAddress(request.getParameter("txtAddress"));
        student.setUserPostCode(request.getParameter("txtPostCode"));
        student.setUserCity(request.getParameter("txtCity"));
        student.setUserCountry(request.getParameter("txtCountry"));
        student.setUserMobilePhone(request.getParameter("txtMobileNo"));
        student.setUserEmail(request.getParameter("txtEmail"));
        student.setUserCountryID(Integer.parseInt(request.getParameter("selCate")));
        student.setUserHomeCode(request.getParameter("txtHomeCode"));
        student.setUserHomeRegion(request.getParameter("txtHomeRegion"));
        student.setUserMobileCode(request.getParameter("txtMobileCode"));
        student.setUserMobileRegion(request.getParameter("txtMobileRegion"));
        student.setUserBamfNumber(request.getParameter("txtBamfNumber"));
        student.setUserBamfChoice(Integer.parseInt(request.getParameter("rdChoice")));
        student.setUserSchoolingYears(Integer.parseInt(request.getParameter("txtSchoolingYears")));
        student.setUserIntTest(Integer.parseInt(request.getParameter("txtIntTest")));
        student.setUserIntTestCheck(Integer.parseInt(request.getParameter("rdInttestcheck")));
        student.setUserProficency(Integer.parseInt(request.getParameter("rdProficency")));
        student.setUserSponsorShip(Integer.parseInt(request.getParameter("rdSponsorship")));
        student.setUserIdentityID(Integer.parseInt(request.getParameter("selIden")));
        student.setUserCostSharing(Integer.parseInt(request.getParameter("rdCost")));
        student.setUserClassification(Integer.parseInt(request.getParameter("rdclass")));
        student.setUserConclusion(MyDate.getSQLDateFromStrings(request.getParameter("selConclusionDay"), request.getParameter("selConclusionMonth"),request.getParameter("selConclusionYear"),MyDate.DEUTSCH));
        student.setUserConcCourse(MyDate.getSQLDateFromStrings(request.getParameter("selConCourseDay"), request.getParameter("selConCourseMonth"),request.getParameter("selConCourseYear"),MyDate.DEUTSCH));
        student.setUserVerifiedNumber(request.getParameter("txtVerified"));
        student.setUserGradingDate(MyDate.getSQLDateFromStrings(request.getParameter("selGraDay"),request.getParameter("selGraMonth"),request.getParameter("selGraYear"),MyDate.DEUTSCH));
        student.setUserModuleNr(Integer.parseInt(request.getParameter("selModule")));
        student.setUserPassport(request.getParameter("txtPassport"));
        student.setUserFahrtKosten(Double.parseDouble(request.getParameter("txtFahrt")));
        if(studentDao.updateStudent(student,(int) request.getSession().getAttribute("loginUser"))){
            return "redirect:/showStudentPreciseD?userid="+student.getUserID();
        }
        return "redirect:notregister";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/schuler/newStudent")
    public String newStudent(HttpServletRequest request) {

        return "newStudent";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/schuler/registerStudent")
    public String registerStudent(HttpServletRequest request) {
        if(loginStatement(request)) {
            return "redirect:/";
        }
        String firstname= request.getParameter("txtFirstName");
        String lastname= request.getParameter("txtLastName");
        String birthday= request.getParameter("selDay");
        String birthmonth= request.getParameter("selMonth");
        String birthyear= request.getParameter("selYear");
        String usergender= request.getParameter("rdGender");
        String birthplace= request.getParameter("txtBirthPlace");
        String nationality= request.getParameter("txtNationality");
        String co= request.getParameter("txtCO");
        String address= request.getParameter("txtAddress");
        String postcode= request.getParameter("txtPostCode");
        String city= request.getParameter("txtCity");
        String country= request.getParameter("txtCountry");
        String homeno= request.getParameter("txtHomeNo");
        String mobileno= request.getParameter("txtMobileNo");
        String email= request.getParameter("txtEmail");
        String loginname="";
        String password="";
        String nationality1= request.getParameter("selCate");
        String homecode= request.getParameter("txtHomeCode");
        String homeregion= request.getParameter("txtHomeRegion");
        String mobilecode= request.getParameter("txtMobileCode");
        String mobileregion= request.getParameter("txtMobileRegion");
        String bamfnumber= request.getParameter("txtBamfNumber");
        String bamfchoice= request.getParameter("rdChoice");
        String schoolingyears= request.getParameter("txtSchoolingYears");
        String inttest= request.getParameter("txtIntTest");
        String inttestcheck= request.getParameter("rdInttestcheck");
        String proficency= request.getParameter("rdProficency");
        String sponsorship= request.getParameter("rdSponsorship");
        String identity= request.getParameter("selIden");
        String costsharing= request.getParameter("rdCost");
        String classification= request.getParameter("rdclass");
        String conclusionday= request.getParameter("selConclusionDay");
        String conclusionmonth= request.getParameter("selConclusionMonth");
        String conclusionyear= request.getParameter("selConclusionYear");
        String concourseday= request.getParameter("selConCourseDay");
        String concoursemonth= request.getParameter("selConCourseMonth");
        String concourseyear= request.getParameter("selConCourseYear");
        String verified= request.getParameter("txtVerified");
        String gradeDay= request.getParameter("selGraDay");
        String gradeMonth= request.getParameter("selGraMonth");
        String gradeYear= request.getParameter("selGraYear");
        String module= request.getParameter("selModule");
        String passport= request.getParameter("txtPassport");
        String fahrt= request.getParameter("txtFahrt");

        java.sql.Date dd=MyDate.getSQLDateFromStrings(birthday,birthmonth,birthyear,MyDate.DEUTSCH);
        java.sql.Date grade=MyDate.getSQLDateFromStrings(gradeDay,gradeMonth,gradeYear,MyDate.DEUTSCH);
        loginname=lastname;
        password=""+dd;
        java.sql.Date registerdate=MyDate.getCurrentSQLDate();

        Student student = new Student();
        student.setUserFirstName(firstname);
        student.setUserLastName(lastname);
        student.setUserBirthDate(dd);
        student.setUserGender(Integer.parseInt(usergender));
        student.setUserBirthPlace(birthplace);
        student.setUserNationality(nationality);
        student.setUserCO(co);
        student.setUserAddress(address);
        student.setUserPostCode(postcode);
        student.setUserCity(city);
        student.setUserCountry(country);
        student.setUserHomePhone(homeno);
        student.setUserMobilePhone(mobileno);
        student.setUserEmail(email);
        student.setUserLoginName(loginname);
        student.setUserPassword(password);
        student.setUserRemarks("");
        student.setUserCountryID(Integer.parseInt(nationality1));
        student.setUserHomeCode(homecode);
        student.setUserHomeRegion(homeregion);
        student.setUserMobileCode(mobilecode);
        student.setUserMobileRegion(mobileregion);
        student.setUserBamfNumber(bamfnumber);
        student.setUserBamfChoice(Integer.parseInt(bamfchoice));
        student.setUserSchoolingYears(Integer.parseInt(schoolingyears));
        student.setUserIntTest(Integer.parseInt(inttest));
        student.setUserIntTestCheck(Integer.parseInt(inttestcheck));
        student.setUserProficency(Integer.parseInt(proficency));
        student.setUserSponsorShip(Integer.parseInt(sponsorship));
        student.setUserIdentityID(Integer.parseInt(identity));
        student.setUserCostSharing(Integer.parseInt(costsharing));
        student.setUserClassification(Integer.parseInt(classification));
        student.setUserConclusion(MyDate.getSQLDateFromStrings(conclusionday, conclusionmonth,conclusionyear,MyDate.DEUTSCH));
        student.setUserConcCourse(MyDate.getSQLDateFromStrings(concourseday, concoursemonth,concourseyear,MyDate.DEUTSCH));
        student.setUserRegDate(registerdate);
        student.setUserVerifiedNumber(verified);
        student.setUserGradingDate(grade);
        student.setUserModuleNr(Integer.parseInt(module));
        student.setUserPassport(passport);
        student.setUserFahrtKosten(Double.parseDouble(fahrt));

        int userId = studentDao.addNewStudent(student, (Integer) request.getSession().getAttribute("loginUser"));
        if(userId <= 0) {
            // TODO: give an error message
            // TODO: return an error page via redirection
        }

        return "redirect:/schuler/insuranceList?sid="+userId;
    }

    @RequestMapping(method = RequestMethod.GET, value = "/schuler/insuranceList")
    public String getInsuranceList(HttpServletRequest request, Model model) {
        if(loginStatement(request)) {
            return "redirect:/";
        }
        InsuranceDao insuranceDao = new InsuranceDao();
        ArrayList<Insurance> insuranceList = null;
        String sid="0";
        if(request.getParameter("cmd") == null) {
            sid= request.getParameter("sid");
            insuranceList = insuranceDao.getAllInsurances();
            if(insuranceList==null){
                insuranceList=new ArrayList();
                String err=studentDao.getError();
                request.setAttribute("err",err);
                request.getSession().setAttribute("lin","../map.jsp");
            }
            request.getSession().setAttribute("studentid",sid);
        } else{
            String studentIDS=(String)request.getSession().getAttribute("studentid");
            request.getSession().setAttribute("studentid",studentIDS);
            int studentID=Integer.parseInt(studentIDS);
            String insu =request.getParameter("insurance");
            if(insu!=null){
                int tempInsuranceID=Integer.parseInt(insu);
                String desc =request.getParameter("desc");
                boolean isok=insuranceDao.addInsuranceRelatedToStudent(studentID,tempInsuranceID,desc);
                if(!isok){
                    String err=studentDao.getError();
                    request.getSession().setAttribute("err",err);
                    request.getSession().setAttribute("lin","../map.jsp");
                    return "redirect:error";
                }else{
                    return "redirect:werbungList.jsp?sid="+studentID;
                }
            }
        }

        model.addAttribute("insuranceList", insuranceList);
        return "insuranceList";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/schuler/notOnlinePaid")
    public String notOnlinePaid(HttpServletRequest request, Model model) {
        if(loginStatement(request)) {
            return "redirect:/";
        }
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        ArrayList<Student> onlinenotpaid;
        ArrayList<Student> onlinenotregister;
        onlinenotpaid=studentDao.getAllOnlineNotPaid(rps.getLoginUser().getUserID());
        onlinenotregister=studentDao.getOnlineStudentWithoutReg(rps.getLoginUser().getUserID());

        List<NotOnlinePaidViewModel> notOnlinePaidViewModelList = new ArrayList<>();
        List<NotOnlinePaidViewModel> onlineNotRegisterViewModelList = new ArrayList<>();

        for(Student student : onlinenotpaid) {
            notOnlinePaidViewModelList.add(createNotOnlinePaidViewModel(student,
                    MyDate.formateDate(student.getUserBirthDate(),MyDate.NUMERIC,MyDate.DEUTSCH),
                    MyDate.formateDate(student.getUserRegDate(),MyDate.NUMERIC,MyDate.DEUTSCH)));
        }

        for(Student student : onlinenotregister) {
            onlineNotRegisterViewModelList.add(createNotOnlinePaidViewModel(student,
                    MyDate.formateDate(student.getUserBirthDate(),MyDate.NUMERIC,MyDate.DEUTSCH),
                    MyDate.formateDate(student.getUserRegDate(),MyDate.NUMERIC,MyDate.DEUTSCH)));
        }

        //model.addAttribute("onlinenotpaid", onlinenotpaid);
        //model.addAttribute("onlinenotregister", onlinenotregister);
        model.addAttribute("onlinenotpaid", notOnlinePaidViewModelList);
        model.addAttribute("onlinenotregister", onlineNotRegisterViewModelList);

        return "notonlinepaid";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/schuler/showStudentNotPaid")
    public String showStudentNotPaid(@SessionAttribute("handler") RPS rps, Model model) {
        if(!studentDao.canSeeOnlineStudentsInformation(rps.getLoginUser().getUserID())) return "redirect:/index?err=permission";
        model.addAttribute("courseDao", courseDao);
        model.addAttribute("studentDao", studentDao);
        return "showStudentNotPaid";
    }

    @RequestMapping(method = RequestMethod.GET, value = "teilnehmerList")
    public String teilnehmerList(HttpServletRequest request, Model model) {
        if(loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(identityDao.canSeeIdentityList(rps.getLoginUser().getUserID())) {
            model.addAttribute("cry", identityDao.getAllIdentities());
        } else {
            return "teilnehmerList?error=permissiondenied";
        }
        return "teilnehmerList";
    }

    @RequestMapping(method = RequestMethod.GET, value = "teilnehmerView")
    public String teilnehmerView(HttpServletRequest request, Model model) {
        if(loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(identityDao.canUpdateIdentity(rps.getLoginUser().getUserID())) {
            String catid=(String)request.getParameter("id");
            if(catid == null) {
                return "teilnehmerView?error=missingParameters";
            }
            Identity c = identityDao.getIdentity(Integer.parseInt(request.getParameter("id")));
            model.addAttribute("c", c);
        } else {
            return "teilnehmerView?error=permissiondenied";
        }
        return "teilnehmerView";
    }

    @RequestMapping(method = RequestMethod.POST, value = "teilnehmerView")
    public String teilnehmerViewProcess(HttpServletRequest request, Model model) {
        if(loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(identityDao.canUpdateIdentity(rps.getLoginUser().getUserID())) {
            Identity c = new Identity();
            String catidP= request.getParameter("hidID");
            String catnameP= request.getParameter("txtName");
            c.setUserIdentityID(Integer.parseInt(catidP));
            c.setUserIdentityName(catnameP);

            identityDao.updateIdentity(c);
            model.addAttribute("c", c);
        } else {
            return "teilnehmerView?error=permissiondenied";
        }
        return "teilnehmerView";
    }

    private NotOnlinePaidViewModel createNotOnlinePaidViewModel(Student student, String birthDate, String regDate) {
        return new NotOnlinePaidViewModel(student,
                MyDate.formateDate(student.getUserBirthDate(),MyDate.NUMERIC,MyDate.DEUTSCH),
                MyDate.formateDate(student.getUserRegDate(),MyDate.NUMERIC,MyDate.DEUTSCH));
    }

    @GetMapping("/schuler/updateFreigabe")
    public String updateFreigabe(@SessionAttribute("handler") RPS rps, Model model) {
        if(!studentDao.canSeeFreigabe(rps.getLoginUser().getUserID())) {
            return "redirect:/index?err=permission";
        }
        model.addAttribute("studentDB", studentDao);
        return "updateFreigabe";
    }

    @PostMapping("/schuler/updateFreigabeProcess")
    public String updateFreigabeProcess(@SessionAttribute("handler") RPS rps, Model model) {
        if(!studentDao.canSeeFreigabe(rps.getLoginUser().getUserID())) {
            return "redirect:/index?err=permission";
        }
        model.addAttribute("studentDB", studentDao);
        model.addAttribute("courseDB", courseDao);
        return "updateFreigabeProcess";
    }

    @GetMapping("/schuler/bookrech")
    public String bookrech(Model model) {
        model.addAttribute("studentDB", studentDao);
        return "bookrech";
    }

    @GetMapping("/schuler/printBuchMull")
    public String printBuchMull() {
        return "schulerPrintBuchMull";
    }
}
