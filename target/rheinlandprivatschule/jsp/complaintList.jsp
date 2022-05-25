<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.model.SystemUser" %>
<%@ page import="com.rheinlandprivatschule.model.Place" %>
<%@ page import="com.rheinlandprivatschule.model.StudentComplaint" %>
<%@ page import="com.rheinlandprivatschule.repository.*" %>
<%@ page import="com.rheinlandprivatschule.model.Complaint" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Katagorie Liste ::</title>
    <style>
        table tr {
            border-bottom: 1px solid white;
        }

        html {
            overflow-y: hidden;
        }

        table a {
            color: #0000EE;
            text-decoration: underline;
        }
    </style>
    <script>
        function newComplaint()
        {
            window.location="newComplaint";
        }
        function notactive()
        {
            window.location="complaintList?status="+document.form1.status.value;
        }
        function active()
        {
            window.location="complaintList";
        }

        function back()
        {
            window.location="complaintList";
        }
        function searchstudentall()
        {
            window.location="searchStudentAll";
        }

        function MM_findObj(n, d) { //v4.0
            var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
                d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
            if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
            for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
            if(!x && document.getElementById) x=document.getElementById(n); return x;
        }
    </script>
</head>
<body>
<%
    ComplaintDao exp= (ComplaintDao) request.getAttribute("complaintDao");
    Vector v=new Vector();
    int pageStatus=-1;


    RPS rps= (RPS) request.getSession().getAttribute("handler");
    SystemUser loginuser= rps.getLoginUser();
    PlaceDao placeDB= (PlaceDao) request.getAttribute("placeDao");
    Vector image=new Vector();
    loginuser=rps.getLoginUser();
    String a=(String)request.getParameter("wid");

    String flag=(String)request.getParameter("status");
    if(flag==null){
        v=exp.getAllComplaints(0);
    }else{
        v=exp.getAllComplaints(Integer.parseInt(flag));
    }
    if(flag==null){
        pageStatus=exp.COMPLAINTACTIVE;
    }else{
        pageStatus=exp.COMPLAINTNOTACTIVE;
    }
%>
<div id="wrapper" class="wrapper" style="height: 100%;">
    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">
        <jsp:include page="templates/navbar.jsp"/>

        <!-- Main Content -->
        <div id="content">
            <!-- Begin Page Content -->
            <div class="container-fluid">

                <div class="wrapper" style="padding-left: 17.5%; padding-right: 17.5%;">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="wrapper" style="margin-bottom: 5px; float:right;">
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="newComplaint()">Neue Katagorie</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="/complaints/complaintList?status=1">Nicht Aktivliste</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="/complaints/complaintList">Aktivliste</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="back()">Zur&uuml;ck</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td valign="top" height="434" bgcolor="D9E5F4" width="82%">
                                    <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                        <tr>
                                            <input name="status" type="hidden" id="status" value="notactive">
                                            <td bgcolor="657A9A" height="17">
                                                <div align="center"><font size="3" color="#FFFFFF"><b>Beschwerden Katagorie
                                                    <input type="hidden" name="hiddenField">
                                                </b></font></div></td>
                                        </tr>
                                        <tr>
                                            <td valign="top">                      <form style="width: 100%;" name="form1" method="post" action="">
                                                <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                                    <tr>
                                                        <td height="20" bgcolor="657A9A" width="15%"><font color="#FFFFFF" size="2"><b>Summe </b></font></td>
                                                        <td height="20" bgcolor="657A9A" colspan="2"><div align="right"><font size="2" color="#FFFFFF"><b><%=v.size()%></b></font></div></td>
                                                    </tr>
                                                    <tr>
                                                        <td height="20" colspan="2" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Katagorie Name </font></b></td>
                                                        <td width="20%" height="20" bgcolor="657A9A">&nbsp;</td>
                                                    </tr>
                                                    <%
                                                        for(int i=0;i<v.size();i++){
                                                            Complaint ec=(Complaint)v.elementAt(i);
                                                            if(pageStatus==exp.COMPLAINTNOTACTIVE){
                                                    %>
                                                    <tr bgcolor="AEBACD">
                                                        <td colspan="2"><font size="2" color="#000033"><a href="complaintView?id=<%=ec.getComplaintID()%>"><%=ec.getComplaintName()%></a></font><font size="2" color="#000000">&nbsp;</font></td>
                                                        <td height="20"><font color="#000033" size="2"><a href="changeComplaintStatus?wid=<%=ec.getComplaintID()%>&status=<%=exp.COMPLAINTACTIVE%>">Aktiv</a></font></td>
                                                    </tr>
                                                    <%
                                                    }else if(pageStatus==exp.COMPLAINTACTIVE){
                                                    %>
                                                    <tr bgcolor="AEBACD">
                                                        <td colspan="2"><font size="2" color="#000033"><a href="complaintView?id=<%=ec.getComplaintID()%>"><%=ec.getComplaintName()%></a></font><font size="2" color="#000000">&nbsp;</font></td>
                                                        <td height="20"><font color="#000033" size="2"><a href="changeComplaintStatus?wid=<%=ec.getComplaintID()%>&status=<%=exp.COMPLAINTNOTACTIVE%>">Nicht Aktiv</a></font></td>
                                                    </tr>
                                                    <%
                                                            }
                                                        }
                                                    %>
                                                    <tr bgcolor="657A9A">
                                                        <td colspan="3">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </form></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="templates/footer.jsp"/>
<jsp:include page="templates/bodyimports.jsp"/>
</body>
</html>
