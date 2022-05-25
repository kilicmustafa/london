<%@ page import="com.rheinlandprivatschule.repository.GroupDao" %>
<HTML>
<HEAD>
    <TITLE>:: Schuler Loschen  ::</TITLE>
    <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
    <!-- ImageReady Preload Script (Template.psd) -->
    <SCRIPT TYPE="text/javascript">

    </SCRIPT>
    <!-- End Preload Script -->
</HEAD>
<BODY BGCOLOR=#FFFFFF LEFTMARGIN=0 TOPMARGIN=0 MARGINWIDTH=0 MARGINHEIGHT=0 ONLOAD="">
<!-- ImageReady Slices (Template.psd) -->

<%
    String studid=(String)request.getParameter("cmd");
    String groupid=(String)request.getParameter("wid");
    GroupDao vt = (GroupDao) request.getAttribute("groupDao");

    vt.deleteGroupRelatedToClient(Integer.parseInt(studid));

    response.sendRedirect("groupStudentList?wid="+groupid);

%>
<!-- End ImageReady Slices -->
</BODY>
</HTML>