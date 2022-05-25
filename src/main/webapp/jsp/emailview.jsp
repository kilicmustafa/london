<%@ page import="com.rheinlandprivatschule.helper.PasswordManager" %>
<%@ page import="com.rheinlandprivatschule.model.SystemUser" %>
<%@ page import="com.rheinlandprivatschule.repository.SystemUserDao" %>
<%@ page import="com.rheinlandprivatschule.repository.MesseStudentDao" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Mitarbeiter Remarks ::</title>
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
        function savePass(){
            if(document.form1.oldp.value=="" || document.form1.newp.value=="" || document.form1.newp1.value==""){
                alert("Altes oder Neues Kennwort kann nicht leer sein.");
            }else{
                document.form1.action="EmailView?pass=pass";
                document.form1.submit();
            }

        }
        function savep(){
            document.form1.action="EmailView?privat=privat";
            document.form1.submit();
        }
        function savel(){
            document.form1.action="EmailView?lehrer=lehrer";
            document.form1.submit();
        }
        function saveg(){
            document.form1.action="EmailView?general=general";
            document.form1.submit();
        }

        function userpage(){
            window.location="adminRemarksF?adminid="+document.form1.userid.value;
        }
        function back()
        {
            window.location="messeList";
        }


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
<%
    SystemUserDao sdb=new SystemUserDao();
    MesseStudentDao messeDB=new MesseStudentDao();

    String remarks="";
    String er="";
    String remarksP="";
    int lehrerID=1;
    String remarksL="";
    int email1=1;
    int email2=2;
    int email3=3;



    SystemUser loginuser=((RPS) request.getAttribute("rps")).getLoginUser();

    remarks=messeDB.getEmailText(email1);
    remarksP=messeDB.getEmailText(email2);
    remarksL=messeDB.getEmailText(email3);

    String lehrer=(String)request.getParameter("lehrer");

    String privat=(String)request.getParameter("privat");

    String general=(String)request.getParameter("general");

    String oldPassword=(String)request.getParameter("oldp");
    String newPassword=(String)request.getParameter("newp");
    String new1Password1=(String)request.getParameter("newp1");

    if(lehrer!=null ){
        String lehrerText=(String)request.getParameter("textL");
        try{
            messeDB.updateEmailText(email3,lehrerText);
            remarksL=lehrerText;
        }catch(Exception e){
        }
    }else if(privat!=null){
        String privatText=(String)request.getParameter("textP");
        messeDB.updateEmailText(email2,privatText);
        remarksP=privatText;
    }else if(general!=null){
        String generalText=(String)request.getParameter("textG");
        messeDB.updateEmailText(email1,generalText);
        remarks=generalText;
    }else{
        if(oldPassword!=null){
            if(loginuser.getUserPassword().equalsIgnoreCase(oldPassword)){
                if(newPassword.equalsIgnoreCase(new1Password1)){
                    //Check//
                    if(PasswordManager.isPasswordSecure(newPassword)){
                        if(sdb.updateSystemUserPassword(loginuser.getUserID(),newPassword)){
                            er="Neu Kennwort ist gespeichert.";
                            loginuser.setUserPassword(newPassword);
                        }else{
                            er="System kann nicht das Kennwort ändern.";
                        }
                    }else{
                        String err="Ändern Sie bitte Ihr Kennwort sofort. Kennwort muss Minimum 7 klein und Großbuchstaben und Zahlen haben.";
                        session.setAttribute("err",err);
                        session.setAttribute("lin","adminInfoView");
                        response.sendRedirect("error");
                    }
                }else{
                    er="Neu Kennwort und Neu Kennwort Nochmal ist nicht gleich.";
                }
            }else{
                er="Altes Kennwort ist nicht richtig.";
            }
        }
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="back()">Zur&uuml;ck</a>

                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form  style="width: 100%;" action="EmailView" method="post" name="form1" onSubmit="MM_validateForm('oldp','','R','newp','','R','newp1','','R');return document.MM_returnValue">
                            <table width="100%" border="0" cellspacing="1" cellpadding="1">
                                <tr bgcolor="657A9A">
                                    <td>
                                        <div align="center"><font size="2"><b><font color="#FFFFFF">Format 1 </font></b></font></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td bgcolor="AEBACD">
                                        <textarea name="textG" cols="90" rows="7" id="textG"><%=remarks%></textarea>
                                    </td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td><div align="left"><font color="#FFFFFF" size="2">
                                        <input class="btn btn-primary" type="button" name="Button" value="Format 1 Speichern" onClick="saveg()">
                                    </font></div></td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td><div align="center"><font color="#FFFFFF" size="2"><b>Format 2 </b></font></div></td>
                                </tr>

                                <tr>
                                    <td bgcolor="AEBACD"><textarea name="textP" cols="90" rows="7" id="textP"><%=remarksP%></textarea></td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td><div align="left"><font color="#FFFFFF" size="2">
                                        <input class="btn btn-primary" type="button" name="Button" value="Format 2 Speichern" onClick="savep()">
                                    </font></div></td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td><div align="center"><font color="#FFFFFF" size="2"><b>Format 3 </b></font></div></td>
                                </tr>
                                <tr>
                                    <td bgcolor="AEBACD"><textarea name="textL" cols="90" rows="7" id="textL"><%=remarksL%></textarea></td>
                                </tr>
                                <tr>
                                    <td bgcolor="AEBACD">
                                        <input class="btn btn-primary" type="button" name="Button" value="Format 3 Speichern" onClick="savel()">
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
