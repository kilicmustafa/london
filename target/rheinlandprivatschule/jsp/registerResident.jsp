<%@ page import="com.rheinlandprivatschule.repository.ResidentDao" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.model.Resident" %>
<html>
<head>
    <title>:: Register User ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>


<body bgcolor="#FFFFFF" text="#000000">
<%
    ResidentDao residentDB = (ResidentDao) request.getAttribute("residentDao");

    String firstname=(String)request.getParameter("txtFirstName");
    String lastname=(String)request.getParameter("txtLastName");
    String birthday=(String)request.getParameter("selDay");
    String birthmonth=(String)request.getParameter("selMonth");
    String birthyear=(String)request.getParameter("selYear");
    String usergender=(String)request.getParameter("rdGender");
    String birthplace=(String)request.getParameter("txtBirthPlace");
    String nationality=(String)request.getParameter("txtNationality");
    String co=(String)request.getParameter("txtCO");
    String address=(String)request.getParameter("txtAddress");
    String postcode=(String)request.getParameter("txtPostCode");
    String city=(String)request.getParameter("txtCity");
    String country=(String)request.getParameter("txtCountry");
    String homeno=(String)request.getParameter("txtHomeNo");
    String mobileno=(String)request.getParameter("txtMobileNo");
    String faxno=(String)request.getParameter("txtFax");
    String email=(String)request.getParameter("txtEmail");
    String loginname="";
    String password="";



    java.sql.Date dd= MyDate.getSQLDateFromStrings(birthday,birthmonth,birthyear,MyDate.DEUTSCH);
    loginname=lastname;
    password=""+dd;
    Resident resident=new Resident();
    resident.setUserFirstName(firstname);
    resident.setUserLastName(lastname);
    resident.setUserBirthDate(dd);
    resident.setUserGender(Integer.parseInt(usergender));
    resident.setUserBirthPlace(birthplace);
    resident.setUserNationality(nationality);
    resident.setUserCO(co);
    resident.setUserAddress(address);
    resident.setUserPostCode(postcode);
    resident.setUserCity(city);
    resident.setUserCountry(country);
    resident.setUserHomePhone(homeno);
    resident.setUserMobilePhone(mobileno);
    resident.setUserFax(faxno);
    resident.setUserEmail(email);
    resident.setUserLoginName(loginname);
    resident.setUserPassword(password);
    resident.setUserRemarks("");

    resident.setStudent(0);
    resident.setStudentReference(null);

    int userid=residentDB.addNewResident(resident);
    if(userid<=0){
        String err=residentDB.getError();
        session.setAttribute("err",err);
        session.setAttribute("lin","../map");
        response.sendRedirect("error");
    }else{
        session.setAttribute("newresident",null);
        response.sendRedirect("residentsList");
    }
%>
</body>
</html>
