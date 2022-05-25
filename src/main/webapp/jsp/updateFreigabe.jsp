<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.repository.StudentDao" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Sch&uuml;ler Pers&ouml;nliche Information ::</title>
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
        function studentdetail()
        {
            window.location="showStudentPreciseD?userid="+document.form1.userids.value;
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
    

    Vector cry=new Vector();
    Vector idy=new Vector();

    String firstname="";
    String lastname="";
    String birthday="1";
    String birthmonth="Janaury";
    String birthyear="1975";
    int freigabeChoice=0;
    String freiday="";
    String freimonth="";
    String freiyear="";
    java.sql.Date freigabeDate= MyDate.getCurrentSQLDate();

    Student student=new Student();
    StudentDao studentDB= (StudentDao) request.getAttribute("studentDB");
    int userid=0;
    RPS rps = (RPS) session.getAttribute("handler");
    String valueS=(String)request.getParameter("userid");
    userid=Integer.parseInt(valueS);
    student=studentDB.getStudentInformation(userid,rps.getLoginUser().getUserID());
    session.setAttribute("pstudent",student);
    firstname=student.getUserFirstName();
    lastname=student.getUserLastName();
    freigabeChoice=student.getFreigabeStatus();
    freigabeDate=student.getFreigabeDate();
    //freigabeDate=MyDate.formateDate(student.getFreigabeDate(),MyDate.NUMERIC,MyDate.DEUTSCH);
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onClick="studentdetail()">Sch&uuml;ler Kurs Einzelheit</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width: 100%;" name="form1" method="post" action="updateFreigabeProcess" onSubmit="MM_validateForm('txtFirstName','','R',
				  																						'txtLastName','','R',
																										'txtBirthPlace','','R',
																										'txtNationality','','R',
																										'txtAddress','','R',
																										'txtPostCode','','RisNum',
																										'txtCity','','R',
																										'txtCountry','','R',
																										'txtHomeNo','','RisNum',
																										'txtMobileNo','','RisNum',
																										'txtEmail','','RisEmail',
																										'txtLoginName','','R',
																										'txtPassword','','R',
																										'txtHomeCode','','R',
																										'txtMobileCode','','R',
																										'txtFaxCode','','R',
																										'txtHomeRegion','','R',
																										'txtMobileRegion','','R',
																										'txtFaxlRegion','','RisEmail');return document.MM_returnValue">
                            <table width="100%" height="110" border="0" cellpadding="1" cellspacing="1">
                                <input type="hidden" name="userids" value="<%=userid%>">
                                <tr bgcolor="657A9A">
                                    <th colspan="2"><b><font color="#FFFFFF">Freigabe Info </font></b></th>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <th><div align="left"><font color="#FFFFFF" size="2">Name, Vorname</font></div></th>
                                    <th><div align="left"><font size="2" color="#000033"><%=student.getUserFirstName()%></font><font size="2">,</font><font size="2" color="#000033"><%=student.getUserLastName()%></font></div></th>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <th><div align="left"><font color="#FFFFFF" size="2">Letzte Freigabe Datum </font></div></th>
                                    <th><div align="left"><font size="2" color="#000033"><%=freigabeDate%></font></div></th>
                                </tr>
                                <tr>
                                    <td height="11" colspan="2" bgcolor="AEBACD"><b></b><font color="#000033">                          <font size="2">    </font><font color="#000033"><font size="2">Nicht Freigegeben
                                        <%
                                            if(freigabeChoice==0){
                                        %>
                                        <input type="radio" name="rdChoice" value="0" checked>
                                        Nur Heute</font> <font size="2">
                                        <input type="radio" name="rdChoice" value="1">
                                        Bis Kurs Ende
                                        <input type="radio" name="rdChoice" value="2">
                                        F&uuml;r Immer
                                        <input type="radio" name="rdChoice" value="3">
                                        <%
                                        }else if(freigabeChoice==1) {
                                        %>
                                        <input type="radio" name="rdChoice" value="0">
                                        Nur Heute</font> <font size="2">
                                        <input type="radio" name="rdChoice" value="1" checked>
                                        Bis Kurs Ende
                                        <input type="radio" name="rdChoice" value="2">
                                        F&uuml;r Immer
                                        <input type="radio" name="rdChoice" value="3">
                                        <%
                                        }else if(freigabeChoice==2){
                                        %>
                                        <input type="radio" name="rdChoice" value="0">
                                        Nur Heute</font> <font size="2">
                                        <input type="radio" name="rdChoice" value="1">
                                        Bis Kurs Ende
                                        <input type="radio" name="rdChoice" value="2" checked>
                                        F&uuml;r Immer
                                        <input type="radio" name="rdChoice" value="3">
                                        <%
                                        }
                                        else {
                                        %>
                                        <input type="radio" name="rdChoice" value="0">
                                        Nur Heute</font> <font size="2">
                                        <input type="radio" name="rdChoice" value="1">
                                        Bis Kurs Ende
                                        <input type="radio" name="rdChoice" value="2">
                                        F&uuml;r Immer
                                        <input type="radio" name="rdChoice" value="3" checked>
                                        <%
                                            }

                                        %>
                                    </font></font> </font></td>
                                </tr>
                                <tr>
                                    <td height="11" colspan="2" bgcolor="AEBACD"><font color="#000033">&nbsp;
                                    </font><font color="#000033">&nbsp;                          </font></td>
                                </tr>
                                <tr>
                                    <td width="21%" height="30" bgcolor="657A9A">&nbsp;</td>
                                    <td width="79%" height="30" bgcolor="AEBACD">
                                        <input class="btn btn-primary" type="submit" name="Submit" value="OK">
                                        <font color="#000033">
                                            <input type="hidden" name="hiddenField" value="<%=userid%>">
                                        </font>                        </td>
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
