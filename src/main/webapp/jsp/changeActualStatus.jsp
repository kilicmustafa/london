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
<%@ page import="com.rheinlandprivatschule.repository.GroupDao" %>

<%

    String status="0";
    String studentid="0";
    String groupid="0";
    String parent="0";
    GroupDao sidb = (GroupDao) request.getAttribute("groupDao");

    try{
        status=(String)request.getParameter("status");
        //studentid=(String)request.getParameter("userid");
        parent=(String)request.getParameter("parent");
        groupid=(String)request.getParameter("wid");


        if(sidb.setGroupStatus(Integer.parseInt(groupid),Integer.parseInt(status))){
            response.sendRedirect("groupList?parent="+parent);
        }else{
            String err=sidb.getError();
            session.setAttribute("err",err);
            session.setAttribute("lin","groupList?parent="+parent);
            response.sendRedirect("error");
        }
    }
    catch(Exception e){
        String err="Problem, noch einmal versuchen"+e.toString();
        session.setAttribute("err",err);
        session.setAttribute("lin","groupList?parent="+parent);
        response.sendRedirect("error");
    }
%>
<!-- End ImageReady Slices -->
</BODY>
</HTML>