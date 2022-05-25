<%@ page import="com.rheinlandprivatschule.model.CourseRegistration" %>
<%@ page import="com.rheinlandprivatschule.repository.StudentDao" %>
<%@ page import="com.rheinlandprivatschule.repository.TransactionDao" %>
<html>
<head>
    <title>:: Change Course Process ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%
    StudentDao studentDB= (StudentDao) request.getAttribute("studentDao");

    String courseid= request.getParameter("selCourse");
    CourseRegistration cr=(CourseRegistration)session.getAttribute("cr");
    session.setAttribute("cr",cr);

    int newCourseID=Integer.parseInt(courseid);
    if(studentDB.changeCourseRegistration(cr,newCourseID)){
        if((new TransactionDao()).updateTransactions(cr.getCourseID(),cr.getStudentID(),newCourseID)){
            response.sendRedirect("changeCourseAfterPlan?courseID="+newCourseID);
        }else{
            String err="Kurs kann nicht geändert werden. "+studentDB.getError();
            session.setAttribute("err",err);
            session.setAttribute("lin","showStudentPreciseD?userid="+cr.getStudentID());
            response.sendRedirect("error");
        }

    }else{
        String err="Kurs kann nicht geändert werden. "+studentDB.getError();
        session.setAttribute("err",err);
        session.setAttribute("lin","showStudentPreciseD?userid="+cr.getStudentID());
        response.sendRedirect("error");
    }
%>
</body>
</html>
