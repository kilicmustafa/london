<html>
<head>
    <title>Register User</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.repository.StudentDao" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="com.rheinlandprivatschule.model.Place" %>
<%@ page import="com.rheinlandprivatschule.repository.PlaceDao" %>
<%@ page import="java.sql.Date" %>


<body bgcolor="#FFFFFF" text="#000000">
<%
    RPS rps=(RPS)session.getAttribute("handler");
    if(rps==null){
        String err="Sitzung lief Ab";
        session.setAttribute("err",err);
        session.setAttribute("lin","../index.jsp");
        response.sendRedirect("error.jsp");
    }else{
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
        String email=(String)request.getParameter("txtEmail");
        String selpla=(String)request.getParameter("selpla");
        Date dd=MyDate.getSQLDateFromStrings(birthday,birthmonth,birthyear,MyDate.DEUTSCH);
        Date registerdate=MyDate.getCurrentSQLDate();
        Date condate= MyDate.getCurrentSQLDate();
        Date coursedate=MyDate.getCurrentSQLDate();

        Place place=(new PlaceDao()).getPlace(Integer.parseInt(selpla));

        Student u=new Student();
        u.setUserFirstName(firstname);
        u.setUserLastName(lastname);
        u.setUserBirthDate(MyDate.getSQLDateFromStrings(birthday,birthmonth,birthyear,MyDate.DEUTSCH));
        u.setUserGender(Integer.parseInt(usergender));
        u.setUserBirthPlace(birthplace);
        u.setUserCountryID(Integer.parseInt(nationality));
        u.setUserCO(co);
        u.setUserAddress(address);
        u.setUserPostCode(postcode);
        u.setUserCity(city);
        u.setUserCountry(country);
        u.setUserHomePhone(homeno);
        u.setUserMobilePhone(mobileno);
        u.setUserEmail(email);
        u.setUserRemarks("");
        u.setUserRegDate(registerdate);
        u.setUserGradingDate(registerdate);
        u.setUserConclusion(condate);
        u.setUserConcCourse(coursedate);
        StudentDao sdb= (StudentDao) request.getAttribute("studentDao");
        int userid=sdb.addNewStudent(u);
        if(userid>0){
            sdb.addOnlineInfo(userid);
            u.setUserID(userid);
            session.setAttribute("pstudent",u);
            session.setAttribute("city",place);
            String lin="info";
            response.sendRedirect(lin);
        }else{
            String err="Misserfolg, Noch einmal versuchen. "+sdb.getError();
            session.setAttribute("err",err);
            session.setAttribute("lin","../../../index");
            response.sendRedirect("error");
        }
        session.setAttribute("handler",rps);
    }
%>
</body>
</html>