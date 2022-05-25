<%@ page import="com.rheinlandprivatschule.repository.EmployeeHours" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<html>
<head>
    <title>:: Add Course Process ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%
    EmployeeHours emphours=new EmployeeHours();
    RPS rps = (RPS) session.getAttribute("handler");

    emphours.updateEmployeeBreak(rps.getLoginUser().getUserID());
    response.sendRedirect("addHoursSchedule");



%>
</body>
</html>
