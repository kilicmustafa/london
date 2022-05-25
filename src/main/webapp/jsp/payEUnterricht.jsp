<%@ page import="com.rheinlandprivatschule.repository.SingleClassDao" %>
<%@ page import="com.rheinlandprivatschule.repository.StudentDao" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="com.rheinlandprivatschule.model.SingleClassBalance" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Einzelunterricht ::</title>
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
        myPopup = '';

        function leave(msg)
        {
            if(!confirm(msg)) return false
            else document.form1.submit()
        }
        function myback()
        {
            window.location="showStudentPreciseD?userid="+document.form1.stid.value;
        }
        function haupt()
        {
            window.location="../map";
        }
        function popUp(loc,eyeD,X,Y){
            window.open(loc,eyeD,"toolbar=no,location=0,directories=no,status=no,menubar=0,scrollbars=yes,resizable=0,width=" + X + ",height=" + Y + "'");
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
    SingleClassDao sidb=new SingleClassDao();
    StudentDao studentDB= (StudentDao) request.getAttribute("studentDao");
    String guthaben="";
    String pay="0.0";
    String sid="0";

    Student student=(Student)session.getAttribute("pstudent");
    RPS rps=(RPS)session.getAttribute("handler");
    if(studentDB.payEinzelUnterricht(rps.getLoginUser().getUserID())){
        SingleClassBalance scb=sidb.getStudentRecord(student.getUserID());
        sid=""+student.getUserID();
        double bal=scb.getBalance();
        guthaben= MyCurrency.getDisplayString(bal);
        double neg=-1;
        if(bal<0)
        {
            bal=(bal*neg);
            pay=MyCurrency.getDisplayString(bal);
        }
    }else{
        String err=studentDB.getError();
        session.setAttribute("err",err);
        session.setAttribute("lin","../map");
        response.sendRedirect("error");
    }
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="myback()">Z&uuml;ruck</a>

                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width: 100%;" name="form1" method="post" action="payEUnterrichtProcess" onSubmit="MM_validateForm('txtCName','','R','txtTime','','R','txtFee','','RisNum');return document.MM_returnValue">
                            <table width="100%" height="186" border="0" cellpadding="1" cellspacing="1">

                                <tr>
                                    <td colspan="2" bgcolor="657A9A" height="4">
                                        <div align="center"><font size="2" color="#FFFFFF"><b><font size="3">Einzelunterricht</font></b></font>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="29%" bgcolor="657A9A" height="13"><font color="#FFFFFF" size="2"><b>Sch&uuml;lername</b></font></td>
                                    <td width="71%" height="13" bgcolor="AEBACD"><font color="#000033" size="2"><%=student.getUserFirstName()+" "+student.getUserLastName()%></font></td>
                                </tr>
                                <tr>
                                    <td width="29%" bgcolor="657A9A" height="11"><b><font size="2" color="#FFFFFF">Guthaben</font></b></td>
                                    <td width="71%" bgcolor="AEBACD" height="11"><font size="2" color="#000033"><%=guthaben%>
                                    </font></td>
                                </tr>
                                <tr>
                                    <td width="29%" bgcolor="657A9A" height="14"><b><font size="2" color="#FFFFFF">Rechnungsbetrag</font></b></td>
                                    <td width="71%" bgcolor="AEBACD" height="14">
                                        <input type="text" name="paid" value="<%=pay%>">
                                    </td>
                                </tr>
                                <tr>
                                    <td width="29%" bgcolor="AEBACD" height="2">&nbsp;</td>
                                    <td width="71%" bgcolor="AEBACD" height="2">
                                        <input class="btn btn-primary" type="submit" name="Submit" value="Zahlen" onClick="leave('Haben Sie '+document.form1.paid.value+' Euro angenommen?');return false">
                                        <input type="hidden" name="stid" value="<%=sid%>">
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
