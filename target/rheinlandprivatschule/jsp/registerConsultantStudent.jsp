<%@ page import="com.rheinlandprivatschule.repository.ConsultantStudentDao" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.model.Werbung" %>
<html>
<head>
    <title>:: Register Admin ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%
    ConsultantStudentDao consultantDB= (ConsultantStudentDao) request.getAttribute("consultantStudentDao");


    String firstname=(String)request.getParameter("txtFirstName");
    String lastname=(String)request.getParameter("txtLastName");
    String telephone=(String)request.getParameter("txtTelephone");
    String email=(String)request.getParameter("txtEmail");
    String remarks=(String)request.getParameter("txtRemarks");
    String paidday=(String)request.getParameter("selDay");
    String paidmonth=(String)request.getParameter("selMonth");
    String paidyear=(String)request.getParameter("selYear");
    String consultantid=(String)request.getParameter("consultantid");
    String fax=(String)request.getParameter("txtFax");
    String mobile=(String)request.getParameter("txtMobile");
    String web=(String)request.getParameter("txtWeb");
    String address=(String)request.getParameter("txtAddress");

    java.sql.Date paiddate= MyDate.getSQLDateFromStrings(paidday,paidmonth,paidyear,MyDate.DEUTSCH);


    Werbung werbung=new Werbung();
    werbung.setConsultantID(Integer.parseInt(consultantid));
    werbung.setFirstName(firstname);
    werbung.setLastName(lastname);
    werbung.setTelephoneNumber(telephone);
    werbung.setEmail(email);
    werbung.setRemarks(remarks);
    werbung.setBeginDate(paiddate);
    werbung.setFax(fax);
    werbung.setMobile(mobile);
    werbung.setWeb(web);
    werbung.setConsultantAddress(address);
    consultantDB.addStudentConsultant(werbung);
    response.sendRedirect("newConsultantStudentForm?consultantid="+consultantid);

%>
</body>
</html>
