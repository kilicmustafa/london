<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="MyCurrency" class="com.rheinlandprivatschule.helper.MyCurrency" />
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Allgemeine Benutzer Informationen ::</title>
    <style>
        table tr {
            border-bottom: 1px solid white;
        }
    </style>

    <script>
        function composeMail(){
            document.form1.action="mailComposer";
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
                    <div class="wrapper" style="margin-bottom: 5px; float:right;">
                        <a style="margin-right: 3px;" class="btn btn-primary" href="/user/adminLohnUpdate?adminid=${adminRemarkViewModel.systemUser.userID}">Stundenlohn</a>
                        <a style="margin-right: 3px;" class="btn btn-primary" href="/user/werbungList?userid=${adminRemarkViewModel.systemUser.userID}">Werbung</a>
                        <a style="margin-right: 3px;" class="btn btn-primary" href="/contentmanager/moduleSelection?userid=${adminRemarkViewModel.systemUser.userID}">Befugnis</a>
                        <a style="margin-right: 3px;" class="btn btn-primary" href="adminRemarksUpdate?adminid=${adminRemarkViewModel.systemUser.userID}">Bemerkung</a>
                        <a style="margin-right: 3px;" class="btn btn-primary" href="#" onclick="composeMail()">Email</a>
                        <a style="margin-right: 3px;" class="btn btn-primarclass y" href="bookTra?cmd=f">Bücher</a>
                        <a style="margin-right: 3px;" class="btn btn-primary" href="adminUpdateForm?adminid=${adminRemarkViewModel.systemUser.userID}">Aktualisierung Benutzer</a>
                        <a style="margin-right: 3px;" class="btn btn-primary" href="/systemUserBilder/attachBilder">Bilder</a>
                        <a style="margin-right: 3px;" class="btn btn-primary" href="../index">Haupt</a>
                    </div>

                    <form name="form1" method="post" action="adminRemarksF">
                        <input name="userid" type="hidden" value="${adminRemarkViewModel.systemUser.userID}">
                        <input name="singleemail" type="hidden" value="${adminRemarkViewModel.systemUser.userEmail}">
                        <table width="100%" border="0" cellspacing="1" cellpadding="1">
                            <tbody>
                            <tr>
                                <td colspan="3" height="21">&nbsp;</td>
                            </tr>
                            <tr bgcolor="657A9A">
                                <td colspan="4"><div align="center"><font size="2"><b><font color="#FFFFFF">Allgemeine Benutzer Informationen</font></b></font></div></td>
                            </tr>
                            <tr bgcolor="AEBACD">
                                <td width="113" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Vorname</font></b></td>
                                <td colspan="3"><font color="#000033" size="2">${adminRemarkViewModel.systemUser.userFirstName}</font></td>
                            </tr>
                            <tr bgcolor="AEBACD">
                                <td bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Nachname</font></b></td>
                                <td colspan="3"><font color="#000033" size="2">${adminRemarkViewModel.systemUser.userLastName}</font></td>
                            </tr>
                            <tr bgcolor="AEBACD">
                                <td bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>*Geburtsort</b></font></td>
                                <td colspan="3"><font color="#000033" size="2">${adminRemarkViewModel.systemUser.userBirthPlace}</font></td>
                            </tr>
                            <tr bgcolor="AEBACD">
                                <td bgcolor="657A9A"><b><font size="2" color="#FFFFFF">*Geschlecht</font></b></td>
                                <td colspan="3"><font color="#000033" size="2">${adminRemarkViewModel.userGender}</font></td>
                            </tr>
                            <tr bgcolor="AEBACD">
                                <td bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Nationalität</font></b></td>
                                <td colspan="3"><font color="#000033" size="2">${adminRemarkViewModel.systemUser.userNationality}</font></td>
                            </tr>
                            <tr bgcolor="AEBACD">
                                <td bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Adresse</font></b></td>
                                <td colspan="3"><font color="#000033" size="2">${adminRemarkViewModel.systemUser.userAddress}</font></td>
                            </tr>
                            <tr bgcolor="AEBACD">
                                <td bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*PLZ</font></b></td>
                                <td colspan="3"><font color="#000033" size="2">${adminRemarkViewModel.systemUser.userPostCode}</font></td>
                            </tr>
                            <tr bgcolor="AEBACD">
                                <td bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Stadt</font></b></td>
                                <td colspan="3"><font color="#000033" size="2">${adminRemarkViewModel.systemUser.userCity}</font></td>
                            </tr>
                            <tr bgcolor="AEBACD">
                                <td bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Land</font></b></td>
                                <td colspan="3"><font color="#000033" size="2">${adminRemarkViewModel.systemUser.userCountry}</font></td>
                            </tr>
                            <tr bgcolor="AEBACD">
                                <td bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Telefon Nr</font></b></td>
                                <td colspan="3"><font color="#000033" size="2">${adminRemarkViewModel.systemUser.userHomePhone}</font></td>
                            </tr>
                            <tr bgcolor="AEBACD">
                                <td bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Handy Nr</font></b></td>
                                <td colspan="3"><font color="#000033" size="2">${adminRemarkViewModel.systemUser.userMobilePhone}</font></td>
                            </tr>
                            <tr bgcolor="AEBACD">
                                <td bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>Fax Nr.</b></font></td>
                                <td colspan="3"><font color="#000033" size="2">${adminRemarkViewModel.systemUser.userFax}</font></td>
                            </tr>
                            <tr bgcolor="AEBACD">
                                <td bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Email</font></b></td>
                                <td colspan="3"><font color="#000033" size="2">${adminRemarkViewModel.systemUser.userEmail}</font></td>
                            </tr>
                            <tr bgcolor="AEBACD">
                                <td colspan="4" bgcolor="657A9A"><div align="center"><b><font color="#FFFFFF">Bankverbindung</font></b></div></td>
                            </tr>
                            <tr bgcolor="AEBACD">
                                <td bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>Konto Nr.</b></font></td>
                                <td colspan="3"><font color="#000033" size="2">${adminRemarkViewModel.systemUser.userAccountNo}</font></td>
                            </tr>
                            <tr bgcolor="AEBACD">
                                <td bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>BLZ</b></font></td>
                                <td colspan="3"><font color="#000033" size="2">${adminRemarkViewModel.systemUser.userBLZ}</font></td>
                            </tr>
                            <tr bgcolor="AEBACD">
                                <td bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>Bankname</b></font></td>
                                <td colspan="3"><font color="#000033" size="2">${adminRemarkViewModel.systemUser.userBankName}</font></td>
                            </tr>
                            <tr bgcolor="AEBACD">
                                <td colspan="4" bgcolor="657A9A"><div align="center"><b><font color="#FFFFFF">Benutzer Typ </font></b></div></td>
                            </tr>
                            <tr bgcolor="AEBACD">
                                <td bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Benutzertyp</font></b></td>
                                <td colspan="3"><font color="#000033" size="2">${adminRemarkViewModel.userType}</font></td>
                            </tr>
                            <tr bgcolor="AEBACD">
                                <td bgcolor="657A9A"><b><font size="2" color="#FFFFFF"><b>Kategory</b></font></b></td>
                                <td colspan="3"><font color="#000033" size="2">${adminRemarkViewModel.userCategoryName}</font></td>
                            </tr>
                            <tr bgcolor="AEBACD">
                                <td colspan="4" bgcolor="657A9A"><div align="center"><font size="2" color="#FFFFFF"><b><font size="3">Bücher </font> </b> </font></div></td>
                            </tr>
                            <tr bgcolor="AEBACD">
                                <td bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Buch Nr.:</font></b></td>
                                <td width="143" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Buchname</font></b></td>
                                <td width="422" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Betrag</font></b></td>
                                <td bgcolor="657A9A"><b><font size="2" color="#FFFFFF">RechnungNr.:</font></b></td>
                            </tr>

                            <c:forEach items="${adminRemarkViewModel.bucher}" var="b">
                                <tr bgcolor="AEBACD">
                                    <td bgcolor="AEBACD"><font size="2" color="#000033">${b.bookTrack}</font></td>
                                    <td><font size="2" color="#000033">${b.bookName}</font></td>
                                    <td><font size="2" color="#000033">${MyCurrency.getDisplayString(b.price)}</font></td>
                                    <td><font size="2" color="#000033">${b.bookRechnungID}</font></td>
                                </tr>
                            </c:forEach>

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