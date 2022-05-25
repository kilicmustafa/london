package com.rheinlandprivatschule.controller.residence;

import com.rheinlandprivatschule.controller.BaseController;
import com.rheinlandprivatschule.helper.MyDate;
import com.rheinlandprivatschule.model.Residence;
import com.rheinlandprivatschule.repository.*;

import com.rheinlandprivatschule.viewmodel.MieterListViewModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;


import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

@Controller
public class ResidenceController extends BaseController {

    private final ResidenceDao residenceDao;
    private final ResidenceOwnerDao residenceOwnerDao;
    private final ResidentDao residentDao;
    private final ResidentEntryDao residentEntryDao;
    private final SystemUserDao systemUserDao;
    private final StudentDao studentDao;

    @Autowired
    public ResidenceController(ResidenceDao residenceDao, ResidenceOwnerDao residenceOwnerDao, ResidentDao residentDao, ResidentEntryDao residentEntryDao, SystemUserDao systemUserDao, StudentDao studentDao) {
        this.residenceDao = residenceDao;
        this.residenceOwnerDao = residenceOwnerDao;
        this.residentDao = residentDao;
        this.residentEntryDao = residentEntryDao;
        this.systemUserDao = systemUserDao;
        this.studentDao = studentDao;
    }

    @RequestMapping(value = "/residence/mieterList", method = { RequestMethod.GET, RequestMethod.POST })
    public String mieterList(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(residenceDao.canSeeResidence(rps.getLoginUser().getUserID())) {
            Vector v=residenceDao.getRentInActive();

            ArrayList<MieterListViewModel> mieterListViewModels = new ArrayList<>();
            Double total=0.0;
            Double total1= 0.0;
            Double total2=0.0;
            Double total3=0.0;
            Double total4=0.0;
            Double total5=0.0;
            Double originalTotal=0.0;
            for(int i=0;i<v.size();i++) {
                MieterListViewModel mieterListViewModel = new MieterListViewModel();
                Residence residence=(Residence)v.elementAt(i);
                mieterListViewModel.residence = residence;
                originalTotal = originalTotal+(residence.getResidenceRent());
                if(residence.getUserAddress()==null){
                    mieterListViewModel.fnldate = "";
                }
                else
                {
                    mieterListViewModel.fnldate = residence.getUserAddress();
                }

                if(residence.getUserFirstName()==null){
                    mieterListViewModel.firstname = "";
                    mieterListViewModel.status="Frei";
                }else{
                    mieterListViewModel.firstname = residence.getUserFirstName();
                }
                if(residence.getUserLastName()==null){
                    mieterListViewModel.lastname = "";
                }else{
                    mieterListViewModel.lastname = residence.getUserLastName();
                }

                double rentin = residenceDao.getRentInAsDouble(residence.getResidenceID(),Integer.parseInt(MyDate.getMonth(MyDate.getCurrentSQLDate())),Integer.parseInt(MyDate.getYear(MyDate.getCurrentSQLDate())));
                mieterListViewModel.rent=residence.getResidenceRent() - rentin;
                rentin = residenceDao.getRentInAsDouble(residence.getResidenceID(),Integer.parseInt(MyDate.getMonth(MyDate.getLastMonth1st())),Integer.parseInt(MyDate.getYear(MyDate.getLastMonth1st())));
                mieterListViewModel.rent1=residence.getResidenceRent() - rentin;
                rentin = residenceDao.getRentInAsDouble(residence.getResidenceID(),Integer.parseInt(MyDate.getMonth(MyDate.getLastMonth2nd())),Integer.parseInt(MyDate.getYear(MyDate.getLastMonth2nd())));
                mieterListViewModel.rent2=residence.getResidenceRent() - rentin;
                rentin = residenceDao.getRentInAsDouble(residence.getResidenceID(),Integer.parseInt(MyDate.getMonth(MyDate.getLastMonth3rd())),Integer.parseInt(MyDate.getYear(MyDate.getLastMonth3rd())));
                mieterListViewModel.rent3=residence.getResidenceRent() - rentin;
                rentin = residenceDao.getRentInAsDouble(residence.getResidenceID(),Integer.parseInt(MyDate.getMonth(MyDate.getLastMonth4th())),Integer.parseInt(MyDate.getYear(MyDate.getLastMonth4th())));
                mieterListViewModel.rent4=residence.getResidenceRent() - rentin;
                rentin = residenceDao.getRentInAsDouble(residence.getResidenceID(),Integer.parseInt(MyDate.getMonth(MyDate.getLastMonth5th())),Integer.parseInt(MyDate.getYear(MyDate.getLastMonth5th())));
                mieterListViewModel.rent5=residence.getResidenceRent() - rentin;

                total=total+(mieterListViewModel.rent);
                total1=total1+(mieterListViewModel.rent1);
                total2=total2+(mieterListViewModel.rent2);
                total3=total3+(mieterListViewModel.rent3);
                total4=total4+(mieterListViewModel.rent4);
                total5=total5+(mieterListViewModel.rent5);

                mieterListViewModels.add(mieterListViewModel);
            }


            model.addAttribute("mieterListViewModels", mieterListViewModels);
            model.addAttribute("total", total);
            model.addAttribute("total1", total1);
            model.addAttribute("total2", total2);
            model.addAttribute("total3", total3);
            model.addAttribute("total4", total4);
            model.addAttribute("total5", total5);
            model.addAttribute("originalTotal", originalTotal);

            return "mieterList";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/residence/mieterListNotActive")
    public String mieterListNotActive(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(residenceDao.canSeeResidence(rps.getLoginUser().getUserID())) {
            model.addAttribute("residenceDao", residenceDao);
            model.addAttribute("residenceOwnerDao", residenceOwnerDao);
            return "mieterListNotActive";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/residence/residenceDetails")
    public String residenceDetail(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(residenceDao.canSeeResidence(rps.getLoginUser().getUserID())) {
            model.addAttribute("residenceDao", residenceDao);
            model.addAttribute("residenceOwnerDao", residenceOwnerDao);
            return "residenceDetail";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/residence/rentIncoming")
    public String rentIncoming(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(residenceDao.canUpdateResidence(rps.getLoginUser().getUserID())) {
            model.addAttribute("residenceDao", residenceDao);
            model.addAttribute("residenceOwnerDao", residenceOwnerDao);
            return "rentIncoming";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/residence/rentOutList", method = { RequestMethod.GET, RequestMethod.POST })
    public String rentOutList(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(residenceDao.canSeeResidence(rps.getLoginUser().getUserID())) {
            model.addAttribute("residenceDao", residenceDao);
            model.addAttribute("residenceOwnerDao", residenceOwnerDao);
            return "rentOutList";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/residence/rentOutGoing")
    public String rentOutGoing(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(residenceDao.canUpdateResidence(rps.getLoginUser().getUserID())) {
            model.addAttribute("residenceDao", residenceDao);
            model.addAttribute("residenceOwnerDao", residenceOwnerDao);
            return "rentOutGoing";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/residence/rentOutListNotActive")
    public String rentOutListNotActive(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(residenceDao.canSeeResidence(rps.getLoginUser().getUserID())) {
            model.addAttribute("residenceDao", residenceDao);
            model.addAttribute("residenceOwnerDao", residenceOwnerDao);
            return "rentOutListNotActive";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/residence/residentsList")
    public String residentsList(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(residenceDao.canAddNewResidence(rps.getLoginUser().getUserID())) {
            model.addAttribute("residenceDao", residenceDao);
            return "residentsList";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/residence/newResidentForm", method = { RequestMethod.GET, RequestMethod.POST })
    public String newResidentForm(HttpServletRequest request) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(residentDao.canAddNewResident(rps.getLoginUser().getUserID())) {
            return "newResidentForm";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/residence/registerResident", method = { RequestMethod.GET, RequestMethod.POST })
    public String registerResident(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(residentDao.canAddNewResident(rps.getLoginUser().getUserID())) {
            model.addAttribute("residentDao", residentDao);

            return "registerResident";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/residence/residencesList")
    public String residencesList(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(residenceDao.canSeeResidence(rps.getLoginUser().getUserID())) {
            model.addAttribute("residenceDao", residenceDao);
            model.addAttribute("residenceOwnerDao", residenceOwnerDao);
            return "residencesList";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/residence/residencesListNotActive")
    public String residencesListNotActive(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(residenceDao.canSeeResidence(rps.getLoginUser().getUserID())) {
            model.addAttribute("residenceDao", residenceDao);
            model.addAttribute("residenceOwnerDao", residenceOwnerDao);
            return "residencesListNotActive";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/residence/newResidenceForm")
    public String newResidenceForm(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(residenceDao.canAddNewResidence(rps.getLoginUser().getUserID())) {
            model.addAttribute("residenceDao", residenceDao);
            model.addAttribute("residenceOwnerDao", residenceOwnerDao);
            return "newResidenceForm";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/residence/registerResidence", method = { RequestMethod.GET, RequestMethod.POST })
    public String registerResidence(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(residenceDao.canAddNewResidence(rps.getLoginUser().getUserID())) {
            model.addAttribute("residenceDao", residenceDao);
            return "registerResidence";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/residence/ownersList")
    public String ownersList(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(residenceOwnerDao.canSeeResidenceOwner(rps.getLoginUser().getUserID())) {
            model.addAttribute("residenceOwnerDao", residenceOwnerDao);
            return "ownersList";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/residence/ownerDetails")
    public String ownerDetails(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(residenceOwnerDao.canSeeResidenceOwner(rps.getLoginUser().getUserID())) {
            model.addAttribute("residenceOwnerDao", residenceOwnerDao);
            return "ownerDetails";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/residence/ownerUpdateForm")
    public String ownerUpdateForm(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(residenceOwnerDao.canUpdateResidenceOwner(rps.getLoginUser().getUserID())) {
            model.addAttribute("residenceOwnerDao", residenceOwnerDao);
            return "ownerUpdateForm";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/residence/updateOwner")
    public String updateOwner(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(residenceOwnerDao.canUpdateResidenceOwner(rps.getLoginUser().getUserID())) {
            model.addAttribute("residenceOwnerDao", residenceOwnerDao);
            return "updateOwner";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/residence/newOwnerForm")
    public String newOwnerForm(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(residenceOwnerDao.canAddNewResidenceOwner(rps.getLoginUser().getUserID())) {
            model.addAttribute("residenceOwnerDao", residenceOwnerDao);
            return "newOwnerForm";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/residence/registerOwner")
    public String registerOwner(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(residenceOwnerDao.canAddNewResidenceOwner(rps.getLoginUser().getUserID())) {
            model.addAttribute("residenceOwnerDao", residenceOwnerDao);
            return "registerOwner";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/residence/mieterEntryDetails")
    public String mieterEntryDetails(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        model.addAttribute("residentEntryDao", residentEntryDao);
        model.addAttribute("residenceDao", residenceDao);
        return "mieterEntryDetails";
    }

    @RequestMapping(value = "/residence/residentUpdateEntry", method = { RequestMethod.GET, RequestMethod.POST })
    public String residentUpdateEntry(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(residentEntryDao.canUpdateResident(rps.getLoginUser().getUserID())) {
            model.addAttribute("residentEntryDao", residentEntryDao);
            return "residentUpdateEntry";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/residence/updateResident")
    public String updateResident(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(residentEntryDao.canUpdateResident(rps.getLoginUser().getUserID())) {
            model.addAttribute("residentEntryDao", residentEntryDao);
            return "updateResident";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/residence/onlyRemark", method = { RequestMethod.GET, RequestMethod.POST })
    public String onlyRemark(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(residentDao.canUpdateResident(rps.getLoginUser().getUserID())) {
            model.addAttribute("residentDao", residentDao);
            return "onlyRemark";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/residence/registerRentIncoming", method = { RequestMethod.GET, RequestMethod.POST })
    public String registerRentIncoming(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(residenceDao.canUpdateResident(rps.getLoginUser().getUserID())) {
            model.addAttribute("residenceDao", residenceDao);
            model.addAttribute("myPlace", rps.getLoginPlace());
            model.addAttribute("loginUser", rps.getLoginUser());
            return "registerRentIncoming";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/residence/printRentInProcessMain", method = { RequestMethod.GET, RequestMethod.POST })
    public String printRentInProcessMain(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(residenceDao.canUpdateResident(rps.getLoginUser().getUserID())) {
            model.addAttribute("residenceDao", residenceDao);
            return "printRentInProcessMain";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/residence/registerRentOutGoing", method = { RequestMethod.GET, RequestMethod.POST })
    public String registerRentOutGoing(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(residenceDao.canUpdateResident(rps.getLoginUser().getUserID())) {
            model.addAttribute("residenceDao", residenceDao);
            model.addAttribute("myPlace", rps.getLoginPlace());
            model.addAttribute("loginUser", rps.getLoginUser());
            return "registerRentOutGoing";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/residence/printRentOutProcessMain", method = { RequestMethod.GET, RequestMethod.POST })
    public String printRentOutProcessMain(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(residenceDao.canUpdateResident(rps.getLoginUser().getUserID())) {
            model.addAttribute("residenceDao", residenceDao);
            return "printRentOutProcessMain";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/residence/printRentOutMain", method = { RequestMethod.GET, RequestMethod.POST })
    public String printRentOutMain(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(residenceDao.canUpdateResident(rps.getLoginUser().getUserID())) {
            model.addAttribute("residenceDao", residenceDao);
            return "printRentOutMain";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/residence/printRentInMain", method = { RequestMethod.GET, RequestMethod.POST })
    public String printRentInMain(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(residenceDao.canUpdateResident(rps.getLoginUser().getUserID())) {
            model.addAttribute("residenceDao", residenceDao);
            return "printRentInMain";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/**/mailComposer", method = { RequestMethod.GET, RequestMethod.POST })
    public String mailComposer(HttpServletRequest request, Model model) {
        if(loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");

        if(systemUserDao.canSendEmail(rps.getLoginUser().getUserID())) {
            String[] toList = request.getParameterValues("checkbox");
            List<String> toVector = new ArrayList<>();
            StringBuilder to= new StringBuilder();
            StringBuilder list = new StringBuilder();
            if(toList != null) {
                int track = 1;
                for (String aToList : toList) {
                    if (track == 1) {
                        to.append(aToList);
                        track++;
                    } else {
                        to.append(",");
                        to.append(aToList);
                    }
                    toVector.add(aToList);
                }
            } else {
                String singleemail= request.getParameter("singleemail");
                if(singleemail == null) {
                    singleemail = (String) request.getSession().getAttribute("singleemail");
                }
                toVector.add(singleemail);
                to.append(singleemail);
            }
            model.addAttribute("toVector", toVector);
            model.addAttribute("subb", "Nachricht von "+rps.getLoginUser().getUserFirstName()+" "+
                    rps.getLoginUser().getUserLastName());
            Vector vb = (Vector) request.getAttribute("filelist");
            String what=request.getParameter("what");
            if(vb!=null && what!=null){
                for(int ii=0;ii<vb.size();ii++){
                    if(ii==0){
                        list = new StringBuilder((String) vb.elementAt(ii));
                    }else{
                        list.append(",").append((String) vb.elementAt(ii));
                    }
                }
            }
            model.addAttribute("to", to);
            model.addAttribute("list", list);
        } else {
            return "redirect:/user/mailComposer?err=permission";
        }

        return "mailComposer";
    }

    @RequestMapping(value = "/residence/mieterDetails", method = { RequestMethod.GET, RequestMethod.POST })
    public String mieterDetails(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        model.addAttribute("residenceDao", residenceDao);
        model.addAttribute("residentDao", residentDao);
        return "mieterDetails";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/residence/mietwizard")
    public String mietwizard(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        MietenDB mietenDB = new MietenDB();
        if(mietenDB.canSeeResidenceMieten(rps.getLoginUser().getUserID())) {
            model.addAttribute("residenceDao", residenceDao);
            model.addAttribute("mietenDB", mietenDB);
            return "mietwizard";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/residence/newResidenceMieten")
    public String newResidenceMieten(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        MietenDB mietenDB = new MietenDB();
        if(mietenDB.canAddNewResidenceMieten(rps.getLoginUser().getUserID())) {
            model.addAttribute("residenceDao", residenceDao);
            model.addAttribute("residentDao", residenceDao);
            model.addAttribute("mietenDB", mietenDB);
            return "newResidenceMieten";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/residence/registerResidenceMieten")
    public String registerResidenceMieten(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        MietenDB mietenDB = new MietenDB();
        if(mietenDB.canUpdateResidenceMieten(rps.getLoginUser().getUserID())) {
            model.addAttribute("residenceDao", residenceDao);
            model.addAttribute("residentDao", residenceDao);
            model.addAttribute("mietenDB", mietenDB);
            return "registerResidenceMieten";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/residence/residenceUpdateForm")
    public String residenceUpdateForm(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(residenceDao.canUpdateResidence(rps.getLoginUser().getUserID())) {
            model.addAttribute("residenceDao", residenceDao);
            model.addAttribute("residenceOwnerDao", residenceOwnerDao);
            return "residenceUpdateForm";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/residence/updateResidence")
    public String updateResidence(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(residenceDao.canUpdateResidence(rps.getLoginUser().getUserID())) {
            model.addAttribute("residenceDao", residenceDao);
            model.addAttribute("residenceOwnerDao", residenceOwnerDao);
            return "updateResidence";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/residence/showRentInTrans", method = { RequestMethod.GET, RequestMethod.POST })
    public String showRentInTrans(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        model.addAttribute("residenceDao", residenceDao);
        return "showRentInTrans";
    }

    @RequestMapping(value = "/residence/rentInPrintProcess", method = { RequestMethod.GET, RequestMethod.POST })
    public String rentInPrintProcess(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        model.addAttribute("residenceDao", residenceDao);
        return "rentInPrintProcess";
    }

    @RequestMapping(value = "/residence/printRentIn", method = { RequestMethod.GET, RequestMethod.POST })
    public String printRentIn(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        model.addAttribute("residenceDao", residenceDao);
        return "printRentIn";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/residence/residentUpdateForm")
    public String residentUpdateForm(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(residentDao.canUpdateResident(rps.getLoginUser().getUserID())) {
            model.addAttribute("residentDao", residentDao);
            return "residentUpdateForm";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/residence/newResidentEntry")
    public String newResidentEntry(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(residentEntryDao.canAddNewResident(rps.getLoginUser().getUserID())) {
            model.addAttribute("residentEntryDao", residentEntryDao);
            return "newResidentEntry";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/residence/registerResidentEntry")
    public String registerResidentEntry(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        RPS rps = (RPS) request.getSession().getAttribute("handler");
        if(residentEntryDao.canAddNewResident(rps.getLoginUser().getUserID())) {
            model.addAttribute("residentEntryDao", residentEntryDao);
            return "registerResidentEntry";
        }

        return "redirect:/index?err=permission";
    }

    @RequestMapping(value = "/residence/studentSearch", method = { RequestMethod.GET, RequestMethod.POST })
    public String studentSearch(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        model.addAttribute("residentDao", residentDao);
        model.addAttribute("studentDao", studentDao);
        return "studentSearch";
    }

    @RequestMapping(value = "/residence/makeStudent", method = { RequestMethod.GET, RequestMethod.POST })
    public String makeStudent(HttpServletRequest request, Model model) {
        if(this.loginStatement(request)) {
            return "redirect:/";
        }

        model.addAttribute("residentDao", residentDao);
        model.addAttribute("studentDao", studentDao);
        return "makeStudent";
    }
}
