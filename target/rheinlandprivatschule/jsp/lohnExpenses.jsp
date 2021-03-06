<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <TITLE>:: L&ouml;hne Ausrechnen ::</TITLE>
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


        function MM_findObj(n, d) { //v4.01
            var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
                d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
            if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
            for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
            if(!x && d.getElementById) x=d.getElementById(n); return x;
        }

        function MM_validateForm() { //v4.0
            var i,p,q,nm,test,num,min,max,errors='',args=MM_validateForm.arguments;
            for (i=0; i<(args.length-2); i+=3) { test=args[i+2]; val=MM_findObj(args[i]);
                if (val) { nm=val.name; if ((val=val.value)!="") {
                    if (test.indexOf('isEmail')!=-1) { p=val.indexOf('@');
                        if (p<1 || p==(val.length-1)) errors+='- '+nm+' must contain an e-mail address.\n';
                    } else if (test!='R') { num = parseFloat(val);
                        if (isNaN(val)) errors+='- '+nm+' must contain a number.\n';
                        if (test.indexOf('inRange') != -1) { p=test.indexOf(':');
                            min=test.substring(8,p); max=test.substring(p+1);
                            if (num<min || max<num) errors+='- '+nm+' must contain a number between '+min+' and '+max+'.\n';
                        } } } else if (test.charAt(0) == 'R') errors += '- '+nm+' is required.\n'; }
            } if (errors) alert('The following error(s) occurred:\n'+errors);
            document.MM_returnValue = (errors == '');
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width:100%;" action="lohnExpenses" method="post" name="form1" onsubmit="MM_validateForm('txtKeyWord','','R');return document.MM_returnValue">
                            <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                <tbody><tr>
                                    <td height="143" valign="top"><table width="100%" border="0" height="160" cellpadding="1" cellspacing="1">
                                        <tbody><tr>
                                            <td height="15"><input name="cmd" type="hidden" id="cmd" value="cmd"></td>
                                        </tr>
                                        <tr bgcolor="657A9A">
                                            <td height="23" colspan="2"><div align="center"><font size="3" color="#FFFFFF"><b>L??hne Ausrechnen </b></font></div></td>
                                        </tr>
                                        <tr>
                                            <td height="21" width="10%" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Von</font></strong></td>
                                            <td height="21" bgcolor="AEBACD">
                                                <select name="selSDay">
                                                    <c:forEach begin="1" end="31" var="i" varStatus="loop">
                                                        <option <c:if test="${i eq day0}">selected</c:if> >${i}</option>
                                                    </c:forEach>
                                                </select>
                                                <select name="selSMonth">

                                                    <option <c:if test="${Integer.parseInt(month0) eq 1}">selected</c:if>>Januar</option>

                                                    <option <c:if test="${Integer.parseInt(month0) eq 2}">selected</c:if>>Februar</option>

                                                    <option <c:if test="${Integer.parseInt(month0) eq 3}">selected</c:if>>M??rz</option>

                                                    <option <c:if test="${Integer.parseInt(month0) eq 4}">selected</c:if>>April</option>

                                                    <option <c:if test="${Integer.parseInt(month0) eq 5}">selected</c:if>>Mai</option>

                                                    <option <c:if test="${Integer.parseInt(month0) eq 6}">selected</c:if>>Juni</option>

                                                    <option <c:if test="${Integer.parseInt(month0) eq 7}">selected</c:if>>Juli</option>

                                                    <option <c:if test="${Integer.parseInt(month0) eq 8}">selected</c:if>>August</option>

                                                    <option <c:if test="${Integer.parseInt(month0) eq 9}">selected</c:if>>September</option>

                                                    <option <c:if test="${Integer.parseInt(month0) eq 10}">selected</c:if>>Oktober</option>

                                                    <option <c:if test="${Integer.parseInt(month0) eq 11}">selected</c:if>>November</option>

                                                    <option <c:if test="${Integer.parseInt(month0) eq 12}">selected</c:if>>Dezember</option>

                                                </select>
                                                <select name="selSYear">
                                                    <c:forEach begin="2004" end="2029" var="y">
                                                        <option <c:if test="${y eq year0}">selected</c:if> >${y}</option>
                                                    </c:forEach>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="24" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Bis</font></strong></td>
                                            <td height="24" bgcolor="AEBACD">
                                                <select name="selEDay">
                                                    <c:forEach begin="1" end="31" var="i" varStatus="loop">
                                                        <option <c:if test="${i eq day}">selected</c:if> >${i}</option>
                                                    </c:forEach>
                                                </select>
                                                <select name="selEMonth">

                                                    <option <c:if test="${Integer.parseInt(month) eq 1}">selected</c:if>>Januar</option>

                                                    <option <c:if test="${Integer.parseInt(month) eq 2}">selected</c:if>>Februar</option>

                                                    <option <c:if test="${Integer.parseInt(month) eq 3}">selected</c:if>>M??rz</option>

                                                    <option <c:if test="${Integer.parseInt(month) eq 4}">selected</c:if>>April</option>

                                                    <option <c:if test="${Integer.parseInt(month) eq 5}">selected</c:if>>Mai</option>

                                                    <option <c:if test="${Integer.parseInt(month) eq 6}">selected</c:if>>Juni</option>

                                                    <option <c:if test="${Integer.parseInt(month) eq 7}">selected</c:if>>Juli</option>

                                                    <option <c:if test="${Integer.parseInt(month) eq 8}">selected</c:if>>August</option>

                                                    <option <c:if test="${Integer.parseInt(month) eq 9}">selected</c:if>>September</option>

                                                    <option <c:if test="${Integer.parseInt(month) eq 10}">selected</c:if>>Oktober</option>

                                                    <option <c:if test="${Integer.parseInt(month) eq 11}">selected</c:if>>November</option>

                                                    <option <c:if test="${Integer.parseInt(month) eq 12}">selected</c:if>>Dezember</option>

                                                </select>
                                                <select name="selEYear">
                                                    <c:forEach begin="2000" end="2029" var="y">
                                                        <option <c:if test="${y eq year}">selected</c:if> >${y}</option>
                                                    </c:forEach>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="21" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Schule</font></strong></td>
                                            <td height="21" bgcolor="AEBACD"><select name="selPlace">
                                                <option value="0" selected="">Alle Schulen</option>

                                                <c:forEach items="${cityV}" var="p">
                                                    <option value="${p.placeID}" <c:if test="${placeID eq p.placeID}">selected</c:if>>${p.placeName}</option>
                                                </c:forEach>

                                            </select></td>
                                        </tr>
                                        <tr bgcolor="AEBACD">
                                            <td height="24" colspan="2"><font size="2" color="#FFFFFF">&nbsp;</font>
                                                <input class="btn btn-primary" type="submit" name="Submit" value="L??hne Ausrechnen">
                                                <input name="cmd" type="hidden" value="cmd"></td>
                                        </tr>
                                        </tbody></table></td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A" height="17"><div align="center"><font size="3" color="#FFFFFF"><b>L??hne Ausrechnen ??bersicht</b></font></div></td>
                                </tr>
                                <tr>
                                    <td valign="top"><table width="100%" border="0" cellpadding="1" cellspacing="1">
                                        <tbody><tr>
                                            <td height="20" bgcolor="657A9A"><font color="#FFFFFF" size="3"><b>L??hne Ausrechnen Bei Lehrer/in </b></font>
                                                <div align="right"><font size="2" color="#FFFFFF"><b></b></font></div></td>
                                        </tr>
                                        <tr bgcolor="AEBACD">
                                            <td height="20" valign="top" bgcolor="#FFFFFF"><table width="100%" border="0" cellpadding="1" cellspacing="1">
                                                <tbody><tr bgcolor="657A9A">
                                                    <td width="35%"><strong><font color="#FFFFFF" size="2">Lehrer/in</font></strong><strong></strong></td>
                                                    <td width="17%"><strong><font color="#FFFFFF" size="2">Kursestunden</font></strong></td>
                                                    <td width="15%"><strong><font color="#FFFFFF" size="2">Privatstunden</font></strong></td>
                                                    <td width="14%"><strong><font color="#FFFFFF" size="2">Gesamtstunden</font></strong></td>
                                                    <td width="19%"><strong><font color="#FFFFFF" size="2">Auszahlungsbetrag (EUR) </font></strong></td>
                                                </tr>
                                                <c:set var="totalNormalHoursBT" value="0" />
                                                <c:set var="totalPrivateHoursBT" value="0" />
                                                <c:set var="totalHoursBT" value="0" />
                                                <c:set var="totalPayableBT" value="0.0" />

                                                <c:forEach items="${reportByTeacher.teacherReports}" var="teacherLohnReport">
                                                    <tr bgcolor="AEBACD">
                                                        <td><font color="#000033" size="2">${teacherLohnReport.teacherName}</font></td>
                                                        <td><font color="#000033" size="2">${teacherLohnReport.totalHoursWorkedNormal}</font></td>
                                                        <td><font color="#000033" size="2">${teacherLohnReport.totalHoursWorkedPrivate}</font></td>
                                                        <td><font color="#000033" size="2">${teacherLohnReport.totalHoursWorkedNormal+teacherLohnReport.totalHoursWorkedPrivate}</font></td>
                                                        <td><font color="#000033" size="2">${teacherLohnReport.amountPayable}</font></td>

                                                        <c:set var="totalNormalHoursBT" value="${totalNormalHoursBT + teacherLohnReport.totalHoursWorkedNormal}" />
                                                        <c:set var="totalPrivateHoursBT" value="${totalPrivateHoursBT + teacherLohnReport.totalHoursWorkedPrivate}" />
                                                        <c:set var="totalHoursBT" value="${totalNormalHoursBT + totalPrivateHoursBT}" />
                                                        <c:set var="totalPayableBT" value="${totalPayableBT + teacherLohnReport.amountPayable}" />
                                                    </tr>
                                                </c:forEach>

                                                <tr bgcolor="AEBACD">
                                                    <td><font color="#000033" size="2">&nbsp;</font><font color="#000033" size="2">&nbsp;</font></td>
                                                    <td bgcolor="AEBACD"><strong><font color="#000033" size="2">${totalNormalHoursBT}</font></strong></td>
                                                    <td bgcolor="AEBACD"><strong><font color="#000033" size="2">${totalPrivateHoursBT}</font></strong></td>
                                                    <td bgcolor="AEBACD"><strong><font color="#000033" size="2">${totalHoursBT}</font></strong></td>
                                                    <td><strong><font color="#000033" size="2">${totalPayableBT}</font></strong></td>
                                                </tr>
                                                </tbody></table></td>
                                        </tr>
                                        <tr bgcolor="AEBACD">
                                            <td height="20" bgcolor="AEBACD"><b></b><b></b><b></b></td>
                                        </tr>
                                        <tr bgcolor="AEBACD">
                                            <td bgcolor="657A9A"><strong><font color="#FFFFFF" size="3"><b>L??hne Ausrechnen</b></font> <font size="3" color="#FFFFFF">Bei Kurse </font></strong></td>
                                        </tr>
                                        <tr bgcolor="AEBACD">
                                            <td valign="top" bgcolor="#FFFFFF"><table width="100%" border="0" cellpadding="1" cellspacing="1" bordercolor="AEBACD">
                                                <tbody><tr bgcolor="657A9A">
                                                    <td width="44%"><strong><font color="#FFFFFF" size="2">Kursname</font></strong></td>
                                                    <td width="17%"><strong><font color="#FFFFFF" size="2">Stadt</font></strong></td>
                                                    <td width="20%"><strong><font color="#FFFFFF" size="2">Gesamtstunden</font></strong></td>
                                                    <td width="19%"><strong><font color="#FFFFFF" size="2">Auszahlungsbetrag (EUR) </font></strong></td>
                                                </tr>
                                                <c:set var="totalHoursBC" value="0" />
                                                <c:set var="totalPayableBC" value="0.0" />

                                                <c:forEach items="${reportByCourse.courseReports}" var="c">
                                                    <c:set var="totalHoursBC" value="${totalHoursBC + c.totalHoursWorkedNormal}" />
                                                    <c:set var="totalPayableBC" value="${totalPayableBC + c.amountPayable}" />

                                                <tr bgcolor="AEBACD">
                                                    <td height="23"><font color="#000033" size="2">${c.courseName}</font></td>
                                                    <td height="23"><font color="#000033" size="2">${c.coursePlace}</font></td>
                                                    <td><font color="#000033" size="2">${c.totalHoursWorkedNormal}</font></td>
                                                    <td><font color="#000033" size="2">${c.amountPayable}</font></td>
                                                </tr>
                                                <tr bgcolor="#FFFFFF">
                                                    <td height="23" colspan="4"><table width="100%" border="0" cellpadding="1" cellspacing="1">
                                                        <tr bgcolor="#CCCCFF">
                                                            <td width="12%"><font color="#FFFFFF"><strong></strong></font></td>
                                                            <td width="49%"><strong><font color="#FFFFFF" size="2">Lehrer/in</font></strong><strong></strong></td>
                                                            <td width="20%"><strong><font color="#FFFFFF" size="2">Gesamtstunden</font></strong></td>
                                                            <td width="19%"><strong><font color="#FFFFFF" size="2">Auszahlungsbetrag (EUR) </font></strong></td>
                                                        </tr>

                                                        <c:forEach items="${c.teacherLohnReport}" var="ct">
                                                            <tr bgcolor="#CCCCCC">
                                                                <td>&nbsp;</td>
                                                                <td><font color="#000033" size="2">${ct.teacherName}</font></td>
                                                                <td><font color="#000033" size="2">${ct.totalHoursWorkedNormal}</font></td>
                                                                <td><font color="#000033" size="2">${ct.amountPayable}</font></td>
                                                            </tr>
                                                        </c:forEach>
                                                    </table>
                                                    </td>
                                                </tr>
                                                </c:forEach>

                                                <tr bgcolor="AEBACD">
                                                    <td height="23" colspan="2">&nbsp;</td>
                                                    <td><font color="#000033" size="2"><strong>${totalHoursBC}</strong></font></td>
                                                    <td><font color="#000033" size="2"><strong>${totalPayableBC}</strong></font></td>
                                                </tr>
                                                </tbody></table></td>
                                        </tr>
                                        </tbody></table></td>
                                </tr>
                                </tbody></table>
                            <p>&nbsp;</p>
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
