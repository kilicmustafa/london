<%@ page import="com.rheinlandprivatschule.repository.MesseDao" %>
<%@ page import="com.rheinlandprivatschule.repository.MesseStudentDao" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.model.Werbung" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Mieter Pers&ouml;nliche Information ::</title>
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
        function back()
        {
            window.location="messeList";
        }
        function telephone(){
            window.location="messeStudentTelephoneForm?messeid="+document.form1.messeidS.value+"&studentID="+document.form1.studentidm.value;
            //window.location="driveControler?folder="+document.form1.f.value+"&myPath="+document.form1.p.value;
        }
        function composeMail(){
            document.form1.action="mailComposer";
            document.form1.submit();
        }

        function newstudent(){
            window.location="newMesseStudentForm?messeid="+document.form1.messeidS.value;
        }
        function checkAll(chk){
            if(chk.checked==true){

                for (i = 0; i < form1.checkbox.length; i++)	{
                    form1.checkbox[i].checked = true ;
                }
            }else{
                for (ii = 0; ii < form1.checkbox.length; ii++){
                    form1.checkbox[ii].checked = false ;
                }
            }
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

    MesseDao messeDB = (MesseDao) request.getAttribute("messeDao");
    MesseStudentDao studentDB = (MesseStudentDao) request.getAttribute("messeStudentDao");
    int messeid=0;
    Vector v=new Vector();
    int studentIDM=0;
    Vector image=new Vector();

    Werbung werbung = new Werbung();
    Werbung studentM = new Werbung();

    String valueS=(String)request.getParameter("messeid");
    try{
        messeid=Integer.parseInt(valueS);
        werbung=messeDB.getMesse(messeid);
        session.setAttribute("werbung",werbung);
    }
    catch(Exception e){
    }

    if(werbung!=null){

        v=studentDB.getAllStudentEmail();


    }else{
        String err=messeDB.getError();
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="composeMail()">Email</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="back()">Zur&uuml;ck</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width: 100%;" name="form1" method="post" action="updateMesse" onSubmit="MM_validateForm('txtFirstName','','R','txtLastName','','R','txtBirthPlace','','R','txtNationality','','R','txtAddress','','R','txtPostCode','','RisNum','txtCity','','R','txtCountry','','R','txtHomeNo','','RisNum','txtMobileNo','','RisNum','txtEmail','','RisEmail','txtLoginName','','R','txtPassword','','R');return document.MM_returnValue">
                            <table width="100%" height="50" border="0" cellpadding="1" cellspacing="1">
                                <tr>
                                    <td height="30" colspan="2" bgcolor="#FFFFFF"><table width="100%"  border="0" cellspacing="1" cellpadding="1">
                                        <tr>
                                            <td height="14" colspan="7" bgcolor="657A9A"><div align="center"><b><font color="#FFFFFF" >Messestudent Liste </font></b></div></td>
                                        </tr>
                                        <tr>
                                            <td height="14" colspan="7" bgcolor="657A9A"><div align="right"><font size="2" color="#FFFFFF"><b><%=v.size()%></b></font></div></td>
                                        </tr>
                                        <tr bgcolor="#405579">
                                            <td width="7%" bgcolor="657A9A"><div align="left"><font color="#FFFFFF"><b>
                                                <input type="checkbox" name="selectm" onClick="checkAll(this)" checked>
                                            </b></font><font color="#ffffff" size="2"></font></div></td>
                                            <td width="93%" height="22" colspan="6" bgcolor="657A9A"><font color="#FFFFFF"><b><FONT size=2>Email</FONT></b></font></td>
                                        </tr>
                                        <tr bgcolor="AEBACD">
                                            <%
                                                for(int i=0;i<v.size();i++)
                                                {
                                                    Werbung werbungStudent=(Werbung)v.elementAt(i);

                                            %>
                                            <td height="6" bgcolor="AEBACD"><font size="2" color="#000033">
                                                <input type="checkbox" name="checkbox" value="<%=werbungStudent.getEmail()%>" onClick="addSel(this)" checked>
                                            </font></td>
                                            <td height="6" colspan="6" bgcolor="AEBACD"><font size="2" color="#000033"><%=werbungStudent.getEmail()%></font></td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                        <tr bgcolor="AEBACD">
                                            <td height="6" colspan="7">&nbsp;</td>
                                        </tr>
                                    </table></td>
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
