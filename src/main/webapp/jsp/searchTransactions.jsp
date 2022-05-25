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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="/bericht/searchUserCash">Kasse</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="/bericht/showStudentGuthaben">Offene Einzelunterricht</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="/bericht/lohnExpenses">Löhne Ausrechnen</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width:100%;" name="form1" method="post" action="showTransactions" onsubmit="MM_validateForm('tranNo','','NisNum');return document.MM_returnValue">
                            <table width="100%" border="0" height="270" cellpadding="1" cellspacing="1">
                                <tbody><tr>

                                </tr>
                                <tr bgcolor="657A9A">
                                    <td height="23" colspan="2">
                                        <div align="center"><font size="3" color="#FFFFFF"><b>Ansicht
                                            Bericht</b></font></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="29" width="24%" bgcolor="657A9A"><font color="#FFFFFF"><b>Gesichtspunkt</b></font></td>
                                    <td height="29" width="76%" bgcolor="AEBACD">
                                        <select name="selC" onchange="if(selectedIndex==2)tranNo.disabled=false;if(selectedIndex==0)tranNo.disabled=true;if(selectedIndex==1)tranNo.disabled=true;if(!tranNo.disabled)tranNo.focus()">
                                            <option value="2" selected="">Date Limit</option>
                                            <option value="1">Given Date</option>
                                            <option value="3">Transaction No</option>
                                        </select>

                                        <input type="checkbox" name="xtraCost" value="checkbox" checked="">

                                        <font size="2" color="#000033">Xtra Kosten</font>
                                        <input type="checkbox" name="bucher" value="checkbox" checked="">

                                        <font size="2" color="#000033">Bucher</font>
                                        <input type="checkbox" name="rent" value="checkbox" checked="">

                                        <font size="2" color="#000033">Miete</font></td>
                                </tr>
                                <tr>
                                    <td height="29" width="24%" bgcolor="657A9A"><font size="2"><b><font color="#FFFFFF">Bericht
                                        Nr</font></b></font></td>
                                    <td height="29" width="76%" bgcolor="AEBACD">
                                        <input type="text" name="tranNo">
                                    </td>
                                </tr>
                                <tr>
                                    <td height="29" width="24%" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Administrator</font></b></td>
                                    <td height="29" width="76%" bgcolor="AEBACD">
                                        <select name="selAdmin">
                                            <option selected>w&auml;hlen Administrator</option>
                                            <c:forEach items="${vec}" var="v">
                                                <option value="${v.userID}">${v.userFirstName}</option>
                                            </c:forEach>

                                        </select>
                                        <font size="1" face="Verdana, Arial, Helvetica, sans-serif">
                                            <input type="button" name="All" value="Alle" onclick="Alle()">
                                        </font>                        </td>
                                </tr>
                                <tr>
                                    <td height="25" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Art der Bezahlung </font></b></td>
                                    <td height="25" bgcolor="AEBACD"><select name="selPayType">
                                        <option value="5" selected="">Zalungsart</option>
                                        <option value="0">Bar</option>
                                        <option value="1">Uberweisung</option>
                                        <option value="2">Online</option>
                                        <option value="3">Inkasso</option>
                                        <option value="4">BAMF</option>
                                    </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="24%" height="25" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Schule
                                        Name</font></b></td>
                                    <td width="76%" height="25" bgcolor="AEBACD">
                                        <select name="selPlace">
                                            <option selected="">wählen Schule</option>

                                            <c:forEach items="${cityV}" var="c">
                                                <option value="${c.placeID}">${c.placeName}</option>
                                            </c:forEach>

                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="24%" height="26" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Anfang
                                        Datum</font></b></td>
                                    <td width="76%" height="26" bgcolor="AEBACD">
                                        <select name="selSDay">
                                            <c:forEach begin="1" end="31" var="i" varStatus="loop">
                                                <option <c:if test="${i eq day0}">selected</c:if> >${i}</option>
                                            </c:forEach>
                                        </select>
                                        <select name="selSMonth">

                                            <option <c:if test="${month0 eq 1}">selected</c:if>>Januar</option>

                                            <option <c:if test="${month0 eq 2}">selected</c:if>>Februar</option>

                                            <option <c:if test="${month0 eq 3}">selected</c:if>>März</option>

                                            <option <c:if test="${month0 eq 4}">selected</c:if>>April</option>

                                            <option <c:if test="${month0 eq 5}">selected</c:if>>Mai</option>

                                            <option <c:if test="${month0 eq 6}">selected</c:if>>Juni</option>

                                            <option <c:if test="${month0 eq 7}">selected</c:if>>Juli</option>

                                            <option <c:if test="${month0 eq 8}">selected</c:if>>August</option>

                                            <option <c:if test="${month0 eq 9}">selected</c:if>>September</option>

                                            <option <c:if test="${month0 eq 10}">selected</c:if>>Oktober</option>

                                            <option <c:if test="${month0 eq 11}">selected</c:if>>November</option>

                                            <option <c:if test="${month0 eq 12}">selected</c:if>>Dezember</option>

                                        </select>
                                        <select name="selSYear">
                                            <c:forEach begin="2004" end="2029" var="y">
                                                <option <c:if test="${y eq year0}">selected</c:if> >${y}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="24%" height="26" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Ende
                                        Datum</font></b></td>
                                    <td width="76%" height="26" bgcolor="AEBACD">
                                        <select name="selEDay">
                                            <c:forEach begin="1" end="31" var="i" varStatus="loop">
                                                <option <c:if test="${i eq day}">selected</c:if> >${i}</option>
                                            </c:forEach>
                                        </select>
                                        <select name="selEMonth">

                                            <option <c:if test="${month eq 1}">selected</c:if>>Januar</option>

                                            <option <c:if test="${month eq 2}">selected</c:if>>Februar</option>

                                            <option <c:if test="${month eq 3}">selected</c:if>>März</option>

                                            <option <c:if test="${month eq 4}">selected</c:if>>April</option>

                                            <option <c:if test="${month eq 5}">selected</c:if>>Mai</option>

                                            <option <c:if test="${month eq 6}">selected</c:if>>Juni</option>

                                            <option <c:if test="${month eq 7}">selected</c:if>>Juli</option>

                                            <option <c:if test="${month eq 8}">selected</c:if>>August</option>

                                            <option <c:if test="${month eq 9}">selected</c:if>>September</option>

                                            <option <c:if test="${month eq 10}">selected</c:if>>Oktober</option>

                                            <option <c:if test="${month eq 11}">selected</c:if>>November</option>

                                            <option <c:if test="${month eq 12}">selected</c:if>>Dezember</option>

                                        </select>
                                        <select name="selEYear">
                                            <c:forEach begin="2000" end="2029" var="y">
                                                <option <c:if test="${y eq year}">selected</c:if> >${y}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="24%" height="24" bgcolor="657A9A">&nbsp;</td>
                                    <td width="76%" height="24" bgcolor="AEBACD">
                                        <input class="btn btn-primary" type="submit" name="Submit" value="Schauen">
                                        <input class="btn btn-primary" type="button" name="SubmitToday" value="Nur Heute" onclick="today()">
                                        <font size="1" face="Verdana, Arial, Helvetica, sans-serif">&nbsp;                        </font>                        <font size="1" face="Verdana, Arial, Helvetica, sans-serif">&nbsp;                        </font>                        </td>
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
