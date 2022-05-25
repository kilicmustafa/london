<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Allgemeine Benutzer Bemerkung  ::</title>
    <style>
        table tr {
            border-bottom: 1px solid white;
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
                    <div class="wrapper" style="margin-bottom: 5px; float:right;">
                        <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="window.history.go(-1); return false;">Zurück</a>
                        <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                    </div>
                    <form name="form1" method="post" action="adminRemarksUpdateProcess">
                        <table width="100%" border="0" cellspacing="1" cellpadding="1">
                            <tbody>
                            <input type="hidden" name="userid" value="${systemUser.userID}">
                            <tr bgcolor="657A9A">
                                <td colspan="2">
                                    <div align="center"><font size="2"><b><font color="#FFFFFF">Allgemeine Benutzer
                                        Bemerkung</font></b></font></div>
                                </td>
                            </tr>
                            <tr>
                                <td bgcolor="AEBACD" colspan="2">
                                    <textarea name="text" rows="15" cols="70">${systemUser.userRemarks}</textarea>
                                </td>
                            </tr>
                            <tr>
                                <td bgcolor="AEBACD" colspan="2">
                                    <input class="btn btn-primary" type="submit" name="Submit" value="OK">
                                </td>
                            </tr>
                            </tbody></table>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="templates/footer.jsp"/>
<jsp:include page="templates/bodyimports.jsp"/>
</body>
</html>
