<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Neue Allgemeine Benutzer Pers&ouml;nliche Informationen ::</title>
    <style>
        html {
            overflow-y: hidden;
        }
    </style>
    <script>
        function MM_findObj(n, d) { //v4.0
            var p, i, x;
            if (!d) d = document;
            if ((p = n.indexOf("?")) > 0 && parent.frames.length) {
                d = parent.frames[n.substring(p + 1)].document;
                n = n.substring(0, p);
            }
            if (!(x = d[n]) && d.all) x = d.all[n];
            for (i = 0; !x && i < d.forms.length; i++) x = d.forms[i][n];
            for (i = 0; !x && d.layers && i < d.layers.length; i++) x = MM_findObj(n, d.layers[i].document);
            if (!x && document.getElementById) x = document.getElementById(n);
            return x;
        }

        function MM_validateForm() { //v4.0
            var i, p, q, nm, test, num, min, max, errors = '', args = MM_validateForm.arguments;
            for (i = 0; i < (args.length - 2); i += 3) {
                test = args[i + 2];
                val = MM_findObj(args[i]);
                if (val) {
                    nm = val.name;
                    if ((val = val.value) != "") {
                        if (test.indexOf('isEmail') != -1) {
                            p = val.indexOf('@');
                            if (p < 1 || p == (val.length - 1)) errors += '- ' + nm + ' must contain an e-mail address.\n';
                        } else if (test != 'R') {
                            if (isNaN(val)) errors += '- ' + nm + ' must contain a number.\n';
                            if (test.indexOf('inRange') != -1) {
                                p = test.indexOf(':');
                                min = test.substring(8, p);
                                max = test.substring(p + 1);
                                if (val < min || max < val) errors += '- ' + nm + ' must contain a number between ' + min + ' and ' + max + '.\n';
                            }
                        }
                    } else if (test.charAt(0) == 'R') errors += '- ' + nm + ' is required.\n';
                }
            }
            if (errors) alert('The following error(s) occurred:\n' + errors);
            document.MM_returnValue = (errors == '');
        }
    </script>

    <c:if test="${sessionScope.get('lin') eq 'newAdminForm' and sessionScope.get('err') != null}">
        <script>
            alert("${sessionScope.get('err')}");
        </script>
    </c:if>
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
                <c:if test="${sessionScope.get('newAdmin') != null}">
                    <c:set var="u" value="${sessionScope.get('newAdmin')}" />
                </c:if>
                <div class="wrapper" style="padding-left: 17.5%; padding-right: 17.5%;">
                    <div class="wrapper" style="margin-bottom: 5px; float:right;">
                        <a style="margin-right: 5px;" class="btn btn-primary" href="catList">Zurück</a>
                        <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                    </div>
                    <form name="form1" method="post" action="updateAdmin"
                          onsubmit="MM_validateForm('txtFirstName','','R','txtLastName','','R','txtBirthPlace','','R','txtNationality','','R','txtAddress','','R','txtPostCode','','RisNum','txtCity','','R','txtCountry','','R','txtHomeNo','','NisNum','txtMobileNo','','NisNum','txtEmail','','NisEmail','txtLoginName','','R','txtPassword','','R');return document.MM_returnValue">
                        <table width="100%" height="523" border="0" cellpadding="1" cellspacing="1">
                            <tbody>
                            <tr>
                                <th colspan="2" height="17" bgcolor="657A9A"><b><font color="#FFFFFF">Neue Allgemeine
                                    Benutzer P</font><font color="#FFFFFF">ersönliche
                                    Informationen</font></b></th>
                            </tr>
                            <tr>
                                <td height="24" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Firma</font></b>
                                </td>
                                <td height="24" bgcolor="AEBACD"><font color="#000033">
                                    <input name="txtCompany" type="text" id="txtCompany" value="${systemUser.userCompany}" maxlength="40">
                                </font></td>
                            </tr>
                            <tr>
                                <td width="26%" height="24" bgcolor="657A9A"><b><font color="#FFFFFF"
                                                                                      size="2">*Vorname</font></b></td>
                                <td width="74%" height="24" bgcolor="AEBACD"><font color="#000033">
                                    <input type="text" name="txtFirstName" value="${systemUser.userFirstName}">
                                </font></td>
                            </tr>
                            <tr>
                                <td width="26%" height="21" bgcolor="657A9A"><b><font color="#FFFFFF"
                                                                                      size="2">*Nachname</font></b></td>
                                <td width="74%" height="21" bgcolor="AEBACD"><font color="#000033">
                                    <input type="text" name="txtLastName" value="${systemUser.userLastName}">
                                </font></td>
                            </tr>
                            <tr>
                                <td width="26%" height="19" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Geburtsdatum</font></b>
                                </td>
                                <td width="74%" height="19" bgcolor="AEBACD"><font color="#000033">
                                    <select name="selDay">
                                        <c:forEach begin="1" end="31" var="i" varStatus="loop">
                                            <option <c:if test="${i eq Integer.parseInt(adminUpdateViewModel.birthday)}">selected</c:if> >${i}</option>
                                        </c:forEach>
                                    </select>
                                    <select name="selMonth">

                                        <option <c:if test="${adminUpdateViewModel.birthmonth eq 1}">selected</c:if>>Januar</option>

                                        <option <c:if test="${adminUpdateViewModel.birthmonth eq 2}">selected</c:if>>Februar</option>

                                        <option <c:if test="${adminUpdateViewModel.birthmonth eq 3}">selected</c:if>>März</option>

                                        <option <c:if test="${adminUpdateViewModel.birthmonth eq 4}">selected</c:if>>April</option>

                                        <option <c:if test="${adminUpdateViewModel.birthmonth eq 5}">selected</c:if>>Mai</option>

                                        <option <c:if test="${adminUpdateViewModel.birthmonth eq 6}">selected</c:if>>Juni</option>

                                        <option <c:if test="${adminUpdateViewModel.birthmonth eq 7}">selected</c:if>>Juli</option>

                                        <option <c:if test="${adminUpdateViewModel.birthmonth eq 8}">selected</c:if>>August</option>

                                        <option <c:if test="${adminUpdateViewModel.birthmonth eq 9}">selected</c:if>>September</option>

                                        <option <c:if test="${adminUpdateViewModel.birthmonth eq 10}">selected</c:if>>Oktober</option>

                                        <option <c:if test="${adminUpdateViewModel.birthmonth eq 11}">selected</c:if>>November</option>

                                        <option <c:if test="${adminUpdateViewModel.birthmonth eq 12}">selected</c:if>>Dezember</option>

                                    </select>
                                    <select name="selYear">
                                        <c:forEach begin="1950" end="2011" var="year">
                                            <option <c:if test="${year eq Integer.parseInt(adminUpdateViewModel.birthyear)}">selected</c:if> >${year}</option>
                                        </c:forEach>
                                    </select>
                                </font></td>
                            </tr>
                            <tr>
                                <td width="26%" height="14" bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>*Geburtsort</b></font>
                                </td>
                                <td width="74%" height="14" bgcolor="AEBACD">
                                    <input type="text" name="txtBirthPlace" value="${systemUser.userBirthPlace}">
                                </td>
                            </tr>
                            <tr style="color:black;">
                                <td width="26%" height="14" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">*Geschlecht</font></b>
                                </td>
                                <td width="74%" height="14" bgcolor="AEBACD"> Männlich
                                    <input type="radio" name="rdGender" value="0" <c:if test="${systemUser.userGender eq 0}">checked</c:if>>
                                    Weiblich
                                    <input type="radio" name="rdGender" value="1" <c:if test="${systemUser.userGender eq 1}">checked</c:if>>
                                </td>
                            </tr>
                            <tr>
                                <td width="26%" height="14" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Nationalität</font></b>
                                </td>
                                <td width="74%" height="14" bgcolor="AEBACD"><font color="#000033">
                                    <input type="text" name="txtNationality" value="${systemUser.userNationality}">
                                </font></td>
                            </tr>
                            <tr>
                                <td width="26%" height="17" bgcolor="657A9A"><b><font color="#FFFFFF"
                                                                                      size="2">*Adresse</font></b></td>
                                <td width="74%" height="17" bgcolor="AEBACD"><font color="#000033">
                                    <input type="text" name="txtAddress" value="${systemUser.userAddress}">
                                </font></td>
                            </tr>
                            <tr>
                                <td width="26%" height="16" bgcolor="657A9A"><b><font color="#FFFFFF"
                                                                                      size="2">*PLZ</font></b></td>
                                <td width="74%" height="16" bgcolor="AEBACD"><font color="#000033">
                                    <input type="text" name="txtPostCode" value="${systemUser.userPostCode}">
                                </font></td>
                            </tr>
                            <tr>
                                <td width="26%" height="19" bgcolor="657A9A"><b><font color="#FFFFFF"
                                                                                      size="2">*Stadt</font></b></td>
                                <td width="74%" height="19" bgcolor="AEBACD"><font color="#000033">
                                    <input type="text" name="txtCity" value="${systemUser.userCity}">
                                </font></td>
                            </tr>
                            <tr>
                                <td width="26%" height="14" bgcolor="657A9A"><b><font color="#FFFFFF"
                                                                                      size="2">*Land</font></b></td>
                                <td width="74%" height="14" bgcolor="AEBACD"><font color="#000033">
                                    <input type="text" name="txtCountry" value="${systemUser.userCountry}">
                                </font></td>
                            </tr>
                            <tr>
                                <td width="26%" height="11" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Handy
                                    Nr</font></b></td>
                                <td width="74%" height="11" bgcolor="AEBACD"><font color="#000033">
                                    <input type="text" name="txtMobileNo" value="${systemUser.userMobilePhone}">
                                </font></td>
                            </tr>
                            <tr>
                                <td width="26%" height="23" bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>Fax
                                    Nr.</b></font></td>
                                <td width="74%" height="23" bgcolor="AEBACD">
                                    <input type="text" name="txtFax" value="${systemUser.userFax}">
                                </td>
                            </tr>
                            <tr>
                                <td height="23" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Email</font></b></td>
                                <td height="23" bgcolor="AEBACD"><font color="#000033">
                                    <input type="text" name="txtEmail" value="${systemUser.userEmail}">
                                </font></td>
                            </tr>
                            <tr>
                                <td width="26%" height="23" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Bamfnummer</font></b>
                                </td>
                                <td width="74%" height="23" bgcolor="AEBACD"><font color="#000033">
                                    <input name="txtBamfNumber" type="text" id="txtBamfNumber" value="${systemUser.userBamfNumber}" maxlength="20">
                                </font></td>
                            </tr>
                            <tr>
                                <td colspan="2" height="14" bgcolor="657A9A">
                                    <div align="center"><b><font color="#FFFFFF">Bankverbindung</font></b></div>
                                </td>
                            </tr>
                            <tr>
                                <td width="26%" height="14" bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>Konto
                                    Nr.</b></font></td>
                                <td width="74%" height="14" bgcolor="AEBACD">
                                    <input type="text" name="txtKonto" value="${systemUser.userAccountNo}">
                                </td>
                            </tr>
                            <tr>
                                <td width="26%" height="14" bgcolor="657A9A"><font size="2"
                                                                                   color="#FFFFFF"><b>BLZ</b></font>
                                </td>
                                <td width="74%" height="14" bgcolor="AEBACD">
                                    <input type="text" name="txtBLZ" value="${systemUser.userBLZ}">
                                </td>
                            </tr>
                            <tr>
                                <td width="26%" height="14" bgcolor="657A9A"><font size="2"
                                                                                   color="#FFFFFF"><b>Bankname</b></font>
                                </td>
                                <td width="74%" height="14" bgcolor="AEBACD">
                                    <input type="text" name="txtbankname" value="${systemUser.userBankName}">
                                </td>
                            </tr>
                            <tr>
                                <td width="26%" height="14" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Benutzertyp</font></b>
                                </td>
                                <td width="74%" height="14" bgcolor="AEBACD"><font color="#000033">
                                    <select name="seltype">

                                        <c:forEach items="${userTypes}" var="ut">
                                            <c:if test="${systemUser.userType eq ut.userTypeID}">
                                                <option value="${ut.userTypeID}" selected>${ut.userTypeName}</option>
                                            </c:if>
                                            <c:if test="${systemUser.userType != ut.userTypeID}">
                                                <option value="${ut.userTypeID}">${ut.userTypeName}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </font></td>
                            </tr>
                            <tr>
                                <td width="26%" height="14" bgcolor="657A9A"><b><font size="2"
                                                                                      color="#FFFFFF">Schule</font></b>
                                </td>
                                <td width="74%" height="14" bgcolor="AEBACD"><font color="#000033">
                                </font>
                                    <table width="100%" border="0" cellspacing="1" cellpadding="1">

                                        <tbody>
                                        <c:forEach items="${places}" var="place">
                                            <c:set var="found" value="false" />
                                            <c:if test="${found eq false}">
                                                <c:forEach items="${systemUser.userPlaces}" var="uplace">
                                                    <fmt:parseNumber var = "i" integerOnly = "true"
                                                                     type = "number" value = "${uplace}" />
                                                    <c:if test="${i eq place.placeID}">
                                                        <tr>
                                                            <td width="8%">
                                                                <input type="checkbox" name="checkbox" value="${place.placeID}" checked>
                                                            </td>
                                                            <td width="92%"><font size="2" color="#000033">${place.placeName}</font></td>
                                                        </tr>
                                                        <c:set var="found" value="true" />
                                                    </c:if>
                                                </c:forEach>
                                                <c:if test="${found eq false}">
                                                    <tr>
                                                        <td width="8%">
                                                            <input type="checkbox" name="checkbox" value="${place.placeID}">
                                                        </td>
                                                        <td width="92%"><font size="2" color="#000033">${place.placeName}</font></td>
                                                    </tr>
                                                </c:if>
                                            </c:if>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td height="14" bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>Katogory</b></font>
                                </td>
                                <td height="14" bgcolor="AEBACD">
                                    <select name="selCate">

                                       <c:forEach items="${categories}" var="category">
                                            <c:if test="${adminUpdateViewModel.userCategoryId eq category.userCategoryID}">
                                                <option value="${category.userCategoryID}" selected>${category.userCategoryName}</option>
                                            </c:if>
                                           <c:if test="${adminUpdateViewModel.userCategoryId != category.userCategoryID}">
                                               <option value="${category.userCategoryID}">${category.userCategoryName}</option>
                                           </c:if>
                                       </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" height="14" bgcolor="657A9A">
                                    <div align="center"><font color="#000033"><b><font color="#FFFFFF">Informationen
                                        zum Erinnern</font></b></font></div>
                                </td>
                            </tr>
                            <tr>
                                <td width="26%" height="22" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Loginname</font></b>
                                </td>
                                <td width="74%" height="22" bgcolor="AEBACD"><font color="#000033">
                                    <input type="text" name="txtLoginName" value="${systemUser.userLoginName}">
                                </font></td>
                            </tr>
                            <tr>
                                <td width="26%" height="17" bgcolor="657A9A"><b><font color="#FFFFFF"
                                                                                      size="2">*Kennwort</font></b></td>
                                <td width="74%" height="17" bgcolor="AEBACD"><font color="#000033">
                                    <input type="password" name="txtPassword" value="${systemUser.userPassword}">
                                </font></td>
                            </tr>
                            <tr>
                                <td width="26%" height="7" bgcolor="657A9A"><b><font size="2"
                                                                                     color="#FFFFFF"></font></b></td>
                                <td width="74%" height="7" bgcolor="AEBACD">
                                    <input class="btn btn-primary" type="submit" name="Submit" value="Update">
                                    <input type="hidden" name="adminid" value="${systemUser.userID}" >

                                </td>
                            </tr>
                            </tbody>
                        </table>
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
