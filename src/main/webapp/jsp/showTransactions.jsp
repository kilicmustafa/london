<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <TITLE>:: Bericht Ansicht ::</TITLE>
    <style>
        table {
            border-collapse: separate;
        }

        a[class="btn btn-primary"] {
            margin-left: 5px;
        }

    </style>

    <script>
        function leave1(){
            if(document.form1.canberprint.value=="true")	{
                document.form1.submit();
            }else{
                alert('Ihnen wird nicht erlaubt, das zu tun.')
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

                    <form name="form1" method="post" action="printBillMul">
                        <table width="100%" border="0" cellspacing="1" cellpadding="1">
                            <tbody><tr>
                                <td colspan="9">
                                    <div align="right">
                                        <input name="sid" type="hidden" id="sid" value="${studentID}">
                                        <input name="canberprint" type="hidden" id="canberprint" value="true">
                                        <a class="btn btn-primary" href="../index" style="float: right;">Haupt</a>
                                        <a class="btn btn-primary" href="showStudentPreciseD?userid=${studentID}" style="float: right;">Zurück</a>
                                        <a class="btn btn-primary" href="#" style="float: right;" onclick="leave1();">Druck</a>


                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="9" bgcolor="657A9A" height="8">
                                    <div align="center"><font size="4" color="#FFFFFF"><b>Bericht
                                        Ansicht</b></font></div>
                                </td>
                            </tr>
                            <tr>
                                <td height="7" bgcolor="657A9A" colspan="2"><font size="2" color="#FFFFFF"><b>Sume</b></font></td>
                                <td colspan="7" height="7" bgcolor="657A9A">
                                    <div align="right"><font size="2" color="#FFFFFF"><b>${roundedEuro}</b></font></div>
                                </td>
                            </tr>
                            <tr>
                                <td width="3%" height="7" bgcolor="657A9A"><b></b></td>
                                <td width="6%" height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Bericht
                                    Nr</font></b></td>
                                <td width="17%" height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Schüler
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
                            <c:forEach items="${transactions}" var="transaction">
                                <tr bgcolor="AEBACD">
                                    <td width="3%"><font size="2" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">
                                        <input type="checkbox" name="dr" value="${transaction.transaction.transactionNo}">
                                    </font></td>
                                    <td width="6%"><font size="2" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${transaction.transaction.transactionNo}</font></td>
                                    <td width="17%"><font size="2" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><a href="schuler/showStudentPreciseD?userid=333">${transaction.transaction.studentCompleteName}</a></font></td>
                                    <td width="17%"><font size="2" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${transaction.transaction.courseName}</font></td>
                                    <td width="8%"><font size="2" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${transaction.paymentDisplay}</font></td>
                                    <td width="10%"><font size="2" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${transaction.paymentDateDisplay}</font></td>
                                    <td width="11%"><font size="2" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><c:choose>
                                        <c:when test="${transaction.transaction.paymentType eq 0}">Bar</c:when>
                                        <c:when test="${transaction.transaction.paymentType eq 1}">Uberweisung</c:when>
                                        <c:when test="${transaction.transaction.paymentType eq 2}">Online</c:when>
                                    </c:choose></font></td>
                                    <td width="15%"><font size="2" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${transaction.transaction.loginUserCompleteName}</font></td>
                                    <td width="13%"><font size="2" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${transaction.transaction.placeName}</font></td>
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