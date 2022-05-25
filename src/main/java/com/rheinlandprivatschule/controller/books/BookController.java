package com.rheinlandprivatschule.controller.books;

import com.rheinlandprivatschule.controller.BaseController;
import com.rheinlandprivatschule.repository.BuchDao;
import com.rheinlandprivatschule.repository.PlaceDao;
import com.rheinlandprivatschule.repository.RPS;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

@Controller
public class BookController extends BaseController {

    private final BuchDao buchDao;
    private final PlaceDao placeDao;

    @Autowired
    public BookController(BuchDao buchDao, PlaceDao placeDao, PlaceDao placeDao1) {
        this.buchDao = buchDao;
        this.placeDao = placeDao1;
    }

    @RequestMapping(value = "/books/bookTra", method = { RequestMethod.GET, RequestMethod.POST })
    public String bookTra(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(buchDao.canBookSale(rps.getLoginUser().getUserID())) {
            model.addAttribute("buchDao", buchDao);
            return "booksBookTra";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/books/booksStockP")
    public String booksStockP(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(buchDao.canSeeBookinStock(rps.getLoginUser().getUserID())) {
            model.addAttribute("buchDao", buchDao);
            model.addAttribute("placeDao", placeDao);
            return "booksStockP";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/books/schuleStock", method = { RequestMethod.GET, RequestMethod.POST })
    public String schuleStock(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(buchDao.canSeeBookinCity(rps.getLoginUser().getUserID())) {
            model.addAttribute("buchDao", buchDao);
            model.addAttribute("placeDao", placeDao);
            return "schuleStock";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/books/schuleshift", method = { RequestMethod.GET, RequestMethod.POST })
    public String schuleshift(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(buchDao.canBooksFreigabe(rps.getLoginUser().getUserID())) {
            model.addAttribute("buchDao", buchDao);
            model.addAttribute("placeDao", placeDao);
            return "schuleshift";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/books/addBook", method = { RequestMethod.GET, RequestMethod.POST })
    public String addBook(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(buchDao.canAddNewBook(rps.getLoginUser().getUserID())) {
            model.addAttribute("buchDao", buchDao);
            model.addAttribute("placeDao", placeDao);
            return "addBook";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/books/addBookProcess", method = { RequestMethod.GET, RequestMethod.POST })
    public String addBookProcess(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(buchDao.canAddNewBook(rps.getLoginUser().getUserID())) {
            model.addAttribute("buchDao", buchDao);
            return "addBookProcess";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/books/bookList", method = { RequestMethod.GET, RequestMethod.POST })
    public String bookList(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(buchDao.canBooksEingang(rps.getLoginUser().getUserID())) {
            model.addAttribute("buchDao", buchDao);
            return "bookList";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/books/booksStock", method = { RequestMethod.GET, RequestMethod.POST })
    public String booksStock(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(buchDao.canSearchBook(rps.getLoginUser().getUserID())) {
            model.addAttribute("buchDao", buchDao);
            model.addAttribute("placeDao", placeDao);
            return "booksStock";
        }

        return "redirect:/index?err=permission";
    }
}
