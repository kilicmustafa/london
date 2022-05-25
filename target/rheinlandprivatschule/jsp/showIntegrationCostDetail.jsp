<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="com.rheinlandprivatschule.repository.StudentDao" %>
<%@ page import="com.rheinlandprivatschule.repository.IntegrationCostDao" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Kurs Registrierung Einzelheit ::</title>
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

        function changeme()
        {
            if(document.form1.checkbox.checked){
                document.form1.checkbox.value="1";
            }else{
                document.form1.checkbox.value="0";
            }
        }

        function anmeld(){
            if(document.form1.anm.value=="true" && document.form1.canregprint.value=="true"){
                window.location="noa";
            }else{
                if(document.form1.anm.value=="false"){
                    alert('Es ist nicht möglich, ohne vollgebühr zu zahlen.')
                }else if(document.form1.canregprint.value=="false"){
                    alert('Ihnen wird nicht erlaubt, das zu tun.')
                }
            }
        }

        function leave(msg)
        {
            if(!confirm(msg)) return false
            else document.form1.submit()
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
    Student student=new Student();
    IntegrationCostDao costDB=new IntegrationCostDao();
    Student cost=new Student();

    ArrayList registrations=new ArrayList();
    Vector cerv=new Vector();

    int userid=0;
    int courseid=0;
    int delevalue=0;

    String day="1";
    String month="Janaury";
    String year="2000";

    String myMsg="";
    String falligDate="";

    boolean inkasso=false;
    boolean mayactiv=false;
    boolean cananm=true;
    boolean canregPrint=false;
    double paid=0;



    RPS rps=(RPS)session.getAttribute("handler");
    student=(Student)session.getAttribute("pstudent");
    if(student==null){
        String err="Wählen Sie Schüler Zuerst aus";
        session.setAttribute("err",err);
        session.setAttribute("lin","seacrhStudent");
        response.sendRedirect("error");
    }else{
        session.setAttribute("pstudent",student);

        canregPrint=studentDB.canPrintRegistration(rps.getLoginUser().getUserID());

        userid=student.getUserID();
        String courseidS=(String)request.getParameter("courseid");

        try	{
            courseid=Integer.parseInt(courseidS);
            student=costDB.getCostStudent(courseid,userid);

            inkasso=studentDB.isInKasso(userid,courseid,rps.getLoginUser().getUserID());
            if(inkasso)	{
                myMsg="Schuler ist im inkasso Liste. Möchten Sie ";
            }else{
                myMsg="Haben Sie ";
            }

            cost=costDB.getXtraCost(courseid);

            day= MyDate.getDay(cost.getUserRegDate());
            month=MyDate.getMonth(cost.getUserRegDate());
            year=MyDate.getYear(cost.getUserRegDate());

            session.setAttribute("cr",cost);
            session.setAttribute("course",student);
            session.setAttribute("myPrint","reg");
        }catch(Exception e){
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

                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width: 100%;" name="form1" method="post" action="updateIntegrationCost" onSubmit="MM_validateForm('txtBal','','RisNum');return document.MM_returnValue">
                            <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                <tr bgcolor="D9E5F4">
                                    <td height="21" colspan="5"><div align="right"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">
                                        <input type="button" name="Submit32" value="Zur&uuml;ck" onClick="studentdetail()">
                                        <input type="button" name="Submit22" value="Haupt" onClick="haupt()">
                                    </font></div></td>
                                </tr>
                                <tr bgcolor="D9E5F4">
                                    <td height="26" colspan="5">
                                        <div align="right"> <font size="1" face="Verdana, Arial, Helvetica, sans-serif">
                                            <input type="hidden" name="userids" value="<%=userid%>">
                                        </font></div>
                                    </td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td colspan="5" height="26">
                                        <div align="center"><font size="2"><b><font color="#FFFFFF">Kost
                                            Registrierung</font></b></font></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="29%" height="18" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Name</font></b></td>
                                    <td width="71" height="18" colspan="3" bgcolor="AEBACB"><font size="2" color="#405579">
                                        <input type="text" name="txtCostDesc" size="8" value="<%=cost.getCostDesc()%>">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td height="15" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Eingangdatum</font></b></td>
                                    <td height="15" bgcolor="AEBACB" colspan="3"><font size="2" color="#000033"><%=MyDate.formateDate(cost.getUserRegDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font><font size="2" color="#405579">
                                    </font><font color="#000033">&nbsp;
                                    </font><font size="2" color="#405579">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td height="18" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Eingang betrag</font></b></td>
                                    <td height="18" bgcolor="AEBACB" colspan="3"><font size="2" color="#405579">
                                        <input type="text" name="txtPay" size="8" value="<%=MyCurrency.getDisplayString(cost.getActualFee())%>">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td height="17" bgcolor="657A9A"><font size="2"><b><font size="2" color="#FFFFFF">betrag</font><font color="#FFFFFF">
                                        bezahlt</font></b></font></td>
                                    <td height="17" bgcolor="AEBACB" colspan="3"><font size="2" color="#000033"><%=MyCurrency.getDisplayString(student.getTotalPay())%></font>
                                        <input type="hidden" input name="totalPaid" id="totalPaid" value="<%=student.getTotalPay()%>" >
                                        <font size="2" color="#405579">&nbsp;						</font></td>
                                </tr>
                                <tr>
                                    <td height="17" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Bestand</font></b></td>
                                    <td height="17" bgcolor="AEBACB" colspan="3"><font size="2" color="#000033"><%=MyCurrency.getDisplayString(cost.getActualFee() - student.getTotalPay())%></font><font size="2" color="#405579">&nbsp;

                                    </font></td>
                                </tr>
                                <tr>
                                    <td height="23" bgcolor="657A9A"><font size="2"><b><font color="#FFFFFF">Art
                                        der Ausgang Bezahlung</font></b></font></td>
                                    <td height="23" bgcolor="AEBACB" colspan="3">
                                        <select name="paytype">
                                            <option value="0" selected>Bar</option>
                                            <option value="1">Uberweisung</option>

                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="23" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Rechnungsbetrag</font></b></td>
                                    <td height="23" bgcolor="AEBACB" colspan="3"> <font size="2" color="#405579">
                                        <input type="text" name="txtBal" size="8" value="<%=MyCurrency.getDisplayString(cost.getActualFee() - student.getTotalPay())%>">
                                        <input type="checkbox" name="checkbox" value="checkbox" onClick="changeme()">
                                    </font><font size="1" face="Verdana, Arial, Helvetica, sans-serif">Geldzurück</font></td>
                                </tr>
                                <tr>
                                    <td height="30" bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>Aktualisierung
                                        <font size="2" color="#FFFFFF">Bestand</font></b></font></td>
                                    <td height="30" bgcolor="AEBACB">
                                        <input type="hidden" name="courseid" value="<%=cost.getCostID()%>">
                                        <input class="btn btn-primary" type="submit" name="Submit" value="Zahlen" onClick="leave('<%=myMsg%>'+document.form1.txtBal.value+' Euro Bezahlt?');return false">
                                        <input type="hidden" name="anm" value="<%=cananm%>">
                                    </td>
                                    <td height="30" bgcolor="AEBACB"><b> </b></td>
                                </tr>
                                <tr>
                                    <td height="30" bgcolor="657A9A">&nbsp;</td>
                                    <td height="30" bgcolor="AEBACB" colspan="3">&nbsp;</td>
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
