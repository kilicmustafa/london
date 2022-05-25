<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Neue Ausgabe ::</title>
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
                        <form style="width: 100%;" name="form1" method="post" action="newAusgabe" onSubmit="MM_validateForm('txtAusgabe','','R','txtBill','','RisNum');return document.MM_returnValue">
                            <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                <tr bgcolor="657A9A">
                                    <td height="22" colspan="2">
                                        <div align="center"><b><font color="#FFFFFF">Neue
                                            Ausgabe</font></b></div>
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6" colspan="2">
                                        <div align="center"><font size="2" color="#000033"><b>${lastgabe}</b></font></div>
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6" bgcolor="657A9A" width="22%"><b><font size="2" color="#FFFFFF">Ausgabe</font></b></td>
                                    <td height="6" bgcolor="AEBACD" width="78%">
                                        <input type="text" name="txtAusgabe">
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6" bgcolor="657A9A" width="22%"><b><font size="2" color="#FFFFFF">Datum</font></b></td>
                                    <td height="6" bgcolor="AEBACD" width="78%">
                                        <select name="selSDay">
                                            <c:forEach begin="1" end="31" var="i" varStatus="loop">
                                                <option>${i}</option>
                                            </c:forEach>
                                        </select>
                                        <select name="selSMonth">

                                            <option >Januar</option>

                                            <option >Februar</option>

                                            <option >März</option>

                                            <option >April</option>

                                            <option >Mai</option>

                                            <option >Juni</option>

                                            <option >Juli</option>

                                            <option >August</option>

                                            <option >September</option>

                                            <option >Oktober</option>

                                            <option >November</option>

                                            <option >Dezember</option>

                                        </select>
                                        <select name="selSYear">
                                            <c:forEach begin="2000" end="2029" var="y">
                                                <option>${y}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6" bgcolor="657A9A" width="22%"><b><font size="2" color="#FFFFFF">Betrag</font></b></td>
                                    <td height="6" bgcolor="AEBACD" width="78%">
                                        <input type="text" name="txtBill">
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6" bgcolor="657A9A" width="22%"><b><font size="2" color="#FFFFFF">Ort</font></b></td>
                                    <td height="6" bgcolor="AEBACD" width="78%" valign="top">
                                        <select name="selPlace" size="5" multiple>
                                            <option value="0" selected>w&auml;hlen</option>
                                            <c:forEach items="${places}" var="place">
                                                <option value="${place.placeID}">${place.placeName}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6" bgcolor="657A9A" width="22%"><b><font size="2" color="#FFFFFF">Ausgabe Kategorie</font></b></td>
                                    <td height="6" bgcolor="AEBACD" width="78%">
                                        <select name="selCat">
                                            <option value="0" selected>w&auml;hlen</option>
                                            <c:forEach items="${cats}" var="cat">
                                                <option value="${cat.categoryID}">${cat.categoryName}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6" bgcolor="657A9A" width="22%">&nbsp;</td>
                                    <td height="6" bgcolor="AEBACD" width="78%">
                                        <input class="btn btn-primary" type="submit" name="Submit" value="OK">
                                        <input class="btn btn-primary" type="button" name="Button" value="Zur&uuml;ck" onClick="back()">
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
