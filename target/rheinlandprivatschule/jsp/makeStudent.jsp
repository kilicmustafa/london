<HTML>
<HEAD>
    <TITLE>:: Sch&uuml;ler Information ::</TITLE>
    <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
    <!-- ImageReady Preload Script (Template.psd) -->
    <!-- End Preload Script -->
</HEAD>
<BODY BGCOLOR=#FFFFFF LEFTMARGIN=0 TOPMARGIN=0 MARGINWIDTH=0 MARGINHEIGHT=0>
<!-- ImageReady Slices (Template.psd) -->
<%@ page import="java.util.*"%>
<%@ page import="com.rheinlandprivatschule.repository.ResidentDao" %>
<%@ page import="com.rheinlandprivatschule.repository.StudentDao" %>
<%@ page import="com.rheinlandprivatschule.model.Resident" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>

<%
    ResidentDao residentDB = (ResidentDao) request.getAttribute("residentDao");
    StudentDao studentDB = (StudentDao) request.getAttribute("studentDao");
    Resident resident = new Resident();
    Student student = new Student();

    int residentid=0;

    try{
        int rid=Integer.parseInt((String)request.getParameter("residentid"));
        int studentID = residentDB.updateResidentToStudent(rid);
        if(studentID>0){
            response.sendRedirect("../schuler/showStudentPreciseD?userid="+studentID);
        }else{
            String err=residentDB.getError();
            session.setAttribute("err",err);
            session.setAttribute("lin","../map");
            response.sendRedirect("error");
        }
    }catch(Exception e){
    }


%>
<!-- End ImageReady Slices -->
</BODY>
</HTML>