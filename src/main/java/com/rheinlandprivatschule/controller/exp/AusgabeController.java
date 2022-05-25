package com.rheinlandprivatschule.controller.exp;


import com.rheinlandprivatschule.controller.BaseController;
import com.rheinlandprivatschule.helper.MyCurrency;
import com.rheinlandprivatschule.helper.MyDate;
import com.rheinlandprivatschule.model.ExpCategory;
import com.rheinlandprivatschule.model.Expenditure;
import com.rheinlandprivatschule.model.Place;
import com.rheinlandprivatschule.model.SystemUser;
import com.rheinlandprivatschule.repository.*;
import com.rheinlandprivatschule.viewmodel.AusgabeListViewModel;
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
public class AusgabeController extends BaseController {

    private final ExpCategoryDao expCategoryDao;
    private final ExpenditureDao expenditureDao;
    private final PlaceDao placeDao;
    private final SystemUserDao systemUserDao;

    @Autowired
    public AusgabeController(ExpCategoryDao expCategoryDao, ExpenditureDao expenditureDao, PlaceDao placeDao, SystemUserDao systemUserDao) {
        this.expCategoryDao = expCategoryDao;
        this.expenditureDao = expenditureDao;
        this.placeDao = placeDao;
        this.systemUserDao = systemUserDao;
    }

    @RequestMapping(method = RequestMethod.GET, value = "/exp/ausgabe")
    public String ausgabe(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(expenditureDao.canSearchAusgabe(rps.getLoginUser().getUserID())) {
            List<ExpCategory> cats=expCategoryDao.getAllExpCategories();
            List<Place> places=(placeDao).getAllPlaces();

            String daySet= MyDate.getDay(MyDate.getCurrentSQLDate());
            String monthSet=MyDate.getMonth(MyDate.getCurrentSQLDate());
            String yearSet=MyDate.getYear(MyDate.getCurrentSQLDate());

            model.addAttribute("cats", cats);
            model.addAttribute("places", places);
            model.addAttribute("day", daySet);
            model.addAttribute("month", monthSet);
            model.addAttribute("year", yearSet);
        }
        return "ausgabe";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/exp/ausgabeList")
    public String ausgabeList(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(expenditureDao.canSearchAusgabe(rps.getLoginUser().getUserID())) {
            String cri= request.getParameter("select");

            String dayS= request.getParameter("selSDay");
            String monthS= request.getParameter("selSMonth");
            String yearS= request.getParameter("selSYear");

            String dayE= request.getParameter("selEDay");
            String monthE= request.getParameter("selEMonth");
            String yearE= request.getParameter("selEYear");

            java.sql.Date firstDate=MyDate.getSQLDateFromStrings(dayS,monthS,yearS,MyDate.DEUTSCH);
            java.sql.Date endDate=MyDate.getSQLDateFromStrings(dayE,monthE,yearE,MyDate.DEUTSCH);

            String[] placesS= request.getParameterValues("selPlace");
            String placess="";
            for(int h=0;h<placesS.length;h++){
                placess=placess+" "+placesS[h];
            }
            List<Place> placeV=expenditureDao.getPlaceVector(placess);
            String cats= request.getParameter("selCat");

            List<Expenditure> v = new ArrayList<>();

            String ids= request.getParameter("txtID");
            int idN = 0;
            if(ids!=null){
                try	{
                    idN=Integer.parseInt(ids);
                }catch(Exception e){
                }
            }
            if(idN>0){

                Expenditure ex=expenditureDao.getExpenditure(idN);
                v.add(ex);
            }else{
                v=expenditureDao.getExpendituresByCriteria(cri,firstDate,endDate, (Vector<Place>) placeV,Integer.parseInt(cats));
            }

            double toto=0;
            String stoto="";

            for(int g=0;g<v.size();g++){
                Expenditure ex= v.get(g);
                toto=toto+ex.getBill();
            }
            stoto= MyCurrency.getDisplayString(toto);

            model.addAttribute("stoto", stoto);
            List<AusgabeListViewModel> ausgabeListViewModels = new ArrayList<>();
            for (Expenditure e : v) {
                SystemUser tempUser = systemUserDao.getSystemUser(e.getAdmin());
                ausgabeListViewModels.add(new AusgabeListViewModel(
                        e,
                        MyDate.formateDate(e.getFirstDate(), MyDate.ALPHANUMERIC,MyDate.DEUTSCH),
                        tempUser.getUserFirstName()+" "+tempUser.getUserLastName()
                ));
            }
            model.addAttribute("ausgabeListViewModels", ausgabeListViewModels);
        }
        return "ausgabeList";
    }

    @RequestMapping(method = { RequestMethod.GET, RequestMethod.POST }, value = "/exp/viewAusgabe")
    public String viewAusgabe(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        String id = request.getParameter("id");
        Expenditure ex;
        String daySet, monthSet, yearSet;
        if(id != null) {
            ex = expenditureDao.getExpenditure(Integer.parseInt(id));
            daySet=MyDate.getDay(ex.getFirstDate());
            monthSet=MyDate.getMonth(ex.getFirstDate());
            yearSet=MyDate.getYear(ex.getFirstDate());
            model.addAttribute("ex", ex);
            model.addAttribute("daySet", daySet);
            model.addAttribute("monthSet", monthSet);
            model.addAttribute("yearSet", yearSet);
            model.addAttribute("formatedDate", MyDate.formateDate(ex.getEnterDate(),MyDate.ALPHANUMERIC,MyDate.DEUTSCH));
            model.addAttribute("cats", expCategoryDao.getAllExpCategories());
            model.addAttribute("places", placeDao.getAllPlaces());
        } else {
            String ausgabe= request.getParameter("txtAusgabe");
            String billS= request.getParameter("txtBill");
            ex = new Expenditure();
            if(ausgabe!=null && billS!=null) {
                String idd = request.getParameter("hidID");
                String dayS = request.getParameter("selSDay");
                String monthS = request.getParameter("selSMonth");
                String yearS = request.getParameter("selSYear");
                String[] placeSS = request.getParameterValues("selPlace");
                String placesS = "";
                for (int h = 0; h < placeSS.length; h++) {
                    placesS = placesS + " " + placeSS[h];
                }
                String catS = request.getParameter("selCat");

                ex.setExpenditureID(Integer.parseInt(idd));
                ex.setExpenditureDesc(ausgabe);
                ex.setBill(Double.parseDouble(billS));
                ex.setCategory(Integer.parseInt(catS));
                ex.setEnterDate(MyDate.getCurrentSQLDate());
                ex.setFirstDate(MyDate.getSQLDateFromStrings(dayS, monthS, yearS, MyDate.DEUTSCH));
                ex.setPlaces(expenditureDao.getPlaceVector(placesS));
                ex.setAdmin(rps.getLoginUser().getUserID());
                if (expenditureDao.updateExpenditure(ex)) {
                    return "redirect:/exp/viewAusgabe?id="+idd;
                }
            }
        }

        return "viewAusgabe";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/exp/newAusgabe")
    public String newAusgabe(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(expenditureDao.canAddNewAusgabe(rps.getLoginUser().getUserID())) {
            Expenditure expenditure = expenditureDao.getLastExpenditure();
            String lastgabe = expenditure.getExpenditureID()+"-"+expenditure.getExpenditureDesc();
            List<ExpCategory> cats=expCategoryDao.getAllExpCategories();
            List<Place> places=(placeDao).getAllPlaces();

            String daySet= MyDate.getDay(MyDate.getCurrentSQLDate());
            String monthSet=MyDate.getMonth(MyDate.getCurrentSQLDate());
            String yearSet=MyDate.getYear(MyDate.getCurrentSQLDate());

            model.addAttribute("cats", cats);
            model.addAttribute("places", places);
            model.addAttribute("day", daySet);
            model.addAttribute("month", monthSet);
            model.addAttribute("year", yearSet);
            model.addAttribute("lastgabe", lastgabe);
        } else {
            return "redirect:/index?err=permission";
        }

        return "newAusgabe";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/exp/newAusgabe")
    public String newAusgabeProcess(HttpServletRequest request) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(expenditureDao.canAddNewAusgabe(rps.getLoginUser().getUserID())) {
            Expenditure ex = new Expenditure();
            String ausgabe= request.getParameter("txtAusgabe");
            String billS= request.getParameter("txtBill");

            String dayS = request.getParameter("selSDay");
            String monthS = request.getParameter("selSMonth");
            String yearS = request.getParameter("selSYear");
            String[] placeSS = request.getParameterValues("selPlace");
            String placesS = "";
            for (int h = 0; h < placeSS.length; h++) {
                placesS = placesS + " " + placeSS[h];
            }
            String catS = request.getParameter("selCat");


            ex.setExpenditureDesc(ausgabe);
            ex.setBill(Double.parseDouble(billS));
            ex.setCategory(Integer.parseInt(catS));
            ex.setEnterDate(MyDate.getCurrentSQLDate());
            ex.setFirstDate(MyDate.getSQLDateFromStrings(dayS, monthS, yearS, MyDate.DEUTSCH));
            ex.setPlaces(expenditureDao.getPlaceVector(placesS));
            ex.setAdmin(rps.getLoginUser().getUserID());
            if (expenditureDao.addExpenditure(ex)) {
                return "redirect:/exp/newAusgabe";
            } else {
                String err = "Operation Failed";
                return "redirect:/exp/newAusgabe?err="+err;
            }
        }  else {
            return "redirect:/index?err=permission";
        }
    }

    @RequestMapping(method = RequestMethod.GET, value = "/exp/catList")
    public String catList(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(expCategoryDao.canSeeAusgabeCategoryList(rps.getLoginUser().getUserID())) {
            List<ExpCategory> categories = expCategoryDao.getAllExpCategories();
            model.addAttribute("categories", categories);
        } else {
            return "redirect:/index?err=permission";
        }

        return "expCatList";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/exp/catView")
    public String catView(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(expCategoryDao.canUpdateAusgabeCategory(rps.getLoginUser().getUserID())) {
            String catid=(String)request.getParameter("id");
            ExpCategory c=expCategoryDao.getAllExpCategories(Integer.parseInt(catid));
            model.addAttribute("c", c);
        } else {
            return "redirect:/index?err=permission";
        }
        return "expCatView";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/exp/catView")
    public String catViewProcess(HttpServletRequest request) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(expCategoryDao.canUpdateAusgabeCategory(rps.getLoginUser().getUserID())) {
            ExpCategory c= new ExpCategory();
            String catidP= request.getParameter("hidID");
            String catnameP= request.getParameter("txtName");
            String catdescP= request.getParameter("txtDesc");
            c.setCategoryID(Integer.parseInt(catidP));
            c.setCategoryName(catnameP);
            c.setCategoryDesc(catdescP);
            expCategoryDao.updateExpCategory(c);
            return "redirect:/exp/catView?id="+catidP;
        } else {
            return "redirect:/index?err=permission";
        }
    }

    @RequestMapping(method = RequestMethod.GET, value = "/exp/newCat")
    public String newCat(HttpServletRequest request) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(!expCategoryDao.canAddNewAusgabeCategory(rps.getLoginUser().getUserID())) {
            return "redirect:/index?err=permission";
        }
        return "expNewCat";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/exp/newCat")
    public String newCatProcess(HttpServletRequest request) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(expCategoryDao.canAddNewAusgabeCategory(rps.getLoginUser().getUserID())) {
            String catnameP=(String)request.getParameter("txtName");
            String catdescP=(String)request.getParameter("txtDesc");
            ExpCategory c = new ExpCategory();
            c.setCategoryName(catnameP);
            c.setCategoryDesc(catdescP);
            if(expCategoryDao.addExpCategory(c)){
                return "redirect:/exp/catList";
            }else{
                String err="Operation Failed";
                return "redirect:/exp/newCat?err=" + err;
            }
        } else {
            return "redirect:/index?err=permission";
        }
    }
}