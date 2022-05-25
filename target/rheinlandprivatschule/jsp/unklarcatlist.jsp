<%@ page import="com.rheinlandprivatschule.repository.MahnungDao" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.model.UnklarCat" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Unklar Katogorie Liste ::</title>
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
        function newcat()
        {
            window.location="newCat";
        }
        function stk(msg,uid,cid)
        {
            if(!confirm(msg))
            {
                return false;
            }
            else
            {
                window.location="sendInKaso?userid="+uid+"&courseid="+cid;
            }
        }
        function leave(msg,cid,uid)
        {
            if(!confirm(msg))
            {
                return false;
            }
            else
            {
                window.location="nor?cid="+cid+"&uid="+uid;
            }
        }
        function leave1(msg,cid,uid)
        {
            if(!confirm(msg))
            {
                return false;
            }
            else
            {
                window.location="send?cid="+cid+"&uid="+uid;
            }
        }
    </script>
</head>
<body>
<%
    MahnungDao mdb = (MahnungDao) request.getAttribute("mdb");

    RPS rps=(RPS)session.getAttribute("handler");
    session.setAttribute("handler",rps);
    Vector vv=mdb.getAllUnklarCategoriesForList(rps.getLoginUser().getUserID());
    Vector v = new Vector();
    if(vv==null){
        String err=mdb.getError();
        session.setAttribute("err",err);
        session.setAttribute("lin","../map.jsp");
        response.sendRedirect("/error");
    }else{
        v=vv;
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onClick="newcat()">Neue Katogory</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td valign="top" height="432" bgcolor="D9E5F4" width="83%">
                                    <table width="100%" border="0" height="120">
                                        <tr>
                                            <td height="100" valign="top">
                                                <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                                    <tr bgcolor="657A9A">
                                                        <td height="22" colspan="2">
                                                            <div align="center"><b><font color="#FFFFFF">Unklar
                                                                Katogorie Liste </font></b></div>
                                                        </td>
                                                    </tr>
                                                    <tr bgcolor="657A9A">
                                                        <td bgcolor="657A9A" height="18" colspan="2">
                                                            <div align="left"><font color="#FFFFFF"><b><font size="2">Katogorie</font></b></font></div>
                                                        </td>
                                                    </tr>
                                                    <%
                                                        for(int i=0;i<v.size();i++)
                                                        {
                                                            UnklarCat m=(UnklarCat)v.elementAt(i);

                                                    %>
                                                    <tr bgcolor="AEBACD">
                                                        <td height="6" width="84%"><font size="2" color="#000033"><a href="unklarlist?id=<%=m.getCatID()%>"><%=m.getCatName()%></a></font></td>
                                                        <td height="6" width="16%"><font size="2" color="#000033"><a href="catView?id=<%=m.getCatID()%>">Aktualisierung</a></font></td>
                                                    </tr>
                                                    <%

                                                        }
                                                    %>
                                                </table>
                                            </td>
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
