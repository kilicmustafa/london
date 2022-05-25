package com.rheinlandprivatschule.controller.courses;

import com.rheinlandprivatschule.model.Course;
import com.rheinlandprivatschule.repository.CourseDao;
import com.rheinlandprivatschule.repository.RPS;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;

@Controller
public class CourseVertragController {

    private final CourseDao courseDao;

    @Autowired
    public CourseVertragController(CourseDao courseDao) {
        this.courseDao = courseDao;
    }

    @GetMapping("/CourseVertrag/attachVertrag")
    public String attachVertrag(Model model) {

        model.addAttribute("cdb", courseDao);
        return "attachVertrag";
    }

    @PostMapping("/CourseVertrag/attachVertrag")
    public String attachVertragPOST(HttpServletRequest request,
                                    @RequestParam("fileName") MultipartFile file) {

        if (!file.isEmpty()) {
            try {
                byte[] bytes = file.getBytes();
                // Creating the directory to store file
                Course course=(Course)request.getSession().getAttribute("pstudent");
                File dir = new File("/opt/tomcat7/webapps/servlet" + File.separator + "CourseVertrag" + File.separator + course.getCourseID());
                if (!dir.exists())
                    dir.mkdirs();

                // Create the file on server
                File serverFile = new File(dir.getAbsolutePath()
                        + File.separator + file.getOriginalFilename());
                BufferedOutputStream stream = new BufferedOutputStream(
                        new FileOutputStream(serverFile));
                stream.write(bytes);
                stream.close();

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                return "redirect:/CourseVertrag/attachVertrag";
            }
        } else {
            return "redirect:/CourseVertrag/attachVertrag";
        }
    }
}
