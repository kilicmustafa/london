<%@ page import="com.rheinlandprivatschule.repository.BuchDao" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="com.rheinlandprivatschule.model.Place" %>
<%@ page import="com.rheinlandprivatschule.model.Buch" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: B&uuml;cher Liste ::</title>
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
        function su()
        {
            document.form1.submit();
        }
    </script>
</head>
<body>
<%
    BuchDao bdb= (BuchDao) request.getAttribute("buchDao");

    int b=0;

    RPS rps=(RPS)session.getAttribute("handler");
    Place myPlace = rps.getLoginPlace();
    String id= request.getParameter("selStufe");
    if(id!=null){
        b=Integer.parseInt(id);
    }
    Vector v=bdb.getAvailableBooks(myPlace.getPlaceID(),b);
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
                        <form name="form1" style="width: 100%;" method="post" action="schuleStock">
                            <table width="100%" border="0" height="120">
                                <tr>
                                    <td height="100" valign="top">
                                        <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                            <tr bgcolor="657A9A">
                                                <td height="22" colspan="2">
                                                    <div align="center"><b><font color="#FFFFFF">B&uuml;cher</font></b></div>
                                                </td>
                                            </tr>
                                            <tr bgcolor="657A9A">
                                                <td bgcolor="657A9A" height="22" width="15%">
                                                    <div align="left"><font color="#FFFFFF"><b><font size="2">Stufe</font></b></font></div>
                                                </td>
                                                <td bgcolor="AEBACD" height="22" width="85%">
                                                    <select name="selStufe" onChange="su()">
                                                        <%
                                                            if(b==0)
                                                            {
                                                        %>
                                                        <option value="0" selected>w&auml;hlen</option>
                                                        <option value="1">Grundstufe I</option>
                                                        <option value="2">Grundstufe II</option>
                                                        <option value="3">Mittelstufe I</option>
                                                        <option value="4">Mittelstufe II</option>
                                                        <option value="5">Oberstufe</option>
                                                        <%
                                                        }
                                                        else if(b==1)
                                                        {
                                                        %>
                                                        <option value="0">w&auml;hlen</option>
                                                        <option value="1" selected>Grundstufe I</option>
                                                        <option value="2">Grundstufe II</option>
                                                        <option value="3">Mittelstufe I</option>
                                                        <option value="4">Mittelstufe II</option>
                                                        <option value="5">Oberstufe</option>
                                                        <%
                                                        }
                                                        else if(b==2)
                                                        {
                                                        %>
                                                        <option value="0">w&auml;hlen</option>
                                                        <option value="1">Grundstufe I</option>
                                                        <option value="2" selected>Grundstufe II</option>
                                                        <option value="3">Mittelstufe I</option>
                                                        <option value="4">Mittelstufe II</option>
                                                        <option value="5">Oberstufe</option>
                                                        <%
                                                        }
                                                        else if(b==3)
                                                        {
                                                        %>
                                                        <option value="0">w&auml;hlen</option>
                                                        <option value="1">Grundstufe I</option>
                                                        <option value="2">Grundstufe II</option>
                                                        <option value="3" selected>Mittelstufe I</option>
                                                        <option value="4">Mittelstufe II</option>
                                                        <option value="5">Oberstufe</option>
                                                        <%
                                                        }
                                                        else if(b==4)
                                                        {
                                                        %>
                                                        <option value="0">w&auml;hlen</option>
                                                        <option value="1">Grundstufe I</option>
                                                        <option value="2">Grundstufe II</option>
                                                        <option value="3">Mittelstufe I</option>
                                                        <option value="4" selected>Mittelstufe II</option>
                                                        <option value="5">Oberstufe</option>
                                                        <%
                                                        }
                                                        else if(b==5)
                                                        {
                                                        %>
                                                        <option value="0" selected>w&auml;hlen</option>
                                                        <option value="1">Grundstufe I</option>
                                                        <option value="2">Grundstufe II</option>
                                                        <option value="3">Mittelstufe I</option>
                                                        <option value="4">Mittelstufe II</option>
                                                        <option value="5" selected>Oberstufe</option>
                                                        <%
                                                            }
                                                        %>
                                                    </select>
                                                </td>
                                            </tr>
                                            <%
                                                for(int i=0;i<v.size();i++)
                                                {
                                                    Buch bu=(Buch)v.elementAt(i);

                                            %>
                                            <tr bgcolor="AEBACD">
                                                <td height="6" colspan="2"><font size="2" color="#000033"><%=bu.getBookName()+"~"+bu.getBookTrack()%></font></td>
                                            </tr>
                                            <%
                                                }
                                            %>
                                        </table>
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
