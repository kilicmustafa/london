<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
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
                    <form name="form1" method="post" action="registerAdmin"
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
                                    <input name="txtCompany" type="text" id="txtCompany" maxlength="40">
                                </font></td>
                            </tr>
                            <tr>
                                <td width="26%" height="24" bgcolor="657A9A"><b><font color="#FFFFFF"
                                                                                      size="2">*Vorname</font></b></td>
                                <td width="74%" height="24" bgcolor="AEBACD"><font color="#000033">
                                    <input type="text" name="txtFirstName" >
                                </font></td>
                            </tr>
                            <tr>
                                <td width="26%" height="21" bgcolor="657A9A"><b><font color="#FFFFFF"
                                                                                      size="2">*Nachname</font></b></td>
                                <td width="74%" height="21" bgcolor="AEBACD"><font color="#000033">
                                    <input type="text" name="txtLastName" >
                                </font></td>
                            </tr>
                            <tr>
                                <td width="26%" height="19" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Geburtsdatum</font></b>
                                </td>
                                <td width="74%" height="19" bgcolor="AEBACD"><font color="#000033">
                                    <select name="selDay">

                                        <option selected="">1</option>

                                        <option>2</option>

                                        <option>3</option>

                                        <option>4</option>

                                        <option>5</option>

                                        <option>6</option>

                                        <option>7</option>

                                        <option>8</option>

                                        <option>9</option>

                                        <option>10</option>

                                        <option>11</option>

                                        <option>12</option>

                                        <option>13</option>

                                        <option>14</option>

                                        <option>15</option>

                                        <option>16</option>

                                        <option>17</option>

                                        <option>18</option>

                                        <option>19</option>

                                        <option>20</option>

                                        <option>21</option>

                                        <option>22</option>

                                        <option>23</option>

                                        <option>24</option>

                                        <option>25</option>

                                        <option>26</option>

                                        <option>27</option>

                                        <option>28</option>

                                        <option>29</option>

                                        <option>30</option>

                                        <option>31</option>

                                    </select>
                                    <select name="selMonth">

                                        <option>Januar</option>

                                        <option>Februar</option>

                                        <option>März</option>

                                        <option>April</option>

                                        <option>Mai</option>

                                        <option>Juni</option>

                                        <option>Juli</option>

                                        <option>August</option>

                                        <option>September</option>

                                        <option>Oktober</option>

                                        <option>November</option>

                                        <option>Dezember</option>

                                    </select>
                                    <select name="selYear">

                                        <option>1950</option>

                                        <option>1951</option>

                                        <option>1952</option>

                                        <option>1953</option>

                                        <option>1954</option>

                                        <option>1955</option>

                                        <option>1956</option>

                                        <option>1957</option>

                                        <option>1958</option>

                                        <option>1959</option>

                                        <option>1960</option>

                                        <option>1961</option>

                                        <option>1962</option>

                                        <option>1963</option>

                                        <option>1964</option>

                                        <option>1965</option>

                                        <option>1966</option>

                                        <option>1967</option>

                                        <option>1968</option>

                                        <option>1969</option>

                                        <option>1970</option>

                                        <option>1971</option>

                                        <option>1972</option>

                                        <option>1973</option>

                                        <option>1974</option>

                                        <option selected="">1975</option>

                                        <option>1976</option>

                                        <option>1977</option>

                                        <option>1978</option>

                                        <option>1979</option>

                                        <option>1980</option>

                                        <option>1981</option>

                                        <option>1982</option>

                                        <option>1983</option>

                                        <option>1984</option>

                                        <option>1985</option>

                                        <option>1986</option>

                                        <option>1987</option>

                                        <option>1988</option>

                                        <option>1989</option>

                                        <option>1990</option>

                                        <option>1991</option>

                                        <option>1992</option>

                                        <option>1993</option>

                                        <option>1994</option>

                                        <option>1995</option>

                                        <option>1996</option>

                                        <option>1997</option>

                                        <option>1998</option>

                                        <option>1999</option>

                                        <option>2000</option>

                                        <option>2001</option>

                                        <option>2002</option>

                                        <option>2003</option>

                                        <option>2004</option>

                                        <option>2005</option>

                                        <option>2006</option>

                                        <option>2007</option>

                                        <option>2008</option>

                                        <option>2009</option>

                                        <option>2010</option>

                                    </select>
                                </font></td>
                            </tr>
                            <tr>
                                <td width="26%" height="14" bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>*Geburtsort</b></font>
                                </td>
                                <td width="74%" height="14" bgcolor="AEBACD">
                                    <input type="text" name="txtBirthPlace" value="">
                                </td>
                            </tr>
                            <tr style="color:black;">
                                <td width="26%" height="14" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">*Geschlecht</font></b>
                                </td>
                                <td width="74%" height="14" bgcolor="AEBACD"> Männlich

                                    <input type="radio" name="rdGender" value="0" checked="">
                                    Weiblich
                                    <input type="radio" name="rdGender" value="1">

                                </td>
                            </tr>
                            <tr>
                                <td width="26%" height="14" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Nationalität</font></b>
                                </td>
                                <td width="74%" height="14" bgcolor="AEBACD"><font color="#000033">
                                    <input type="text" name="txtNationality" value="">
                                </font></td>
                            </tr>
                            <tr>
                                <td width="26%" height="17" bgcolor="657A9A"><b><font color="#FFFFFF"
                                                                                      size="2">*Adresse</font></b></td>
                                <td width="74%" height="17" bgcolor="AEBACD"><font color="#000033">
                                    <input type="text" name="txtAddress" value="">
                                </font></td>
                            </tr>
                            <tr>
                                <td width="26%" height="16" bgcolor="657A9A"><b><font color="#FFFFFF"
                                                                                      size="2">*PLZ</font></b></td>
                                <td width="74%" height="16" bgcolor="AEBACD"><font color="#000033">
                                    <input type="text" name="txtPostCode" value="">
                                </font></td>
                            </tr>
                            <tr>
                                <td width="26%" height="19" bgcolor="657A9A"><b><font color="#FFFFFF"
                                                                                      size="2">*Stadt</font></b></td>
                                <td width="74%" height="19" bgcolor="AEBACD"><font color="#000033">
                                    <input type="text" name="txtCity" value="">
                                </font></td>
                            </tr>
                            <tr>
                                <td width="26%" height="14" bgcolor="657A9A"><b><font color="#FFFFFF"
                                                                                      size="2">*Land</font></b></td>
                                <td width="74%" height="14" bgcolor="AEBACD"><font color="#000033">
                                    <input type="text" name="txtCountry" value="">
                                </font></td>
                            </tr>
                            <tr>
                                <td width="26%" height="11" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Handy
                                    Nr</font></b></td>
                                <td width="74%" height="11" bgcolor="AEBACD"><font color="#000033">
                                    <input type="text" name="txtMobileNo" value="">
                                </font></td>
                            </tr>
                            <tr>
                                <td width="26%" height="23" bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>Fax
                                    Nr.</b></font></td>
                                <td width="74%" height="23" bgcolor="AEBACD">
                                    <input type="text" name="txtFax" value="">
                                </td>
                            </tr>
                            <tr>
                                <td height="23" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Email</font></b></td>
                                <td height="23" bgcolor="AEBACD"><font color="#000033">
                                    <input type="text" name="txtEmail" value="">
                                </font></td>
                            </tr>
                            <tr>
                                <td width="26%" height="23" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Bamfnummer</font></b>
                                </td>
                                <td width="74%" height="23" bgcolor="AEBACD"><font color="#000033">
                                    <input name="txtBamfNumber" type="text" id="txtBamfNumber" value="" maxlength="20">
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
                                    <input type="text" name="txtKonto" value="">
                                </td>
                            </tr>
                            <tr>
                                <td width="26%" height="14" bgcolor="657A9A"><font size="2"
                                                                                   color="#FFFFFF"><b>BLZ</b></font>
                                </td>
                                <td width="74%" height="14" bgcolor="AEBACD">
                                    <input type="text" name="txtBLZ" value="">
                                </td>
                            </tr>
                            <tr>
                                <td width="26%" height="14" bgcolor="657A9A"><font size="2"
                                                                                   color="#FFFFFF"><b>Bankname</b></font>
                                </td>
                                <td width="74%" height="14" bgcolor="AEBACD">
                                    <input type="text" name="txtbankname" value="">
                                </td>
                            </tr>
                            <tr>
                                <td width="26%" height="14" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Benutzertyp</font></b>
                                </td>
                                <td width="74%" height="14" bgcolor="AEBACD"><font color="#000033">
                                    <select name="seltype">

                                        <option value="1">Admin</option>

                                        <option value="2">Sch?ler</option>

                                        <option value="3">Mitarbeiter</option>

                                        <option value="4">Lehrer</option>

                                        <option value="5">Kontakt</option>

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
                                        <tr>
                                            <td width="8%">
                                                <input type="checkbox" name="checkbox" value="5">
                                            </td>
                                            <td width="92%"><font size="2" color="#000033">Dortmund</font></td>
                                        </tr>


                                        <tr>
                                            <td width="8%">
                                                <input type="checkbox" name="checkbox" value="4">
                                            </td>
                                            <td width="92%"><font size="2" color="#000033">Duisburg</font></td>
                                        </tr>


                                        <tr>
                                            <td width="8%">
                                                <input type="checkbox" name="checkbox" value="2">
                                            </td>
                                            <td width="92%"><font size="2" color="#000033">Düsseldorf</font></td>
                                        </tr>


                                        <tr>
                                            <td width="8%">
                                                <input type="checkbox" name="checkbox" value="1">
                                            </td>
                                            <td width="92%"><font size="2" color="#000033">Essen</font></td>
                                        </tr>


                                        <tr>
                                            <td width="8%">
                                                <input type="checkbox" name="checkbox" value="3">
                                            </td>
                                            <td width="92%"><font size="2" color="#000033">Köln</font></td>
                                        </tr>


                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td height="14" bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>Katogory</b></font>
                                </td>
                                <td height="14" bgcolor="AEBACD">
                                    <select name="selCate">

                                        <option value="1">Agenturen</option>

                                        <option value="2">Mittarbeiter</option>

                                        <option value="3">DSH Lehrer</option>

                                        <option value="4">Admin</option>

                                        <option value="5">Ex Personal</option>

                                        <option value="6">Lehrer Tutorium</option>

                                        <option value="7">Gesch?ftspartner</option>

                                        <option value="8">DRUPA</option>

                                        <option value="9">R?ckerstattung</option>

                                        <option value="10">Vermieter</option>

                                        <option value="11">Medien</option>

                                        <option value="12">Agenturen in Spe.</option>

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
                                    <input type="text" name="txtLoginName">
                                </font></td>
                            </tr>
                            <tr>
                                <td width="26%" height="17" bgcolor="657A9A"><b><font color="#FFFFFF"
                                                                                      size="2">*Kennwort</font></b></td>
                                <td width="74%" height="17" bgcolor="AEBACD"><font color="#000033">
                                    <input type="password" name="txtPassword">
                                </font></td>
                            </tr>
                            <tr>
                                <td width="26%" height="7" bgcolor="657A9A"><b><font size="2"
                                                                                     color="#FFFFFF"></font></b></td>
                                <td width="74%" height="7" bgcolor="AEBACD">
                                    <input class="btn btn-primary" type="submit" name="Submit" value="Add">
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
