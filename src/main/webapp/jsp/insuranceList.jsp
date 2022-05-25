<%--
  Created by IntelliJ IDEA.
  User: cemasma
  Date: 3/27/2019
  Time: 2:27 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Neue Schüler ::</title>
    <style>
        table tr {
            border-bottom: 1px solid white;
        }
    </style>
    <script>
        function haupt() {
            window.location = "/index";
        }
    </script>
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
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tbody><tr>
                            <td valign="top" height="146" bgcolor="D9E5F4" width="86%">
                                <table width="100%" border="0" height="120">
                                    <tbody><tr>
                                        <td height="2" valign="top">
                                            <div align="right"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">
                                                <input type="button" name="Submit22" value="Haupt" onclick="haupt()">
                                            </font></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="423" valign="top">
                                            <form name="form1" method="post" action="insuranceList">
                                                <table width="100%" border="0" cellpadding="1" cellspacing="1">

                                                    <tbody><tr bgcolor="657A9A">
                                                        <td height="6" colspan="2"><div align="center"><strong><font color="#FFFFFF">Liste von Krankenversicherung </font></strong></div></td>
                                                    </tr>
                                                    <tr bgcolor="657A9A">
                                                        <td width="3%" height="6"><input type="hidden" name="cmd" value="command"></td>
                                                        <td height="6"><strong><font color="#FFFFFF" size="2">Krankenversicherung</font></strong></td>
                                                    </tr>
                                                    <tr bgcolor="657A9A">
                                                        <td height="6" bgcolor="AEBACD"><input name="insurance" type="radio" value="0" checked=""></td>
                                                        <td height="6" bgcolor="AEBACD"><font size="2" color="#000033">Keine Krankenversicherung</font></td>
                                                    </tr>


                                                    <tr bgcolor="657A9A">
                                                        <td height="6" bgcolor="AEBACD"><input name="insurance" type="radio" value="1"></td>
                                                        <td height="6" bgcolor="AEBACD"><font size="2" color="#000033">AOK</font></td>
                                                    </tr>


                                                    <tr bgcolor="657A9A">
                                                        <td height="6" bgcolor="AEBACD"><input name="insurance" type="radio" value="2"></td>
                                                        <td height="6" bgcolor="AEBACD"><font size="2" color="#000033">Care Colleg</font></td>
                                                    </tr>


                                                    <tr bgcolor="657A9A">
                                                        <td height="6" bgcolor="AEBACD"><input name="insurance" type="radio" value="3"></td>
                                                        <td height="6" bgcolor="AEBACD"><font size="2" color="#000033">sontiges</font></td>
                                                    </tr>

                                                    <tr bgcolor="657A9A">
                                                        <td height="6" colspan="2"><strong><font color="#FFFFFF" size="2">Krankenversicherung Bemerkung</font></strong> </td>
                                                    </tr>
                                                    <tr bgcolor="AEBACD">
                                                        <td colspan="2"><input name="desc" type="text" id="desc" value=""></td>
                                                    </tr>
                                                    <tr bgcolor="AEBACD">
                                                        <td height="6" colspan="2">&nbsp;</td>
                                                    </tr>
                                                    <tr bgcolor="AEBACD">
                                                        <td height="6" bgcolor="AEBACD" colspan="2">
                                                            <input type="submit" name="Submit" value="Weiter">
                                                        </td>
                                                    </tr>
                                                    </tbody></table>
                                            </form>
                                        </td>
                                    </tr>
                                    </tbody></table>
                            </td>
                        </tr>
                        </tbody></table>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="templates/footer.jsp"/>
<jsp:include page="templates/bodyimports.jsp"/>
</body>
</html>
