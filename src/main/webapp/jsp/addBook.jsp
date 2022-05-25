<%@ page import="com.rheinlandprivatschule.model.Place" %>
<%@ page import="com.rheinlandprivatschule.model.SystemUser" %>
<%@ page import="com.rheinlandprivatschule.repository.BuchDao" %>
<%@ page import="com.rheinlandprivatschule.repository.PlaceDao" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="java.util.Vector" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Das neue Buch ::</title>
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
<%

%>
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
                        <form style="width: 100%;" name="form1" method="post" action="addBookProcess" onSubmit="MM_validateForm('bname','','R','isbn','','R','price','','R');return document.MM_returnValue">
                            <table width="100%" height="164" border="0" cellpadding="1" cellspacing="1">
                                <tr>
                                    <td colspan="2" bgcolor="657A9A">
                                        <div align="center"><b><font color="#FFFFFF">Das neue
                                            Buch </font></b></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="29%" bgcolor="657A9A" height="7"><b><font size="2" color="#FFFFFF">Buchname</font></b></td>
                                    <td width="71%" height="7" bgcolor="AEBACD">
                                        <input type="text" name="bname">
                                    </td>
                                </tr>
                                <tr>
                                    <td width="29%" bgcolor="657A9A" height="5"><b><font size="2" color="#FFFFFF">ISBN</font></b></td>
                                    <td width="71%" height="5" bgcolor="AEBACD">
                                        <input type="text" name="isbn">
                                    </td>
                                </tr>
                                <tr>
                                    <td width="29%" bgcolor="657A9A" height="20"><b><font size="2" color="#FFFFFF">Preis</font></b></td>
                                    <td width="71%" height="20" bgcolor="AEBACD">
                                        <input type="text" name="price">
                                    </td>
                                </tr>
                                <tr>
                                    <td width="29%" bgcolor="657A9A" height="13"><b><font size="2" color="#FFFFFF">Stufe</font></b></td>
                                    <td width="71%" bgcolor="AEBACD" height="13">
                                        <select name="selStufe">
                                            <option value="0" selected>w&auml;hlen</option>
                                            <option value="1">Grundstufe I</option>
                                            <option value="2">Grundstufe II</option>
                                            <option value="3">Mittelstufe I</option>
                                            <option value="4">Mittelstufe II</option>
                                            <option value="5">Oberstufe</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="29%" bgcolor="AEBACD" height="2">&nbsp;</td>
                                    <td width="71%" bgcolor="AEBACD" height="2">
                                        <input type="submit" name="Submit" value="OK">
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" bgcolor="AEBACD" height="2"> <font size="1" color="#000033">
                                    </font></td>
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
