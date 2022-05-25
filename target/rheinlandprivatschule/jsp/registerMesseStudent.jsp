<%@ page import="com.rheinlandprivatschule.repository.MesseStudentDao" %>
<%@ page import="com.rheinlandprivatschule.model.Werbung" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<html>
<head>
    <title>:: Register Admin ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%
    MesseStudentDao messeDB = (MesseStudentDao) request.getAttribute("messeStudentDao");


    String firstname=(String)request.getParameter("txtFirstName");
    String lastname=(String)request.getParameter("txtLastName");
    String telephone=(String)request.getParameter("txtTelephone");
    String email=(String)request.getParameter("txtEmail");
    String reason=(String)request.getParameter("txtReason");
    String language=(String)request.getParameter("txtLanguage");
    String remarks=(String)request.getParameter("txtRemarks");
    String paidday=(String)request.getParameter("selDay");
    String paidmonth=(String)request.getParameter("selMonth");
    String paidyear=(String)request.getParameter("selYear");
    String messeid=(String)request.getParameter("messeid");

    java.sql.Date paiddate=MyDate.getSQLDateFromStrings(paidday,paidmonth,paidyear, MyDate.DEUTSCH);


    Werbung werbung=new Werbung();
    werbung.setMesseID(Integer.parseInt(messeid));
    werbung.setFirstName(firstname);
    werbung.setLastName(lastname);
    werbung.setTelephoneNumber(telephone);
    werbung.setEmail(email);
    werbung.setStudyReason(reason);
    werbung.setIntendedLanguage(language);
    werbung.setRemarks(remarks);
    werbung.setBeginDate(paiddate);
    messeDB.addStudentMesse(werbung);
    response.sendRedirect("newMesseStudentForm?messeid="+messeid);

%>
</body>
</html>
