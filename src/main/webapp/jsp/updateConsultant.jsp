<html>
<head>
    <title>:: Update Course ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<%@ page import="com.rheinlandprivatschule.repository.ConsultantDao" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.model.Werbung" %>

<body bgcolor="#FFFFFF" text="#000000">
<%
    ConsultantDao consultantDB= (ConsultantDao) request.getAttribute("consultantDao");



    String consultantid=(String)request.getParameter("consultantidS");
    String birthday=(String)request.getParameter("selDay");
    String birthmonth=(String)request.getParameter("selMonth");
    String birthyear=(String)request.getParameter("selYear");
    String city=(String)request.getParameter("txtCity");
    String country=(String)request.getParameter("txtCountry");
    String organisation=(String)request.getParameter("txtOrg");
    String user=(String)request.getParameter("txtUser");


    java.sql.Date dd= MyDate.getSQLDateFromStrings(birthday,birthmonth,birthyear,MyDate.DEUTSCH);

    Werbung werbung=new Werbung();

    werbung.setConsultantID(Integer.parseInt(consultantid));
    werbung.setConsultantDate(dd);
    werbung.setConsultantPlace(city);
    werbung.setConsultantCountry(country);
    werbung.setConsultantOrg(organisation);
    werbung.setConsultantUser(user);

    consultantDB.updateConsultant(werbung);

    response.sendRedirect("consultantList?");


%>

<!-- End ImageReady Slices -->
</BODY>
</HTML>
