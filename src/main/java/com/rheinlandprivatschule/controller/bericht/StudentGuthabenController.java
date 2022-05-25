package com.rheinlandprivatschule.controller.bericht;

import com.rheinlandprivatschule.controller.BaseController;
import com.rheinlandprivatschule.helper.MyCurrency;
import com.rheinlandprivatschule.helper.MyDate;
import com.rheinlandprivatschule.model.SingleClassBalance;
import com.rheinlandprivatschule.model.Student;
import com.rheinlandprivatschule.repository.RPS;
import com.rheinlandprivatschule.repository.SingleClassDao;
import com.rheinlandprivatschule.repository.StudentDao;
import com.rheinlandprivatschule.repository.TransactionDao;
import com.rheinlandprivatschule.viewmodel.StudentGuthabenViewModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
public class StudentGuthabenController extends BaseController {

    private final StudentDao studentDao;
    private final SingleClassDao singleClassDao;
    private final TransactionDao transactionDao;

    @Autowired
    public StudentGuthabenController(StudentDao studentDao, SingleClassDao singleClassDao, TransactionDao transactionDao) {
        this.studentDao = studentDao;
        this.singleClassDao = singleClassDao;
        this.transactionDao = transactionDao;
    }

    @RequestMapping(method = RequestMethod.GET, value = "/bericht/showStudentGuthaben")
    public String showStudentGuthaben(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(transactionDao.canSeeSingleClassNochOffen(rps.getLoginUser().getUserID())) {
            List<SingleClassBalance> allu = singleClassDao.getStudentWithMinusGuthaben();

            List<StudentGuthabenViewModel> studentGuthabenViewModels = new ArrayList<>();
            double total = 0;
            for(SingleClassBalance singleClassBalance : allu) {
                Student student = studentDao.getStudentForSubProcess(singleClassBalance.getStudentID());
                studentGuthabenViewModels.add(new StudentGuthabenViewModel(
                        singleClassBalance,
                        student,
                        MyDate.formateDate(student.getUserBirthDate(),MyDate.NUMERIC,MyDate.DEUTSCH),
                        MyCurrency.getDisplayString(singleClassBalance.getBalance())
                ));
                total += singleClassBalance.getBalance();
            }

            model.addAttribute("studentGuthabenViewModels", studentGuthabenViewModels);
            model.addAttribute("total", MyCurrency.getDisplayString(total));
        } else {
            return "redirect:/index?err=permission";
        }

        return "showStudentGuthaben";
    }
}
