<%@ page import="com.rheinlandprivatschule.model.Werbung" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.repository.MesseDao" %>
<html>
<head>
    <title>:: Update Course ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%
    MesseDao werbungDB = (MesseDao) request.getAttribute("messeDao");

    String messeid=(String)request.getParameter("messeidS");
    String birthday=(String)request.getParameter("selDay");
    String birthmonth=(String)request.getParameter("selMonth");
    String birthyear=(String)request.getParameter("selYear");
    String city=(String)request.getParameter("txtCity");
    String country=(String)request.getParameter("txtCountry");
    String organisation=(String)request.getParameter("txtOrg");
    String user=(String)request.getParameter("txtUser");


    java.sql.Date dd=MyDate.getSQLDateFromStrings(birthday,birthmonth,birthyear, MyDate.DEUTSCH);

    Werbung werbung=new Werbung();

    werbung.setMesseID(Integer.parseInt(messeid));
    werbung.setMesseDate(dd);
    werbung.setMessePlace(city);
    werbung.setMesseCountry(country);
    werbung.setMesseOrg(organisation);
    werbung.setMesseUser(user);

    werbungDB.updateMesse(werbung);

    response.sendRedirect("messeList?");

%>

<!-- End ImageReady Slices -->
</BODY>
</HTML>
