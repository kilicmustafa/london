package com.rheinlandprivatschule.controller;

import com.rheinlandprivatschule.model.Student;
import com.rheinlandprivatschule.repository.BildTraker;
import com.rheinlandprivatschule.repository.RPS;
import com.rheinlandprivatschule.repository.StudentDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;


import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

@Controller
public class StudentVertragController {

    private final StudentDao studentDao;

    @Autowired
    public StudentVertragController(StudentDao studentDao) {
        this.studentDao = studentDao;
    }


    @RequestMapping(method = RequestMethod.GET, value = "/vertrag/attachVertrag")
    public String getAttachBilder(HttpServletRequest request, Model model) {
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        Student student = ((Student) request.getSession().getAttribute("pstudent"));

        model.addAttribute("student", student);
        model.addAttribute("vertrags", studentDao.downloadVertrag(student.getUserID(), rps.getLoginUser().getUserID()));
        return "attachVertragStudent";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/vertrag/attachVertrag")
    public String postAttachBilder(HttpServletRequest request,
                                   @RequestParam("fileName") MultipartFile file) {

        if (!file.isEmpty()) {
            Student student = (Student) request.getSession().getAttribute("pstudent");
            RPS rps = (RPS) request.getSession().getAttribute("handler");
            try {
                byte[] bytes = file.getBytes();
                // Creating the directory to store file
                String rootPath = System.getProperty("catalina.home");
                File dir = new File("/opt/tomcat7/webapps/servlet/vertrag" + File.separator + student.getUserID());
                if (!dir.exists())
                    dir.mkdirs();

                // Create the file on server
                File serverFile = new File(dir.getAbsolutePath()
                        + File.separator + file.getOriginalFilename());
                BufferedOutputStream stream = new BufferedOutputStream(
                        new FileOutputStream(serverFile));
                stream.write(bytes);
                stream.close();

                studentDao.uploadVertrag(student.getUserID(), file.getOriginalFilename(), rps.getLoginUser().getUserID());

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                return "redirect:/vertrag/attachVertrag";
            }
        } else {
            return "redirect:/vertrag/attachVertrag";
        }

    }

    @RequestMapping(method = RequestMethod.GET, value = "/vertrag/vertrag")
    public void image(HttpServletResponse response, @RequestParam("userId") String userId, @RequestParam("ver") String ver) {
        try {
            byte[] bytes = Files.readAllBytes(Paths.get("/opt/tomcat7/webapps/servlet/vertrag" + File.separator + userId
                    + File.separator + ver));

            ServletOutputStream sos = response.getOutputStream();
            sos.write(bytes);
            sos.flush();
            sos.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(method = RequestMethod.GET, value = "/vertrag/deleteVertrag")
    public String deleteBilder(HttpServletRequest request) {
        Student student = (Student) request.getSession().getAttribute("pstudent");
        try {
            Files.delete(Paths.get("/opt/tomcat7/webapps/servlet/vertrag" + File.separator + student.getUserID()
                    + File.separator + request.getParameter("ver")));
        } catch (IOException e) {
            e.printStackTrace();
            return "redirect:/vertrag/attachVertrag?err=exception";
        }
        return "redirect:/vertrag/attachVertrag";
    }
}
