<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Stundenplan ::</title>
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
        function submitForm() {
            document.form1.submit();
        }
    </script>
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="submitForm()">Aktualisieren</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="window.history.go(-1); return false;">Zurück</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width: 100%;" name="form1" method="post" action="">
                            <table width="100%" border="0" cellspacing="1" cellpadding="1">
                                <tbody>
                                <tr>
                                    <td bgcolor="657A9A" colspan="2">
                                        <div align="center"><font size="3" color="#FFFFFF"><b>Stunden Bemerkung </b></font></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="5%" height="18" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">St</font></strong></td>
                                    <td bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">
                                        ${stufeName}</font></strong><strong></strong><strong></strong><strong></strong><strong></strong></td>
                                </tr>

                                <c:forEach items="${tea}" var="t">
                                    <tr>

                                        <td width="5%" bgcolor="AEBACD"><font color="#000033" size="2">${t.stundenValue}</font></td>
                                        <td bgcolor="AEBACD"><textarea style="width: 100%;" name="${t.stundenValue}" cols="80" rows="5">${t.stundenDetail}</textarea></td>

                                    </tr
                                </c:forEach>
                                <tr bgcolor="AEBACD">
                                    <td>&nbsp;</td>
                                    <td>
                                        <input class="btn btn-primary" name="Submit" type="submit" value="Aktualisieren">
                                        <input name="stufe" type="hidden" id="stufe" value="${stufe}">
                                        <input name="cmd" type="hidden" id="cmd" value="cmd">
                                    </td>
                                </tr>
                                </tbody></table>
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
