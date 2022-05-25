<%--
  Created by IntelliJ IDEA.
  User: cemasma
  Date: 4/12/2019
  Time: 2:50 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Suchkursteilnehmer ::</title>
    <style>
        table tr {
            border-bottom: 1px solid white;
        }

    </style>
</head>
<body>
<div id="wrapper" class="wrapper">
    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">
        <jsp:include page="templates/navbar.jsp"/>

        <!-- Main Content -->
        <div id="content">
            <!-- Begin Page Content -->
            <div class="container-fluid">

                <div class="wrapper" style="padding-left: 17.5%; padding-right: 17.5%;">
                    <a class="btn btn-primary" href="../index" style="float: right;">Haupt</a>
                    <table width="100%" border="0" cellpadding="1" cellspacing="1">
                        <tbody>
                        <tr>
                            <td bgcolor="657A9A" height="17">
                                <div align="center"><font size="3" color="#FFFFFF"><b>Suchresultat</b></font></div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                    <tbody>
                                    <tr>
                                        <td height="20" bgcolor="657A9A" width="41%"><font color="#FFFFFF" size="2"><b>Summe</b></font>
                                        </td>
                                        <td height="20" bgcolor="657A9A" colspan="2">
                                            <div align="right"><font size="2" color="#FFFFFF"><b>${students.size()}</b></font>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="20" bgcolor="657A9A" width="41%"><b><font size="3" color="#FFFFFF">Vorname</font></b>
                                        </td>
                                        <td height="20" bgcolor="657A9A" width="39%"><b><font size="3" color="#FFFFFF">Nachname</font></b>
                                        </td>
                                        <td height="20" bgcolor="657A9A" width="20%"><b><font size="3" color="#FFFFFF">Geburtsdatum</font></b>
                                        </td>
                                    </tr>
                                    <c:forEach items="${students}" var="student">
                                        <tr bgcolor="AEBACD">
                                            <td><font size="3" color="#000000"><a
                                                    href="showStudentPreciseD?userid=${student.userID}">${student.userFirstName}</a></font>
                                            </td>
                                            <td bgcolor="AEBACD"><font size="3"
                                                                       color="#000000">${student.userLastName}</font>
                                            </td>
                                            <td bgcolor="AEBACD"><font size="3"
                                                                       color="#000000">${student.userBirthDate}</font>
                                            </td>
                                        </tr>
                                    </c:forEach>

                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="templates/footer.jsp"/>
<jsp:include page="templates/bodyimports.jsp"/>
</body>
</html>