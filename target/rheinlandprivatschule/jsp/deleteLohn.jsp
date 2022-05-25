<%@ page import="com.rheinlandprivatschule.repository.TeacherLohnDao" %>
<%@ page import="com.rheinlandprivatschule.repository.SystemUserDao" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="com.rheinlandprivatschule.model.SystemUser" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<html>
<head>
    <title>:: Update Administrator ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<%@ page session="true" %>

<body bgcolor="#FFFFFF" text="#000000">
<%
    TeacherLohnDao tldb=new TeacherLohnDao();
    SystemUserDao sdb=new SystemUserDao();

    RPS rps=(RPS)session.getAttribute("handler");
    SystemUser loginuser=new SystemUser();
    if(rps==null){
        String err="Sitzung lief Ab";
        session.setAttribute("err",err);
        session.setAttribute("lin","../index.jsp");
        response.sendRedirect("error");
    }else{
        session.setAttribute("handler",rps);
        loginuser=rps.getLoginUser();

        if(sdb.canUpdateGeneralUserLohn(loginuser.getUserID())){
            String userid=(String)request.getParameter("userid");
            String startdate=(String)request.getParameter("sdate");
            String enddate=(String)request.getParameter("edate");
            String lohnTypeS=(String)request.getParameter("ltype");
            int userIDN=Integer.parseInt(userid);
            java.sql.Date firstDate= MyDate.getSQLDateFromDashFormatString(startdate,MyDate.DEUTSCH);
            java.sql.Date lastDate=null;
            if(enddate != null){
                lastDate=MyDate.getSQLDateFromDashFormatString(enddate,MyDate.DEUTSCH);
            }
            int lohnType=Integer.parseInt(lohnTypeS);
            tldb.deleteTeacherLohn(userIDN,firstDate,lastDate,lohnType);
            response.sendRedirect("adminLohnUpdate?adminid="+userIDN);

        }else{
            String err=sdb.getError();
            session.setAttribute("err",err);
            session.setAttribute("lin","../map.jsp");
            response.sendRedirect("error");
        }
    }
%>
</body>
</html>
