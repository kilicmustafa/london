<%@ page import="com.rheinlandprivatschule.repository.ResidentEntryDao" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.model.Resident" %>
<html>
<head>
    <title>:: Register User ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%
    ResidentEntryDao residentDB= (ResidentEntryDao) request.getAttribute("residentEntryDao");


    String residenceID=(String)request.getParameter("residenceid");
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
    String startday=(String)request.getParameter("selSDay");
    String startmonth=(String)request.getParameter("selSMonth");
    String startyear=(String)request.getParameter("selSYear");
    String endday=(String)request.getParameter("selEDay");
    String endmonth=(String)request.getParameter("selEMonth");
    String endyear=(String)request.getParameter("selEYear");
    String countStart=(String)request.getParameter("txtCountStart");
    String countEnd=(String)request.getParameter("txtCountEnd");

    java.sql.Date dd= MyDate.getSQLDateFromStrings(birthday,birthmonth,birthyear,MyDate.DEUTSCH);
    java.sql.Date startdate=MyDate.getSQLDateFromStrings(startday,startmonth,startyear,MyDate.DEUTSCH);


    loginname=lastname;
    password=""+dd;
    Resident resident=new Resident();

    resident.setResidenceID(Integer.parseInt(residenceID));
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
    System.out.print(residenceID + firstname + lastname + dd + usergender + birthplace + nationality + co + address + "   ");
    System.out.print(postcode + city + country + homeno + mobileno + "   ");
    resident.setUserEmail(email);
    resident.setUserLoginName(loginname);
    resident.setUserPassword(password);
    resident.setUserRemarks("");
    resident.setStudent(0);
    resident.setStudentReference(null);

    System.out.print(email + loginname + password + "   ");

    java.sql.Date enddate = null;

    try{
        Integer.parseInt(endday);
        Integer.parseInt(endyear);
        if(!endmonth.equalsIgnoreCase("--")){
            enddate=MyDate.getSQLDateFromStrings(endday,endmonth,endyear,MyDate.DEUTSCH);
        }
    }catch(Exception eee){
    }


    resident.setMietStart(startdate);
    resident.setMietEnd(enddate);
    resident.setMieterCountStart(countStart);
    resident.setMieterCountEnd(countEnd);
    System.out.print(startdate +"     "+ enddate + countStart + countEnd + "  asfdsaf ");
    residentDB.addNewResidentWithoutReference(resident);

    response.sendRedirect("residenceDetails?residenceid="+residenceID);
%>
</body>
</html>
