package com.rheinlandprivatschule.controller.balanz;

import com.rheinlandprivatschule.controller.BaseController;
import com.rheinlandprivatschule.helper.MyDate;
import com.rheinlandprivatschule.model.ExpenseCategory;
import com.rheinlandprivatschule.model.Place;
import com.rheinlandprivatschule.repository.ExpenseDao;
import com.rheinlandprivatschule.repository.LohnReportDao;
import com.rheinlandprivatschule.repository.PlaceDao;
import com.rheinlandprivatschule.repository.RPS;
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
public class ExpenseReportController extends BaseController {

    private final ExpenseDao expenseDao;
    private final PlaceDao placeDao;


    @Autowired
    public ExpenseReportController(ExpenseDao expenseDao, PlaceDao placeDao) {
        this.expenseDao = expenseDao;
        this.placeDao = placeDao;
    }

    @RequestMapping(value = "/balanz/expenseReport", method = {RequestMethod.GET, RequestMethod.POST})
    public String expenseReport(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        Vector<ExpenseCategory> catList=new Vector();
        Vector<Place> placeList=new Vector();

        java.sql.Date firstDate = new java.sql.Date(new java.util.Date().getTime());
        java.sql.Date lastDate = new java.sql.Date(new java.util.Date().getTime());

        int dayO=0;
        int yearO=0;
        String monthO="01";
        int day =0;
        int year=0;
        String month="01";
        String displayFirstDate="";
        String displayEndDate="";


        RPS rps = (RPS) request.getSession().getAttribute("handler");
        placeList = placeDao.getAllPlaces();
        if(expenseDao.canWorkWithExpenseCategory(rps.getLoginUser().getUserID())) {
            String cmd=(String)request.getParameter("cmd");
            if(cmd!=null){
                firstDate= MyDate.getSQLDateFromStrings((String)request.getParameter("selSDay"),(String)request.getParameter("selSMonth"),(String)request.getParameter("selSYear"),MyDate.DEUTSCH);
                dayO=Integer.parseInt(MyDate.getDay(firstDate));
                yearO=Integer.parseInt(MyDate.getYear(firstDate));
                monthO=MyDate.getMonth(firstDate);
                lastDate=MyDate.getSQLDateFromStrings((String)request.getParameter("selEDay"),(String)request.getParameter("selEMonth"),(String)request.getParameter("selEYear"),MyDate.DEUTSCH);
                day =Integer.parseInt(MyDate.getDay(lastDate));
                year=Integer.parseInt(MyDate.getYear(lastDate));
                month=MyDate.getMonth(lastDate);
                displayFirstDate=MyDate.formateDate(firstDate,MyDate.NUMERIC,MyDate.DEUTSCH);
                displayEndDate=MyDate.formateDate(lastDate,MyDate.NUMERIC,MyDate.DEUTSCH);

                catList=expenseDao.combineCategories(firstDate,lastDate);
            }else{
                firstDate=MyDate.getFirstCurrentMonthDate();
                lastDate=MyDate.getLastCurrentMonthDate();
                dayO=Integer.parseInt(MyDate.getDay(firstDate));
                yearO=Integer.parseInt(MyDate.getYear(firstDate));
                monthO=MyDate.getMonth(firstDate);
                day =Integer.parseInt(MyDate.getDay(lastDate));
                year=Integer.parseInt(MyDate.getYear(firstDate));
                month=MyDate.getMonth(firstDate);
                displayFirstDate=MyDate.formateDate(firstDate,MyDate.NUMERIC,MyDate.DEUTSCH);
                displayEndDate=MyDate.formateDate(lastDate,MyDate.NUMERIC,MyDate.DEUTSCH);

                catList=expenseDao.combineCategories(firstDate,lastDate);
            }

            model.addAttribute("day0", dayO);
            model.addAttribute("month0", monthO);
            model.addAttribute("year0", yearO);

            model.addAttribute("day", day);
            model.addAttribute("month", month);
            model.addAttribute("year", year);

            model.addAttribute("placeList", placeList);
            model.addAttribute("catList", catList);
            model.addAttribute("displayFirstDate", displayFirstDate);
            model.addAttribute("displayEndDate", displayEndDate);
            model.addAttribute("firstDate", firstDate);
            model.addAttribute("lastDate", lastDate);
            model.addAttribute("edb", expenseDao);
        } else {
            return "redirect:/index?err=permission";
        }

        return "expenseReport";
    }

    @RequestMapping(value = "/balanz/viewExpenseCat", method = {RequestMethod.GET, RequestMethod.POST})
    public String viewExpenseCat(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }


        String daySet="01";
        String monthSet="01";
        String yearSet="2006";

        String dayEnd ="01";
        String yearEnd="01";
        String monthEnd="2006";

        int catType=0;
        ExpenseCategory cat = new ExpenseCategory();

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(expenseDao.canWorkWithExpenseCategory(rps.getLoginUser().getUserID())) {
            String cid= request.getParameter("id");
            if(cid!=null){
                cat=expenseDao.getExpenseCategory(Integer.parseInt(cid));
                daySet=MyDate.getDay(cat.getExpenseStartDate());
                monthSet=MyDate.getMonth(cat.getExpenseStartDate());
                yearSet=MyDate.getYear(cat.getExpenseStartDate());

                if(cat.getExpenseEndDate()==null){
                    dayEnd="0";
                    monthEnd="0";
                    yearEnd="0";
                }else{
                    dayEnd=MyDate.getDay(cat.getExpenseEndDate());
                    monthEnd=MyDate.getMonth(cat.getExpenseEndDate());
                    yearEnd=MyDate.getYear(cat.getExpenseEndDate());
                }

                catType=cat.getExpensePaymentType();

                model.addAttribute("cat", cat);
                model.addAttribute("catType", catType);
                model.addAttribute("dayEnd", dayEnd);
                model.addAttribute("monthEnd", monthEnd);
                model.addAttribute("yearEnd", yearEnd);
                model.addAttribute("daySet", daySet);
                model.addAttribute("monthSet", monthSet);
                model.addAttribute("yearSet", yearSet);
                model.addAttribute("cid", cid);
            }else{
                String catidP=(String)request.getParameter("hidID");
                cat=expenseDao.getExpenseCategory(Integer.parseInt(catidP));

                String nameS=(String)request.getParameter("txtName");
                String typeS=(String)request.getParameter("selType");

                String dayS=(String)request.getParameter("selDay");
                String monthS=(String)request.getParameter("selMonth");
                String yearS=(String)request.getParameter("selYear");

                String dayE=(String)request.getParameter("selEDay");
                String monthE=(String)request.getParameter("selEMonth");
                String yearE=(String)request.getParameter("selEYear");

                String amountS=(String)request.getParameter("txtAmount");
                cat.setExpenseName(nameS);
                cat.setExpensePaymentType(Integer.parseInt(typeS));
                cat.setExpenseStartDate(MyDate.getSQLDateFromStrings(dayS,monthS,yearS,MyDate.DEUTSCH));

                if(Integer.parseInt(dayE)==0){
                    cat.setExpenseEndDate(null);
                }else{
                    cat.setExpenseEndDate(MyDate.getSQLDateFromStrings(dayE,monthE,yearE,MyDate.DEUTSCH));
                }

                cat.setExpenseAmount(Double.parseDouble(amountS));

                Vector newPlacesVec=new Vector();
                String newplaces[]=request.getParameterValues("place");
                if(newplaces!=null){
                    for(int iii=0;iii<newplaces.length;iii++){
                        try{
                            Integer tempValue=new Integer((String)newplaces[iii]);
                            newPlacesVec.addElement(tempValue);
                        }catch(Exception eee){
                        }
                    }
                }
                cat.setSchoolID(newPlacesVec);

                if(!expenseDao.updateExpenseCategory(cat))	{
                    String err=expenseDao.getError();
                    request.getSession().setAttribute("err",err);
                    request.getSession().setAttribute("lin","expenseCatList");
                    return "redirect:/error";
                }
                model.addAttribute("cat", cat);
                model.addAttribute("catType", cat.getExpensePaymentType());
                model.addAttribute("dayEnd", dayE);
                model.addAttribute("monthEnd", MyDate.getMonth(cat.getExpenseEndDate()));
                model.addAttribute("yearEnd", yearE);
                model.addAttribute("daySet", dayS);
                model.addAttribute("monthSet", MyDate.getMonth(cat.getExpenseStartDate()));
                model.addAttribute("yearSet", yearS);
                model.addAttribute("cid", cid);
            }
        }
        List<String> cattypelist=new ArrayList<>();
        cattypelist.add("Stündliche");
        cattypelist.add("Täglich");
        cattypelist.add("Wöchentlich");
        cattypelist.add("Vierzehntägig");
        cattypelist.add("Monatlich");
        cattypelist.add("Vierteljährlich");
        cattypelist.add("Jährlich");
        model.addAttribute("cities", placeDao.getAllPlaces());
        model.addAttribute("cattypelist", cattypelist);

        return "viewExpenseCat";
    }
}
