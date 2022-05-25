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
    MahnungDao mdb= (MahnungDao) request.getAttribute("mdb");
    RPS rps= (RPS)request.getSession().getAttribute("handler");
    session.setAttribute("handler",rps);
    String sid=(String)request.getParameter("uid");
    String cid=(String)request.getParameter("cid");
    Vector v=mdb.getAllUnklarCategoriesForUnklar(rps.getLoginUser().getUserID());
    if(v==null){
        String err=mdb.getError();
        session.setAttribute("err",err);
        session.setAttribute("lin","../map.jsp");
        response.sendRedirect("/error");
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width: 100%;" name="form1" method="post" action="unklar">
                            <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                <tr bgcolor="657A9A">
                                    <td height="22">
                                        <div align="center"><b><font color="#FFFFFF">Unklar
                                            Katogorie Liste </font></b></div>
                                    </td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td bgcolor="657A9A" height="18">
                                        <div align="left"><font color="#FFFFFF"><b><font size="2">Katogorie</font></b></font></div>
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6"><font size="2" color="#000033">
                                        <select name="select">
                                            <option value="0" selected>w?hlen katogorie</option>
                                            <%
                                                for(int i=0;i<v.size();i++)
                                                {
                                                    UnklarCat m=(UnklarCat)v.elementAt(i);

                                            %>
                                            <option value="<%=m.getCatID()%>"><%=m.getCatName()%></option>
                                            <%

                                                }
                                            %>
                                        </select>
                                        <input type="hidden" name="uid" value="<%=sid%>">
                                        <input type="hidden" name="cid" value="<%=cid%>">
                                    </font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6">
                                        <input class="btn btn-primary" type="submit" name="Submit" value="Unklar">
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
