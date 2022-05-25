<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Alle Allgemeine Benutzer Liste ::</title>
    <style>
        table tr {
            border-bottom: 1px solid white;
        }

        html {
            overflow-y: hidden;
        }
    </style>
</head>
<body>
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
                        <div class="col-md-12">
                            <center>
                                <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                    <tr bgcolor="#315D73">
                                        <td colspan="2" bgcolor="657A9A">
                                            <div align="center"><font size="2"><b><font color="#FFFFFF">Best&auml;tigungsAnzeige</font></b></font></div>
                                        </td>
                                    </tr>
                                    <c:forEach items="${too}" var="to">
                                        <tr bgcolor="#315D73">
                                            <td colspan="2" bgcolor="AEBACB" height="16">
                                                <div align="center"><font face="Geneva, Arial, Helvetica, san-serif" size="2" color="#000033"><b>${to}</b></font></div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <tr bgcolor="#315D73">
                                        <td colspan="2" bgcolor="AEBACB" height="14">
                                            <div align="center"><font face="Geneva, Arial, Helvetica, san-serif" size="2" color="#000033"><b><font size="3"><a href="../map.jsp"><font size="2">Zur�ck</font></a></font></b></font></div>
                                        </td>
                                    </tr>
                                </table>
                            </center>
                        </div>
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
