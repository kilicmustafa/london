<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Ausgabe Suchen ::</title>
    <style>
        table tr {
            border-bottom: 1px solid white;
        }

        html {
            overflow-y: hidden;
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
                    <div class="row">
                        <div class="col-md-12">
                            <div class="wrapper" style="margin-bottom: 5px; float:right;">
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width: 100%;" name="form1" method="post" action="berichtPrintProcess">
                            <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                <tr bgcolor="657A9A">
                                    <td height="23" colspan="6">
                                        <div align="center"><b><font color="#FFFFFF">Ausgabe
                                            Liste </font></b></div>
                                    </td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td height="19" colspan="2"><font size="2" color="#FFFFFF"><b>Sume</b></font></td>
                                    <td height="19" colspan="4">
                                        <div align="right"><b><font color="#FFFFFF" size="2">${stoto}</font></b></div>
                                    </td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td height="19" width="5%"><b><font size="2" color="#FFFFFF"></font></b></td>
                                    <td height="19" width="12%"><b><font size="2" color="#FFFFFF">Nr.</font></b></td>
                                    <td height="19" width="35%"><b><font size="2" color="#FFFFFF">Ausgabe</font></b></td>
                                    <td height="19" width="12%"><b><font size="2" color="#FFFFFF">Datum</font></b></td>
                                    <td height="19" width="11%"><b></b><b><font size="2" color="#FFFFFF">Betrag</font></b></td>
                                    <td height="19" width="25%"><b><font size="2" color="#FFFFFF">Admin</font></b></td>
                                </tr>

                                <c:forEach items="${ausgabeListViewModels}" var="a">
                                    <tr bgcolor="AEBACD">
                                        <td height="6" bgcolor="AEBACD" width="5%"><font size="2" color="#000033">
                                            <input type="checkbox" name="checkbox" value="${a.expenditure.expenditureID}">
                                        </font></td>
                                        <td height="6" bgcolor="AEBACD" width="12%"><font size="2" color="#000033">${a.expenditure.expenditureID}</font></td>
                                        <td height="6" bgcolor="AEBACD" width="35%"><font size="2" color="#000033"><a href="viewAusgabe?id=${a.expenditure.expenditureID}">${a.expenditure.expenditureDesc}</a></font></td>
                                        <td height="6" bgcolor="AEBACD" width="12%"><font size="2" color="#000033">${a.formatedDate}</font></td>
                                        <td height="6" bgcolor="AEBACD" width="11%"><font size="2" color="#000033">${a.expenditure.bill}</font></td>
                                        <td height="6" bgcolor="AEBACD" width="25%"><font size="2" color="#000033">${a.neStr}</font></td>
                                    </tr>
                                </c:forEach>
                                <tr bgcolor="AEBACD">
                                    <td height="6" bgcolor="AEBACD" width="5%">&nbsp;</td>
                                    <td height="6" bgcolor="AEBACD" colspan="5">
                                        <input class="btn btn-primary" type="submit" name="Submit" value="Druck">
                                        <input class="btn btn-primary" type="button" name="Button" value="Zur&uuml;ck" onClick="window.history.go(-1); return false;">
                                    </td>
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
