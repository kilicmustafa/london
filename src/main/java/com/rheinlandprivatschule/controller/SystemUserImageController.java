package com.rheinlandprivatschule.controller;

import com.rheinlandprivatschule.model.SystemUser;
import com.rheinlandprivatschule.repository.RPS;
import com.rheinlandprivatschule.repository.SystemUserBildTraker;
import com.rheinlandprivatschule.repository.SystemUserDao;
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
public class SystemUserImageController {

    private final SystemUserDao systemUserDao;
    private final SystemUserBildTraker systemUserBildTraker;

    @Autowired
    public SystemUserImageController(SystemUserDao systemUserDao, SystemUserBildTraker systemUserBildTraker) {
        this.systemUserDao = systemUserDao;
        this.systemUserBildTraker = systemUserBildTraker;
    }

    @RequestMapping(method = RequestMethod.GET, value = "/systemUserBilder/attachBilder")
    public String getAttachBilder(HttpServletRequest request, Model model) {
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        SystemUser systemUser = ((SystemUser) request.getSession().getAttribute("puser"));

        model.addAttribute("systemUser", systemUser);
        model.addAttribute("vertrags", systemUserDao.downloadBilder(systemUser.getUserID(), rps.getLoginUser().getUserID()));
        return "attachSystemUserBilder";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/systemUserBilder/attachBilder")
    public String postAttachBilder(HttpServletRequest request,
                                   @RequestParam("fileName") MultipartFile file) {

        if (!file.isEmpty()) {
            SystemUser systemUser = (SystemUser) request.getSession().getAttribute("puser");
            RPS rps = (RPS) request.getSession().getAttribute("handler");
            try {
                byte[] bytes = file.getBytes();
                // Creating the directory to store file
                String rootPath = System.getProperty("catalina.home");
                File dir = new File(rootPath + File.separator + "systemUserBilder" + File.separator + systemUser.getUserID());
                if (!dir.exists())
                    dir.mkdirs();

                // Create the file on server
                File serverFile = new File(dir.getAbsolutePath()
                        + File.separator + file.getOriginalFilename());
                BufferedOutputStream stream = new BufferedOutputStream(
                        new FileOutputStream(serverFile));
                stream.write(bytes);
                stream.close();

                systemUserDao.uploadBilder(systemUser.getUserID(), file.getOriginalFilename(), rps.getLoginUser().getUserID());

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                return "redirect:/systemUserBilder/attachBilder";
            }
        } else {
            return "redirect:/systemUserBilder/attachBilder";
        }

    }

    @RequestMapping(method = RequestMethod.GET, value = "/systemUserBilder/image")
    public void image(HttpServletResponse response, HttpServletRequest request) {
        SystemUser systemUser = (SystemUser) request.getSession().getAttribute("puser");
        try {
            byte[] bytes = Files.readAllBytes(Paths.get(System.getProperty("catalina.home") + File.separator + "systemUserBilderf" + File.separator + systemUser.getUserID()
                    + File.separator + request.getParameter("ver")));

            BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
            bos.write(bytes);
            bos.flush();
            bos.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(method = RequestMethod.GET, value = "/systemUserBilder/deleteBilder")
    public String deleteBilder(HttpServletRequest request) {
        SystemUser systemUser = (SystemUser) request.getSession().getAttribute("puser");
        try {
            Files.delete(Paths.get(System.getProperty("catalina.home") + File.separator + "systemUserBilder" + File.separator + systemUser.getUserID()
                    + File.separator + request.getParameter("cmd")));
            systemUserBildTraker.deleteBild(systemUser.getUserID(), request.getParameter("cmd"));
        } catch (IOException e) {
            e.printStackTrace();
            return "redirect:/systemUserBilder/attachBilder?err=exception";
        }
        return "redirect:/systemUserBilder/attachBilder";
    }
}
