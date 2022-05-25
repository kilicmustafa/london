<%@ page import="com.rheinlandprivatschule.repository.StudentDao" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<html>
<head>
    <title>:: L&ouml;schen Kurs ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%
    int userid=0;
    StudentDao studentDB= (StudentDao) request.getAttribute("studentDao");

    Student u=(Student)session.getAttribute("pstudent");

    if(u==null){
        String err="Wählen Sie Schüler Zuerst aus";
        session.setAttribute("err",err);
        session.setAttribute("lin","seacrhStudent");
        response.sendRedirect("error");
    }
    session.setAttribute("pstudent",u);
    userid=u.getUserID();


    String courseidS= request.getParameter("cid");
    int courseID=0;
    try{
        courseID=Integer.parseInt(courseidS);
    }catch(Exception e){
    }

    if(courseID!=0){
        if(studentDB.deleteCourseRegistration(courseID,userid)){
            response.sendRedirect("showStudentPreciseD?userid="+u.getUserID());
        }else{
            String err="Kurs kann nicht gelöscht werden";
            session.setAttribute("err",err);
            session.setAttribute("lin","showStudentPreciseD?userid="+userid);
            response.sendRedirect("error");
        }
    }else{
        String err="Kurs kann nicht gelöscht werden";
        session.setAttribute("err",err);
        session.setAttribute("lin","showStudentPreciseD?userid="+userid);
        response.sendRedirect("error");
    }
%>
</body>
</html>
