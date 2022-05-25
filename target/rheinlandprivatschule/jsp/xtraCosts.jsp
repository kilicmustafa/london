<%@ page import="com.rheinlandprivatschule.repository.*" %>
<%@ page import="com.rheinlandprivatschule.model.SystemUser" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
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
    StudentDao studentDB= (StudentDao) request.getAttribute("studentDao");
    RPS rps=(RPS)session.getAttribute("handler");

    String firstname="";
    String lastname="";
    String desc="";
    double fee=0;

    Student student=new Student();
    Student cost=new Student();
    XtraCostDao costDB=new XtraCostDao();
    int userid=0;

    String valueS=(String)request.getParameter("userid");
    try{
        userid=Integer.parseInt(valueS);
        student=studentDB.getStudentInformation(userid,rps.getLoginUser().getUserID());
        session.setAttribute("pstudent",student);
    }
    catch(Exception e){
    }

    if(student!=null){
        firstname=student.getUserFirstName();
        lastname=student.getUserLastName();

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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onClick="studentdetail()">Sch&uuml;ler Kurs Einzelheit</a>

                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width: 100%;" name="form1" method="post" action="registerXtraCosts" onSubmit="MM_validateForm('txtDesc','','R',
				  																						'txtFee','','RisNum');return document.MM_returnValue">
                            <table width="100%" height="96" border="0" cellpadding="1" cellspacing="1">
                                <input type="hidden" name="userids" value="<%=userid%>">
                                <tr bgcolor="657A9A">
                                    <th colspan="2" height="17"><b><font color="#FFFFFF">Sonstige Kosten
                                        Informationen</font></b></th>
                                </tr>
                                <tr>
                                    <td width="19%" height="21" bgcolor="657A9A"><font color="#FFFFFF" size="2"><b>Schuler Name </b></font></td>
                                    <td width="81%" height="21" bgcolor="AEBACD"><font size="2" color="#000033"><%=firstname%></font><font color="#000033">&nbsp;
                                    </font></td>
                                </tr>
                                <tr>
                                    <td height="2" bgcolor="657A9A"><font color="#FFFFFF" size="2"><b>Grund</b></font></td>
                                    <td height="2" bgcolor="AEBACD"><font color="#000033">
                                        <input type="text" name="txtDesc" value="<%=desc%>">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td height="2" bgcolor="657A9A"><font color="#FFFFFF" size="2"><b>Geb&uuml;hr</b></font></td>
                                    <td height="2" bgcolor="AEBACD"><font color="#000033">
                                        <input name="txtFee" type="text" id="txtFee" value="<%=fee%>">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td width="19%" height="30" bgcolor="657A9A">&nbsp;</td>
                                    <td width="81%" height="30" bgcolor="AEBACD">
                                        <input class="btn btn-primary" type="submit" name="Submit" value="OK">
                                        <font color="#000033">
                                            <input type="hidden" name="txtuserid" value="<%=userid%>">
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
