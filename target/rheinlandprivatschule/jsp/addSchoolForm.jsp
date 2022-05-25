<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Neue Schuleinformationen ::</title>
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
                        <form style="width: 100%;" name="form1" method="post" action="addSchool" onSubmit="MM_validateForm('txtName','','R','txtAddress','','R','txtTelephone','','R','txtPostCode','','RisNum','txtCity','','R','txtCountry','','R','txtEmail','','RisEmail');return document.MM_returnValue">
                            <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                <tr>
                                    <td colspan="2" bgcolor="657A9A"><div align="center"><b><font color="#FFFFFF">Neue Schuleinformationen</font></b></div></td>
                                </tr>
                                <tr>
                                    <td width="25%"><b><font size="2"></font></b></td>
                                    <td width="75%">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Firma</font></b></td>
                                    <td bgcolor="AEBACD"><input type="text" name="txtFirma">
                                    </td>
                                </tr>
                                <tr>
                                    <td width="25%" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Name</font></b></td>
                                    <td width="75%" bgcolor="AEBACD"><input type="text" name="txtName">
                                    </td>
                                </tr>
                                <tr>
                                    <td width="25%" bgcolor="657A9A"><b><font size="2" color="#FFFFFF"> Adresse</font></b></td>
                                    <td width="75%" bgcolor="AEBACD"><input type="text" name="txtAddress">
                                    </td>
                                </tr>
                                <tr>
                                    <td width="25%" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Telefon</font></b></td>
                                    <td width="75%" bgcolor="AEBACD"><input type="text" name="txtTelephone">
                                    </td>
                                </tr>
                                <tr>
                                    <td width="25%" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">PLZ</font></b></td>
                                    <td width="75%" bgcolor="AEBACD"><input type="text" name="txtPostCode">
                                    </td>
                                </tr>
                                <tr>
                                    <td width="25%" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Stadt</font></b></td>
                                    <td width="75%" bgcolor="AEBACD"><input type="text" name="txtCity">
                                    </td>
                                </tr>
                                <tr>
                                    <td width="25%" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Land</font></b></td>
                                    <td width="75%" bgcolor="AEBACD"><input type="text" name="txtCountry">
                                    </td>
                                </tr>
                                <tr>
                                    <td width="25%" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Fax Nr</font></b></td>
                                    <td width="75%" bgcolor="AEBACD"><input type="text" name="txtFax">
                                    </td>
                                </tr>
                                <tr>
                                    <td width="25%" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Email</font></b></td>
                                    <td width="75%" bgcolor="AEBACD"><input type="text" name="txtEmail">
                                    </td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Bamfnummer</font></b></td>
                                    <td bgcolor="AEBACD"><input name="txtBamf" type="text" id="txtBamf">
                                    </td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Betriebsnummer</font></b></td>
                                    <td bgcolor="AEBACD"><input name="txtBusiness" type="text" id="txtBusiness">
                                    </td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Steuernummer</font></b></td>
                                    <td bgcolor="AEBACD"><input name="txtTax" type="text" id="txtTax">
                                    </td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Rechnungschule</font></b></td>
                                    <td bgcolor="AEBACD"><input name="txtRechSchool" type="text" id="txtRechSchool">
                                    </td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><b><font size="2" color="#FFFFFF">RechnungURL</font></b></td>
                                    <td bgcolor="AEBACD"><input name="txtRechURL" type="text" id="txtRechURL">
                                    </td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><b><font size="2" color="#FFFFFF"> Rechnung Ansicht </font></b></td>
                                    <td bgcolor="AEBACD"><input name="txtRechAddress" type="text" id="txtRechAddress">
                                    </td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><b><font size="2" color="#FFFFFF"> Anschlusskennung </font></b></td>
                                    <td bgcolor="AEBACD"><input name="txtComment1" type="text" id="txtComment1">
                                    </td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><b><font size="2" color="#FFFFFF"> T-Online-Nr</font></b></td>
                                    <td bgcolor="AEBACD"><input name="txtComment2" type="text" id="txtComment2">
                                    </td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><b><font size="2" color="#FFFFFF"> Ger&auml;tepassword </font></b></td>
                                    <td bgcolor="AEBACD"><input name="txtComment3" type="text" id="txtComment3">
                                    </td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><b><font size="2" color="#FFFFFF"> Pers&ouml;nliches Kennwort</font></b></td>
                                    <td bgcolor="AEBACD"><input name="txtComment4" type="text" id="txtComment4">
                                    </td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><b><font size="2" color="#FFFFFF"> WLAN</font></b></td>
                                    <td bgcolor="AEBACD"><input name="txtComment5" type="text" id="txtComment5">
                                    </td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><b><font size="2" color="#FFFFFF"> Feld1</font></b></td>
                                    <td bgcolor="AEBACD"><input name="txtComment6" type="text" id="txtComment6">
                                    </td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><b><font size="2" color="#FFFFFF"> Feld2</font></b></td>
                                    <td bgcolor="AEBACD"><input name="txtComment7" type="text" id="txtComment7">
                                    </td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><b><font size="2" color="#FFFFFF"> MSN Passwort </font></b></td>
                                    <td bgcolor="AEBACD"><input name="txtComment8" type="text" id="txtComment8">
                                    </td>
                                </tr>
                                <tr>
                                    <td width="25%" bgcolor="657A9A">&nbsp;</td>
                                    <td width="75%" bgcolor="AEBACD"><input class="btn btn-primary" type="submit" name="Submit" value="Add">
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
