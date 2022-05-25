<%@ page import="com.rheinlandprivatschule.repository.MahnungDao" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ page import="com.rheinlandprivatschule.model.MahnungElement" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Block Mahnung Liste ::</title>
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
    
</head>
<body>
<%
    Vector v=new Vector();
    double total=0;

    RPS rps=(RPS)session.getAttribute("handler");
   
    MahnungDao mdb= (MahnungDao) request.getAttribute("mdb");
    Vector vv=mdb.getMahnungListWithDatum(rps.getLoginUser().getUserID());
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
                                                        <td height="22" colspan="4">
                                                            <div align="center"><b><font color="#FFFFFF">Block Mahnung
                                                                Liste </font></b></div>
                                                        </td>
                                                    </tr>
                                                    <tr bgcolor="657A9A">
                                                        <td bgcolor="657A9A" height="22"><font size="2" color="#FFFFFF"><b>Summe</b></font></td>
                                                        <td bgcolor="657A9A" height="22">&nbsp;</td>
                                                        <td bgcolor="657A9A" height="22">&nbsp;</td>
                                                        <td width="17%" height="22" bgcolor="657A9A">
                                                            <div align="right"><font size="2" color="#FFFFFF"><b><%=v.size()%></b></font></div></td>
                                                    </tr>
                                                    <tr bgcolor="657A9A">
                                                        <td bgcolor="657A9A" height="22" width="29%">
                                                            <div align="left"><font color="#FFFFFF"><b><font size="2">Vorname</font></b></font></div>
                                                        </td>
                                                        <td bgcolor="657A9A" height="22" width="29%"><font size="2" color="#FFFFFF"><b>Nachname</b></font></td>
                                                        <td bgcolor="657A9A" height="22" width="25%"><font size="2" color="#FFFFFF"><b>kursname</b></font></td>
                                                        <td height="22" bgcolor="657A9A"><font color="#FFFFFF" size="2"><b>Nochoffen</b></font></td>
                                                    </tr>
                                                    <%
                                                        for(int i=0;i<v.size();i++)
                                                        {
                                                            MahnungElement m=(MahnungElement)v.elementAt(i);
                                                            total=total+m.getBalance();
                                                    %>
                                                    <tr bgcolor="AEBACD">
                                                        <td height="6" width="29%"><font size="2" color="#000033"><a href="../schuler/showStudentPreciseD?userid=<%=m.getUserID()%>"><%=m.getUserName()%></a></font></td>
                                                        <td height="6" width="29%"><font size="2" color="#000033"><%=m.getUserLastName()%></font></td>
                                                        <td height="6" width="25%"><font size="2" color="#000033"><%=m.getCourseName()%></font></td>
                                                        <td height="6"><font color="#000033" size="2"><%=MyCurrency.getDisplayString(m.getBalance())%></font><font size="2" color="#000033"></font><font size="2" color="#000033"></font><font size="2" color="#000033"></font></td>
                                                    </tr>

                                                    <%
                                                        }
                                                    %>
                                                    <tr bgcolor="657A9A">
                                                        <td height="6" width="29%">&nbsp;</td>
                                                        <td height="6" width="29%">&nbsp;</td>
                                                        <td height="6" width="25%">&nbsp;</td>
                                                        <td height="6" bgcolor="657A9A"><font size="2" color="#FFFFFF"><b><%=MyCurrency.getDisplayString(total)%></b></font></td>
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
