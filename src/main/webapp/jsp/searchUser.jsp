<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Suchbenutzer ::</title>
    <style>
        table tr {
            border-bottom: 1px solid white;
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
                    <div class="wrapper" style="margin-bottom: 5px; float:right;">
                        <a style="margin-right: 5px;" class="btn btn-primary" href="adminUserList">Benutzer Liste</a>
                        <a style="margin-right: 5px;" class="btn btn-primary" href="catList">Kategorie Liste</a>
                        <a style="margin-right: 5px;" class="btn btn-primary" href="newAdminForm">Neue Beutzer</a>
                        <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                    </div>
                    <form action="searchUser" method="post" name="form1" onsubmit="MM_validateForm('txtKeyWord','','R');return document.MM_returnValue">
                        <input name="cmd" type="hidden" id="cmd" value="cmd">
                        <table width="100%" border="0" cellpadding="1" cellspacing="1">
                            <tbody><tr>
                                <td height="107" valign="top">
                                    <table width="100%" border="0" height="123" cellpadding="1" cellspacing="1">
                                        <tbody>
                                        <tr bgcolor="657A9A">
                                            <td height="23" colspan="3">
                                                <div align="center"><font size="3" color="#FFFFFF"><b>Suchbenutzer</b></font></div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="31" width="25%" bgcolor="657A9A"><strong><font size="2" color="#FFFFFF">Wählen
                                                Sie SuchKriterien</font></strong></td>
                                            <td height="31" colspan="2" bgcolor="AEBACD">
                                                <select name="selCriteria">

                                                    <option value="1" selected="">Vorname</option>
                                                    <option value="2">Nachname</option>

                                                </select>
                                                <font color="#000033" size="2">Alle

                                                    <input name="alle" type="checkbox" id="alle" value="checkbox">


                                                </font>								</td>
                                        </tr>
                                        <tr>
                                            <td height="24" bgcolor="657A9A"><font size="2" color="#FFFFFF"><strong>Schlüsselwort</strong></font></td>
                                            <td width="36%" height="24" bgcolor="AEBACD"><input name="txtKeyWord" type="text" value="" size="14"></td>
                                            <td width="39%" height="24" bgcolor="AEBACD"><input class="btn btn-primary" type="submit" name="Submit" value="Suche"></td>
                                        </tr>
                                        </tbody></table>
                                </td>
                            </tr>
                            </tbody></table>
                        <p>&nbsp;</p>
                    </form>

                    <div class="row">
                        <div class="col-md-6" style="float:left;">
                            <h3>Suchresultat</h3>
                        </div>
                        <div class="table-responsive">
                            <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                <tr>
                                    <td height="20" bgcolor="657A9A" width="41%"><font color="#FFFFFF" size="2"><b>Summe</b></font></td>
                                    <td height="20" bgcolor="657A9A">
                                        <div align="right"><font size="2" color="#FFFFFF"><b>${users.size()}</b></font></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="20" bgcolor="657A9A" width="41%"><b><font size="2" color="#FFFFFF">Vorname</font></b></td>
                                    <td height="20" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Nachname</font></b><b></b></td>
                                </tr>
                                <c:if test="${users != null}">
                                    <c:forEach items="${users}" var="user">
                                        <tr bgcolor="AEBACD">
                                            <td><font size="2" color="#000000"><a href="adminRemarksF?adminid=${user.userID}">${user.userFirstName}</a></font></td>
                                            <td bgcolor="AEBACD"><font size="2" color="#000000">${user.userLastName}</font></td>
                                        </tr>
                                    </c:forEach>
                                </c:if>
                            </table>
                        </div>

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
