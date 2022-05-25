<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="MyCurrency" class="com.rheinlandprivatschule.helper.MyCurrency" />
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Buch zu eintragen ::</title>
    <style>
        table tr {
            border-bottom: 1px solid white;
        }
    </style>

    <script>
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
                        <a style="margin-right: 5px;" class="btn btn-primary" href="/showStudentPreciseD?userid=${userid}">Schüler Einzelheit</a>
                        <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                    </div>

                    <form name="form1" method="post" action="bookTra" onsubmit="MM_validateForm('ano','','RisNum');return document.MM_returnValue">
                        <table width="100%" height="142" border="0" cellpadding="1" cellspacing="1">
                            <tbody>
                            <tr bgcolor="657A9A">
                                <td colspan="3" height="11">
                                    <div align="center"><b><font color="#FFFFFF">Buch zu
                                        eintragen </font></b></div>
                                </td>
                            </tr>
                            <tr>
                                <td width="33%" bgcolor="657A9A" height="7"><b><font size="2" color="#FFFFFF">BuchNr.:</font></b></td>
                                <td height="7" bgcolor="AEBACD" colspan="2">
                                    <input type="text" name="id">
                                </td>
                            </tr>
                            <tr>
                                <td width="33%" bgcolor="AEBACD" height="2">&nbsp;</td>
                                <td bgcolor="AEBACD" height="2" colspan="2">
                                    <input type="submit" name="Submit" value="OK">
                                    <input type="button" name="Submit2" value="Bezahlen" onclick="pay()">
                                    <input type="hidden" name="userids" value="${userid}">
                                </td>
                            </tr>
                            <tr bgcolor="657A9A">
                                <td colspan="3" height="2">
                                    <div align="center"><font size="3" color="#FFFFFF"><b>Bücher
                                        zu verkaufen</b></font></div>
                                </td>
                            </tr>
                            <tr bgcolor="AEBACD">
                                <td width="33%" bgcolor="657A9A" height="2"><b><font size="2" color="#FFFFFF">Summe</font></b></td>
                                <c:if test="${sessionScope.get('booktrag') != null}">
                                    <c:set var="books" property="${sessionScope.get('booktrag')}" />
                                </c:if>
                                <td height="2" colspan="2"><font size="2" color="#000033"><c:if test="${books eq null}">0</c:if><c:if test="${books != null}">${books.size()}</c:if></font></td>
                            </tr>
                            <c:forEach items="${books}" var="bk">
                                <tr bgcolor="AEBACD">
                                    <td height="2" width="33%"><font size="2" color="#000033">${bk.bookName}~${bk.bookTrack}</font></td>
                                    <td height="2" width="46%">&nbsp;</td>
                                    <td height="2" width="21%"><font size="2" color="#000033"><a href="removebook?bid=${bk.bookID}">L&ouml;schen</a></font></td>
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

<c:if test="${param.err != null}">
    <script>
        window.onload = function() {
            alert('${param.err}')
        }
    </script>
</c:if>
</body>
</html>