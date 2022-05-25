<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: cemasma
  Date: 4/7/2019
  Time: 6:05 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Bild Hochladen  ::</title>
    <style>
        table tr {
            border-bottom: 1px solid white;
        }
    </style>

    <script>
        function addfile(){
            if(document.form1.fileName.value!=null)
            {
                document.form1.action = "attachBilder?cmd=r";
                document.form1.submit();
            }
        }

        function haupt() {
            window.location = "/index";
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
                    <table border="0" cellspacing="0" cellpadding="0" align="center">
                        <tbody><tr>
                            <td>&nbsp;</td>
                            <td>
                                <table width="780" border="0" cellpadding="0" cellspacing="0">
                                    <tbody>
                                    <tr>
                                        <td colspan="12" rowspan="14" valign="top">

                                            <table width="101%" border="0" cellspacing="0" cellpadding="0" height="434">
                                                <tbody><tr>
                                                    <td valign="top" height="488" bgcolor="D9E5F4" width="83%">                <table width="100%" border="0" cellspacing="1" cellpadding="1" height="160">
                                                        <tbody><tr>
                                                            <td colspan="3" valign="top"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"> </font>
                                                                <div align="right"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"> &nbsp;
                                                                    <input type="button" name="Submit22" value="Zurück" onclick="haupt()">
                                                                    &nbsp; &nbsp; </font></div></td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3" valign="top" bgcolor="657A9A"><font color="#FFFFFF">Wählen Sie eine Vertrag aus :</font></td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3" valign="top" bgcolor="AEBACD"><form name="form1" method="post" action="/systemUserBilder/attachBilder" enctype="multipart/form-data">
                                                                <input type="file" name="fileName" size="30">
                                                            </form>
                                                                <div align="right"> </div>
                                                                <div align="center"> </div>
                                                                <div align="center"> </div>
                                                                <div align="center"> </div>
                                                                <div align="center"> </div></td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3" valign="top" bgcolor="AEBACD"><input type="button" name="attach" value="Hochladen" onclick="addfile()">
                                                                <form name="form2" method="post" action="">
                                                                    <input type="hidden" name="hd" value="10702">
                                                                </form></td>
                                                        </tr>
                                                        <tr>
                                                            <td width="10%" height="16" valign="top" bgcolor="657A9A"><p><font size="2"><b><font color="#FFFFFF">Schuler/in</font></b></font></p></td>
                                                            <td valign="top" bgcolor="AEBACD" height="16" colspan="2"><font size="2" color="#000033">${systemUser.userFirstName} ${systemUser.userLastName}</font></td>
                                                        </tr>

                                                        <c:forEach items="${vertrags}" var="pp">
                                                            <tr bgcolor="AEBACD">
                                                                <td valign="top" height="20"><font size="2" color="#000033">${vertrags.indexOf(pp) + 1}</font> </td>
                                                                <td height="20" valign="top"><font size="2" color="#000033"><a href="image?ver=${pp}">${pp}</a></font><font size="2" color="#000033" input="" type="hidden">
                                                                    <input type="hidden" name="userids" value="9462">
                                                                </font></td>
                                                                <td width="17%" height="20" colspan="3"><font size="2" color="#000033"><a href="deleteBilder?cmd=${pp}"> Löschen</a></font></td>
                                                            </tr>
                                                        </c:forEach>

                                                        </tbody></table></td>
                                                </tr>
                                                </tbody></table>
                                        </td>
                                    </tbody></table>
                            </td>
                            <td>&nbsp;</td>
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
