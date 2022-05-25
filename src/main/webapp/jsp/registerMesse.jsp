<%@ page import="com.rheinlandprivatschule.repository.MesseDao" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.model.Werbung" %>
<html>
<head>
    <title>:: Register Admin ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%
    MesseDao messeDB = (MesseDao) request.getAttribute("messeDao");


    String city=(String)request.getParameter("txtCity");
    String country=(String)request.getParameter("txtCountry");
    String user=(String)request.getParameter("txtUser");
    String organisation=(String)request.getParameter("txtOrg");

    String paidday=(String)request.getParameter("selDay");
    String paidmonth=(String)request.getParameter("selMonth");
    String paidyear=(String)request.getParameter("selYear");

    java.sql.Date paiddate= MyDate.getSQLDateFromStrings(paidday,paidmonth,paidyear,MyDate.DEUTSCH);


    Werbung werbung=new Werbung();
    werbung.setMessePlace(city);
    werbung.setMesseCountry(country);
    werbung.setMesseOrg(organisation);
    werbung.setMesseUser(user);
    werbung.setMesseDate(paiddate);
    messeDB.addMesse(werbung);
    response.sendRedirect("messeList");

%>
</body>
</html>
