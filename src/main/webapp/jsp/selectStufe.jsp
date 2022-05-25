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
        function popUp(loc,eyeD,X,Y){
            var openedWindow = window.open(loc,eyeD,"toolbar=no,location=0,directories=no,status=no,menubar=0,scrollbars=yes,resizable=0,width=" + X + ",height=" + Y + "'");
            openedWindow.onbeforeunload = function() {
                window.location.reload();
            }
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="/stundenplan/selectStufe">Stundenbemerkung</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="table-responsive">
                            <table width="100%" border="0" cellspacing="1" cellpadding="1">
                                <tr>
                                    <td bgcolor="657A9A" colspan="2">
                                        <div align="center"><font size="3" color="#FFFFFF"><b>Alle Stufen</b></font></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="5%" height="18" bgcolor="657A9A"><strong></strong></td>
                                    <td bgcolor="657A9A">                           <strong><font color="#FFFFFF">Stufen</font></strong></td>
                                </tr>
                                <tr>
                                    <td bgcolor="AEBACD"><font color="#000033" size="2">1</font></td>
                                    <td bgcolor="AEBACD"><font color="#000033" size="2"><a href="remarksForm?stufe=1">Grundstufe I </a></font></td>
                                </tr>
                                <tr>
                                    <td bgcolor="AEBACD"><font color="#000033" size="2">2</font></td>
                                    <td bgcolor="AEBACD"><font color="#000033" size="2"><a href="remarksForm?stufe=2">Grundstufe II </a></font></td>
                                </tr>
                                <tr>
                                    <td bgcolor="AEBACD"><font color="#000033" size="2">3</font></td>
                                    <td bgcolor="AEBACD"><font color="#000033" size="2"><a href="remarksForm?stufe=3">Mittelstufe I </a></font></td>
                                </tr>
                                <tr>
                                    <td bgcolor="AEBACD"><font color="#000033" size="2">4</font></td>
                                    <td bgcolor="AEBACD"><font color="#000033" size="2"><a href="remarksForm?stufe=4">Mittelstufe II </a></font></td>
                                </tr>
                                <tr>

                                    <td width="5%" bgcolor="AEBACD"><font color="#000033" size="2">5</font></td>
                                    <td bgcolor="AEBACD"><font color="#000033" size="2"><a href="remarksForm?stufe=5">Oberstufe</a></font></td>

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
