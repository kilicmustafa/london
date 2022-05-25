<%@ page import="com.rheinlandprivatschule.repository.ConsultantStudentDao" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.model.Werbung" %>
<html>
<head>
    <title>:: Update Course ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%
    ConsultantStudentDao werbungDB= (ConsultantStudentDao) request.getAttribute("consultantStudentDao");


    String studentID=(String)request.getParameter("studentid");
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
    String fax=(String)request.getParameter("txtFax");
    String mobile=(String)request.getParameter("txtMobile");
    String web=(String)request.getParameter("txtWeb");
    String address=(String)request.getParameter("txtAddress");

    java.sql.Date dd= MyDate.getSQLDateFromStrings(paidday,paidmonth,paidyear,MyDate.DEUTSCH);

    Werbung werbung=new Werbung();

    werbung.setStudentID(Integer.parseInt(studentID));
    werbung.setFirstName(firstname);
    werbung.setLastName(lastname);
    werbung.setTelephoneNumber(telephone);
    werbung.setEmail(email);
    werbung.setStudyReason(reason);
    werbung.setIntendedLanguage(language);
    werbung.setRemarks(remarks);
    werbung.setFax(fax);
    werbung.setMobile(mobile);
    werbung.setWeb(web);
    werbung.setConsultantAddress(address);
    werbung.setBeginDate(dd);

    werbungDB.updateStudentConsultant(werbung);

    response.sendRedirect("consultantList?");

%>

<!-- End ImageReady Slices -->
</BODY>
</HTML>
