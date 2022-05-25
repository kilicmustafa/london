<%@ page import="com.rheinlandprivatschule.repository.EmployeeHours" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Stunden Eintrag Form ::</title>
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
        function abmeldung()
        {
            window.location="registerAbmeldung";
        }

        function breakStart()
        {
            window.location="registerBreakStart";
        }

        function breakEnd()
        {
            window.location="registerBreakEnd";
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

    </script>
</head>
<body>
<%
    EmployeeHours emphours;
    EmployeeHours emphoursDB=new EmployeeHours();

    RPS rps = (RPS) session.getAttribute("handler");

    emphours=emphoursDB.getEmployeeHours(rps.getLoginUser().getUserID());

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
                        <form style="width: 100%;" name="form1" method="post" action="registerHours" onSubmit="MM_validateForm('txtName','','R','txtAddress','','R','txtTelephone','','R','txtPostCode','','RisNum','txtCity','','R','txtCountry','','R','txtEmail','','RisEmail');return document.MM_returnValue">
                            <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                <tr>
                                    <td colspan="2" bgcolor="657A9A"><div align="center"><b>                        <font color="#FFFFFF">Mitarbeiter Stunden Information</font></b></div></td>
                                </tr>
                                <tr>
                                    <td width="25%"><b><font size="2"></font></b></td>
                                    <td width="75%">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><b>
                                        <input type="submit" name="Submit" value="Anmeldung">
                                    </b></td>
                                    <td bgcolor="AEBACD"><font size="2" color="#000033"><%=emphours.getLoginTime()%></font>
                                        <input type="hidden" name="userid" value="<%=rps.getLoginUser().getUserID()%>"></td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><b>
                                        <input type="button" name="Submit2" value="Pause" onClick="breakStart()">
                                    </b></td>
                                    <td bgcolor="AEBACD"><font size="2" color="#000033"><%=emphours.getBreakStartTime()%></font>
                                    </td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><b>
                                        <input type="button" name="Submit3" value="PauseEnde" onClick="breakEnd()">
                                    </b></td>
                                    <td bgcolor="AEBACD"><font size="2" color="#000033"><%=emphours.getBreakEndTime()%></font>
                                    </td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><b>
                                        <input type="button" name="Submit4" value="abmeldung" onClick="abmeldung()">
                                    </b></td>
                                    <td bgcolor="AEBACD"><font size="2" color="#000033"><%=emphours.getLogoutTime()%></font>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="25%" bgcolor="657A9A">&nbsp;</td>
                                    <td width="75%" bgcolor="AEBACD">&nbsp;                        </td>
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
