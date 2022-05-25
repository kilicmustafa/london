<%@ page import="com.rheinlandprivatschule.repository.GroupDao" %>
<%@ page import="com.rheinlandprivatschule.model.Group" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="com.rheinlandprivatschule.model.StudentFinance" %>
<%@ page import="com.rheinlandprivatschule.repository.StudentDao" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Schuler Liste ::</title>
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
        function notactive()
        {
            window.location="groupStudentList?status="+document.form1.status.value;;
        }
        function active()
        {
            window.location="groupStudentList";
        }

        function back()
        {
            window.location="groupList";
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
    GroupDao wdb = (GroupDao) request.getAttribute("groupDao");
    StudentDao sdb = (StudentDao) request.getAttribute("studentDao");
    Group group = new Group();
    Vector students=new Vector();
    double geb=0;
    double bez=0;
    double noc=0;

    int groupid=0;
    int pageStatus=-1;


    String werS=(String)request.getParameter("wid");
    String flag=(String)request.getParameter("status");

    try{
        int wer =Integer.parseInt(werS);
        //students=sdb.getStudentRelatedToGroup(wer);
        group = wdb.getGroup(wer);

        groupid = group.getGroupID();

    }catch(Exception e){
    }

    if(flag==null){
        pageStatus=wdb.STUDENTACTIVE;
        students=wdb.getStudentRelatedToGroup(groupid,wdb.STUDENTACTIVE);
    }else{
        pageStatus=wdb.STUDENTNOTACTIVE;
        students=wdb.getStudentRelatedToGroup(groupid,wdb.STUDENTNOTACTIVE);
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
                                <input name="status" type="hidden" id="status" value="notactive">
                                <input name="groupid" type="hidden" id="groupid" value="<%=groupid%>">

                                <a style="margin-right: 5px;" class="btn btn-primary" href="groupStudentList?status=0&wid=<%=groupid%>">Nicht Aktivliste</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="groupStudentList?wid=<%=groupid%>">Aktivliste</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="back()">Zur&uuml;ck</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <table width="100%" border="0" cellpadding="1" cellspacing="1">

                            <tr>
                                <td bgcolor="657A9A" height="17">
                                    <div align="center"><font size="3" color="#FFFFFF"><b>Student
                                        des Group
                                        <input type="hidden" name="hiddenField">
                                    </b></font></div>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top">                      <form style="width: 100%;" name="form1" method="post" action="">
                                    <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                        <tr>
                                            <td bgcolor="657A9A" width="15%"><font color="#FFFFFF" size="2"><b>Summe </b></font></td>
                                            <td height="20" bgcolor="657A9A" width="15%"><font color="#FFFFFF" size="2">&nbsp;</font></td>
                                            <td height="20" bgcolor="657A9A" colspan="6"><div align="right"><font size="2" color="#FFFFFF"><b><%=students.size()%></b></font></div></td>
                                        </tr>
                                        <tr>
                                            <td bgcolor="657A9A" width="15%"><b><font size="2" color="#FFFFFF">Kunden-Nr</font></b></td>
                                            <td height="20" bgcolor="657A9A" width="15%"><b><font size="2" color="#FFFFFF">Vorname</font></b></td>
                                            <td height="20" bgcolor="657A9A" width="17%"><b><font size="2" color="#FFFFFF">Nachname</font></b></td>
                                            <td bgcolor="657A9A" width="15%"><b><font size="2" color="#FFFFFF">Name</font></b></td>
                                            <td bgcolor="657A9A" width="15%"><b><font size="2" color="#FFFFFF">Email</font></b></td>
                                            <td bgcolor="657A9A" width="15%"><b><font size="2" color="#FFFFFF">Telefon</font></b></td>
                                            <td height="20" colspan="2" bgcolor="657A9A">&nbsp;</td>
                                        </tr>
                                        <%
                                            for(int i=0;i<students.size();i++)
                                            {
                                                Student uu=(Student)students.elementAt(i);
                                                StudentFinance sf=sdb.getStudentFinanceStatus(uu.getUserID());
                                                geb=geb+sf.getTotalFee();
                                                bez=bez+(sf.getTotalFee()-sf.getBalance());
                                                noc=noc+sf.getBalance();
                                                if(pageStatus==wdb.STUDENTNOTACTIVE){
                                        %>
                                        <tr bgcolor="AEBACD">
                                            <td><font size="2" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><a href="../schuler/showStudentPreciseD?userid=<%=uu.getUserID()%>"><%=uu.getUserID()%></a></font></td>
                                            <td><font size="2" color="#000000"><a href="../schuler/showStudentPreciseD?userid=<%= uu.getUserID()%>"><%=uu.getUserFirstName()%></a></font></td>
                                            <td bgcolor="AEBACD"><font size="2" color="#000000"><%=uu.getUserLastName()%></font></td>
                                            <td bgcolor="AEBACD"><font size="2" color="#000000"><%=uu.getUserFirstName()%> </a><%=uu.getUserLastName()%></font></td>
                                            <td bgcolor="AEBACD"><font size="2" color="#000000"><%=uu.getUserEmail()%></font></td>
                                            <td bgcolor="AEBACD"><font size="2" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=uu.getUserMobileCode()%><%=uu.getUserMobileRegion()%><%=uu.getUserMobilePhone()%></font></td>
                                            <td width="13%"><font color="#000033" size="2"><a href="changeGroupStatus?wid=<%=groupid%>&status=<%=wdb.STUDENTACTIVE%>&userid=<%= uu.getUserID()%>">Aktiv</a></font></td>
                                            <td width="13%" height="20" ><font size="2" color="#000033"><a href="deleteStudent?wid=<%=groupid%>&cmd=<%=uu.getUserID()%>"> L&ouml;schen</a></font></td>
                                        </tr>
                                        <%
                                        }else if(pageStatus==wdb.STUDENTACTIVE){
                                        %>
                                        <tr bgcolor="AEBACD">
                                            <td width="15%"><font size="2" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><a href="../schuler/showStudentPreciseD?userid=<%=uu.getUserID()%>"><%=uu.getUserID()%></a></font></td>
                                            <td width="15%"><font size="2" color="#000000"><%=uu.getUserFirstName()%></font></td>
                                            <td bgcolor="AEBACD" width="17%"><font size="2" color="#000000"><%=uu.getUserLastName()%></font></td>
                                            <td bgcolor="AEBACD" width="15%"><font size="2" color="#000000"><%=uu.getUserFirstName()%></a> <%=uu.getUserLastName()%></font></td>
                                            <td bgcolor="AEBACD" width="15%"><font size="2" color="#000000"><%=uu.getUserEmail()%></font></td>
                                            <td bgcolor="AEBACD" width="15%"><font size="2" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=uu.getUserMobileCode()%><%=uu.getUserMobileRegion()%><%=uu.getUserMobilePhone()%></font></td>
                                            <td width="13%"><font color="#000033" size="2"><a href="changeGroupStatus?wid=<%=groupid%>&status=<%=wdb.STUDENTNOTACTIVE%>&userid=<%= uu.getUserID()%>">Nicht Aktiv</a></font></td>
                                            <td width="13%" height="20" ><font size="2" color="#000033"><a href="deleteStudent?wid=<%=groupid%>&cmd=<%=uu.getUserID()%>"> L&ouml;schen</a></font></td>
                                        </tr>
                                        <%
                                                }
                                            }
                                        %>
                                        <tr bgcolor="657A9A">
                                            <td width="15%">&nbsp;</td>
                                            <td width="15%">&nbsp;</td>
                                            <td width="17%">&nbsp;</td>
                                            <td width="15%">&nbsp;</td>
                                            <td width="15%">&nbsp;</td>
                                            <td width="15%">&nbsp;</td>
                                            <td colspan="2">&nbsp;</td>
                                        </tr>
                                    </table>
                                </form></td>
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
