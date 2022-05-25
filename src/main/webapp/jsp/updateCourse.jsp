<%@ page import="com.rheinlandprivatschule.repository.CourseDao" %>
<%@ page import="com.rheinlandprivatschule.model.Course" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<html>
<head>
    <title>:: Update Course ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%
    CourseDao courseDB= (CourseDao) request.getAttribute("courseDao");


    String definecourse=(String)request.getParameter("selCo");

    String coursename="Oberstufe";
    String coro="";
    String coursedes=(String)request.getParameter("txtDes");
    String sDay=(String)request.getParameter("selSDay");
    String sMonth=(String)request.getParameter("selSMonth");
    String sYear=(String)request.getParameter("selSYear");
    String eDay=(String)request.getParameter("selEDay");
    String eMonth=(String)request.getParameter("selEMonth");
    String eYear=(String)request.getParameter("selEYear");
    String timing=(String)request.getParameter("txtTim");
    String fee=(String)request.getParameter("txtFee");
    String strengthS=(String)request.getParameter("strength");
    String hours=(String)request.getParameter("hours");
    String totalhour=(String)request.getParameter("totalhour");
    String bamfnr=(String)request.getParameter("bamfnr");
    String dailyhour=(String)request.getParameter("dailyhour");
    String courseinit=(String)request.getParameter("courseinit");

    int coursetype=0;
    int dv=Integer.parseInt(definecourse);
    if(dv==1){
        coursetype=1;
        coursename="Grundstufe I"+" "+sMonth+" "+sYear;
        coro="Grundstufe I"+" "+"Elite"+" "+sMonth+" "+sYear;
    }else if(dv==2){
        coursetype=2;
        coursename="Grundstufe II"+" "+sMonth+" "+sYear;
        coro="Grundstufe II"+" "+"Elite"+" "+sMonth+" "+sYear;
    }else if(dv==3){
        coursetype=3;
        coursename="Mittelstufe I"+" "+sMonth+" "+sYear;
        coro="Mittelstufe I"+" "+"Elite"+" "+sMonth+" "+sYear;
    }else if(dv==4){
        coursetype=4;
        coursename="Mittelstufe II"+" "+sMonth+" "+sYear;
        coro="Mittelstufe II"+" "+"Elite"+" "+sMonth+" "+sYear;
    }else if(dv==5){
        coursetype=5;
        coursename=coursename+" "+sMonth+" "+sYear;
        coro="Oberstufe"+" "+"Elite"+" "+sMonth+" "+sYear;
    }


    if(timing.equalsIgnoreCase("Vormittag")){
        timing="8:30-12:00";
    }else if(timing.equalsIgnoreCase("Nachmittag")){
        timing="12:00-18:00";
    }else if(timing.equalsIgnoreCase("Abendkurs")){
        timing="18:00-21:00";
    }

    int strength=Integer.parseInt(strengthS);
    Course c=new Course();
    try{
        java.sql.Date d1= MyDate.getSQLDateFromStrings(sDay,sMonth,sYear,MyDate.DEUTSCH);

        java.sql.Date d2=MyDate.getSQLDateFromStrings(eDay,eMonth,eYear,MyDate.DEUTSCH);

        int courseidd=Integer.parseInt((String)session.getAttribute("courseid"));
        c=courseDB.getCourse(courseidd);

        boolean mb=courseDB.isEliteCourses(c.getCourseName());
        if(!mb)	{
            c.setCourseName(coursename);
        }else{
            c.setCourseName(coro);
        }

        c.setCourseDesc(coursedes);
        c.setCourseStartDate(d1);
        c.setCourseEndDate(d2);
        c.setCourseTiming(timing);
        c.setCourseFee(Double.parseDouble(fee));
        c.setCourseStrength(strength);
        c.setCourseHours(hours);
        c.setCourseTotalHours(totalhour);
        c.setCourseType(coursetype);
        c.setCourseBamfNr(bamfnr);
        c.setCourseDailyHrs(dailyhour);
        c.setCourseInit(courseinit);
    }catch(Exception e){
    }

    if(courseDB.updateCourse(c)){
        response.sendRedirect("courseList");
    }else{
        String err="Kurs kann nicht aktualisieren, noch einmal versuchen";
        session.setAttribute("err",err);
        session.setAttribute("lin","courseList");
        response.sendRedirect("error");
    } }
    }

%>
</body>
</html>
