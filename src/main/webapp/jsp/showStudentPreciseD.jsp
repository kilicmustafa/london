<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: cemasma
  Date: 3/21/2019
  Time: 2:26 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Schüler Information ::</title>
    <style>
        table {
            border-collapse: separate;
        }

        table tr {
            border-bottom: 1px solid white;
        }
    </style>
    <script>
        function addBilder() {
            window.location = "/studentBilder/attachBilder";
        }
        function addVer()
        {
            window.location="/vertrag/attachVertrag";
        }

        function complaints()
        {
            window.location="/complaints/studentComplaintList?userid="+document.form1.userids.value;
        }
        function anmeld(){
            window.location="/schuler/RegisterFormula?userid="+document.form1.userids.value;
        }
        function studentinfo(){
            window.location="/schuler/showStudentDetail?userid="+document.form1.userids.value;
        }
        function xtraCosts(){
            window.location="/schuler/xtraCosts?userid="+document.form1.userids.value;
        }
        function integrationcost(){
            window.location="/schuler/integrationCosts?userid="+document.form1.userids.value;
        }
        function makevertrag(){
            window.location="/schuler/currentLocation";
        }
        function makevertragstk(){
            window.location="/schuler/currentLocationSTK";
        }

        function editwerbung()
        {
            window.location="/schuler/editWerbungList";
        }
        function editgroup()
        {
            window.location="/schuler/editGroupList";
        }
        function editinsurance()
        {
            window.location="/schuler/editInsuranceList";
        }
        function payEU()
        {
            window.location="/schuler/payEUnterricht";
        }
        function downVer()
        {
            window.location="../../../../vertrag/downVertrag";
        }
        function sale()
        {
            window.location="/schuler/bookTra?cmd=f";
        }
        function einzel()
        {
            window.location="/schuler/addEUnterricht";
        }
        function einzelliste()
        {
            window.location="unterrichtListe";
        }

        function updateR(msg)
        {
            if(!confirm(msg)) return false
            else document.form1.submit()
        }

        function haupt() {
            window.location = "/index";
        }
    </script>
</head>
<body>
<!-- Page Wrapper -->
<div id="wrapper">

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
                            <td valign="top" height="146" bgcolor="D9E5F4" width="81%">
                                <table width="100%" height="454" border="0" cellpadding="1" cellspacing="1">
                                    <tbody><tr>
                                        <td height="12" colspan="5"><div align="right"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><b>
                                            <input type="button" name="Submit11" value=" Anmeldeformular" onclick="anmeld()">
                                        </b>
                                            <input type="button" name="Button" value="Versicherung" onclick="editinsurance()">
                                            <input name="Submit8" type="button" value="Bilder" onclick="addBilder()">
                                            <input type="button" name="Submit7" value="Vertrag" onclick="addVer()">
                                            <input type="button" name="Submit2" value="Haupt" onclick="haupt()">
                                        </font></div></td>
                                        <c:forEach items="${vertrags}" var="vertrag">
                                            <td width="1%" height="26" rowspan="4">&nbsp;</td>
                                            <td width="13%" rowspan="4"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><img src="/studentBilder/image?ver=${vertrag.bildName}" width="100" height="90"></font></td>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td height="6" colspan="5"><div align="right"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">
                                            <input type="button" name="Submit4" value="Einzelunterricht" onclick="einzel()">
                                            <input type="button" name="Submit5" value="Werbung" onclick="editwerbung()">
                                            <input type="submit" name="Submit" value="Kurs-Registrierung" onclick="makevertrag()">
                                            <input type="submit" name="Submit" value="STK" onclick="makevertragstk()">
                                            <input type="button" name="Submit3" value="Schüler-Daten" onclick="studentinfo()">
                                        </font></div></td>
                                    </tr>
                                    <tr>
                                        <td height="6" colspan="5"><div align="right"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">
                                            <input type="button" name="Submit30" value="Beschwerden" onclick="complaints()">
                                            <input type="button" name="Submit20" value="Gruppen" onclick="editgroup()">
                                            <input type="button" name="Submit10" value="Fahrt Kosten" onclick="integrationcost()">
                                            <input type="button" name="Submit3" value="Sonstige Kosten" onclick="xtraCosts()">
                                            <input type="button" name="Submit6" value="Bücher verkaufen" onclick="sale()">
                                        </font></div></td>
                                    </tr>
                                    <tr>
                                        <td height="13" colspan="5">&nbsp;</td>
                                    </tr>

                                    <tr>
                                        <td height="21" colspan="7" bgcolor="657A9A">
                                            <div align="center"><b><font size="3" color="#FFFFFF">Schüler
                                                Information</font></b></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="15%" height="17" bgcolor="657A9A">
                                            <div align="center"><b><font size="2" color="#FFFFFF">Kunde
                                                Nr.</font></b></div>
                                        </td>
                                        <td width="25%" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Vorname</font></b></td>
                                        <td width="13%" bgcolor="657A9A">
                                            <div align="center"><b><font size="2" color="#FFFFFF">Nachname</font></b></div>
                                        </td>
                                        <td width="33%" colspan="2" bgcolor="657A9A">
                                            <div align="center"><b><font size="2" color="#FFFFFF">Werbung</font></b></div>
                                        </td>
                                        <td colspan="2" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Anwesenheit</font></strong></td>
                                    </tr>
                                    <tr>
                                        <td width="15%" height="20" bgcolor="AEBACD"><font size="2" color="#000033"><a href="schuler/showStudentDetail?userid=${student.userID}">${student.userID}</a></font></td>
                                        <td width="25%" bgcolor="AEBACD"><font size="2" color="#000033"><a href="/schuler/showStudentDetail?userid=${student.userID}">${student.userFirstName}</a></font></td>
                                        <td bgcolor="AEBACD"><font size="2" color="#000033">${student.userLastName}</font></td>
                                        <td width="33%" colspan="2" bgcolor="AEBACD"><font size="2" color="#000033">${allWerbung}</font></td>
                                        <td colspan="2" bgcolor="AEBACD"><font size="2" color="#000033">${anwesenheit}</font></td>
                                    </tr>
                                    <tr>
                                        <td height="21" colspan="2"><font color="#FF0000"><strong><font size="2">${vertragStatus}</font></strong></font>
                                            <div align="center"><font color="#FF0000"><strong></strong></font></div></td>
                                        <td height="21" colspan="2"><font size="2" color="#000033"><a href="/schuler/updateFreigabe?userid=${student.userID}">${freigabeStatusText}</a></font><font color="#FF0000"><strong></strong></font></td>
                                        <td height="21" colspan="3"><div align="right"><font color="#FF0000"><strong><font size="2">${beitrag}</font></strong></font></div></td>
                                    </tr>
                                    <tr>
                                        <td colspan="7" height="14" bgcolor="657A9A">
                                            <div align="center"><font size="3"><b><font color="#FFFFFF">Kurs
                                                Einzelheit</font></b></font></div>
                                        </td>
                                    </tr>
                                    <tr valign="top">
                                        <td height="127" colspan="7">
                                            <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                                <tbody><tr bgcolor="657A9A">
                                                    <td width="7%"><b><font size="2" color="#FFFFFF">Abmelden</font></b></td>
                                                    <td width="25%"><b><font size="2" color="#FFFFFF">Kursname</font></b></td>
                                                    <td width="11%"><b><font size="2" color="#FFFFFF">Anfang Datum</font></b></td>
                                                    <td width="5%"><b><font size="2" color="#FFFFFF">Status</font></b></td>
                                                    <td width="7%"><b><font color="#FFFFFF" size="2">Gebühr</font></b></td>
                                                    <td width="8%"><b><font size="2" color="#FFFFFF">bezahlt</font></b></td>
                                                    <td width="9%"><b><font size="2" color="#FFFFFF">Noch Offen</font></b></td>
                                                    <td width="19%"><b><font size="2" color="#FFFFFF">Bericht Nr</font></b></td>
                                                    <td width="9%"><font size="2" color="#FFFFFF"><b>InKasso</b></font></td>
                                                </tr>

                                                <c:forEach items="${spdv}" var="s">
                                                    <c:choose>
                                                        <c:when test="${s.courseRegistration.registrationStatus eq 0}">
                                                            <tr bgcolor="AEBACD">
                                                                <td width="7%"><font size="2" color="#000033">
                                                                    <input type="checkbox" name="checkbox" value="checkbox" onClick="leave('Haben Sie 100 Euro angenommen?','${s.course.courseID}');return false">
                                                                </font></td>
                                                                <td width="25%"><font size="2" color="#000033"><a href="/schuler/showFeeDetail?courseid=${s.course.courseID}">${s.course.courseName}</a></font></td>
                                                                <td width="11%"><font size="2" color="#000033">${s.courseStartDate}</font></td>
                                                                <td width="5%"><font size="2" color="#000033">${s.mys}
                                                                    <!--Tauseef -->
                                                                </font></td>
                                                                <td width="7%"><font size="2" color="#000033">${s.courseFee}</font></td>
                                                                <td width="8%"><font size="2" color="#000033">${s.creStr}</font></td>
                                                                <td width="9%"><font size="2" color="#000033">${s.balance}</font></td>
                                                                <td width="19%"><font size="2" color="#000033"><a href="/schuler/linkToBericht?studentID=${s.courseRegistration.studentID}">${s.tempb}</a></font></td>
                                                                <td width="9%"><font size="2" color="#FF0000">${s.inkasso}</font></td>
                                                            </tr>
                                                        </c:when>
                                                        <c:when test="${s.courseRegistration.registrationStatus eq 1}">
                                                            <tr bgcolor="AEBACD">
                                                                <td width="7%"><font size="2" color="#000033">
                                                                    <input type="checkbox" name="checkbox2" value="checkbox" onClick="leave('Haben Sie 100 Euro angenommen?','${s.course.courseID}');return false" disabled>
                                                                </font></td>
                                                                <td width="25%"><font size="2" color="#000033"><a href="/schuler/showFeeDetail?courseid=${s.course.courseID}">${s.course.courseName}</a></font></td>
                                                                <td width="11%"><font size="2" color="#000033">${s.courseStartDate}</font></td>
                                                                <td width="5%"><font size="2" color="#000033">${s.mys}</font></td>
                                                                <td width="7%"><font size="2" color="#000033">${s.courseFee} </font></td>
                                                                <td width="8%"><font size="2" color="#000033">${s.creStr}</font></td>
                                                                <td width="9%"><font size="2" color="#000033">${s.balance}</font></td>
                                                                <td width="19%"><font size="2" color="#000033"><a href="/schuler/showTransactions?studentID=${s.courseRegistration.studentID}">${s.tempb}</a></font></td>
                                                                <td width="9%"><font size="2" color="#FF0000">${s.inkasso}</font></td>
                                                            </tr>
                                                        </c:when>
                                                        <c:when test="${s.courseRegistration.registrationStatus eq 2}">
                                                            <tr bgcolor="AEBACD">
                                                                <td width="7%"><font size="2" color="#000033">
                                                                    <input type="checkbox" name="checkbox2" value="checkbox" onClick="leave('Haben Sie 100 Euro angenommen?','${s.course.courseID}');return false" disabled>
                                                                </font></td>
                                                                <td width="25%"><font size="2" color="#000033">${s.course.courseName}</font></td>
                                                                <td width="11%"><font size="2" color="#000033">${s.courseStartDate}</font></td>
                                                                <td width="5%"><font size="2" color="#000033">${s.mys}</font></td>
                                                                <td width="7%"><font size="2" color="#000033">${s.courseFee} </font></td>
                                                                <td width="8%"><font size="2" color="#000033">${s.creStr}</font></td>
                                                                <td width="9%"><font size="2" color="#000033">${s.balance}</font></td>
                                                                <td width="19%"><font size="2" color="#000033"><a href="/schuler/linkToBericht?studentID=${s.courseRegistration.studentID}%>">${s.tempb}</a></font></td>
                                                                <td width="9%"><font size="2" color="#FF0000">${s.inkasso}</font></td>
                                                            </tr>
                                                        </c:when>
                                                        <c:when test="${s.courseRegistration.registrationStatus eq 3}">
                                                            <tr bgcolor="AEBACD">
                                                                <td width="7%"><font size="2" color="#000033">
                                                                    <input type="checkbox" name="checkbox" value="checkbox" onClick="leave('Haben Sie 100 Euro angenommen?','${s.course.courseID}');return false">
                                                                </font></td>
                                                                <td width="25%"><font size="2" color="#000033"><a href="/schuler/showFeeDetail?courseid=${s.course.courseID}">${s.course.courseName}</a></font></td>
                                                                <td width="11%"><font size="2" color="#000033">${s.courseStartDate}</font></td>
                                                                <td width="5%"><font size="2" color="#000033">${s.mys}</font></td>
                                                                <td width="7%"><font size="2" color="#000033">${s.courseFee} </font></td>
                                                                <td width="8%"><font size="2" color="#000033">${s.creStr}</font></td>
                                                                <td width="9%"><font size="2" color="#000033">${s.balance}</font></td>
                                                                <td width="19%"><font size="2" color="#000033"><a href="/schuler/linkToBericht?studentID=${s.courseRegistration.studentID}">${s.tempb}</a></font></td>
                                                                <td width="9%"><font size="2" color="#FF0000">${s.inkasso}</font></td>
                                                            </tr>
                                                        </c:when>
                                                    </c:choose>
                                                </c:forEach>

                                                <c:forEach items="${spdvBottom}" var="s">
                                                    <tr bgcolor="AEBACD">
                                                        <td width="7%"><div align="center"><font size="2" color="#000033"><a href="/schuler/showXtraCosts?userid=${s.stu.userID}&costid=${s.stu.residenceID}">${s.stu.residenceID}</a></font></div>
                                                        </td>
                                                        <td width="25%"><font size="2" color="#000033"><a href="/schuler/showXtraCostDetail?courseid=${s.stu.residenceID}">${s.stu.userRemarks}</a></font></td>
                                                        <td width="11%"><font size="2" color="#000033">${MyDate.formateDate(s.stu.userRegDate,MyDate.NUMERIC,MyDate.DEUTSCH)}</font></td>
                                                        <td width="5%"><font size="2" color="#000033">&nbsp;</font></td>
                                                        <td width="7%"><font size="2" color="#000033">${s.stu.userStundenLohn}</font></td>
                                                        <td width="8%"><font size="2" color="#000033">${s.pay.totalPay}</font></td>
                                                        <td width="9%"><font size="2" color="#000033">${s.xtracost.actualFee - s.pay.totalPay}</font></td>
                                                        <td width="19%"><font size="2" color="#000033"><a href="/schuler/linkToXtraCostBericht?costid=${s.stu.residenceID}">${s.tempc}</a></font></td>
                                                        <td width="9%" bgcolor="AEBACD"><input type="hidden" input name="costid" id="costid" value="${s.stu.residenceID}" ></td>
                                                    </tr>
                                                </c:forEach>


                                                <tr bgcolor="AEBACD">
                                                    <td width="7%">&nbsp;</td>
                                                    <td width="25%">&nbsp;</td>
                                                    <td width="11%">&nbsp;</td>
                                                    <td width="5%">&nbsp;</td>
                                                    <td width="7%"><font size="2" color="#000033"><b>${toge}</b></font></td>
                                                    <td width="8%"><font size="2" color="#000033"><b>${bez}</b></font></td>
                                                    <td width="9%"><font size="2" color="#000033"><b>${nochof}</b></font></td>
                                                    <td width="19%" bgcolor="AEBACD">&nbsp;</td>
                                                    <td width="9%" bgcolor="AEBACD">&nbsp;</td>
                                                </tr>
                                                </tbody></table></td>
                                    </tr>
                                    <tr>
                                        <td height="17" colspan="7" bgcolor="657A9A">
                                            <div align="center"><b><font size="2" color="#FFFFFF">Bemerkung</font></b></div>
                                        </td>
                                    </tr>
                                    <tr valign="top">
                                        <td colspan="7" height="25" bgcolor="AEBACD">
                                            <form name="form1" method="post" action="onlyRemark">
                                                <textarea name="textfield" cols="80" rows="6">${student.userRemarks}</textarea>
                                                <input type="hidden" name="userids" value="${student.userID}">
                                            </form>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="26" colspan="7" bgcolor="AEBACD">
                                            <input type="button" name="Button" value="speichern" onclick="updateR('Wollen Sie die bemerkung speisen?');return false">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="7" height="6">
                                            <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                                <tbody><tr bgcolor="657A9A">
                                                    <td colspan="4">
                                                        <div align="center"><font size="2" color="#FFFFFF"><b><font size="3">Bücher
                                                        </font> </b> </font></div>
                                                    </td>
                                                </tr>
                                                <tr bgcolor="657A9A">
                                                    <td width="17%"><b><font size="2" color="#FFFFFF">Buch
                                                        Nr.:</font></b></td>
                                                    <td width="41%"><b><font size="2" color="#FFFFFF">Buchname</font></b></td>
                                                    <td width="18%"><b><font size="2" color="#FFFFFF">Betrag</font></b></td>
                                                    <td width="24%"><b><font size="2" color="#FFFFFF">RechnungNr.:</font></b></td>
                                                </tr>
                                                <c:forEach items="${buches}" var="buch">
                                                    <tr bgcolor="AEBACD">
                                                        <td width="17%" bgcolor="AEBACD"><font size="2" color="#000033">${buch.bookTrack}</font></td>
                                                        <td width="41%"><font size="2" color="#000033">${buch.bookName}</font></td>
                                                        <td width="18%"><font size="2" color="#000033">${MyCurrency.getDisplayString(buch.price)}</font></td>
                                                        <td height="15" bgcolor="AEBACB" width="11%"><font size="2" color="#000033"><a href="bookrech?rechID=${buch.bookRechnungID}">${buch.bookRechnungID}</a></font></td>
                                                    </tr>
                                                </c:forEach>
                                                </tbody></table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="7" height="93">
                                            <table width="100%" cellpadding="1" cellspacing="1" border="0">
                                                <tbody><tr bgcolor="657A9A">
                                                    <td height="21" colspan="8">
                                                        <div align="center"><b><font color="#FFFFFF">Einzelunterricht
                                                            Liste </font></b></div>
                                                    </td>
                                                </tr>
                                                <tr bgcolor="657A9A">
                                                    <td bgcolor="657A9A" height="22" width="10%">
                                                        <div align="left"><font color="#FFFFFF"><b><font size="2">U
                                                            Nr. </font></b></font></div>
                                                    </td>
                                                    <td width="15%" height="22" bgcolor="657A9A"><font size="2"><b></b></font><font color="#FFFFFF" size="2"><b>Kursname</b></font></td>
                                                    <td bgcolor="657A9A" height="22" width="22%"><font size="2" color="#FFFFFF"><b>Lehrer/in
                                                        name </b></font></td>
                                                    <td bgcolor="657A9A" width="14%"><strong><font color="#FFFFFF" size="2">Stadt</font></strong></td>
                                                    <td bgcolor="657A9A" height="22" width="11%"><font size="2" color="#FFFFFF"><b>Datum</b></font></td>
                                                    <td bgcolor="657A9A" height="22" width="9%"><b><font size="2" color="#FFFFFF">Stunden</font></b></td>
                                                    <td bgcolor="657A9A" height="22" width="9%"><font size="2" color="#FFFFFF"><b>Euro/Std.</b></font></td>
                                                    <td bgcolor="657A9A" height="22" width="10%"><font size="2" color="#FFFFFF"><b>Summe</b></font></td>
                                                </tr>

                                                <tr bgcolor="AEBACD">
                                                    <td height="6" bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>Bericht
                                                        Nrs</b></font></td>
                                                    <td height="6" colspan="7" bgcolor="AEBACD"><font size="2" color="#000033"><a href="linkToBericht?studentID=${student.userID}"></a></font></td>
                                                </tr>
                                                <tr bgcolor="AEBACD">
                                                    <td height="6" colspan="6" bgcolor="657A9A">
                                                        <div align="right"><font size="2" color="#FFFFFF"><b>Einzelunterricht
                                                            Gebühr Guthaben</b></font></div>
                                                    </td>
                                                    <td height="6" width="9%">&nbsp;</td>
                                                    <td height="6" width="10%"><font size="2" color="#000033"><b>,00</b></font></td>
                                                </tr>
                                                <tr bgcolor="AEBACD">
                                                    <td height="6" colspan="8" bgcolor="657A9A">
                                                        <div align="right"><font size="2" color="#FFFFFF"></font></div>
                                                        <div align="right"><font size="2" color="#000033">
                                                            <input type="button" name="Submit9" value="Zahlen" onclick="payEU()">
                                                        </font></div>
                                                    </td>
                                                </tr>
                                                </tbody></table>
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
