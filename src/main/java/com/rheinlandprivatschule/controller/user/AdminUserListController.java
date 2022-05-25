package com.rheinlandprivatschule.controller.user;

import com.rheinlandprivatschule.controller.BaseController;
import com.rheinlandprivatschule.model.Buch;
import com.rheinlandprivatschule.model.SystemUser;
import com.rheinlandprivatschule.model.UserCategory;
import com.rheinlandprivatschule.repository.*;
import com.rheinlandprivatschule.viewmodel.AdminRemarkViewModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;


import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
public class AdminUserListController extends BaseController {

    private final SystemUserDao systemUserDao;
    private final BookDao bookDao;
    private final BuchDao buchDao;
    private final StudentDao studentDao;

    @Autowired
    public AdminUserListController(SystemUserDao systemUserDao, BookDao bookDao, BuchDao buchDao, StudentDao studentDao) {
        this.systemUserDao = systemUserDao;
        this.bookDao = bookDao;
        this.buchDao = buchDao;
        this.studentDao = studentDao;
    }

    @RequestMapping(value = "/user/adminUserList", method = {RequestMethod.GET, RequestMethod.POST})
    public String adminUserList(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(systemUserDao.canSeeGeneralCategoryUsers(rps.getLoginUser().getUserID())) {
            List<UserCategory> userCategories = bookDao.getAllCategoryByOwner(0);
            String cmdS=request.getParameter("cmd");
            int selectedCat = 0, loginUserType;
            if(cmdS != null) {
                if(cmdS.equalsIgnoreCase("set")){
                    String selectedCatS=request.getParameter("selectCat");
                    selectedCat=Integer.parseInt(selectedCatS);
                }
            }
            loginUserType = rps.getLoginUser().getUserType();
            List<SystemUser> systemUsers;
            if(selectedCat == 0) {
                systemUsers = systemUserDao.getAllSystemUser(selectedCat);
            } else {
                systemUsers = bookDao.getAllUserByCategory(selectedCat);
            }
            model.addAttribute("systemUsers", systemUsers);
            model.addAttribute("loginUserType", loginUserType);
            model.addAttribute("selectedCat", selectedCat);
            model.addAttribute("userCategories", userCategories);
        }

        return "adminUserList";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/user/adminRemarksF")
    public String adminRemarksF(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");

        if(systemUserDao.canSeeGeneralCategoryUsers(rps.getLoginUser().getUserID())) {
            PreviligeManager pm=new PreviligeManager();
            boolean befugnis =pm.isBefugnisAllowed(rps.getLoginUser().getUserID());
            String adminid= request.getParameter("adminid");

            if(adminid == null) {
                return "redirect:/?err=missingparameters";
            }
            SystemUser systemUser = systemUserDao.getSystemUser(Integer.parseInt(adminid));
            request.getSession().setAttribute("puser", systemUser);
            AdminRemarkViewModel adminRemarkViewModel = new AdminRemarkViewModel(systemUser);
            adminRemarkViewModel.setUserType(systemUserDao.getAllUserTypes());
            adminRemarkViewModel.setUserCategoryName(bookDao.getAllCategoryByOwner(0), bookDao.getUserCategory(systemUser.getUserID()));
            adminRemarkViewModel.setBucher(buchDao.getBooksSaledToStudent(systemUser.getUserID(), 1));
            model.addAttribute("befugnis", befugnis);
            model.addAttribute(adminRemarkViewModel);
            // TODO: resim kısmını yap
        }

        return "adminRemarksF";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/user/bookTra")
    public String bookTra(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        SystemUser systemUser = (SystemUser) request.getSession().getAttribute("puser");
        model.addAttribute("userid", systemUser.getUserID());
        return "bookTra";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/user/bookTra")
    public String bookTraProcess(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(studentDao.saleBooks(rps.getLoginUser().getUserID())) {
            List<String> books = (List<String>) request.getSession().getAttribute("booktrag");
            if(books == null) {
                books = new ArrayList<>();
            }
            String ano= request.getParameter("id");
            if(ano != null) {
                int anoN = Integer.parseInt(ano);
                boolean chk=buchDao.isBookForSale(anoN,rps.getLoginPlace().getPlaceID());
                if(chk) {
                    boolean track=true;
                    for(int i=0;i<books.size();i++)	{
                        int temp=Integer.parseInt(books.get(i));
                        if(temp==anoN)
                        {
                            track=false;
                        }
                    }
                    if(track){
                        books.add(""+anoN);
                        request.getSession().setAttribute("booktrag",books);
                    }
                } else {
                    return "redirect:/user/bookTra?err="+buchDao.getError();
                }
            } /*else {
                String cmd= request.getParameter("cmd");
                if(cmd!=null){
                    request.getSession().setAttribute("booktrag",books);
                }
            }*/
            List<Buch> bookList = new ArrayList<>();
            for (String s : books) {
                bookList.add(buchDao.getBookForSale(Integer.parseInt(s)));
            }
            request.getSession().setAttribute("booktrag",bookList);
        } else {
            return "redirect:/user/bookTra?err="+studentDao.getError();
        }

        return "bookTra";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/user/removebook")
    public String removeBook(HttpServletRequest request) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        int bookId = Integer.parseInt(request.getParameter("bid"));
        List<Buch> bookList = (List<Buch>) request.getSession().getAttribute("booktrag");
        for (int i = 0; i < bookList.size(); i++) {
            if(bookList.get(i).getBookTrack() == bookId) {
                bookList.remove(i);
            }
        }

        request.getSession().setAttribute("booktrag", bookList);
        return "redirect:/user/bookTra";
    }
}
