<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.repository.MahnungDao" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="com.rheinlandprivatschule.model.MahnungElement" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Unklar Mahnung Liste ::</title>
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
        function leave3(msg,cid,uid)
        {
            if(!confirm(msg))
            {
                return false;
            }
            else
            {
                window.location="klar?cid="+cid+"&uid="+uid;
            }
        }
    </script>
</head>
<body>
<%
    MahnungDao mdb= (MahnungDao) request.getAttribute("mdb");
    RPS rps=(RPS)session.getAttribute("handler");
    double total=0;
    session.setAttribute("handler",rps);
    String id=(String)request.getParameter("id");
    Vector v=mdb.getUnklarMahnungList(Integer.parseInt(id),rps.getLoginUser().getUserID());
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
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td valign="top" height="432" bgcolor="D9E5F4" width="83%">
                                    <table width="100%" border="0" height="120">
                                        <tr>
                                            <td height="100" valign="top">
                                                <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                                    <tr bgcolor="657A9A">
                                                        <td height="22" colspan="6">
                                                            <div align="center"><b><font color="#FFFFFF">Mahnung
                                                                Liste </font></b></div>
                                                        </td>
                                                    </tr>
                                                    <tr bgcolor="657A9A">
                                                        <td bgcolor="657A9A" height="22" colspan="4"><font size="2" color="#FFFFFF"><b>Summe</b></font></td>
                                                        <td bgcolor="657A9A" height="22" colspan="2">
                                                            <div align="right"><font size="2" color="#FFFFFF"><b><%=v.size()%></b></font></div>
                                                        </td>
                                                    </tr>
                                                    <tr bgcolor="657A9A">
                                                        <td bgcolor="657A9A" height="22" width="21%">
                                                            <div align="left"><font color="#FFFFFF"><b><font size="2">Vorname</font></b></font></div>
                                                        </td>
                                                        <td bgcolor="657A9A" height="22" width="18%"><font size="2" color="#FFFFFF"><b>Nachname</b></font></td>
                                                        <td bgcolor="657A9A" height="22" width="28%"><font size="2" color="#FFFFFF"><b>kursname</b></font></td>
                                                        <td bgcolor="657A9A" height="22" width="10%"><font color="#FFFFFF" size="2"><b>Nochoffen</b></font></td>
                                                        <td bgcolor="657A9A" height="22" width="14%"><font size="2" color="#FFFFFF"><b>Vertrag</b></font></td>
                                                        <td bgcolor="657A9A" height="22" width="9%">&nbsp;</td>
                                                    </tr>
                                                    <%
                                                        for(int i=0;i<v.size();i++)
                                                        {
                                                            MahnungElement m=(MahnungElement)v.elementAt(i);
                                                            total=total+m.getBalance();
                                                    %>
                                                    <tr bgcolor="AEBACD">
                                                        <td height="6" width="21%"><font size="2" color="#000033"><a href="../schuler/showStudentPreciseD?userid=<%=m.getUserID()%>"><%=m.getUserName()%></a></font></td>
                                                        <td height="6" width="18%"><font size="2" color="#000033"><%=m.getUserLastName()%></font></td>
                                                        <td height="6" width="28%"><font size="2" color="#000033"><%=m.getCourseName()%></font></td>
                                                        <td height="6" width="10%"><font color="#000033" size="2"><%=MyCurrency.getDisplayString(m.getBalance())%></font></td>
                                                        <td height="6" width="14%"><font size="2" color="#000033"><a href="../../../ver/downVertragM?id=<%=m.getUserID()%>">Vertrag</a></font></td>
                                                        <td height="6" width="9%"><font size="2" color="#000033"><a href="" onClick="leave3('M�chten Sie die Mahnung zum Klar schiken?',<%=m.getCourseID()%>,<%=m.getUserID()%>);return false">Klar</a></font></td>
                                                    </tr>

                                                    <%

                                                        }
                                                    %>
                                                    <tr bgcolor="657A9A">
                                                        <td height="6" width="21%">&nbsp;</td>
                                                        <td height="6" width="18%">&nbsp;</td>
                                                        <td height="6" width="28%">&nbsp;</td>
                                                        <td height="6" width="10%"><font size="2" color="#FFFFFF"><b><%=MyCurrency.getDisplayString(total)%></b></font></td>
                                                        <td height="6" width="14%">&nbsp;</td>
                                                        <td height="6" width="9%">&nbsp;</td>
                                                    </tr>
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
