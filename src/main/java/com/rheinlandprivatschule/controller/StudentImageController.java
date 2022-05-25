package com.rheinlandprivatschule.controller;

import com.rheinlandprivatschule.model.Student;
import com.rheinlandprivatschule.repository.BildTraker;
import com.rheinlandprivatschule.repository.RPS;
import com.rheinlandprivatschule.repository.StudentDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;


import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

@Controller
public class StudentImageController {

    private final StudentDao studentDao;
    private final BildTraker bildTraker;

    @Autowired
    public StudentImageController(StudentDao studentDao, BildTraker bildTraker) {
        this.studentDao = studentDao;
        this.bildTraker = bildTraker;
    }


    @RequestMapping(method = RequestMethod.GET, value = "/studentBilder/attachBilder")
    public String getAttachBilder(HttpServletRequest request, Model model) {
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        Student student = ((Student) request.getSession().getAttribute("pstudent"));

        model.addAttribute("student", student);
        model.addAttribute("vertrags", studentDao.downloadBilder(student.getUserID(), rps.getLoginUser().getUserID()));
        return "attachBilder";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/studentBilder/attachBilder")
    public String postAttachBilder(HttpServletRequest request,
                                   @RequestParam("fileName") MultipartFile file) {

        if (!file.isEmpty()) {
            Student student = (Student) request.getSession().getAttribute("pstudent");
            RPS rps = (RPS) request.getSession().getAttribute("handler");
            try {
                byte[] bytes = file.getBytes();
                // Creating the directory to store file
                String rootPath = System.getProperty("catalina.home");
                File dir = new File("/opt/tomcat7/webapps/servlet/studentBilder" + File.separator + student.getUserID());
                if (!dir.exists())
                    dir.mkdirs();

                // Create the file on server
                File serverFile = new File(dir.getAbsolutePath()
                        + File.separator + file.getOriginalFilename());
                BufferedOutputStream stream = new BufferedOutputStream(
                        new FileOutputStream(serverFile));
                stream.write(bytes);
                stream.close();

                studentDao.uploadBilder(student.getUserID(), file.getOriginalFilename(), rps.getLoginUser().getUserID());

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                return "redirect:/studentBilder/attachBilder";
            }
        } else {
            return "redirect:/studentBilder/attachBilder";
        }

    }

    @RequestMapping(method = RequestMethod.GET, value = "/studentBilder/image")
    public void image(HttpServletResponse response, HttpServletRequest request) {
        Student student = (Student) request.getSession().getAttribute("pstudent");
        try {
            byte[] bytes = Files.readAllBytes(Paths.get("/opt/tomcat7/webapps/servlet/studentBilder" + File.separator + student.getUserID()
                    + File.separator + request.getParameter("ver")));

            BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
            bos.write(bytes);
            bos.flush();
            bos.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(method = RequestMethod.GET, value = "/studentBilder/deleteBilder")
    public String deleteBilder(HttpServletRequest request) {
        Student student = (Student) request.getSession().getAttribute("pstudent");
        try {
            Files.delete(Paths.get("/opt/tomcat7/webapps/servlet/studentBilder" + File.separator + student.getUserID()
                    + File.separator + request.getParameter("ver")));
            bildTraker.deleteBild(student.getUserID(), Integer.parseInt(request.getParameter("cmd")));
        } catch (IOException e) {
            e.printStackTrace();
            return "redirect:/studentBilder/attachBilder?err=exception";
        }
        return "redirect:/studentBilder/attachBilder";
    }
}
