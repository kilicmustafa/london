<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Lehrer/in ::</title>
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

        // function that takes names string and inserts it into the parant windows textbox
        function chkMe(){
            document.form1.txtStd.disabled= !document.form1.checkbox.checked;
            document.form1.txtTea.disabled = !document.form1.checkbox.checked;
            document.form1.txtDesc.disabled = !document.form1.checkbox.checked;
        }
        function backAtYa(form) {
            document.form1.submit();
            window.close();

        }

        function MM_findObj(n, d) { //v4.0
            var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
                d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
            if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
            for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
            if(!x && document.getElementById) x=document.getElementById(n); return x;
        }

        function MM_validateForm() { //v4.0
            var i,p,q,nm,test,num,min,max,errors='',args=MM_validateForm.arguments;
            for (i=0; i<(args.length-2); i+=3) { test=args[i+2]; val=MM_findObj(args[i]);
                if (val) { nm=val.name; if ((val=val.value)!="") {
                    if (test.indexOf('isEmail')!=-1) { p=val.indexOf('@');
                        if (p<1 || p==(val.length-1)) errors+='- '+nm+' must contain an e-mail address.\n';
                    } else if (test!='R') {
                        if (isNaN(val)) errors+='- '+nm+' must contain a number.\n';
                        if (test.indexOf('inRange') != -1) { p=test.indexOf(':');
                            min=test.substring(8,p); max=test.substring(p+1);
                            if (val<min || max<val) errors+='- '+nm+' must contain a number between '+min+' and '+max+'.\n';
                        } } } else if (test.charAt(0) == 'R') errors += '- '+nm+' is required.\n'; }
            } if (errors) alert('The following error(s) occurred:\n'+errors);
            document.MM_returnValue = (errors == '');
        }
        //-->
    </script>
</head>
<body>
<form name="form1" onSubmit="MM_validateForm('txtStd','','RisNum');return document.MM_returnValue" action="teacherSelection" method="post">
    <table width="100%" border="0" cellpadding="1" cellspacing="1">
        <tr bgcolor="657A9A">
            <td colspan="2">
                <div align="center"><b><font size="3" color="#FFFFFF">Lehrer/in</font></b></div>
            </td>
        </tr>
        <tr bgcolor="AEBACD">
            <td width="29%" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Lehrer/in</font></b>
            </td>
            <td width="71%">
                <select name="select">
                    <option value="0" selected>Keine Lehrer/in</option>
                    <c:forEach items="${refine}" var="u">
                        <c:set var="na" value="${u.userFirstName} ${u.userLastName}" />
                        <c:if test='${tname.equalsIgnoreCase(na)}'>
                            <option value="${u.userID}" selected>${na}</option>
                        </c:if>
                        <c:if test='${tname.equalsIgnoreCase(na) eq false}'>
                            <option value="${u.userID}">${na}</option>
                        </c:if>
                    </c:forEach>
                </select>
            </td>
        </tr>
        <tr bgcolor="AEBACD">
            <td width="29%" bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>Nur Heute</b></font></td>
            <td width="71%">
                <c:if test="${forSingleElement}">
                    <input type="checkbox" name="checkbox" value="checkbox" onClick="chkMe()" checked>
                </c:if>
                <c:if test="${forSingleElement eq false}">
                    <input type="checkbox" name="checkbox" value="checkbox" onClick="chkMe()">
                </c:if>
            </td>
        </tr>
        <tr bgcolor="AEBACD">
            <td bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>Unterricht Stunden Kurs </b></font></td>
            <td>
                <c:if test="${forSingleElement}">
                    <input type="text" name="txtStd" value="${hours}">
                </c:if>
                <c:if test="${forSingleElement eq false}">
                    <input type="text" name="txtStd" value="${hours}" disabled>
                </c:if>
            </td>
        </tr>
        <tr bgcolor="AEBACD">
            <td bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Unterricht Stunden Lehrer/in </font></strong></td>
            <td>
                <c:if test="${forSingleElement}">
                    <input name="txtTea" type="text" id="txtTea" value="${teacherStunden}">
                </c:if>
                <c:if test="${forSingleElement eq false}">
                    <input name="txtTea" type="text" disabled id="txtTea" value="${teacherStunden}">
                </c:if>
            </td>
        </tr>
        <tr bgcolor="AEBACD">
            <td bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Bemerkung</font></strong></td>
            <td>
                <c:if test="${forSingleElement}">
                    <textarea name="txtDesc" cols="50" rows="5" id="txtDesc" >${desc}</textarea>
                </c:if>
                <c:if test="${forSingleElement eq false}">
                    <textarea name="txtDesc" cols="50" rows="5" id="txtDesc" disabled>${desc}</textarea>
                </c:if>
            </td>
        </tr>
        <tr bgcolor="AEBACD">
            <td colspan="2" bgcolor="657A9A">&nbsp;</td>
        </tr>
        <tr bgcolor="AEBACD">
            <td bgcolor="657A9A"><font size="2" color="#FFFFFF"><b><font size="2" color="#FFFFFF">Gesamtumfang</font></b></font></td>
            <td><font color="#000033" size="2">${totalHours}</font></td>
        </tr>
        <tr bgcolor="AEBACD">
            <td bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>Kursstunden<font size="2" color="#FFFFFF"> bis <font color="#CC6600">${limitDate} </font></font></b></font></td>
            <td><font color="#000033" size="2">${completedHours}</font></td>
        </tr>
        <tr bgcolor="AEBACD">
            <td bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>Noch stunden </b></font></td>
            <td><font color="#000033" size="2">${nochHours}</font></td>
        </tr>
        <tr bgcolor="AEBACD">
            <td width="29%">&nbsp; </td>
            <td width="71%">
                <input class="btn btn-primary" type="button" onClick="backAtYa(this.form)" value="OK" name="button">
            </td>
        </tr>
    </table>
    <br>
</form>
</body>
</html>
