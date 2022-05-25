package com.rheinlandprivatschule.controller.schuler;

import com.rheinlandprivatschule.controller.BaseController;
import com.rheinlandprivatschule.helper.MyCurrency;
import com.rheinlandprivatschule.helper.MyDate;
import com.rheinlandprivatschule.model.*;
import com.rheinlandprivatschule.repository.*;
import com.rheinlandprivatschule.viewmodel.ShowTransactionsViewModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttribute;


import javax.servlet.http.HttpServletRequest;
import java.sql.Array;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Vector;

@Controller
public class PreciseController extends BaseController {

    private final StudentDao studentDao;
    private final CourseDao courseDao;
    private final TransactionDao transactionDao;

    @Autowired
    public PreciseController(StudentDao studentDao, CourseDao courseDao, TransactionDao transactionDao) {
        this.studentDao = studentDao;
        this.courseDao = courseDao;
        this.transactionDao = transactionDao;
    }

    @RequestMapping(value = {"/showStudentPreciseD", "/schuler/showStudentPreciseD"}, method = RequestMethod.GET)
    public String showStudentPreciseD(HttpServletRequest request, Model model) {
        if(loginStatement(request)) {
            return "redirect:/";
        }
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        Place myPlace = rps.getLoginPlace();
        SystemUser systemUser = rps.getLoginUser();
        int userId= Integer.parseInt(request.getParameter("userid"));
        Student student = studentDao.getStudent(userId, rps.getLoginUser().getUserID());
        String birthdate = MyDate.formateDate(student.getUserBirthDate(),MyDate.NUMERIC,MyDate.DEUTSCH);
        ArrayList registrations = studentDao.getRegistrationByStudentID(student.getUserID(), rps.getLoginUser().getUserID());
        request.getSession().setAttribute("regvec",registrations);
        String anwesenheit = (student.getUserActive() == 1) ? "Ja" : "Nein";
        Course freiCourse = courseDao.getMaxCourseEndDate(student.getUserID());
        Date endDate = MyDate.getCurrentSQLDate();
        Date freiDate = student.getFreigabeDate();
        Course frei = courseDao.isFreigegeben(student.getUserID());

        int freigabeStatus = student.getFreigabeStatus();
        int num=0;
        if(frei.getCourseEndDate()!=null){
            num=1;
        }else{
            num=0;
        }
        String freigabeStatusText = "";
        if(freigabeStatus==0){
            freigabeStatusText="Nicht Freigegeben";
        }else if(freigabeStatus==1 && MyDate.isEqual(freiDate,endDate)==false){
            freigabeStatusText="Nicht Freigegeben";
        }else if(freigabeStatus==2 && num==0){
            freigabeStatusText="Nicht Freigegeben";
        }else{
            freigabeStatusText="Freigegeben";
        }

        request.getSession().setAttribute("pstudent",student);
        Vector bucher = new BuchDao().getBooksSaledToStudent(userId, 0);
        SingleClassDao scd = new SingleClassDao();
        Vector singleClasses = scd.getSingleClasses(student.getUserID());
        SingleClassBalance scb = scd.getStudentRecord(student.getUserID());
        Vector eubev = scb.getTransactions();
        boolean b=true;
        String eubericht = "";
        for(int ii=0;ii<eubev.size();ii++){
            Transaction tt=(Transaction)eubev.elementAt(ii);
            if(b){
                eubericht=eubericht+tt.getTransactionNo();
                b=false;
            }else{
                eubericht=eubericht+","+tt.getTransactionNo();
            }
        }

        boolean btb=true;
        WerbungDao wdb=new WerbungDao();
        Werbung werbung=wdb.getWerbungRelatedToStudent(student.getUserID());
        String allwerbung=werbung.getWerbungName();
        if(allwerbung==null){
            allwerbung="";
        }

        InsuranceDao insuranceDao = new InsuranceDao();
        VertragTraker vertragDao = new VertragTraker();
        String isinsured="", vertragStatus = "";
        if(!insuranceDao.isInsured(userId)){
            isinsured="Nicht Versichert!";
        }
        if(!vertragDao.existsVertrag(userId)){
            vertragStatus="Kein Vertrag";
        }

        String beitrag = "";
        if(student.getUserBamfNumber()!=null){
            if(student.getUserCostSharing()==1){
                beitrag="mit Kostenbeitrag";
            }
            else if(student.getUserCostSharing()==2){
                beitrag="ohne Kostenbeitrag";
            }
            else {
                beitrag="";
            }
        }

        ArrayList<Student> vertrags = studentDao.downloadBilder(userId, rps.getLoginUser().getUserID());
        model.addAttribute("vertrags", vertrags);
        double bez = 0.0;
        double toge = 0.0;
        Iterator registrationIterator = registrations.iterator();
        ArrayList<StudentPreciseDViewModel> studentPreciseDViewModels = new ArrayList<>();
        while(registrationIterator.hasNext()) {
            CourseRegistration courseRegistration = (CourseRegistration) registrationIterator.next();
            Course course = courseDao.getCourse(courseRegistration.getCourseID());

            toge = toge + courseRegistration.getCourseFee();

            StudentPreciseDViewModel preciseDViewModel = new StudentPreciseDViewModel();
            preciseDViewModel.courseRegistration = courseRegistration;
            preciseDViewModel.course = course;
            if(courseRegistration.getRegistrationStatus()==1)
            {preciseDViewModel.mys="R";}
            else if(courseRegistration.getRegistrationStatus()==0)
            {preciseDViewModel.mys="V";}
            else if(courseRegistration.getRegistrationStatus()==2)
            {preciseDViewModel.mys="A";}
            else if(courseRegistration.getRegistrationStatus()==3)
            {preciseDViewModel.mys="O";}

            ArrayList<Transaction> myv = transactionDao.getTransactions(student.getUserID(), course.getCourseID());
            String tempb = "";
            b=true;
            double cre=0;
            for(int ii=0;ii<myv.size();ii++){
                Transaction tt=(Transaction)myv.get(ii);
                if(b){
                    tempb=tempb+tt.getTransactionNo();
                    cre=cre+tt.getPaid();
                    b=false;
                }else{
                    tempb=tempb+","+tt.getTransactionNo();
                    cre=cre+tt.getPaid();
                }
            }
            bez=bez+cre;
            String inkasso="";
            boolean inkasoCHK=studentDao.isInKasso(courseRegistration.getStudentID(),courseRegistration.getCourseID(),rps.getLoginUser().getUserID());
            if(inkasoCHK){
                inkasso="Inkasso";
            }
            preciseDViewModel.inkasso = inkasso;
            preciseDViewModel.cre = cre;
            preciseDViewModel.courseFee = MyCurrency.getDisplayString(courseRegistration.getCourseFee());
            preciseDViewModel.creStr = MyCurrency.getDisplayString(cre);
            preciseDViewModel.balance = MyCurrency.getDisplayString(courseRegistration.getCourseBalance());
            preciseDViewModel.tempb = tempb;
            preciseDViewModel.courseStartDate = MyDate.formateDate(course.getCourseStartDate(),MyDate.NUMERIC,MyDate.DEUTSCH);
            studentPreciseDViewModels.add(preciseDViewModel);

        }
        /*if(vertrags == null) {

            vertrags=new Vector();
			String err=studentDB.getError();
				session.setAttribute("err",err);
				session.setAttribute("lin","../unitutor/rps/admin/map.jsp");
				response.sendRedirect("error.jsp");
				}*/

        ArrayList<PreciseDViewModelBottom> preciseDViewModelBottoms = new ArrayList<>();
        Vector<Student> xtra = new XtraCostDao().getXtraCosts(userId);
        double nochof = 0.0;
        String tempc = "";
        for (int i = 0; i < xtra.size(); i++) {
            PreciseDViewModelBottom preciseDViewModelBottom = new PreciseDViewModelBottom();
            boolean c=true;

            Student stu= xtra.elementAt(i);

            XtraCostDao xtraCostDB=new XtraCostDao();
            Student xtracost = xtraCostDB.getXtraCost(stu.getResidenceID());
            Student pay = xtraCostDB.getCostStudent(stu.getResidenceID(), userId);
            toge=toge+stu.getUserStundenLohn();
            bez=bez+pay.getTotalPay();
            nochof=nochof+((xtracost.getActualFee()-pay.getTotalPay()));
            Vector xtracost1 = xtraCostDB.getXtraTran(stu.getResidenceID());

            for(int j=0;j<xtracost1.size();j++){
                Student tt=(Student)xtracost1.elementAt(j);
                if(c){
                    tempc=""+tt.getResidenceID();
                    c=false;
                }else{
                    tempc=tempc+","+tt.getResidenceID();
                }
            }
            if(pay.getTotalPay() <1){
                tempc="";
            }
            preciseDViewModelBottom.stu = stu;
            preciseDViewModelBottom.pay = pay;
            preciseDViewModelBottom.xtracost = xtracost;
            preciseDViewModelBottom.tempc = tempc;
            preciseDViewModelBottoms.add(preciseDViewModelBottom);
        }

        ArrayList<Buch> buches = new ArrayList<>();
        for (int i = 0; i < bucher.size(); i++) {
            buches.add((Buch) bucher.elementAt(i));
        }

        model.addAttribute("allWerbung", allwerbung);
        model.addAttribute("student", student);
        model.addAttribute("anwesenheit", anwesenheit);
        model.addAttribute("vertragStatus", vertragStatus);
        model.addAttribute("freigabeStatusText", freigabeStatusText);
        model.addAttribute("beitrag", beitrag);
        model.addAttribute("spdv", studentPreciseDViewModels);
        model.addAttribute("spdvBottom", preciseDViewModelBottoms);
        model.addAttribute("toge", MyCurrency.getDisplayString(toge));
        model.addAttribute("bez", MyCurrency.getDisplayString(bez));
        model.addAttribute("nochof", MyCurrency.getDisplayString(nochof));
        model.addAttribute("buches", buches);
        return "showStudentPreciseD";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/schuler/showTransactions")
    public String showTransactions(HttpServletRequest request, Model model) {
        if(loginStatement(request)) {
            return "redirect:/";
        }
        TransactionDao transactionDao = new TransactionDao();
        RPS rps = (RPS) request.getSession().getAttribute("handler");


        ArrayList<Transaction> transactions = transactionDao.getTransactionsByStudent(Integer.parseInt(request.getParameter("studentID")), rps.getLoginUser().getUserID());
        //double sume = transactions.stream().mapToDouble(Transaction::getPaid).sum();

        ArrayList<ShowTransactionsViewModel> showTransactionsViewModels = new ArrayList<>();
        double sume = 0;
        for(Transaction transaction : transactions) {
            sume += transaction.getPaid();

            showTransactionsViewModels.add(new ShowTransactionsViewModel(
                    transaction,
                    MyCurrency.getDisplayString(transaction.getPaid()),
                    MyDate.formateDate(transaction.getPaymentDate(),MyDate.NUMERIC,MyDate.DEUTSCH)
                    ));
        }
        String roundedEuro = MyCurrency.getDisplayString(sume);

        model.addAttribute("transactions", showTransactionsViewModels);
        model.addAttribute("studentID", request.getParameter("studentID"));
        model.addAttribute("sume", sume);
        model.addAttribute("roundedEuro", roundedEuro);
        return "showTransactions";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/schuler/printBillMul")
    public String printBillMul(HttpServletRequest request) {
        if(loginStatement(request)) {
            return "redirect:/";
        }
        Vector v = new Vector();
        String list[] =request.getParameterValues("dr");
        if(list!=null){
            for(int i=0;i<list.length;i++){
                try{
                    Transaction t=(new TransactionDao()).getTransaction(Integer.parseInt((String)list[i]));
                    v.addElement(t);
                }catch(Exception e){
                }
            }
            request.getSession().setAttribute("tr",v);
        }
        return "printBillMul";
    }

    @RequestMapping(value = "/schuler/RegisterFormula", method = { RequestMethod.GET, RequestMethod.POST })
    public String registerFormula() {
        return "RegisterFormula";
    }

    @RequestMapping(value = "/schuler/printRegistrationFormula", method = { RequestMethod.GET, RequestMethod.POST })
    public String printRegistrationFormula(Model model) {
        model.addAttribute("studentDao", studentDao);
        return "printRegistrationFormula";
    }

    @RequestMapping(value = "/schuler/xtraCosts", method = { RequestMethod.GET, RequestMethod.POST })
    public String xtraCosts(Model model) {
        model.addAttribute("studentDao", studentDao);
        return "xtraCosts";
    }

    @RequestMapping(value = "/schuler/registerXtraCosts", method = { RequestMethod.GET, RequestMethod.POST })
    public String registerXtraCosts(Model model) {
        model.addAttribute("studentDao", studentDao);
        return "registerXtraCosts";
    }

    @RequestMapping(value = "/schuler/integrationCosts", method = { RequestMethod.GET, RequestMethod.POST })
    public String integrationCosts(Model model) {
        model.addAttribute("studentDao", studentDao);
        return "integrationCosts";
    }

    @RequestMapping(value = "/schuler/registerIntegrationCosts", method = { RequestMethod.GET, RequestMethod.POST })
    public String registerIntegrationCosts(Model model) {
        model.addAttribute("studentDao", studentDao);
        return "registerIntegrationCosts";
    }

    @RequestMapping(value = "/schuler/currentLocation", method = { RequestMethod.GET, RequestMethod.POST })
    public String currentLocation(@SessionAttribute("handler") RPS rps, Model model) {
        if(!studentDao.canMakeVertrag(rps.getLoginUser().getUserID())) {
            return "redirect:/index?err=permission";
        }
        model.addAttribute("studentDao", studentDao);
        return "currentLocation";
    }

    @RequestMapping(value = "/schuler/makeVertrag", method = { RequestMethod.GET, RequestMethod.POST })
    public String makeVertrag(@SessionAttribute("handler") RPS rps, Model model) {
        if(!studentDao.canMakeVertrag(rps.getLoginUser().getUserID())) {
            return "redirect:/index?err=permission";
        }
        model.addAttribute("studentDao", studentDao);
        return "makeVertrag";
    }

    @RequestMapping(value = "/schuler/makeVertrag2", method = { RequestMethod.GET, RequestMethod.POST })
    public String makeVertrag2(@SessionAttribute("handler") RPS rps, Model model) {
        if(!studentDao.canMakeVertrag(rps.getLoginUser().getUserID())) {
            return "redirect:/index?err=permission";
        }
        model.addAttribute("studentDao", studentDao);
        model.addAttribute("courseDao", courseDao);
        return "makeVertrag2";
    }

    @RequestMapping(value = "/schuler/vertragPlan", method = { RequestMethod.GET, RequestMethod.POST })
    public String vertragPlan(@SessionAttribute("handler") RPS rps, Model model) {
        if(!studentDao.canMakeVertrag(rps.getLoginUser().getUserID())) {
            return "redirect:/index?err=permission";
        }
        model.addAttribute("courseDao", courseDao);
        return "vertragPlan";
    }

    @RequestMapping(value = "/schuler/vertragFinal", method = { RequestMethod.GET, RequestMethod.POST })
    public String vertragFinal(@SessionAttribute("handler") RPS rps, Model model) {
        if(!studentDao.canMakeVertrag(rps.getLoginUser().getUserID())) {
            return "redirect:/index?err=permission";
        }
        model.addAttribute("studentDao", studentDao);
        model.addAttribute("courseDao", courseDao);
        return "vertragFinal";
    }

    @RequestMapping(value = "/schuler/registerVerFee", method = { RequestMethod.GET, RequestMethod.POST })
    public String registerVerFee(@SessionAttribute("handler") RPS rps, Model model) {
        if(!studentDao.canMakeVertrag(rps.getLoginUser().getUserID())) {
            return "redirect:/index?err=permission";
        }
        model.addAttribute("studentDao", studentDao);
        model.addAttribute("courseDao", courseDao);
        return "registerVerFee";
    }

    @RequestMapping(value = "/schuler/linkToIntegrationCostBericht ", method = { RequestMethod.GET, RequestMethod.POST })
    public String linkToIntegrationCostBericht () {
        return "linkToIntegrationCostBericht";
    }

    @RequestMapping(value = "/schuler/editWerbungList", method = { RequestMethod.GET, RequestMethod.POST })
    public String editWerbungList (Model model) {
        model.addAttribute("studentDao", studentDao);
        return "editWerbungList";
    }

    @RequestMapping(value = "/schuler/bookTra", method = { RequestMethod.GET, RequestMethod.POST })
    public String bookTra(Model model) {
        model.addAttribute("studentDao", studentDao);
        return "schulerBookTra";
    }

    @RequestMapping(value = "/schuler/removebook", method = { RequestMethod.GET, RequestMethod.POST })
    public String removebook() {
        return "removebook";
    }

    @RequestMapping(value = "/schuler/payEUnterricht", method = { RequestMethod.GET, RequestMethod.POST })
    public String payEUnterricht(Model model) {
        model.addAttribute("studentDao", studentDao);
        return "payEUnterricht";
    }

    @RequestMapping(value = "/schuler/payEUnterrichtProcess", method = { RequestMethod.GET, RequestMethod.POST })
    public String payEUnterrichtProcess(Model model) {
        model.addAttribute("studentDao", studentDao);
        return "payEUnterrichtProcess";
    }

    @RequestMapping(value = "/schuler/showIntegrationCostDetail", method = { RequestMethod.GET, RequestMethod.POST })
    public String showIntegrationCostDetail(@SessionAttribute("handler") RPS rps, Model model) {
        if(!studentDao.canSeeCourseRegistration(rps.getLoginUser().getUserID())) {
            return "redirect:/index?err=permission";
        }
        model.addAttribute("studentDao", studentDao);
        return "showIntegrationCostDetail";
    }


    @RequestMapping(value = "/schuler/updateIntegrationCost", method = { RequestMethod.GET, RequestMethod.POST })
    public String updateIntegrationCost(@SessionAttribute("handler") RPS rps, Model model) {
        if(!studentDao.canSeeCourseRegistration(rps.getLoginUser().getUserID())) {
            return "redirect:/index?err=permission";
        }
        model.addAttribute("studentDao", studentDao);
        return "updateIntegrationCost";
    }

    @RequestMapping(value = "/schuler/integrationBillProcess", method = { RequestMethod.GET, RequestMethod.POST })
    public String integrationBillProcess(@SessionAttribute("handler") RPS rps, Model model) {
        if(!studentDao.canSeeCourseRegistration(rps.getLoginUser().getUserID())) {
            return "redirect:/index?err=permission";
        }
        return "integrationBillProcess";
    }


    @RequestMapping(value = "/schuler/printIntegrationCostBill", method = { RequestMethod.GET, RequestMethod.POST })
    public String printIntegrationCostBill(@SessionAttribute("handler") RPS rps, Model model) {
        if(!studentDao.canSeeCourseRegistration(rps.getLoginUser().getUserID())) {
            return "redirect:/index?err=permission";
        }
        model.addAttribute("studentDao", studentDao);
        return "printIntegrationCostBill";
    }

    @RequestMapping(value = "/schuler/currentLocationSTK", method = { RequestMethod.GET, RequestMethod.POST })
    public String currentLocationSTK(@SessionAttribute("handler") RPS rps) {
        if(!studentDao.canMakeVertrag(rps.getLoginUser().getUserID())) {
            return "redirect:/index?err=permission";
        }
        return "currentLocationSTK";
    }

    @RequestMapping(value = "/schuler/makeVertragSTK", method = { RequestMethod.GET, RequestMethod.POST })
    public String makeVertragSTK(@SessionAttribute("handler") RPS rps) {
        if(!studentDao.canMakeVertrag(rps.getLoginUser().getUserID())) {
            return "redirect:/index?err=permission";
        }
        return "makeVertragSTK";
    }

    @RequestMapping(value = "/schuler/editGroupList", method = { RequestMethod.GET, RequestMethod.POST })
    public String editGroupList(Model model) {
        model.addAttribute("studentDao", studentDao);
        return "editGroupList";
    }

    @RequestMapping(value = "/schuler/editInsuranceList", method = { RequestMethod.GET, RequestMethod.POST })
    public String editInsuranceList() {
        return "editInsuranceList";
    }

    @RequestMapping(value = "/schuler/addEUnterricht", method = { RequestMethod.GET, RequestMethod.POST })
    public String addEUnterricht(@SessionAttribute("handler") RPS rps) {
        if(!studentDao.newEinzelUnterricht(rps.getLoginUser().getUserID())) {
            return "redirect:/index?err=permission";
        }
        return "addEUnterricht";
    }

    @RequestMapping(value = "/schuler/addEUnterrichtProcess", method = { RequestMethod.GET, RequestMethod.POST })
    public String addEUnterrichtProcess(@SessionAttribute("handler") RPS rps, Model model) {
        if(!studentDao.newEinzelUnterricht(rps.getLoginUser().getUserID())) {
            return "redirect:/index?err=permission";
        }
        return "addEUnterrichtProcess";
    }
}
