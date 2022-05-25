package com.rheinlandprivatschule.controller.balanz;

import com.rheinlandprivatschule.controller.BaseController;
import com.rheinlandprivatschule.repository.ExpenseDao;
import com.rheinlandprivatschule.repository.PlaceDao;
import com.rheinlandprivatschule.repository.RPS;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

@Controller
public class ExpenseCatController extends BaseController {

    private final ExpenseDao expenseDao;
    private final PlaceDao placeDao;

    @Autowired
    public ExpenseCatController(ExpenseDao expenseDao, PlaceDao placeDao) {
        this.expenseDao = expenseDao;
        this.placeDao = placeDao;
    }

    @RequestMapping(method = RequestMethod.GET, value = "/balanz/expenseCatList")
    public String expenseCatList(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(expenseDao.canWorkWithExpenseCategory(rps.getLoginUser().getUserID())) {
            model.addAttribute("expenseDao", expenseDao);
            return "expenseCatList";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/balanz/newExpenseCat", method = {RequestMethod.GET, RequestMethod.POST})
    public String newExpenseCat(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(expenseDao.canWorkWithExpenseCategory(rps.getLoginUser().getUserID())) {
            model.addAttribute("expenseDao", expenseDao);
            model.addAttribute("placeDao", placeDao);
            return "newExpenseCat";
        }

        return "redirect:/index?err=permission";
    }
}
