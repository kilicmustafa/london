<html>
<head>
    <title>:: Update Student ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<%@ page import="com.rheinlandprivatschule.repository.StudentDao" %>
<%@ page import="com.rheinlandprivatschule.repository.CourseDao" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="com.rheinlandprivatschule.model.Course" %>
<%@ page session="true" %>

<body bgcolor="#FFFFFF" text="#000000">
<%
    StudentDao studentDB= (StudentDao) request.getAttribute("studentDB");

    CourseDao courseDB= (CourseDao) request.getAttribute("courseDB");

    RPS rps=(RPS)session.getAttribute("handler");
    Student student=(Student)session.getAttribute("pstudent");
    if(student==null){
        student=new Student();
    }else{
        String freigabeChoice=(String)request.getParameter("rdChoice");

        //java.sql.Date grade=MyDate.getSQLDateFromStrings(gradeDay,gradeMonth,gradeYear,MyDate.DEUTSCH);
        java.sql.Date enddate= MyDate.getCurrentSQLDate();
        Course course=courseDB.getMaxCourseEndDate(student.getUserID());

        int freigabeStatus=Integer.parseInt(freigabeChoice);
        student.setFreigabeStatus(freigabeStatus);
        if(freigabeStatus==2){
            student.setFreigabeDate(course.getCourseEndDate());
        }else{
            student.setFreigabeDate(enddate);
        }
        //student.setUserConclusion(MyDate.getSQLDateFromStrings(conclusionday, conclusionmonth,conclusionyear,MyDate.DEUTSCH));
        //student.setUserConcCourse(MyDate.getSQLDateFromStrings(concourseday, concoursemonth,concourseyear,MyDate.DEUTSCH));

        if(studentDB.updateStudentFreigabe(student,rps.getLoginUser().getUserID())){
            response.sendRedirect("showStudentPreciseD?userid="+student.getUserID());
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
