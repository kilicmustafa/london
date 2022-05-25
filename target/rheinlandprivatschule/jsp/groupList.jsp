<%@ page import="com.rheinlandprivatschule.repository.GroupDao" %>
<%@ page import="com.rheinlandprivatschule.model.Group" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Group Klassifikation ::</title>
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
        function back()
        {
            window.location="groupList"
        }
        function insurance()
        {
            window.location="../insurance/insuranceList"
        }
        function newgroupclass(){
            window.location="newGroup?isdir="+document.form1.isdir.value;
        }


    </script>
</head>
<body>
<%
    GroupDao wdb = (GroupDao) request.getAttribute("groupDao");
    ArrayList groupList=new ArrayList();

    String isdir="0";
    String isdir1="0";
    int pageStatus=-1;
    int parent1=0;

    String parentS1=request.getParameter("parent1");
    String flag1=(String)request.getParameter("status1");
    if(parentS1!=null){
        parent1=Integer.parseInt(parentS1);
        isdir1=parentS1;
    }

    int parent=0;
    String parentS=request.getParameter("parent");
    String flag=(String)request.getParameter("status");
    if(parentS!=null){
        parent=Integer.parseInt(parentS);
        isdir=parentS;
    }

    if(flag==null){
        pageStatus=wdb.STUDENTACTIVE;
        groupList=wdb.getAllGroupsStatus(parent,wdb.STUDENTACTIVE);
    }else{
        pageStatus=wdb.STUDENTNOTACTIVE;
        groupList=wdb.getAllGroupsStatus(parent,wdb.STUDENTNOTACTIVE);
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="groupList?status=0&parent=<%=isdir%>">Nicht Aktivliste</a>

                                <a style="margin-right: 5px;" class="btn btn-primary" href="groupList?parent=<%=isdir%>">Aktivliste</a>

                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="newgroupclass()">Neuer Group</a>

                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="back()">Zur&uuml;ck</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <table width="100%" border="0" height="120">
                            <tr>
                                <td height="423" valign="top">
                                    <form style="width: 100%;" name="form1" method="post" action="">
                                        <input name="groupid" type="hidden" id="groupid" value="<%=isdir%>">
                                        <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                            <tr bgcolor="657A9A">
                                                <td height="22" colspan="4"><div align="center"><b><font color="#FFFFFF">Group Klassifikation </font></b></div></td>
                                            </tr>
                                            <tr bgcolor="657A9A">
                                                <td width="69%" height="6"><b><font size="2" color="#FFFFFF">Group Klassifikation </font></b><b></b>
                                                    <input name="isdir" type="hidden" id="isdir" value="<%=isdir%>"></td>
                                                <td width="12%">&nbsp;</td>
                                                <td height="6" width="7%">&nbsp;</td>
                                                <td width="12%">&nbsp;</td>
                                            </tr>
                                            <%
                                                Iterator groupListIT=groupList.iterator();
                                                while(groupListIT.hasNext()){
                                                    Group group=(Group)groupListIT.next();
                                                    String name = "Aktualisierung";
                                                    //int id = group.getStatus();
                                                    //if(id==1){
                                                    //name = "";
//}
                                                    if(pageStatus==wdb.STUDENTNOTACTIVE){
                                            %>
                                            <tr bgcolor="AEBACD">
                                                <td height="5"><font size="2" color="#000033"><a href="groupList?parent=<%=group.getGroupID()%>"><%=group.getGroupName()%></a></font><font color="#000033" size="2">&nbsp;</font></td>
                                                <td height="5"><font color="#000033" size="2"><a href="groupStudentList?wid=<%=group.getGroupID()%>">Sch&uuml;ler/in</a></font></td>
                                                <td width="7%" height="5"><font size="2" color="#000033"><a href="viewGroup?id=<%=group.getGroupID()%>"><%=name%></a></font></td>
                                                <td width="12%"><font color="#000033" size="2"><a href="changeActualStatus?parent=<%=isdir%>&wid=<%=group.getGroupID()%>&status=<%=wdb.STUDENTACTIVE%>">Aktiv</a></font></td>
                                            </tr>
                                            <%
                                            }else if(pageStatus==wdb.STUDENTACTIVE){
                                            %>
                                            <tr bgcolor="AEBACD">
                                                <td height="5"><font size="2" color="#000033"><a href="groupList?parent=<%=group.getGroupID()%>"><%=group.getGroupName()%></a></font><font color="#000033" size="2">&nbsp;</font></td>
                                                <td height="5"><font color="#000033" size="2"><a href="groupStudentList?wid=<%=group.getGroupID()%>">Sch&uuml;ler/in</a></font></td>
                                                <td width="7%" height="5"><font size="2" color="#000033"><a href="viewGroup?id=<%=group.getGroupID()%>"><%=name%></a></font></td>
                                                <td width="12%"><font color="#000033" size="2"><a href="changeActualStatus?parent=<%=isdir%>&wid=<%=group.getGroupID()%>&status=<%=wdb.STUDENTNOTACTIVE%>">Nicht Aktiv</a></font></td>
                                            </tr>
                                            <%
                                                    }
                                                }
                                            %>
                                            <tr bgcolor="AEBACD">
                                                <td height="6" bgcolor="AEBACD" colspan="4">&nbsp;</td>
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
