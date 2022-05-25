<%@ page import="com.rheinlandprivatschule.repository.ConsultantStudentDao" %>
<%@ page import="com.rheinlandprivatschule.repository.ConsultantDao" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
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
            window.location="consultantList";
        }
        function telephone(){
            window.location="consultantStudentTelephoneForm?consultantid="+document.form1.consultantidS.value+"&studentID="+document.form1.studentidm.value;
            //window.location="driveControler.jsp?folder="+document.form1.f.value+"&myPath="+document.form1.p.value;
        }

        function notactive(){
            window.location="consultantTelephoneListeN?consultantid="+document.form1.consultantidS.value;
            //window.location="driveControler.jsp?folder="+document.form1.f.value+"&myPath="+document.form1.p.value;
        }

        function interested(){
            window.location="consultantTelephoneListeInt?consultantid="+document.form1.consultantidS.value;
            //window.location="driveControler.jsp?folder="+document.form1.f.value+"&myPath="+document.form1.p.value;
        }

        function composeMail(){
            document.form1.action="mailComposer";
            document.form1.submit();
        }

        function newstudent(){
            window.location="newConsultantStudentForm?consultantid="+document.form1.consultantidS.value;
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
    ConsultantDao consultantDB= (ConsultantDao) request.getAttribute("consultantDao");
    ConsultantStudentDao studentDB= (ConsultantStudentDao) request.getAttribute("consultantStudentDao");

    int consultantid=0;
    Vector v=new Vector();
    int day=0;
    int month=0;
    int year=0;
    Date date=new Date();
    String monthS="";
    String yearS="";
    String dayS="";
    int studentIDM=0;
    Vector image=new Vector();

   Werbung werbung = new Werbung();
   Werbung studentM = new Werbung();



    monthS= MyDate.getMonth(MyDate.getFutureMonth3rd());
    dayS=MyDate.getDay(MyDate.getFutureMonth3rd());
    yearS=MyDate.getYear(MyDate.getFutureMonth3rd());
    java.sql.Date travelDate=MyDate.getSQLDateFromStrings(dayS,monthS,yearS,MyDate.DEUTSCH);

    String valueS=(String)request.getParameter("consultantid");
    try{
        consultantid=Integer.parseInt(valueS);
        werbung=consultantDB.getConsultant(consultantid);
        session.setAttribute("werbung",werbung);
    }
    catch(Exception e){
    }

    if(werbung!=null){

        //monthS=MyDate.getMonth(MyDate.getFutureMonth3rd());
        //dayS=MyDate.getDay(MyDate.getFutureMonth3rd());
        //yearS=MyDate.getYear(MyDate.getFutureMonth3rd());
        //String currentmonth = Integer.parseInt(MyDate.getMonth(MyDate.getFutureMonth3rd()), MyDate.DEUTSCH);
        //month =Integer.parseInt(MyDate.getMonth(MyDate.getFutureMonth3rd()), MyDate.DEUTSCH);
        date=MyDate.getFutureMonth3rd();
        day =Integer.parseInt(dayS);
        year=Integer.parseInt(yearS);

        //java.sql.Date travelDate=MyDate.getSQLDateFromStrings(dayS,monthS,yearS,MyDate.DEUTSCH);
        //MyDate.getSQLDateFromStrings(dayS,monthS,yearS,MyDate.DEUTSCH)

        v=studentDB.getAllStudentTelephone(consultantid);
        studentM=studentDB.getMinStudentID(consultantid);
        studentIDM= studentM.getStudentID();


    }else{
        String err=consultantDB.getError();
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="interested()">Groß interesse</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="notactive()">Nicht Aktiv</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="telephone()">Telefon Liste</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="newstudent()">Neue Agentur</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="back()">Zur&uuml;ck</a>

                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form name="form1" style="width: 100%;" method="post" action="updateConsultant" onSubmit="MM_validateForm('txtFirstName','','R','txtLastName','','R','txtBirthPlace','','R','txtNationality','','R','txtAddress','','R','txtPostCode','','RisNum','txtCity','','R','txtCountry','','R','txtHomeNo','','RisNum','txtMobileNo','','RisNum','txtEmail','','RisEmail','txtLoginName','','R','txtPassword','','R');return document.MM_returnValue">
                            <table width="100%" height="50" border="0" cellpadding="1" cellspacing="1">
                                <input type="hidden" name="hiddenField" value="<%=consultantid%>">
                                <input type="hidden" name="studentidm" value="<%=studentIDM%>">
                                <input name="consultantidS" type="hidden" id="consultantidS" value="<%=consultantid%>">
                                <input name="studentS" type="hidden" id="studentS" value="<%=studentIDM%>">
                                <tr>
                                    <td height="30" colspan="2" bgcolor="#FFFFFF"><table width="100%"  border="0" cellspacing="1" cellpadding="1">
                                        <tr>
                                            <td height="14" colspan="7" bgcolor="657A9A"><div align="center"><b><font color="#FFFFFF" >Consultantstudent Liste </font></b></div></td>
                                        </tr>
                                        <tr>
                                            <td height="14" colspan="7" bgcolor="657A9A"><div align="right"><font size="2" color="#FFFFFF"><b><%=v.size()%></b></font></div></td>
                                        </tr>
                                        <tr bgcolor="#405579">
                                            <td width="7%" bgcolor="657A9A"><div align="left"><font color="#FFFFFF"><b>
                                                <input type="checkbox" name="selectm" onClick="checkAll(this)">
                                            </b></font><font color="#ffffff" size="2"></font></div></td>
                                            <td width="28%" bgcolor="657A9A"><font color="#ffffff" size="2"><B>Name</B></font></td>
                                            <td width="22%" height="14" bgcolor="657A9A"><font color="#FFFFFF"><b><FONT size=2>Email</FONT></b></font></td>
                                            <td width="21%" bgcolor="657A9A"><strong><b><font color="#ffffff" size="2">Telephone</font></b></strong></td>
                                            <td colspan="3" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Anfang Datum </font></strong></td>
                                        </tr>
                                        <tr bgcolor="AEBACD">
                                            <%
                                                for(int i=0;i<v.size();i++)
                                                {
                                                   Werbung werbungStudent=(Werbung)v.elementAt(i);

                                            %>
                                            <td height="6" bgcolor="AEBACD"><font size="2" color="#000033">
                                                <input type="checkbox" name="checkbox" value="<%=werbungStudent.getEmail()%>" onClick="addSel(this)">
                                            </font></td>
                                            <td height="6" bgcolor="AEBACD"><input name="studentS" type="hidden" id="studentS" value="<%=werbungStudent.getStudentID()%>">
                                                <font size="2" color="#000033"><font size="2" color="#000033"><a href="consultantStudentUpdateForm?consultantid=<%=werbungStudent.getConsultantID()%>&studentID=<%=werbungStudent.getStudentID()%>"><%=werbungStudent.getFirstName()%> </a><font size="2" color="#000033"></font></font></font></td>
                                            <td height="6" bgcolor="AEBACD"><font size="2" color="#000033"><%=werbungStudent.getEmail()%></font></td>
                                            <td height="6" bgcolor="AEBACD"><font size="4" color="#000033"><%=werbungStudent.getTelephoneNumber()%></font></td>
                                            <td height="6" colspan="3" bgcolor="AEBACD"><font size="2" color="#000033"><%=MyDate.formateDate(werbungStudent.getBeginDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                        <tr bgcolor="AEBACD">
                                            <td height="6">&nbsp;</td>
                                            <td height="6">&nbsp;</td>
                                            <td height="6">&nbsp;</td>
                                            <td height="6" bgcolor="AEBACD">&nbsp;</td>
                                            <td width="5%" height="6" bgcolor="AEBACD">&nbsp;</td>
                                            <td width="17%" height="6" colspan="2" bgcolor="AEBACD">&nbsp;</td>
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
