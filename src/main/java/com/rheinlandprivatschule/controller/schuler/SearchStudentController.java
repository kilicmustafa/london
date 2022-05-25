package com.rheinlandprivatschule.controller.schuler;

import com.rheinlandprivatschule.controller.BaseController;
import com.rheinlandprivatschule.model.Student;
import com.rheinlandprivatschule.model.SystemUser;
import com.rheinlandprivatschule.repository.RPS;
import com.rheinlandprivatschule.repository.StudentDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;

@Controller
public class SearchStudentController extends BaseController {

    private final StudentDao studentDao;

    @Autowired
    public SearchStudentController(StudentDao studentDao) {
        this.studentDao = studentDao;
    }

    @RequestMapping(method = RequestMethod.POST, value = "/schuler/searchStudent")
    public String searchStudent(HttpServletRequest request, Model model) {
        if(loginStatement(request)) {
            return "redirect:/";
        }
        ArrayList<Student> students = new ArrayList<>();
        int placeID=0;
        int criterion=1;
        int recentStu =0;


        String criterionString="1";
        String keyWord="";
        String alle=null;
        String birthday="1";
        String birthmonth="1";
        String birthyear="1950";
        String recent =null;
        int max = 0;

        Student stu = studentDao.getMaxStudentID();
        max = stu.getUserID();

        criterionString=(String)request.getParameter("selCriteria");

        if(criterionString!=null){
            keyWord=(String)request.getParameter("txtKeyWord");
            alle=(String)request.getParameter("alle");
            recent=(String)request.getParameter("recent");
            birthday=(String)request.getParameter("selDay");;
            birthmonth=(String)request.getParameter("selMonth");
            birthyear=(String)request.getParameter("selYear");
        }else{
            criterionString="1";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        SystemUser systemUser = rps.getLoginUser();
        placeID=rps.getLoginPlace().getPlaceID();

        String same=request.getParameter("same");
        if(same!=null){
            keyWord=request.getParameter("txtKeyWord");
            boolean serachForIDFlag=false;
            int searchForStudentID=0;
            try{
                searchForStudentID=Integer.parseInt(keyWord);
                serachForIDFlag=true;
            }catch(Exception searchStudentExc){
                serachForIDFlag=false;
            }

            if(serachForIDFlag){
                Student stTemp=studentDao.getStudentForSearch(searchForStudentID,rps.getLoginUser().getUserID());
                if(stTemp.getUserID()>0){
                    students.add(stTemp);
                    return "redirect:/showStudentPreciseD?userid="+stTemp.getUserID();
                }
            }else{
                criterionString=(String)request.getParameter("selCriteria");
                try{
                    criterion=Integer.parseInt(criterionString);
                }catch(Exception ignored){
                }

                alle=request.getParameter("alle");
                birthday=(String)request.getParameter("selDay");
                birthmonth=(String)request.getParameter("selMonth");
                birthyear=(String)request.getParameter("selYear");
                if(alle!=null){
                    placeID=0;
                }
                if(recent!=null){
                    recentStu=max - 1000;
                }
                if (recent==null){
                    recentStu=0;
                }
                if(criterion == studentDao.DATEOFBIRTH){
                    keyWord=birthyear+"-"+birthmonth+"-"+birthday;
                }
                students=studentDao.getStudentsByCriteria(criterion,keyWord,placeID,rps.getLoginUser().getUserID(), recentStu);
            }
        }else{
            students=studentDao.getStudentsByCriteria(criterion,keyWord,placeID,rps.getLoginUser().getUserID(),recentStu);
        }
        model.addAttribute("students", students);
        return "searchresult";
    }
}
