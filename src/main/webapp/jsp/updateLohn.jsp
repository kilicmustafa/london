<%@ page import="com.rheinlandprivatschule.repository.TeacherLohnDao" %>
<%@ page import="com.rheinlandprivatschule.model.TeacherLohn" %>
<%@ page import="com.rheinlandprivatschule.repository.SystemUserDao" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="com.rheinlandprivatschule.model.SystemUser" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<html>
<head>
    <title>:: Update Administrator ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>


<body bgcolor="#FFFFFF" text="#000000">
<%
    TeacherLohnDao tldb=new TeacherLohnDao();
    TeacherLohn teacherlohn=new TeacherLohn();
    SystemUserDao sdb=new SystemUserDao();

    RPS rps=(RPS)session.getAttribute("handler");
    SystemUser loginuser=new SystemUser();
    if(rps==null){
        String err="Sitzung lief Ab";
        session.setAttribute("err",err);
        session.setAttribute("lin","../index.jsp");
        response.sendRedirect("error.jsp");
    }else{

        session.setAttribute("handler",rps);
        loginuser=rps.getLoginUser();

        if(sdb.canUpdateGeneralUserLohn(loginuser.getUserID())){
            String userid1=(String)request.getParameter("hidID");
            String startDay=(String)request.getParameter("selSDay");
            String startMonth=(String)request.getParameter("selSMonth");
            String startYear=(String)request.getParameter("selSYear");
            String endDay=(String)request.getParameter("selEDay");
            String endMonth=(String)request.getParameter("selEMonth");
            String endYear=(String)request.getParameter("selEYear");
            String lohn1=(String)request.getParameter("txtLohn");
            String hlohnType=(String)request.getParameter("hlohntype");
            String startdateinit=(String)request.getParameter("sdate");
            String enddateinit=(String)request.getParameter("edate");
            int userIDN=Integer.parseInt(userid1);



            java.sql.Date start= MyDate.getSQLDateFromStrings(startDay,startMonth,startYear,MyDate.DEUTSCH);
            java.sql.Date end=MyDate.getSQLDateFromStrings(endDay,endMonth,endYear,MyDate.DEUTSCH);
            java.sql.Date initstart=MyDate.getSQLDateFromDashFormatString(startdateinit,MyDate.DEUTSCH);
            //java.sql.Date firstDate=MyDate.getSQLDateFromDashFormatString(startdate,MyDate.DEUTSCH);
            int lohnType=Integer.parseInt(hlohnType);

            teacherlohn = tldb.getTeacherLohn(userIDN,lohnType,start);

            TeacherLohn tlohn=new TeacherLohn();

            tlohn.setUserID(userIDN);
            tlohn.setStartDate(start);
            tlohn.setEndDate(end);
            tlohn.setTeacherLohn(Double.parseDouble(lohn1));

            tldb.updatePrivateTeacherLohn(tlohn, lohnType, initstart);
            response.sendRedirect("adminLohnUpdate?adminid="+userIDN);

        }else{
            String err=sdb.getError();
            session.setAttribute("err",err);
            session.setAttribute("lin","../map.jsp");
            response.sendRedirect("error.jsp");
        }
    }
%>
</body>
</html>
