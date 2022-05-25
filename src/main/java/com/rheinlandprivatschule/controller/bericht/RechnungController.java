package com.rheinlandprivatschule.controller.bericht;

import com.rheinlandprivatschule.controller.BaseController;
import com.rheinlandprivatschule.helper.MyCurrency;
import com.rheinlandprivatschule.helper.MyDate;
import com.rheinlandprivatschule.model.Place;
import com.rheinlandprivatschule.model.Student;
import com.rheinlandprivatschule.model.SystemUser;
import com.rheinlandprivatschule.model.Transaction;
import com.rheinlandprivatschule.repository.*;
import com.rheinlandprivatschule.viewmodel.ShowTransactionsViewModel;
import com.rheinlandprivatschule.viewmodel.ShowTransactionsViewModelXtr;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;


import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Controller
public class RechnungController extends BaseController {

    private final TransactionDao transactionDao;
    private final SystemUserDao systemUserDao;
    private final PlaceDao placeDao;
    private final TeacherLohnDao teacherLohnDao;
    private final XtraCostDao xtraCostDao;

    @Autowired
    public RechnungController(TransactionDao transactionDao, SystemUserDao systemUserDao, PlaceDao placeDao, TeacherLohnDao teacherLohnDao, XtraCostDao xtraCostDao) {
        this.transactionDao = transactionDao;
        this.systemUserDao = systemUserDao;
        this.placeDao = placeDao;
        this.teacherLohnDao = teacherLohnDao;
        this.xtraCostDao = xtraCostDao;
    }

    @RequestMapping(method = RequestMethod.GET, value = "/bericht/searchTransactions")
    public String searchTransactions(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        List<SystemUser> vec= new ArrayList<>();
        List<Place> cityV= new ArrayList<>();
        int dayO=0;
        int yearO=0;
        String monthO="01";
        int day =0;
        int year=0;
        String month="01";
        String xtraCost=null;
        String bucher=null;
        String rent =null;

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(transactionDao.canSeeBericht(rps.getLoginUser().getUserID())) {
            vec = systemUserDao.getAllSystemUserWOTeacher();
            cityV = placeDao.getAllPlaces();

            month= MyDate.getMonth(MyDate.getCurrentSQLDate());
            String dayS=MyDate.getDay(MyDate.getCurrentSQLDate());
            String yearS=MyDate.getYear(MyDate.getCurrentSQLDate());
            day =Integer.parseInt(dayS);
            year=Integer.parseInt(yearS);

            java.util.Calendar gc=new java.util.GregorianCalendar();
            gc.setTime(MyDate.getCurrentSQLDate());
            gc.add(Calendar.DATE, -9);
            java.sql.Date tempdate=new java.sql.Date(gc.getTime().getTime());
            monthO=MyDate.getMonth(tempdate);
            String dayOS=MyDate.getDay(tempdate);
            String yearOS=MyDate.getYear(tempdate);
            dayO=Integer.parseInt(dayOS);
            yearO=Integer.parseInt(yearOS);
            model.addAttribute("day0", dayO);
            model.addAttribute("month0", Integer.parseInt(monthO));
            model.addAttribute("year0", yearO);
            model.addAttribute("day", day);
            model.addAttribute("year", year);
            model.addAttribute("month", Integer.parseInt(month));
        } else {
            return "redirect:/index?err=permission";
        }

        model.addAttribute("vec", vec);
        model.addAttribute("cityV", cityV);

        return "searchTransactions";
    }

    @RequestMapping(value = {"/bericht/showTransactions", "/bericht/showTransactionsToday"}, method = {RequestMethod.GET, RequestMethod.POST})
    public String showTransactions(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(transactionDao.canSeeBericht(rps.getLoginUser().getUserID())) {
            boolean canprint=transactionDao.canPrintBericht(rps.getLoginUser().getUserID());
            String cri= request.getParameter("selC");
            String adminS= request.getParameter("selAdmin");
            SystemUser reqAdmin = new SystemUser();
            Place reqPlace = new Place();
            int paytype = 0;
            int tranNo = 0;
            String xtraCost = "";
            String bucher = "";
            String rent = "";

            double sume=0;
            double xsume = 0;
            double bsume = 0;
            double rentSume = 0;

            try{
                if(!adminS.equalsIgnoreCase("wählen Administrator")){
                    int admin=Integer.parseInt(adminS);
                    reqAdmin= systemUserDao.getSystemUser(admin);
                }
            }catch(Exception ignored){
            }

            String placename= request.getParameter("selPlace");
            try{
                if(!placename.equalsIgnoreCase("wählen Schule")){
                    int place=Integer.parseInt(placename);
                    reqPlace= placeDao.getPlace(place);
                }
            }catch(Exception e){
            }
            String sPayType= request.getParameter("selPayType");
            try{
                if(!sPayType.equalsIgnoreCase("Zalungsart")){
                    paytype=Integer.parseInt(sPayType);
                }
            }catch(Exception e){
            }

            String tranno= request.getParameter("tranNo");
            try{
                tranNo=Integer.parseInt(tranno);
            }catch(Exception ee){
            }
            String sDay= request.getParameter("selSDay");
            String sMonth= request.getParameter("selSMonth");
            String sYear= request.getParameter("selSYear");
            String eDay= request.getParameter("selEDay");
            String eMonth= request.getParameter("selEMonth");
            String eYear= request.getParameter("selEYear");
            xtraCost= request.getParameter("xtraCost");
            bucher = request.getParameter("bucher");
            rent = request.getParameter("rent");

            java.sql.Date d1= (request.getServletPath().equals("/bericht/showTransactionsToday")) ? MyDate.getCurrentSQLDate() : MyDate.getSQLDateFromStrings(sDay,sMonth,sYear,MyDate.DEUTSCH);;
            java.sql.Date d2=(request.getServletPath().equals("/bericht/showTransactionsToday")) ? MyDate.getCurrentSQLDate() : MyDate.getSQLDateFromStrings(eDay,eMonth,eYear,MyDate.DEUTSCH);
            List<Transaction> myTr=transactionDao.getTransactionsMain(Integer.parseInt(cri),reqAdmin.getUserID(),d1,d2,reqPlace.getPlaceID(),tranNo, paytype);
            List<ShowTransactionsViewModel> myTrModel = new ArrayList<>();
            for(int x=0;x<myTr.size();x++){
                Transaction tx= myTr.get(x);
                sume=sume+tx.getPaid();
                myTrModel.add(new ShowTransactionsViewModel(
                   tx, MyCurrency.getDisplayString(tx.getPaid()), MyDate.formateDate(tx.getPaymentDate(),MyDate.NUMERIC,MyDate.DEUTSCH)
                ));
            }
            String roundedEuro= MyCurrency.getDisplayString(sume);

            List<ShowTransactionsViewModelXtr> myXtrModel = new ArrayList<>();
            if(xtraCost!=null){
                List<Transaction> myXtr=transactionDao.getXtraTransactions(Integer.parseInt(cri),reqAdmin.getUserID(),d1,d2,reqPlace.getPlaceID(),tranNo, paytype);
                for(int a=0;a<myXtr.size();a++){
                    Transaction xt= myXtr.get(a);
                    xsume=xsume+xt.getPaid();
                    myXtrModel.add(new ShowTransactionsViewModelXtr(
                            xt,
                            MyCurrency.getDisplayString(xt.getPaid()),
                            MyDate.formateDate(xt.getPaymentDate(),MyDate.NUMERIC,MyDate.DEUTSCH),
                            xtraCostDao.getXtraCost(xt.getCourseID())
                    ));
                }
            }
            String xroundedEuro=MyCurrency.getDisplayString(xsume);

            List<ShowTransactionsViewModel> myBuchModel = new ArrayList<>();
            if(bucher!=null){
                List<Transaction> myBuch=transactionDao.getBooksTransactions(Integer.parseInt(cri),reqAdmin.getUserID(),d1,d2,reqPlace.getPlaceID(),tranNo, paytype);
                for(int f=0;f<myBuch.size();f++){
                    Transaction book= myBuch.get(f);
                    bsume=bsume+book.getPaid();
                    myBuchModel.add(new ShowTransactionsViewModel(
                            book, MyCurrency.getDisplayString(book.getPaid()), MyDate.formateDate(book.getPaymentDate(),MyDate.NUMERIC,MyDate.DEUTSCH)
                    ));
                }
            }
            String broundedEuro=MyCurrency.getDisplayString(bsume);

            List<ShowTransactionsViewModel> myRentModel = new ArrayList<>();
            if(rent!=null){
                ArrayList<Transaction> myRent=transactionDao.getRentTransaction(Integer.parseInt(cri),reqAdmin.getUserID(),d1,d2,reqPlace.getPlaceID(),tranNo, paytype);
                for(int n=0;n<myRent.size();n++){
                    Transaction rent1= myRent.get(n);
                    rentSume=rentSume+rent1.getPaid();
                    myRentModel.add(new ShowTransactionsViewModel(
                            rent1, MyCurrency.getDisplayString(rent1.getPaid()), MyDate.formateDate(rent1.getPaymentDate(),MyDate.NUMERIC,MyDate.DEUTSCH
                    )));
                }
            }
            String rentRoundedEuro=MyCurrency.getDisplayString(rentSume);

            String total = MyCurrency.getDisplayString(rentSume+bsume+xsume+sume);

            model.addAttribute("payType", paytype);
            model.addAttribute("total", total);
            model.addAttribute("roundedEuro", roundedEuro);
            model.addAttribute("broundedEuro", broundedEuro);
            model.addAttribute("xroundedEuro", xroundedEuro);
            model.addAttribute("rentRoundedEuro", rentRoundedEuro);
            model.addAttribute("myTrModel", myTrModel);
            model.addAttribute("myXtrModel", myXtrModel);
            model.addAttribute("myRentModel", myRentModel);
            model.addAttribute("myBuchModel", myBuchModel);
            model.addAttribute("canprint", canprint);
        } else {
            return "redirect:/index?err=permission";
        }

        return "rechnungShowTransactions";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/bericht/berichtPrintProcess")
    public String berichtPrintProcess(HttpServletRequest request) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        return "berichtPrintProcess";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/bericht/printBillMul")
    public String printBillMull(HttpServletRequest request) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        return "rechnungPrintBillMull";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/bericht/searchUserCash")
    public String searchUserCash(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        Vector<SystemUser> vec;
        Vector<Place> cityV;
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(transactionDao.canSeeBericht(rps.getLoginUser().getUserID())) {
            vec = systemUserDao.getAllSystemUserWOTeacher();
            cityV = placeDao.getAllPlaces();

            String month= MyDate.getMonth(MyDate.getCurrentSQLDate());
            String dayS=MyDate.getDay(MyDate.getCurrentSQLDate());
            String yearS=MyDate.getYear(MyDate.getCurrentSQLDate());
            int day =Integer.parseInt(dayS);
            int year=Integer.parseInt(yearS);

            java.util.Calendar gc=new java.util.GregorianCalendar();
            gc.setTime(MyDate.getCurrentSQLDate());
            gc.add(Calendar.DATE, -9);
            java.sql.Date tempdate=new java.sql.Date(gc.getTime().getTime());
            String monthO=MyDate.getMonth(tempdate);
            String dayOS=MyDate.getDay(tempdate);
            String yearOS=MyDate.getYear(tempdate);
            int dayO=Integer.parseInt(dayOS);
            int yearO=Integer.parseInt(yearOS);

            model.addAttribute("day0", dayO);
            model.addAttribute("month0", monthO);
            model.addAttribute("year0", yearO);
            model.addAttribute("day", day);
            model.addAttribute("year", year);
            model.addAttribute("month", month);
        } else {
            return "redirect:/index?err=permission";
        }

        model.addAttribute("vec", vec);
        model.addAttribute("cityV", cityV);

        return "searchUserCash";
    }

    @RequestMapping(value = "/bericht/showUserCash", method = {RequestMethod.GET, RequestMethod.POST})
    public String showUserCash(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        Place reqPlace=new Place();
        SystemUser reqAdmin=new SystemUser();

        ArrayList<Transaction> myTr;
        ArrayList<Transaction> myXtr;
        ArrayList<Transaction> myBuch;
        ArrayList<Transaction> myRent;
        ArrayList<Transaction> myKasse;

        String myMsg="";

        int tranNo=0;
        double sume=0;
        String roundedEuro="";

        int xtranNo=0;
        double xsume=0;
        String xroundedEuro="";
        String xtraCost="";

        int btranNo=0;
        double bsume=0;
        String broundedEuro="";
        String bucher="";

        int rentTranNo=0;
        double rentSume=0;
        double kasseSume=0;
        String rentRoundedEuro="";
        String kasseRoundedEuro="";
        String rent="";
        String geld="";

        String cri="";
        String adminS="";
        String placename="";
        String paytype ="" ;
        String tranno="";


        String sDay="";
        String sMonth="";
        String sYear="";
        String eDay="";
        String eMonth="";
        String eYear="";


        String total="";
        boolean canprint=false;

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(transactionDao.canSeeBericht(rps.getLoginUser().getUserID())) {
            canprint=transactionDao.canPrintBericht(rps.getLoginUser().getUserID());

            cri=(String)request.getParameter("selC");
            adminS=(String)request.getParameter("selAdmin");
            try{
                if(!adminS.equalsIgnoreCase("wählen Administrator")){
                    int admin=Integer.parseInt(adminS);
                    reqAdmin= systemUserDao.getSystemUser(admin);
                }
            }catch(Exception e){
            }

            placename=(String)request.getParameter("selPlace");
            try{
                if(!placename.equalsIgnoreCase("wählen Schule")){
                    int place=Integer.parseInt(placename);
                    reqPlace= placeDao.getPlace(place);
                }
            }catch(Exception e){
            }

            tranno=(String)request.getParameter("tranNo");
            try{
                tranNo=Integer.parseInt(tranno);
            }catch(Exception ee){
            }
            sDay=(String)request.getParameter("selSDay");
            sMonth=(String)request.getParameter("selSMonth");
            sYear=(String)request.getParameter("selSYear");
            eDay=(String)request.getParameter("selEDay");
            eMonth=(String)request.getParameter("selEMonth");
            eYear=(String)request.getParameter("selEYear");
            xtraCost=(String)request.getParameter("xtraCost");
            bucher = (String)request.getParameter("bucher");
            rent = (String)request.getParameter("rent");
            paytype = (String)request.getParameter("paytype");


            java.sql.Date d1=MyDate.getSQLDateFromStrings(sDay,sMonth,sYear,MyDate.DEUTSCH);
            java.sql.Date d2=MyDate.getSQLDateFromStrings(eDay,eMonth,eYear,MyDate.DEUTSCH);
            myTr=transactionDao.getTransactionCash(Integer.parseInt(cri),reqAdmin.getUserID(),d1,d2,reqPlace.getPlaceID(),tranNo, Integer.parseInt(paytype));
            for(int x=0;x<myTr.size();x++){
                Transaction tx= myTr.get(x);
                sume=sume+tx.getPaid();
            }
            roundedEuro=MyCurrency.getDisplayString(sume);

            myXtr=transactionDao.getXtraTransactions(Integer.parseInt(cri),reqAdmin.getUserID(),d1,d2,reqPlace.getPlaceID(),tranNo,Integer.parseInt(paytype));
            for(int a=0;a<myXtr.size();a++){
                Transaction xt= myXtr.get(a);
                xsume=xsume+xt.getPaid();
            }
            xroundedEuro=MyCurrency.getDisplayString(xsume);


            myBuch=transactionDao.getBooksTransactions(Integer.parseInt(cri),reqAdmin.getUserID(),d1,d2,reqPlace.getPlaceID(),tranNo,Integer.parseInt(paytype));
            for(int f=0;f<myBuch.size();f++){
                Transaction book= myBuch.get(f);
                bsume=bsume+book.getPaid();
            }
            broundedEuro=MyCurrency.getDisplayString(bsume);

            myRent=transactionDao.getRentTransaction(Integer.parseInt(cri),reqAdmin.getUserID(),d1,d2,reqPlace.getPlaceID(),tranNo,Integer.parseInt(paytype));
            for(int n=0;n<myRent.size();n++){
                Transaction rent1= myRent.get(n);
                rentSume=rentSume+rent1.getPaid();
            }
            rentRoundedEuro=MyCurrency.getDisplayString(rentSume);

            List<ShowTransactionsViewModel> kasseViewModels = new ArrayList<>();
            myKasse=transactionDao.getKasse(Integer.parseInt(cri),reqAdmin.getUserID(),d1,d2,reqPlace.getPlaceID(),tranNo);
            for(int n=0;n<myKasse.size();n++){
                Transaction kasse= myKasse.get(n);
                kasseSume=kasseSume+kasse.getKassePay();
                kasseViewModels.add(new ShowTransactionsViewModel(
                        kasse,
                        MyCurrency.getDisplayString(kasse.getKassePay()),
                        MyDate.formateDate(kasse.getKasseDate(),MyDate.NUMERIC,MyDate.DEUTSCH)
                ));
            }
            kasseRoundedEuro=MyCurrency.getDisplayString(kasseSume);

            total = MyCurrency.getDisplayString(rentSume+bsume+xsume+sume);
            double kassegeld = (rentSume+bsume+xsume+sume) - kasseSume;
            geld=MyCurrency.getDisplayString(kassegeld);

            model.addAttribute("total", total);
            model.addAttribute("myMsg", myMsg);
            model.addAttribute("geld", geld);
            model.addAttribute("cri", cri);
            model.addAttribute("adminS", adminS);
            model.addAttribute("placeName", placename);
            model.addAttribute("paytype", paytype);
            model.addAttribute("tranno", tranNo);
            model.addAttribute("sDay", sDay);
            model.addAttribute("sMonth", sMonth);
            model.addAttribute("sYear", sYear);
            model.addAttribute("eDay", eDay);
            model.addAttribute("eMonth", eMonth);
            model.addAttribute("eYear", eYear);
            model.addAttribute("kasseRoundedEuro", kasseRoundedEuro);
            model.addAttribute("kasseViewModels", kasseViewModels);
            model.addAttribute("canprint", canprint);

        } else {
            return "redirect:/index?err=permission";
        }

        return "showUserCash";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/bericht/updateUserCash")
    public String updateUserCash(HttpServletRequest request) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        return "updateUserCash";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/bericht/searchEmployeeTimeSheet")
    public String searchEmployeeTimeSheet(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(transactionDao.canSeeBericht(rps.getLoginUser().getUserID())) {
            model.addAttribute("placeDao", placeDao);
            model.addAttribute("systemUserDao", systemUserDao);
            return "searchEmployeeTimeSheet";
        }
        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/bericht/showEmployeeTimeSheet")
    public String showEmployeeTimeSheet(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        EmployeeHours employeeHours = new EmployeeHours();
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(employeeHours.canAddEmployeeHours(rps.getLoginUser().getUserID())) {
            model.addAttribute("placeDao", placeDao);
            model.addAttribute("teacherLohnDao", teacherLohnDao);
            model.addAttribute("systemUserDao", systemUserDao);
            model.addAttribute("hours", employeeHours);
            return "showEmployeeTimeSheet";
        }


        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/bericht/searchNullGebTran")
    public String searchNullGebTran(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(transactionDao.canSeeBericht(rps.getLoginUser().getUserID())) {
            model.addAttribute("placeDao", placeDao);
            model.addAttribute("systemUserDao", systemUserDao);
            return "searchNullGebTran";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/bericht/showNullGebTran")
    public String showNullGebTran(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(transactionDao.canSeeBericht(rps.getLoginUser().getUserID())) {
            model.addAttribute("placeDao", placeDao);
            model.addAttribute("systemUserDao", systemUserDao);
            model.addAttribute("transactionDao", transactionDao);
            model.addAttribute("rps", rps);
            return "showNullGebTran";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/bericht/searchFirstPay")
    public String searchFirstPay(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(transactionDao.canSeeFirstPay(rps.getLoginUser().getUserID())) {
            model.addAttribute("placeDao", placeDao);
            model.addAttribute("myPlace", rps.getLoginPlace());
            return "searchFirstPay";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/bericht/showFirstPay")
    public String showFirstPay(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(transactionDao.canSeeFirstPay(rps.getLoginUser().getUserID())) {
            model.addAttribute("transactionDao", transactionDao);
            return "showFirstPay";
        }

        return "redirect:/index?err=permission";
    }
}
