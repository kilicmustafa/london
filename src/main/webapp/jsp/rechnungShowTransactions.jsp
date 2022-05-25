<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Bericht Ansicht ::</title>
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
        function leave1(){
            if(document.form1.canberprint.value==="true")	{
                document.form1.submit();
            }else{
                alert('Ihnen wird nicht erlaubt, das zu tun.')
            }
        }

        function goback()
        {
            window.location="searchTransactions";
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="leave1()">Druck</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="goback()">Zurück</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width: 100%;" name="form1" method="post" action="berichtPrintProcess">
                            <input name="canberprint" type="hidden" id="canberprint" value="${canprint}">
                            <table width="100%" border="0" cellspacing="1" cellpadding="1">
                                <tr>
                                    <td colspan="9" bgcolor="657A9A" height="8">
                                        <div align="center"><font size="4" color="#FFFFFF"><b>Bericht
                                            Ansicht</b></font></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="7" bgcolor="657A9A" colspan="2"><font size="2" color="#FFFFFF"><b>Total Sume</b></font></td>
                                    <td colspan="7" height="7" bgcolor="657A9A"><div align="right"><font size="2" color="#FFFFFF"><b>${total}</b></font></div></td>
                                </tr>
                                <tr>
                                    <td height="7" bgcolor="657A9A" colspan="2"><font size="2" color="#FFFFFF"><b>Sume</b></font></td>
                                    <td colspan="7" height="7" bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>${payType}</b></font>
                                        <div align="right"><font size="2" color="#FFFFFF"><b>${roundedEuro}</b></font></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="3%" height="7" bgcolor="657A9A"><b></b></td>
                                    <td width="6%" height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Bericht
                                        Nr</font></b></td>
                                    <td width="17%" height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Sch&uuml;ler
                                        Name</font></b></td>
                                    <td width="17%" height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Kurs
                                        Name</font></b></td>
                                    <td width="8%" height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Betrag</font></b></td>
                                    <td width="10%" height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Datum</font></b></td>
                                    <td width="11%" height="7" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Ordnung</font></b></td>
                                    <td width="15%" height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Admin
                                        Name</font></b></td>
                                    <td width="13%" height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Schule
                                        Name</font></b></td>
                                </tr>
                                <c:forEach items="${myTrModel}" var="t">
                                    <c:choose>
                                        <c:when test="${t.transaction.paymentType eq 0}">
                                            <c:set var="ordnung" value="Bar"/>
                                        </c:when>
                                        <c:when test="${t.transaction.paymentType eq 1}">
                                            <c:set var="ordnung" value="Uberweisung"/>
                                        </c:when>
                                        <c:when test="${t.transaction.paymentType eq 2}">
                                            <c:set var="ordnung" value="Online"/>
                                        </c:when>
                                        <c:when test="${t.transaction.paymentType eq 3}">
                                            <c:set var="ordnung" value="Inkasso"/>
                                        </c:when>
                                        <c:when test="${t.transaction.paymentType eq 4}">
                                            <c:set var="ordnung" value="BAMF"/>
                                        </c:when>
                                    </c:choose>


                                    <tr bgcolor="AEBACD">
                                        <td width="3%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">
                                            <input type="checkbox" name="dr" value="${t.transaction.transactionNo}">
                                        </font></td>
                                        <td width="6%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${t.transaction.transactionNo}</font></td>
                                        <td width="17%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><a href="/schuler/showStudentPreciseD?userid=${t.transaction.studentID}">${t.transaction.studentCompleteName}</a></font></td>
                                        <td width="17%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${t.transaction.courseName}</font></td>
                                        <td width="8%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${t.paymentDisplay}</font></td>
                                        <td width="10%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${t.paymentDateDisplay}</font></td>
                                        <td width="11%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${ordnung}</font></td>
                                        <td width="15%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${t.transaction.loginUserCompleteName}</font></td>
                                        <td width="13%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${t.transaction.placeName}</font></td>
                                    </tr>
                                </c:forEach>


                                <tr bgcolor="AEBACD">
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td height="7" bgcolor="657A9A" colspan="9"><div align="center"><font size="4" color="#FFFFFF"><b>Sonstige Kosten  Ansicht</b></font></div></td>
                                </tr>
                                <tr>
                                    <td height="7" bgcolor="657A9A" colspan="2"><font size="2" color="#FFFFFF"><b>Sume</b></font></td>
                                    <td colspan="7" height="7" bgcolor="657A9A"><div align="right"><font size="2" color="#FFFFFF"><b>${xroundedEuro}</b></font></div></td>
                                </tr>
                                <tr>
                                    <td height="7" bgcolor="657A9A"><b></b></td>
                                    <td height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Bericht Nr</font></b></td>
                                    <td height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Sch&uuml;ler Name</font></b></td>
                                    <td height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Kost</font></b></td>
                                    <td height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Betrag</font></b></td>
                                    <td height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Datum</font></b></td>
                                    <td height="7" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Ordnung</font></b></td>
                                    <td height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Admin Name</font></b></td>
                                    <td height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Schule Name</font></b></td>
                                </tr>
                                <c:forEach items="${myXtrModel}" var="t">
                                    <c:choose>
                                        <c:when test="${t.transaction.paymentType eq 0}">
                                            <c:set var="ordnung" value="Bar"/>
                                        </c:when>
                                        <c:when test="${t.transaction.paymentType eq 1}">
                                            <c:set var="ordnung" value="Uberweisung"/>
                                        </c:when>
                                        <c:when test="${t.transaction.paymentType eq 2}">
                                            <c:set var="ordnung" value="Online"/>
                                        </c:when>
                                        <c:when test="${t.transaction.paymentType eq 3}">
                                            <c:set var="ordnung" value="Inkasso"/>
                                        </c:when>
                                        <c:when test="${t.transaction.paymentType eq 4}">
                                            <c:set var="ordnung" value="BAMF"/>
                                        </c:when>
                                    </c:choose>


                                    <tr bgcolor="AEBACD">
                                        <td width="3%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">
                                            <input type="hidden" name="dr" value="${t.transaction.transactionNo}">
                                        </font></td>
                                        <td width="6%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${t.transaction.transactionNo}</font></td>
                                        <td width="17%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><a href="/schuler/showStudentPreciseD?userid=${t.transaction.studentID}">${t.transaction.studentCompleteName}</a></font></td>
                                        <td width="17%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${t.sta.costDesc}</font></td>
                                        <td width="8%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${t.paymentDisplay}</font></td>
                                        <td width="10%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${t.paymentDateDisplay}</font></td>
                                        <td width="11%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${ordnung}</font></td>
                                        <td width="15%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${t.transaction.loginUserCompleteName}</font></td>
                                        <td width="13%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${t.transaction.placeName}</font></td>
                                    </tr>
                                </c:forEach>
                                <tr bgcolor="AEBACD">
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td height="7" bgcolor="657A9A" colspan="9"><div align="center"><font size="4" color="#FFFFFF"><b>B&uuml;cher Ansicht</b></font></div></td>
                                </tr>
                                <tr>
                                    <td height="7" bgcolor="657A9A" colspan="2"><font size="2" color="#FFFFFF"><b>Sume</b></font></td>
                                    <td colspan="7" height="7" bgcolor="657A9A"><div align="right"><font size="2" color="#FFFFFF"><b>${broundedEuro}</b></font></div></td>
                                </tr>
                                <tr>
                                    <td height="7" bgcolor="657A9A"><b></b></td>
                                    <td height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Bericht Nr</font></b></td>
                                    <td height="7" colspan="2" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Sch&uuml;ler Name</font></b><b></b></td>
                                    <td height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Betrag</font></b></td>
                                    <td height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Datum</font></b></td>
                                    <td height="7" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Ordnung</font></b></td>
                                    <td height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Admin Name</font></b></td>
                                    <td height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Schule Name</font></b></td>
                                </tr>
                                <c:forEach items="${myBuchModel}" var="t">
                                    <c:choose>
                                        <c:when test="${t.transaction.paymentType eq 0}">
                                            <c:set var="ordnung" value="Bar"/>
                                        </c:when>
                                        <c:when test="${t.transaction.paymentType eq 1}">
                                            <c:set var="ordnung" value="Uberweisung"/>
                                        </c:when>
                                        <c:when test="${t.transaction.paymentType eq 2}">
                                            <c:set var="ordnung" value="Online"/>
                                        </c:when>
                                        <c:when test="${t.transaction.paymentType eq 3}">
                                            <c:set var="ordnung" value="Inkasso"/>
                                        </c:when>
                                        <c:when test="${t.transaction.paymentType eq 4}">
                                            <c:set var="ordnung" value="BAMF"/>
                                        </c:when>
                                    </c:choose>


                                    <tr bgcolor="AEBACD">
                                        <td width="3%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">
                                            <input type="hidden" name="dr" value="${t.transaction.transactionNo}">
                                        </font></td>
                                        <td width="6%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${t.transaction.transactionNo}</font></td>
                                        <td width="17%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><a href="/schuler/showStudentPreciseD?userid=${t.transaction.studentID}">${t.transaction.studentCompleteName}</a></font></td>
                                        <td width="17%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${t.transaction.courseName}</font></td>
                                        <td width="8%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${t.paymentDisplay}</font></td>
                                        <td width="10%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${t.paymentDateDisplay}</font></td>
                                        <td width="11%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${ordnung}</font></td>
                                        <td width="15%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${t.transaction.loginUserCompleteName}</font></td>
                                        <td width="13%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${t.transaction.placeName}</font></td>
                                    </tr>
                                </c:forEach>
                                <tr bgcolor="AEBACD">
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td colspan="2">&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td height="7" bgcolor="657A9A" colspan="9"><div align="center"><font size="4" color="#FFFFFF"><b>Miete Ansicht</b></font></div></td>
                                </tr>
                                <tr>
                                    <td height="7" bgcolor="657A9A" colspan="2"><font size="2" color="#FFFFFF"><b>Sume</b></font></td>
                                    <td colspan="7" height="7" bgcolor="657A9A"><div align="right"><font size="2" color="#FFFFFF"><b>${rentRoundedEuro}</b></font></div></td>
                                </tr>
                                <tr>
                                    <td height="7" bgcolor="657A9A"><b></b></td>
                                    <td height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Bericht Nr</font></b></td>
                                    <td height="7" colspan="2" bgcolor="657A9A"><b><font color="#FFFFFF" size="2"><b>Bezeichnung</b></font></b><b></b></td>
                                    <td height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Betrag</font></b></td>
                                    <td height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Datum</font></b></td>
                                    <td height="7" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Ordnung</font></b></td>
                                    <td height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Admin Name</font></b></td>
                                    <td height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Schule Name</font></b></td>
                                </tr>
                                <c:forEach items="${myRentModel}" var="t">
                                    <c:choose>
                                        <c:when test="${t.transaction.paymentType eq 1}">
                                            <c:set var="ordnung" value="Bar"/>
                                        </c:when>
                                        <c:when test="${t.transaction.paymentType eq 3}">
                                            <c:set var="ordnung" value="Uberweisung"/>
                                        </c:when>
                                        <c:when test="${t.transaction.paymentType eq 2}">
                                            <c:set var="ordnung" value="Abbuchung"/>
                                        </c:when>
                                        <c:when test="${t.transaction.paymentType eq -1}">
                                            <c:set var="ordnung" value="Inkasso"/>
                                        </c:when>
                                        <c:when test="${t.transaction.paymentType eq -2}">
                                            <c:set var="ordnung" value="BAMF"/>
                                        </c:when>
                                    </c:choose>


                                    <tr bgcolor="AEBACD">
                                        <td width="3%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">
                                            <input type="hidden" name="dr" value="${t.transaction.transactionNo}">
                                        </font></td>
                                        <td width="6%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${t.transaction.transactionNo}</font></td>
                                        <td width="17%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><a href="/schuler/showStudentPreciseD?userid=${t.transaction.studentID}">${t.transaction.studentCompleteName}</a></font></td>
                                        <td width="17%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${t.transaction.courseName}</font></td>
                                        <td width="8%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${t.paymentDisplay}</font></td>
                                        <td width="10%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${t.paymentDateDisplay}</font></td>
                                        <td width="11%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${ordnung}</font></td>
                                        <td width="15%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${t.transaction.loginUserCompleteName}</font></td>
                                        <td width="13%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${t.transaction.placeName}</font></td>
                                    </tr>
                                </c:forEach>
                                <tr bgcolor="AEBACD">
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td colspan="2">&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                </tr>

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
