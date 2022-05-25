<HTML>
<HEAD>
    <TITLE>:: Schulen ::</TITLE>
    <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
    <!-- ImageReady Preload Script (Template.psd) -->
    <SCRIPT TYPE="text/javascript">

    </SCRIPT>
    <!-- End Preload Script -->
</HEAD>
<BODY BGCOLOR=#FFFFFF LEFTMARGIN=0 TOPMARGIN=0 MARGINWIDTH=0 MARGINHEIGHT=0 ONLOAD="preloadImages();">
<!-- ImageReady Slices (Template.psd) -->
<%@ page import="java.util.*" %>
<%@ page import="com.rheinlandprivatschule.repository.GroupDao" %>

<%

    String status="0";
    String studentid="0";
    String groupid="0";
    GroupDao sidb = (GroupDao) request.getAttribute("groupDao");
    try{
        status=(String)request.getParameter("status");
        studentid=(String)request.getParameter("userid");
        groupid=(String)request.getParameter("wid");


        if(sidb.setStudentStatus(Integer.parseInt(studentid),Integer.parseInt(status))){
            response.sendRedirect("groupStudentList?wid="+groupid);
        }else{
            String err=sidb.getError();
            session.setAttribute("err",err);
            session.setAttribute("lin","groupStudentList?wid="+groupid);
            response.sendRedirect("error");
        }
    }
%>

<!-- End ImageReady Slices -->
</BODY>
</HTML>