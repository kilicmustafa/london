package com.rheinlandprivatschule.controller.stundenplan;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class EmployeWorkController {

    @RequestMapping(method = RequestMethod.GET, value = "/stundenplan/addHoursSchedule")
    public String addHoursSchedule() {

        return "addHoursSchedule";
    }

    @RequestMapping(value = "/stundenplan/registerHours", method = { RequestMethod.GET, RequestMethod.POST })
    public String registerHours() {
        return "registerHours";
    }

    @RequestMapping(value = "/stundenplan/registerAbmeldung", method = { RequestMethod.GET, RequestMethod.POST })
    public String registerAbmeldung() {
        return "registerAbmeldung";
    }

    @RequestMapping(value = "/stundenplan/registerBreakEnd", method = { RequestMethod.GET, RequestMethod.POST })
    public String registerBreakEnd() {
        return "registerBreakEnd";
    }

    @RequestMapping(value = "/stundenplan/registerBreakStart", method = { RequestMethod.GET, RequestMethod.POST })
    public String registerBreakStart() {
        return "registerBreakStart";
    }
}
