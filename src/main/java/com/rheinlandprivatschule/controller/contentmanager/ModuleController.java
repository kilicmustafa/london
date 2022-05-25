package com.rheinlandprivatschule.controller.contentmanager;


import com.rheinlandprivatschule.controller.BaseController;
import com.rheinlandprivatschule.helper.contentmanager.ContentManager;
import com.rheinlandprivatschule.helper.contentmanager.Module;
import com.rheinlandprivatschule.helper.contentmanager.ModuleManager;
import com.rheinlandprivatschule.model.Activity;
import com.rheinlandprivatschule.repository.PreviligeManager;
import com.rheinlandprivatschule.repository.RPS;
import com.rheinlandprivatschule.viewmodel.ActivitySelectionViewModel;
import com.rheinlandprivatschule.viewmodel.ModuleSelectionViewModel;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
public class ModuleController extends BaseController {

    @RequestMapping(method = RequestMethod.GET, value = "/contentmanager/moduleSelection")
    public String moduleSelection(HttpServletRequest request, Model model) {
        if (this.loginStatement(request)) {
            return "redirect:/";
        }
        ContentManager contentManager = new ContentManager();
        ModuleManager moduleManager = null;
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        boolean respect;
        String userid = request.getParameter("userid");
        int userID = Integer.parseInt(userid);
        request.getSession().setAttribute("processuser", userid);

        respect = (userID == 1 && userID == rps.getLoginUser().getUserID()) || userID != 1;

        List<Module> moduleList = new ArrayList<>();
        if (respect) {
            ServletContext app = request.getSession().getServletContext();
            String path = app.getRealPath("/resources/Activity.xml");
            java.io.File fil = new java.io.File(path);
            moduleManager = contentManager.getModuleManager(fil);
            moduleList = moduleManager.getModuleList();
        }

        List<ModuleSelectionViewModel> moduleSelectionViewModels = new ArrayList<>();
        if (moduleManager != null) {
            for (Module module : moduleList) {
                ModuleSelectionViewModel moduleSelectionViewModel = new ModuleSelectionViewModel(
                        module,
                        PreviligeManager.isSystemUserHasThisPrivilage(userID, module.getModuleID()),
                        moduleManager.isModuleHasPredecessor(module.getModuleID())
                );
                moduleSelectionViewModels.add(moduleSelectionViewModel);
            }
        }

        model.addAttribute("msvm", moduleSelectionViewModels);

        return "moduleSelection";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/contentmanager/saveModule")
    public String saveModule(HttpServletRequest request) {
        if (this.loginStatement(request)) {
            return "redirect:/";
        }
        return "saveModule";
    }

    @RequestMapping(method = RequestMethod.GET, value = "/contentmanager/activitySelection")
    public String activitySelection(HttpServletRequest request, Model model) {
        if (this.loginStatement(request)) {
            return "redirect:/";
        }

        ContentManager contentManager = new ContentManager();
        ModuleManager moduleManager = null;
        RPS rps = (RPS) request.getSession().getAttribute("handler");
        int userID = Integer.parseInt(String.valueOf(request.getSession().getAttribute("processuser")));

        //List<Module> moduleList = new ArrayList<>();
        ServletContext app = request.getSession().getServletContext();
        String path = app.getRealPath("/resources/Activity.xml");
        java.io.File fil = new java.io.File(path);
        moduleManager = contentManager.getModuleManager(fil);
        //moduleList = moduleManager.getModuleList();

        String cmd = request.getParameter("cmd");
        List<Activity> activityList = new ArrayList<>();
        if (cmd == null) {
            String moduleid = request.getParameter("moduleid");
            activityList = moduleManager.getPredecessor(moduleid, ModuleManager.MODULE);
        } else {
            String activityid = request.getParameter("activityid");
            activityList = moduleManager.getPredecessor(activityid, ModuleManager.ACTIVITY);
        }

        List<ActivitySelectionViewModel> activitySelectionViewModels = new ArrayList<>();
        for (Activity activity : activityList) {
            activitySelectionViewModels.add(new ActivitySelectionViewModel(
                    activity,
                    PreviligeManager.isSystemUserHasThisPrivilage(userID, activity.activityID),
                    moduleManager.isActivityHasPredecessor(activity.activityID)
            ));
        }

        model.addAttribute("asvm", activitySelectionViewModels);


        return "activitySelection";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/contentmanager/saveActivity")
    public String saveActivity(HttpServletRequest request) {
        if (this.loginStatement(request)) {
            return "redirect:/";
        }
        return "saveActivity";
    }
}
