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
        function leave(msg)
        {
            if(!confirm(msg)) return false
            else document.form1.submit()
        }

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
                    <div class="row">
                        <div class="col-md-12">
                            <div class="wrapper" style="margin-bottom: 5px; float:right;">
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="window.history.go(-1); return false;">Zurück</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width: 100%;" name="form1" method="post" action="/bericht/updateUserCash" onSubmit="MM_validateForm('txtBal','','RisNum');return document.MM_returnValue">
                            <table width="100%" border="0" cellspacing="1" cellpadding="1">
                                <input name="canberprint" type="hidden" id="canberprint" value="${canprint}">
                                <tr>
                                    <td colspan="6" bgcolor="657A9A" height="8">
                                        <div align="center"><font size="4" color="#FFFFFF"><b>Bericht
                                            Ansicht</b></font></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="7" bgcolor="657A9A" colspan="2"><font size="2" color="#FFFFFF"><b>Total Sume</b></font></td>
                                    <td colspan="4" height="7" bgcolor="657A9A"><div align="left"><font size="2" color="#FFFFFF"><b>${total}</b></font></div></td>
                                </tr>
                                <tr>
                                    <td height="23" bgcolor="657A9A" colspan="2"><b><font size="2" color="#FFFFFF">Betrag</font></b></td>
                                    <td height="23" bgcolor="AEBACB" colspan="4"><font size="2" color="#405579">
                                        <input type="text" name="txtBal" size="8" value="${geld}">
                                        <input type="hidden" name="selC" size="8" value="${cri}">
                                        <input type="hidden" name="selAdmin" size="8" value="${adminS}">
                                        <input type="hidden" name="selPlace" size="8" value="${placeName}">
                                        <input type="hidden" name="paytype" size="8" value="${paytype}">
                                        <input type="hidden" name="tranno" size="8" value="${tranno}">
                                        <input type="hidden" name="selSDay" size="8" value="${sDay}">
                                        <input type="hidden" name="selSMonth" size="8" value="${sMonth}">
                                        <input type="hidden" name="selSYear" size="8" value="${sYear}">
                                        <input type="hidden" name="selEDay" size="8" value="${eDay}">
                                        <input type="hidden" name="selEMonth" size="8" value="${eMonth}">
                                        <input type="hidden" name="selEYear" size="8" value="${eYear}">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td height="23" bgcolor="657A9A" colspan="2"><b></b></td>
                                    <td height="23" bgcolor="AEBACB" colspan="4"><font size="2" color="#405579">
                                        <input class="btn btn-primary" type="submit" name="Submit" value="Zahlen" onClick="leave('${myMsg}'+document.form1.txtBal.value+' Euro angenommen?');return false">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td height="7" bgcolor="657A9A" colspan="2"><font size="2" color="#FFFFFF"><b>Sume</b></font></td>
                                    <td colspan="4" height="7" bgcolor="657A9A">
                                        <div align="right"><font size="2" color="#FFFFFF"><b>${kasseRoundedEuro}</b></font></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="3%" height="7" bgcolor="657A9A"><b></b></td>
                                    <td width="10%" height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Bericht
                                        Nr</font></b></td>
                                    <td width="30%" height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Betrag</font></b></td>
                                    <td width="23%" height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Datum</font></b><b></b></td>
                                    <td width="21%" height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Admin
                                        Name</font></b></td>
                                    <td width="13%" height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Schule
                                        Name</font></b></td>
                                </tr>
                                <c:forEach items="${kasseViewModels}" var="k">
                                    <tr bgcolor="AEBACD">
                                        <td width="3%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">
                                            <input type="checkbox" name="dr" value="${k.transaction.kasseNo}">
                                        </font></td>
                                        <td width="10%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${k.transaction.kasseNo}</font></td>
                                        <td><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${k.paymentDisplay}</font></td>
                                        <td><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${k.paymentDateDisplay}</font></td>
                                        <td width="21%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${k.transaction.loginUserCompleteName}></font></td>
                                        <td width="13%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">${k.transaction.placeName}</font></td>
                                    </tr>
                                </c:forEach>
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
