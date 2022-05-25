package com.rheinlandprivatschule.controller.schuler;


import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.rheinlandprivatschule.model.Certificate;
import com.rheinlandprivatschule.model.Course;
import com.rheinlandprivatschule.model.QRCodeInformation;
import com.rheinlandprivatschule.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.*;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.awt.image.DataBufferByte;
import java.io.BufferedOutputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

@Controller
public class FeeController {

    private final StudentDao studentDao;
    private final MahnungDao mahnungDao;
    private final CourseDao courseDao;
    private final QRCodeDao qrCodeDao;

    @Autowired
    public FeeController(StudentDao studentDao, MahnungDao mahnungDao, CourseDao courseDao, QRCodeDao qrCodeDao) {
        this.studentDao = studentDao;
        this.mahnungDao = mahnungDao;
        this.courseDao = courseDao;
        this.qrCodeDao = qrCodeDao;
    }

    @GetMapping("/schuler/showFeeDetail")
    public String showFeeDetail(@SessionAttribute("handler") RPS rps, Model model) {
        if(!studentDao.canSeeCourseRegistration(rps.getLoginUser().getUserID())) {
            return "redirect:/index?err=permission";
        }
        model.addAttribute("studentDao", studentDao);
        model.addAttribute("courseDao", courseDao);
        model.addAttribute("mahnungDao", mahnungDao);
        return "showFeeDetail";
    }

    @PostMapping("/schuler/updateFee")
    public String updateFee(Model model) {
        model.addAttribute("studentDao", studentDao);
        return "updateFee";
    }

    @GetMapping("/schuler/nov")
    public String nov() {
        return "nov";
    }

    @RequestMapping(value = "/schuler/mahnungdatum", method = { RequestMethod.GET, RequestMethod.POST })
    public String mahnungDatum(@SessionAttribute("handler") RPS rps, Model model) {
        if(!studentDao.canBlockMahnung(rps.getLoginUser().getUserID())) {
            return "redirect:/index?err=permission";
        }
        model.addAttribute("mahnungDao", mahnungDao);
        return "mahnungdatum";
    }

    @RequestMapping(value = "/schuler/changeCourse", method = { RequestMethod.GET, RequestMethod.POST })
    public String changeCourse(@SessionAttribute("handler") RPS rps, Model model) {
        if(!studentDao.canChangeCourse(rps.getLoginUser().getUserID())) {
            return "redirect:/index?err=permission";
        }
        model.addAttribute("courseDao", courseDao);
        return "changeCourse";
    }

    @RequestMapping(value = "/schuler/changeCourseP", method = { RequestMethod.GET, RequestMethod.POST })
    public String changeCourseP(@SessionAttribute("handler") RPS rps, Model model) {
        if(!studentDao.canChangeCourse(rps.getLoginUser().getUserID())) {
            return "redirect:/index?err=permission";
        }
        model.addAttribute("studentDao", studentDao);
        return "changeCourseP";
    }

    @RequestMapping(value = "/schuler/changeCourseAfterPlan", method = { RequestMethod.GET, RequestMethod.POST })
    public String changeCourseAfterPlan(@SessionAttribute("handler") RPS rps, Model model) {
        if(!studentDao.canChangeCourse(rps.getLoginUser().getUserID())) {
            return "redirect:/index?err=permission";
        }
        model.addAttribute("courseDao", courseDao);
        model.addAttribute("studentDao", studentDao);
        return "changeCourseAfterPlan";
    }

    @RequestMapping(value = "/schuler/noa", method = { RequestMethod.GET, RequestMethod.POST })
    public String noa(Model model) {
        model.addAttribute("studentDao", studentDao);
        return "noa";
    }

    @RequestMapping(value = "/schuler/printRegistration", method = { RequestMethod.GET, RequestMethod.POST })
    public String printRegistration(Model model) {
        model.addAttribute("studentDao", studentDao);
        return "printRegistration";
    }

    @RequestMapping(value = "/schuler/noaIntegration", method = { RequestMethod.GET, RequestMethod.POST })
    public String noaIntegration(Model model) {
        model.addAttribute("studentDao", studentDao);
        return "noaIntegration";
    }

    @RequestMapping(value = "/schuler/printIntegrationReg", method = { RequestMethod.GET, RequestMethod.POST })
    public String printIntegrationReg(Model model) {
        model.addAttribute("studentDao", studentDao);
        return "printIntegrationReg";
    }

    @RequestMapping(value = "/schuler/teil", method = { RequestMethod.GET, RequestMethod.POST })
    public String teil() {
        return "teil";
    }

    @RequestMapping(value = "/schuler/printTeilnahme", method = { RequestMethod.GET, RequestMethod.POST })
    public String printTeilnahme(Model model) {
        model.addAttribute("studentDao", studentDao);
        return "printTeilnahme";
    }

    @RequestMapping(value = "/schuler/teilT", method = { RequestMethod.GET, RequestMethod.POST })
    public String teilT() {
        return "teilT";
    }

    @RequestMapping(value = "/schuler/printTeilnahmeT", method = { RequestMethod.GET, RequestMethod.POST })
    public String printTeilnahmeT(Model model) {
        model.addAttribute("studentDao", studentDao);
        return "printTeilnahmeT";
    }

    @RequestMapping(value = "/schuler/teilM", method = { RequestMethod.GET, RequestMethod.POST })
    public String teilM() {
        return "teilM";
    }

    @RequestMapping(value = "/schuler/printTeilnahmeM", method = { RequestMethod.GET, RequestMethod.POST })
    public String printTeilnahmeM(Model model) {
        model.addAttribute("studentDao", studentDao);
        return "printTeilnahmeM";
    }

    @RequestMapping(value = "/schuler/teilW", method = { RequestMethod.GET, RequestMethod.POST })
    public String teilW() {
        return "teilW";
    }

    @RequestMapping(value = "/schuler/printTeilnahmeW", method = { RequestMethod.GET, RequestMethod.POST })
    public String printTeilnahmeW(Model model) {
        model.addAttribute("studentDao", studentDao);
        return "printTeilnahmeW";
    }

    @RequestMapping(value = "/schuler/teilG", method = { RequestMethod.GET, RequestMethod.POST })
    public String teilG() {
        return "teilG";
    }

    @RequestMapping(value = "/schuler/printTeilnahmeG", method = { RequestMethod.GET, RequestMethod.POST })
    public String printTeilnahmeG(Model model) {
        model.addAttribute("studentDao", studentDao);
        return "printTeilnahmeG";
    }

    @RequestMapping(value = "/schuler/deleteRegis", method = { RequestMethod.GET, RequestMethod.POST })
    public String deleteRegis(@SessionAttribute("handler") RPS rps, Model model) {
        if(!studentDao.canDeleteRegistration(rps.getLoginUser().getUserID())) {
            return "redirect:/index?err=permission";
        }
        model.addAttribute("studentDao", studentDao);
        return "deleteRegis";
    }

    @RequestMapping(value = "/schuler/nullgeb", method = { RequestMethod.GET, RequestMethod.POST })
    public String nullgeb(@SessionAttribute("handler") RPS rps, Model model) {
        if(!studentDao.canMakeNullFee(rps.getLoginUser().getUserID())) {
            return "redirect:/index?err=permission";
        }
        model.addAttribute("studentDao", studentDao);
        return "nullgeb";
    }

    @RequestMapping(value = "/schuler/mahnnom", method = { RequestMethod.GET, RequestMethod.POST })
    public String nullgeb(Model model) {
        model.addAttribute("mahnungDao", mahnungDao);
        return "mahnnom";
    }

    @RequestMapping(value = "/schuler/printMahnung", method = { RequestMethod.GET, RequestMethod.POST })
    public String printMahnung(Model model) {
        model.addAttribute("studentDao", studentDao);
        model.addAttribute("courseDao", courseDao);
        return "printMahnungSchuler";
    }

    @RequestMapping(value = "/schuler/cerInput", method = { RequestMethod.GET, RequestMethod.POST })
    public String cerInput() {
        return "cerInput";
    }

    @RequestMapping(value = "/schuler/cerInputOnline", method = { RequestMethod.GET, RequestMethod.POST })
    public String cerInputOnline() {
        return "cerInputOnline";
    }

    @RequestMapping(value = "/schuler/verifyCert", method = { RequestMethod.GET, RequestMethod.POST })
    public String verifyCert(Model model) {
        model.addAttribute("studentDao", studentDao);
        return "verifyCert";
    }

    @RequestMapping(value = "/schuler/verifyCertOnline", method = { RequestMethod.GET, RequestMethod.POST })
    public String verifyCertOnline(Model model) {
        model.addAttribute("studentDao", studentDao);
        return "verifyCertOnline";
    }

    @RequestMapping(value = "/schuler/cerNPInput", method = { RequestMethod.GET, RequestMethod.POST })
    public String cerNPInput() {
        return "cerNPInput";
    }

    @RequestMapping(value = "/schuler/verifyCertNP", method = { RequestMethod.GET, RequestMethod.POST })
    public String verifyCertNP(Model model) {
        model.addAttribute("studentDao", studentDao);
        return "verifyCertNP";
    }

    @RequestMapping(value = "/schuler/noceronline", method = { RequestMethod.GET, RequestMethod.POST })
    public String noceronline() {
        return "noceronline";
    }

    @RequestMapping(value = "/schuler/nocer", method = { RequestMethod.GET, RequestMethod.POST })
    public String nocer() {
        return "nocer";
    }

    @RequestMapping(value = "/schuler/printCertificate", method = { RequestMethod.GET, RequestMethod.POST })
    public String printCertificate(Model model) {
        model.addAttribute("studentDao", studentDao);
        model.addAttribute("courseDao", courseDao);
        return "printCertificate";
    }

    @RequestMapping(value = "/schuler/printCertificateForOnline", method = { RequestMethod.GET, RequestMethod.POST })
    public String printCertificateForOnline(Model model) {
        model.addAttribute("studentDao", studentDao);
        model.addAttribute("courseDao", courseDao);
        return "printCertificateForOnline";
    }

    @RequestMapping(value = "/schuler/createqr", method = { RequestMethod.GET })
    public void createQR(@RequestParam("studentId") Integer studentId, @RequestParam("certificateId") Integer certificateId,
                         @RequestParam("type") String type,
                         HttpServletRequest request,
                         HttpServletResponse response) {
        createCertificateQR(studentId, certificateId, request, response, "certificate");
    }

    @RequestMapping(value = "/schuler/createonlineqr", method = { RequestMethod.GET })
    public void createonlineQR(@RequestParam("studentId") Integer studentId, @RequestParam("certificateId") Integer certificateId,
                         @RequestParam("type") String type,
                         HttpServletRequest request,
                         HttpServletResponse response) {
        createCertificateQR(studentId, certificateId, request, response, "onlineCertificate");
    }

    private void createCertificateQR(int studentId, int certificateId, HttpServletRequest request, HttpServletResponse response, String url) {
        String md5Text = String.valueOf(studentId) + String.valueOf(certificateId);
        String md5 = DigestUtils.md5DigestAsHex(md5Text.getBytes());

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        qrCodeDao.insertRecord(md5, studentId, certificateId, rps.getLoginUser().getUserID());

        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        try {
            String address = "http://almanca.at/" + url + "?c="+md5;

            BitMatrix bitMatrix = qrCodeWriter.encode(address, BarcodeFormat.QR_CODE, 500, 500);

            ByteArrayOutputStream pngOutputStream = new ByteArrayOutputStream();
            MatrixToImageWriter.writeToStream(bitMatrix, "PNG", pngOutputStream);
            byte[] pngData = pngOutputStream.toByteArray();

            response.setHeader("Content-Disposition", "attachment;filename=qrcode.jpg");
            BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
            bos.write(pngData);
            bos.flush();
            bos.close();
        } catch (WriterException | IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/schuler/createregistrationqr", method = RequestMethod.GET)
    public void createCourseRegistrationQR(@RequestParam("studentId") Integer studentId, @RequestParam("courseId") Integer courseId,
                         HttpServletRequest request,
                         HttpServletResponse response) {
        createRegistrationQR(studentId, courseId, request, response, "courseRegistration");
    }

    @RequestMapping(value = "/schuler/createtbqr", method = RequestMethod.GET)
    public void createTbQR(@RequestParam("studentId") Integer studentId, @RequestParam("courseId") Integer courseId,
                                           HttpServletRequest request,
                                           HttpServletResponse response) {
        createRegistrationQR(studentId, courseId, request, response, "teilnahme");
    }

    private void createRegistrationQR(int studentId, int courseId, HttpServletRequest request, HttpServletResponse response, String url) {
        String md5Text = String.valueOf(studentId) + String.valueOf(courseId);
        String md5 = DigestUtils.md5DigestAsHex(md5Text.getBytes());

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        qrCodeDao.insertCourseRegistrationRecord(md5, studentId, courseId, rps.getLoginUser().getUserID());

        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        try {
            String address = "http://almanca.at/" + url + "?c="+md5;

            BitMatrix bitMatrix = qrCodeWriter.encode(address, BarcodeFormat.QR_CODE, 900, 996);

            ByteArrayOutputStream pngOutputStream = new ByteArrayOutputStream();
            MatrixToImageWriter.writeToStream(bitMatrix, "PNG", pngOutputStream);
            byte[] pngData = pngOutputStream.toByteArray();

            response.setHeader("Content-Disposition", "attachment;filename=qrcode.jpg");
            BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
            bos.write(pngData);
            bos.flush();
            bos.close();
        } catch (WriterException | IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/schuler/publicqr", method = { RequestMethod.GET })
    public void publicQr(@RequestParam("studentId") Integer studentId, @RequestParam("certificateId") Integer certificateId,
                         HttpServletRequest request,
                         HttpServletResponse response) {
        String md5Text = String.valueOf(studentId) + String.valueOf(certificateId);
        String md5 = DigestUtils.md5DigestAsHex(md5Text.getBytes());

        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        try {
            BitMatrix bitMatrix = qrCodeWriter.encode("http://almanca.at/certificate?c="+md5, BarcodeFormat.QR_CODE, 500, 500);

            ByteArrayOutputStream pngOutputStream = new ByteArrayOutputStream();
            MatrixToImageWriter.writeToStream(bitMatrix, "PNG", pngOutputStream);
            byte[] pngData = pngOutputStream.toByteArray();

            response.setHeader("Content-Disposition", "attachment;filename=qrcode.jpg");
            BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
            bos.write(pngData);
            bos.flush();
            bos.close();
        } catch (WriterException | IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/certificate", method = { RequestMethod.GET, RequestMethod.POST })
    public String publicPrintCertificate(HttpServletRequest request, Model model) {
        // TODO: resolve here studentId, certificateId
        // model.addAttribute("studentId", studentId);
        // model.addAttribute("certificateId", certificateId);

        String md5 = request.getParameter("c");

        model.addAttribute("studentDao", studentDao);
        model.addAttribute("courseDao", courseDao);

        try {
            QRCodeInformation qrCode = qrCodeDao.getQRCodeInformations(md5);
            model.addAttribute("qrCodeInformation", qrCode);

            Certificate certificate = new CertificateDao().getCertificateNP(qrCode.getCertificateId());

            if (certificate != null && certificate.getCertificateID() == qrCode.getCertificateId()) {
                return "publicPrintCertificateNP";
            } else {
                return "publicPrintCertificate";
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return "publicPrintCertificate";
    }

    @RequestMapping(value = "/onlineCertificate", method = { RequestMethod.GET, RequestMethod.POST })
    public String publicPrintOnlineCertificate(HttpServletRequest request, Model model) {
        String md5 = request.getParameter("c");

        model.addAttribute("studentDao", studentDao);
        model.addAttribute("courseDao", courseDao);

        try {
            QRCodeInformation qrCode = qrCodeDao.getQRCodeInformations(md5);
            model.addAttribute("qrCodeInformation", qrCode);

            Certificate certificate = new CertificateDao().getCertificateNP(qrCode.getCertificateId());

            if (certificate != null && certificate.getCertificateID() == qrCode.getCertificateId()) {
                return "publicPrintCertificateNP";
            } else {
                return "publicPrintOnlineCertificate";
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return "publicPrintOnlineCertificate";
    }

    @RequestMapping(value = "/courseRegistration", method = { RequestMethod.GET, RequestMethod.POST })
    public String publicPrintRegistration(HttpServletRequest request, Model model) {
        String md5 = request.getParameter("c");

        model.addAttribute("studentDao", studentDao);
        model.addAttribute("courseDao", courseDao);

        try {
            QRCodeInformation qrCode = qrCodeDao.getQRCodeRegistrationInformation(md5);
            model.addAttribute("qrCodeInformation", qrCode);

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return "printRegistrationPublic";
    }

    @RequestMapping(value = "/teilnahme", method = { RequestMethod.GET, RequestMethod.POST })
    public String publicPrintTeilnahme(HttpServletRequest request, Model model) {
        String md5 = request.getParameter("c");

        model.addAttribute("studentDao", studentDao);
        model.addAttribute("courseDao", courseDao);

        try {
            QRCodeInformation qrCode = qrCodeDao.getQRCodeRegistrationInformation(md5);
            model.addAttribute("qrCodeInformation", qrCode);

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return "printTeilnahmePublic";
    }

    @RequestMapping(value = "/schuler/nocerNP", method = { RequestMethod.GET, RequestMethod.POST })
    public String nocerNP() {
        return "nocerNP";
    }

    @RequestMapping(value = "/schuler/printCertificateNP", method = { RequestMethod.GET, RequestMethod.POST })
    public String printCertificateNP(Model model) {
        model.addAttribute("studentDao", studentDao);
        model.addAttribute("courseDao", courseDao);
        return "printCertificateNP";
    }

    @RequestMapping(value = "/schuler/nocerone", method = RequestMethod.GET)
    public String nocerone() {
        return "nocerone";
    }

    @RequestMapping(value = "/schuler/noceroneonline", method = RequestMethod.GET)
    public String noceroneonline() {
        return "noceroneonline";
    }

    @RequestMapping(value = "/schuler/nocerNPone", method = RequestMethod.GET)
    public String nocerNPone() {
        return "nocerNPone";
    }
}
