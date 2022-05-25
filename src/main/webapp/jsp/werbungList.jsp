<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Werbung Klassifikation ::</title>
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="window.history.go(-1); return false;">Zurück</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="/user/adminRemarksF?adminid=${userid}">Benutzer Informationen</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="table-responsive">
                            <table width="100%" border="0" height="120">
                                <tr>
                                    <td height="423" valign="top">
                                        <form name="form1" method="post" action="">
                                            <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                                <tr bgcolor="657A9A">
                                                    <td height="22" colspan="3"><div align="center"><b><font color="#FFFFFF">Werbung Klassifikation </font></b></div></td>
                                                </tr>
                                                <tr bgcolor="657A9A">
                                                    <td width="19%" height="6"><strong><font color="#FFFFFF" size="2">Benutzer Werbung</font></strong> </td>
                                                    <!-- TODO: <a href="../werbung/werbungStudentList?wid=adminWerbung.getWerbungID() -->
                                                    <td height="6" colspan="2" bgcolor="AEBACD"><font color="#000033" size="2"><a href="../werbung/werbungStudentList?wid=">${currentWerbung}</a></font></td>
                                                </tr>
                                                <tr bgcolor="657A9A">
                                                    <td height="6" colspan="3">&nbsp;</td>
                                                </tr>
                                                <tr bgcolor="657A9A">
                                                    <td height="6" colspan="2"><b><font size="2" color="#FFFFFF">Werbung Klassifikation </font></b><b></b></td>
                                                    <td width="14%" height="6"><input name="userid" type="hidden" id="userid" value="${userid}"></td>
                                                </tr>
                                                <c:forEach items="${werbungList}" var="werbung">
                                                    <tr bgcolor="AEBACD">
                                                        <td height="5" colspan="2"><font size="2" color="#000033"><a href="werbungList?parent=${werbung.werbungID}&userid=${userid}">${werbung.werbungName}</a>
                                                            <a href="werbungList?parent=${werbung.werbungID}&userid=${userid}">${werbung.werbungID}</a></font></td>
                                                        <td height="5"><font color="#000033" size="2"><a href="werbungList?userid=${userid}&werbung=${werbung.werbungID}&cmd=cmd">Zuordnen</a></font></td>
                                                    </tr>
                                                </c:forEach>
                                                <tr bgcolor="AEBACD">
                                                    <td height="6" colspan="3">&nbsp;</td>
                                                </tr>
                                            </table>
                                        </form></td>
                                </tr>
                            </table>
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
