<html>
<head>
    <title>:: Add Course Process ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<%@ page import="java.util.*" %>
<%@ page import="com.rheinlandprivatschule.repository.EmployeeHours" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="com.rheinlandprivatschule.model.SystemUser" %>

<body bgcolor="#FFFFFF" text="#000000">
<%
    EmployeeHours emphours=new EmployeeHours();

    RPS rps = (RPS) session.getAttribute("handler");
    EmployeeHours emp=new EmployeeHours();

    String userIDS= request.getParameter("userid");

    Vector v=emp.getEmployeeSameOffice(rps.getLoginPlace().getPlaceID());

    emphours.addEmployeeInformation(Integer.parseInt(userIDS),rps.getLoginPlace().getPlaceID());
    if(v.size() >0){
        emp.updateEmployeeCount(rps.getLoginPlace().getPlaceID());
    }
    response.sendRedirect("addHoursSchedule");
%>
</body>
</html>
