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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="/exp/catList">Kategorie</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="/exp/newAusgabe">Neue Ausgabe</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width: 100%;" name="form1" method="post" action="ausgabeList" onSubmit="MM_validateForm('txtID','','NisNum');return document.MM_returnValue">
                            <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                <tr bgcolor="657A9A">
                                    <td height="22" colspan="2">
                                        <div align="center"><b><font color="#FFFFFF">Ausgabe
                                            Suchen </font></b></div>
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6" bgcolor="657A9A" width="23%"><font color="#FFFFFF"><b><font size="2">Gesichtspunkt</font></b></font></td>
                                    <td height="6" bgcolor="AEBACD" width="77%">
                                        <select name="select">
                                            <option selected>Datum Limit</option>
                                            <option>Datum</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6" bgcolor="657A9A" width="23%"><b><font size="2" color="#FFFFFF">Ausgabe
                                        Nr. </font></b></td>
                                    <td height="6" bgcolor="AEBACD" width="77%">
                                        <input type="text" name="txtID">
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6" bgcolor="657A9A" width="23%"><b><font size="2" color="#FFFFFF">Erste
                                        Datum</font></b></td>
                                    <td height="6" bgcolor="AEBACD" width="77%">
                                        <select name="selSDay">
                                            <c:forEach begin="1" end="31" var="i" varStatus="loop">
                                                <option <c:if test="${i eq day}">selected</c:if> >${i}</option>
                                            </c:forEach>
                                        </select>
                                        <select name="selSMonth">

                                            <option <c:if test="${month.equalsIgnoreCase('Januar')}">selected</c:if>>Januar</option>

                                            <option <c:if test="${month.equalsIgnoreCase('Februar')}">selected</c:if>>Februar</option>

                                            <option <c:if test="${month.equalsIgnoreCase('März')}">selected</c:if>>März</option>

                                            <option <c:if test="${month.equalsIgnoreCase('April')}">selected</c:if>>April</option>

                                            <option <c:if test="${month.equalsIgnoreCase('Mai')}">selected</c:if>>Mai</option>

                                            <option <c:if test="${month.equalsIgnoreCase('Juni')}">selected</c:if>>Juni</option>

                                            <option <c:if test="${month.equalsIgnoreCase('Juli')}">selected</c:if>>Juli</option>

                                            <option <c:if test="${month.equalsIgnoreCase('August')}">selected</c:if>>August</option>

                                            <option <c:if test="${month.equalsIgnoreCase('September')}">selected</c:if>>September</option>

                                            <option <c:if test="${month.equalsIgnoreCase('Oktober')}">selected</c:if>>Oktober</option>

                                            <option <c:if test="${month.equalsIgnoreCase('November')}">selected</c:if>>November</option>

                                            <option <c:if test="${month.equalsIgnoreCase('Dezember')}">selected</c:if>>Dezember</option>

                                        </select>
                                        <select name="selSYear">
                                            <c:forEach begin="2000" end="2029" var="y">
                                                <option <c:if test="${y eq year}">selected</c:if> >${y}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6" bgcolor="657A9A" width="23%"><font size="2" color="#FFFFFF"><b>Ende
                                        Datum</b></font> </td>
                                    <td height="6" bgcolor="AEBACD" width="77%" valign="top">
                                        <select name="selEDay">
                                            <c:forEach begin="1" end="31" var="i" varStatus="loop">
                                                <option <c:if test="${i eq day}">selected</c:if> >${i}</option>
                                            </c:forEach>
                                        </select>
                                        <select name="selEMonth">

                                            <option <c:if test="${month.equalsIgnoreCase('Januar')}">selected</c:if>>Januar</option>

                                            <option <c:if test="${month.equalsIgnoreCase('Februar')}">selected</c:if>>Februar</option>

                                            <option <c:if test="${month.equalsIgnoreCase('März')}">selected</c:if>>März</option>

                                            <option <c:if test="${month.equalsIgnoreCase('April')}">selected</c:if>>April</option>

                                            <option <c:if test="${month.equalsIgnoreCase('Mai')}">selected</c:if>>Mai</option>

                                            <option <c:if test="${month.equalsIgnoreCase('Juni')}">selected</c:if>>Juni</option>

                                            <option <c:if test="${month.equalsIgnoreCase('Juli')}">selected</c:if>>Juli</option>

                                            <option <c:if test="${month.equalsIgnoreCase('August')}">selected</c:if>>August</option>

                                            <option <c:if test="${month.equalsIgnoreCase('September')}">selected</c:if>>September</option>

                                            <option <c:if test="${month.equalsIgnoreCase('Oktober')}">selected</c:if>>Oktober</option>

                                            <option <c:if test="${month.equalsIgnoreCase('November')}">selected</c:if>>November</option>

                                            <option <c:if test="${month.equalsIgnoreCase('Dezember')}">selected</c:if>>Dezember</option>

                                        </select>
                                        <select name="selEYear">
                                            <c:forEach begin="2000" end="2029" var="y">
                                                <option <c:if test="${y eq year}">selected</c:if> >${y}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6" bgcolor="657A9A" width="23%"><b><font size="2" color="#FFFFFF">Ort</font></b></td>
                                    <td height="6" bgcolor="AEBACD" width="77%" valign="top">
                                        <select name="selPlace" size="5" multiple>
                                            <option value="0" selected>w&auml;hlen</option>
                                            <c:forEach items="${places}" var="place">
                                                <option value="${place.placeID}">${place.placeName}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6" bgcolor="657A9A" width="23%"><b><font size="2" color="#FFFFFF">Ausgabe Kategorie</font></b></td>
                                    <td height="6" bgcolor="AEBACD" width="77%">
                                        <select name="selCat">
                                            <option value="0" selected>w&auml;hlen</option>
                                            <c:forEach items="${cats}" var="cat">
                                                <option value="${cat.categoryID}">${cat.categoryName}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6" bgcolor="657A9A" width="23%">&nbsp;</td>
                                    <td height="6" bgcolor="AEBACD" width="77%">
                                        <input class="btn btn-primary" type="submit" name="Submit" value="OK">
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
