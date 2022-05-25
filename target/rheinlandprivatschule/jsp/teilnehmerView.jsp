<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Nationalitat ::</title>
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
                        <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                    </div>


                    <form name="form1" method="post" action="teilnehmerView">
                        <table width="100%" border="0" cellpadding="1" cellspacing="1">
                            <tbody><tr bgcolor="657A9A">
                                <td height="22" colspan="2">
                                    <div align="center"><b><font color="#FFFFFF">Nationalitat</font></b></div>
                                </td>
                            </tr>
                            <tr bgcolor="AEBACD">
                                <td height="20" bgcolor="657A9A" width="26%"><b><font size="2" color="#FFFFFF">Nationalitat
                                    ID </font></b></td>
                                <td height="20" bgcolor="AEBACD" width="74%"><font size="2" color="#000033">${c.userIdentityID}
                                    <input type="hidden" name="hidID" value="${c.userIdentityID}">
                                </font></td>
                            </tr>
                            <tr bgcolor="AEBACD">
                                <td height="6" bgcolor="657A9A" width="26%"><b><font size="2" color="#FFFFFF">Nationalitatname </font></b></td>
                                <td height="6" bgcolor="AEBACD" width="74%">
                                    <input name="txtName" type="text" value="${c.userIdentityName}" size="50" maxlength="50">
                                </td>
                            </tr>
                            <tr bgcolor="AEBACD">
                                <td height="6" bgcolor="657A9A" width="26%">&nbsp;</td>
                                <td height="6" bgcolor="AEBACD" width="74%">
                                    <input class="btn btn-primary" type="submit" name="Submit" value="OK">
                                    <a class="btn btn-primary" href="teilnehmerList">Zurück</a>
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
