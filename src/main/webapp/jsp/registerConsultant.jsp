<%@ page import="com.rheinlandprivatschule.repository.ConsultantDao" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.model.Werbung" %>
<html>
<head>
    <title>:: Register Admin ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%
    ConsultantDao consultantDB= (ConsultantDao) request.getAttribute("consultantDao");


    String city=(String)request.getParameter("txtCity");
    String country=(String)request.getParameter("txtCountry");
    String user=(String)request.getParameter("txtUser");
    String organisation=(String)request.getParameter("txtOrg");

    String paidday=(String)request.getParameter("selDay");
    String paidmonth=(String)request.getParameter("selMonth");
    String paidyear=(String)request.getParameter("selYear");

    java.sql.Date paiddate= MyDate.getSQLDateFromStrings(paidday,paidmonth,paidyear,MyDate.DEUTSCH);


    Werbung werbung=new Werbung();
    werbung.setConsultantPlace(city);
    werbung.setConsultantCountry(country);
    werbung.setConsultantOrg(organisation);
    werbung.setConsultantUser(user);
    werbung.setConsultantDate(paiddate);
    consultantDB.addConsultant(werbung);
    response.sendRedirect("consultantList");
%>
</body>
</html>
