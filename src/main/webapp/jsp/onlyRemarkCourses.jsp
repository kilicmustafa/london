<%@ page import="com.rheinlandprivatschule.repository.StudentDao" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<html>
<head>
    <title>:: Update Remarks ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%
    StudentDao studentDB= (StudentDao) request.getAttribute("studentDao");
    Student u=(Student)session.getAttribute("pstudent");
    RPS rps=(RPS)session.getAttribute("handler");
    if(u==null)	{
        String err="Wählen Sie Schüler Zuerst aus";
        session.setAttribute("err",err);
        session.setAttribute("lin","seacrhStudent");
        response.sendRedirect("error");
    }else{
        session.setAttribute("pstudent",u);
        String remarks=(String)request.getParameter("textfield");
        if(studentDB.updateRemark(u.getUserID(),remarks,rps.getLoginUser().getUserID())){
            response.sendRedirect("showStudentPreciseD?userid="+u.getUserID());
        }else{
            String err=studentDB.getError();
            session.setAttribute("err",err);
            session.setAttribute("lin","../map");
            response.sendRedirect("error");
        }
    }
%>
</body>
</html>
