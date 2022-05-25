<%@ page import="com.rheinlandprivatschule.repository.GroupDao" %>
<%@ page import="com.rheinlandprivatschule.model.Group" %>
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
    </script>
</head>
<body>
<%
    GroupDao wdb = (GroupDao) request.getAttribute("groupDao");
    Group group = null;

    String wid=(String)request.getParameter("id");
    if(wid!=null){
        group=wdb.getGroup(Integer.parseInt(wid));
    }else{
        String catidP=(String)request.getParameter("hidID");
        group=wdb.getGroup(Integer.parseInt(catidP));
        String catnameP=(String)request.getParameter("txtName");
        String catdetailP=(String)request.getParameter("detail");
        group.setGroupName(catnameP);
        group.setGroupDetail(catdetailP);

        if(!wdb.updateGroup(group))	{
            String err=wdb.getError();
            session.setAttribute("err",err);
            session.setAttribute("lin","groupList");
            response.sendRedirect("error");
        }else{
            response.sendRedirect("groupList");
        }
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

                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="back()">Zur&uuml;ck</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width: 100%;" name="form1" method="post" action="viewGroup">
                            <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                <tr bgcolor="657A9A">
                                    <td height="22" colspan="2">
                                        <div align="center"><b><font color="#FFFFFF">Group Klassifikation </font></b></div>
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="20" bgcolor="657A9A" width="26%"><b><font size="2" color="#FFFFFF">Klassifikation
                                        ID </font></b></td>
                                    <td height="20" bgcolor="AEBACD" width="74%"><font size="2" color="#000033"><%=group.getGroupID()%>
                                        <input type="hidden" name="hidID" value="<%=group.getGroupID()%>">
                                    </font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6" bgcolor="657A9A" width="26%"><b><font size="2" color="#FFFFFF">Klassifikationname
                                    </font></b></td>
                                    <td height="6" bgcolor="AEBACD" width="74%">
                                        <input type="text" name="txtName" value="<%=group.getGroupName()%>">
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Group bemerkung</font></strong></td>
                                    <td height="6" bgcolor="AEBACD"><textarea name="detail" cols="40" rows="3" id="detail"><%=group.getGroupDetail()%></textarea></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6" bgcolor="657A9A" width="26%">&nbsp;</td>
                                    <td height="6" bgcolor="AEBACD" width="74%">
                                        <input class="btn btn-primary" type="submit" name="Submit" value="OK">
                                    </td>
                                </tr>
                            </table>
                        </form>
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
