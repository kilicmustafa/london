<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Ansicht Bericht ::</title>
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

        function today()
        {
            window.location="showTransactionsToday?selC="+document.form1.selC.value
                +"&selAdmin="+document.form1.selAdmin.value
                +"&selPlace="+document.form1.selPlace.value
                +"&tranNo="+document.form1.tranNo.value
                +"&selSDay="+document.form1.selSDay.value
                +"&selSMonth="+document.form1.selSMonth.value
                +"&selSYear="+document.form1.selSYear.value
                +"&selEDay="+document.form1.selEDay.value
                +"&selEMonth="+document.form1.selEMonth.value
                +"&selEYear="+document.form1.selEYear.value
                +"&xtraCost="+document.form1.xtraCost.value
                +"&bucher="+document.form1.bucher.value
                +"&rent="+document.form1.rent.value;
        }
        // -->

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
                        <form style="width: 100%;" name="form1" method="post" action="">
                            <table width="100%" border="0" cellpadding="1" cellspacing="1" height="42">
                                <tr>
                                    <td bgcolor="657A9A" height="17">
                                        <div align="center"><font size="3" color="#FFFFFF"><b>Offene
                                            Einzelunterricht </b></font></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                            <tr>
                                                <td height="20" bgcolor="657A9A" width="34%"><font color="#FFFFFF" size="2"><b>Summe</b></font></td>
                                                <td height="20" bgcolor="657A9A" colspan="3">
                                                    <div align="right"><font size="2" color="#FFFFFF"><b>${studentGuthabenViewModels.size()}</b></font></div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="20" bgcolor="657A9A" width="34%"><b><font size="2" color="#FFFFFF">Vorname</font></b></td>
                                                <td height="20" bgcolor="657A9A" width="35%"><b><font size="2" color="#FFFFFF">Nachname</font></b></td>
                                                <td height="20" bgcolor="657A9A" width="16%"><b><font size="2" color="#FFFFFF">Geburtsdatum</font></b></td>
                                                <td height="20" bgcolor="657A9A" width="15%"><b><font color="#FFFFFF" size="2">Guthaben</font></b></td>
                                            </tr>

                                            <c:forEach items="${studentGuthabenViewModels}" var="s">
                                                <tr bgcolor="AEBACD">
                                                    <td><font size="2" color="#000000"><a href="/schuler/showStudentPreciseD?userid=${s.student.userID}">${s.student.userFirstName}</a></font></td>
                                                    <td bgcolor="AEBACD"><font size="2" color="#000000">${s.student.userLastName}</font></td>
                                                    <td bgcolor="AEBACD"><font size="2" color="#000000">${s.formatedDate}</font></td>
                                                    <td bgcolor="AEBACD"><font size="2" color="#000000">${s.formatedCurrency}</font></td>
                                                </tr>
                                            </c:forEach>
                                            <tr bgcolor="AEBACD">
                                                <td>&nbsp;</td>
                                                <td bgcolor="AEBACD">&nbsp;</td>
                                                <td bgcolor="AEBACD">&nbsp;</td>
                                                <td bgcolor="AEBACD"><font size="2" color="#000000"><b>${total}</b></font></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
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
