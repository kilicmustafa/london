package com.rheinlandprivatschule.controller.drive;

import com.rheinlandprivatschule.controller.BaseController;
import com.rheinlandprivatschule.helper.FileManage;
import com.rheinlandprivatschule.repository.RPS;
import org.apache.commons.io.IOUtils;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;

@Controller
public class DriveController extends BaseController {

    private FileManage fileManage;

    public DriveController() {
        fileManage = new FileManage();
    }

    @RequestMapping(method = RequestMethod.GET, value = "/drive/driveControler")
    public String driveControler(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(fileManage.canWorkWithFilesSystem(rps.getLoginUser().getUserID())) {
            model.addAttribute("fileManage", fileManage);
            return "driveControler";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/drive/renameFolder", method = {RequestMethod.GET, RequestMethod.POST})
    public String renameFolder(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(fileManage.canWorkWithFilesSystem(rps.getLoginUser().getUserID())) {
            model.addAttribute("fileManage", fileManage);
            return "renameFolder";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/drive/newFolder", method = {RequestMethod.GET, RequestMethod.POST})
    public String newFolder(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(fileManage.canWorkWithFilesSystem(rps.getLoginUser().getUserID())) {
            model.addAttribute("fileManage", fileManage);
            return "newFolder";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/drive/deleteFolder", method = {RequestMethod.GET, RequestMethod.POST})
    public String deleteFolder(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(fileManage.canWorkWithFilesSystem(rps.getLoginUser().getUserID())) {
            model.addAttribute("fileManage", fileManage);
            return "deleteFolder";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/drive/deleteFile", method = {RequestMethod.GET, RequestMethod.POST})
    public String deleteFile(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(fileManage.canWorkWithFilesSystem(rps.getLoginUser().getUserID())) {
            model.addAttribute("fileManage", fileManage);
            return "deleteFile";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/drive/upload", method = {RequestMethod.GET})
    public String upload(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(fileManage.canWorkWithFilesSystem(rps.getLoginUser().getUserID())) {
            model.addAttribute("fileManage", fileManage);
            return "upload";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/drive/upload", method = {RequestMethod.POST})
    public String uploadPost(HttpServletRequest request, @RequestParam("fileName") MultipartFile file) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        String cmd= request.getParameter("cmd");
        if(fileManage.canWorkWithFilesSystem(rps.getLoginUser().getUserID()) && cmd.equalsIgnoreCase("r")){
            byte[] bytes = new byte[0];
            try {
                bytes = file.getBytes();
            } catch (IOException e) {
                e.printStackTrace();
            }

            String path=(String)request.getSession().getAttribute("HmyPath");
            String folder=(String)request.getSession().getAttribute("Hfolder");

            String rel=path+"/"+folder;
            String rootPath = System.getProperty("catalina.home");
            File dir = new File(rel);
            System.out.println("File upload path: " + rel);
            if (!dir.exists())
                dir.mkdirs();

            // Create the file on server
            File serverFile = new File(dir.getAbsolutePath()
                    + File.separator + file.getOriginalFilename());
            BufferedOutputStream stream = null;
            try {
                stream = new BufferedOutputStream(
                        new FileOutputStream(serverFile));
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            }

            try {
                stream.write(bytes);
                stream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
            return "redirect:/drive/upload?cmd=r";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/drive/drives", method = RequestMethod.GET)
    public void getFile(HttpServletRequest request, HttpServletResponse response, @SessionAttribute("handler") RPS rps) {


        if(fileManage.canWorkWithFilesSystem(rps.getLoginUser().getUserID())) {
            try {
                byte[] bytes = Files.readAllBytes(Paths.get("/opt/tomcat7/webapps/servlet/drive/" + File.separator + request.getParameter("filePath")));
                String[] splittedPath = request.getParameter("filePath").split("/");
                response.setContentType("application/x-download");
                response.setHeader("Content-Disposition", "attachment;filename=" + splittedPath[splittedPath.length - 1]);
                BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
                bos.write(bytes);
                bos.flush();
                bos.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
