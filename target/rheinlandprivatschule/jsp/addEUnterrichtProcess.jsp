<%@ page import="com.rheinlandprivatschule.repository.SingleClassDao" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="com.rheinlandprivatschule.model.SingleClass" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<HTML>
<HEAD>
    <TITLE>:: Schulen ::</TITLE>
    <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
    <!-- ImageReady Preload Script (Template.psd) -->
    <SCRIPT TYPE="text/javascript">

    </SCRIPT>
    <!-- End Preload Script -->
</HEAD>
<BODY BGCOLOR=#FFFFFF LEFTMARGIN=0 TOPMARGIN=0 MARGINWIDTH=0 MARGINHEIGHT=0>
<!-- ImageReady Slices (Template.psd) -->

<%
    SingleClassDao sidb=new SingleClassDao();
    Student student=(Student)session.getAttribute("pstudent");
    try{
        String coursename=(String)request.getParameter("txtCName");
        String sDay=(String)request.getParameter("selSDay");
        String sMonth=(String)request.getParameter("selSMonth");
        String sYear=(String)request.getParameter("selSYear");

        String timing=(String)request.getParameter("txtTime");
        String fee=(String)request.getParameter("txtFee");
        String cityids=(String)request.getParameter("selectCity");
        String teacherids=(String)request.getParameter("selTeacher");
        double feeD=Double.parseDouble(fee);
        if(Integer.parseInt(teacherids)>0){
            SingleClass sc=new SingleClass();
            sc.setStudentID(student.getUserID());
            sc.setCourseName(coursename);
            sc.setPlaceID(Integer.parseInt(cityids));
            sc.setTeacherID(Integer.parseInt(teacherids));
            sc.setCLassDate(MyDate.getSQLDateFromStrings(sDay,sMonth,sYear,MyDate.DEUTSCH));
            sc.setClassTime(Integer.parseInt(timing));
            sc.setCourseFee(feeD);
            sidb.addSingleClass(sc);
            response.sendRedirect("addEUnterricht?userid="+student.getUserID());

        }else{
            String err="Zuerst wählen Sie ein Lehrer / Lehrerin";
            session.setAttribute("err",err);
            session.setAttribute("lin","showStudentPreciseD?userid="+student.getUserID());
            response.sendRedirect("error");
        }
    }catch(Exception e){
        String err="Problem, noch einmal versuchen";
        session.setAttribute("err",err);
        session.setAttribute("lin","showStudentPreciseD?userid="+student.getUserID());
        response.sendRedirect("error");
    }
%>

<!-- End ImageReady Slices -->
</BODY>
</HTML>