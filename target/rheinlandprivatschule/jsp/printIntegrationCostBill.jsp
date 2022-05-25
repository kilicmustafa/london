<html>
<head>
    <title>Print Bill</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%@ page import="java.util.*" %>
<%@ page import="com.rheinlandprivatschule.repository.TransactionDao" %>
<%@ page import="com.rheinlandprivatschule.repository.StudentDao" %>
<%@ page import="com.rheinlandprivatschule.repository.IntegrationCostDao" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%
    TransactionDao trdb=new TransactionDao();
    StudentDao studentDB= (StudentDao) request.getAttribute("studentDao");
    IntegrationCostDao xtraCostDB=new IntegrationCostDao();
    String totalpay="";
    String pcode="";
    String topay="";
    String tranno="";
    String co="";

    String add1="";
    String add2="";
    String add3="";
    String add4="";
    String add5="";
    String add6="";

    Student cr=new Student();
    Student course=new Student();
    Student student=new Student();
    Student cost=new Student();
    Student pay=new Student();

    Student pstudent=(Student)session.getAttribute("pstudent");
    RPS rps=(RPS)session.getAttribute("handler");

    pcode=rps.getLoginPlace().getPlacePostCode()+" "+rps.getLoginPlace().getPlaceCity();
    cr=(Student)session.getAttribute("cr");
    course=(Student)session.getAttribute("course");

    topay=(String)session.getAttribute("ap");



    //totalpay=""+(cr.getCourseFee()-cr.getCourseBalance());
    Vector myv=new Vector();



    if(pstudent.getUserCO()==null){
        add1=pstudent.getUserFirstName()+" "+pstudent.getUserLastName();
        add2=pstudent.getUserAddress();
        add3="";
        add4=pstudent.getUserPostCode()+" "+pstudent.getUserCity();
        add5="";
        add6="";
    }else{
        add1=pstudent.getUserFirstName()+" "+pstudent.getUserLastName();
        add2="c\\o "+pstudent.getUserCO();
        add3=pstudent.getUserAddress();
        add4="";
        add5=pstudent.getUserPostCode()+" "+pstudent.getUserCity();
        add6="";
    }
    tranno=(String)session.getAttribute("tranno");
    student = xtraCostDB.getXtraCostByStudent(Integer.parseInt(tranno),pstudent.getUserID());
    cost = xtraCostDB.getXtraCost(student.getCostID());
    pay = xtraCostDB.getCostStudent(student.getCostID(), student.getUserID());
%>
<table width="100%" border="0" height="822">
    <tr>
        <td height="22" width="14%" rowspan="4">&nbsp;</td>
        <td height="22" colspan="3" valign="top" rowspan="4"><b><font face="Times New Roman, Times, serif" color="#FFFFFF">
        </font><font face="Times New Roman, Times, serif">&nbsp;&nbsp;&nbsp;</font></b></td>
        <td width="4%" height="22" rowspan="4">&nbsp;</td>
        <td width="48%" height="10">
            <div align="right"><b><font face="Times New Roman, Times, serif">R</font></b><font face="Times New Roman, Times, serif">heinland</font><b><font face="Times New Roman, Times, serif">
                P</font></b><font face="Times New Roman, Times, serif">rivatschule</font></div>
        </td>
    </tr>
    <tr>
        <td width="48%" height="10">
            <div align="right"><font size="2"><%=rps.getLoginPlace().getPlaceAddress()%></font></div>
        </td>
    </tr>
    <tr>
        <td width="48%" height="22">
            <div align="right"><font size="2"><%=pcode%></font></div>
        </td>
    </tr>
    <tr>
        <td width="48%" height="22">
            <div align="right"><font size="2">Fon: <%=rps.getLoginPlace().getPlaceTelephone()%></font></div>
        </td>
    </tr>
    <tr>
        <td colspan="2">&nbsp;</td>
        <td width="2%">&nbsp;</td>
        <td width="6%">&nbsp;</td>
        <td width="4%">&nbsp;</td>
        <td width="48%">
            <div align="right"><font size="2">Fax: <%=rps.getLoginPlace().getPlaceFax()%></font></div>
        </td>
    </tr>
    <tr>
        <td colspan="2">&nbsp;</td>
        <td width="2%">&nbsp;</td>
        <td width="6%">&nbsp;</td>
        <td width="4%">&nbsp;</td>
        <td width="48%">
            <div align="right"><font size="2">e-Mail: info@unitutor.de</font></div>
        </td>
    </tr>
    <tr>
        <td colspan="2">&nbsp;</td>
        <td width="2%">&nbsp;</td>
        <td width="6%">&nbsp;</td>
        <td width="4%">&nbsp;</td>
        <td width="48%">
            <div align="right"><font size="2"><a href="#"><font color="#000000">www.unitutor.de</font></a></font></div>
        </td>
    </tr>
    <tr>
        <td colspan="2" height="18"><font size="1"><a href="#"><font color="#000000">Aydin
            &Ouml;zt&uuml;rk * Viehofer Stra&szlig;e 14 * 45127 Essen</font></a></font></td>
        <td height="18" width="2%">&nbsp;</td>
        <td height="18" width="6%">&nbsp;</td>
        <td height="18" width="4%">&nbsp;</td>
        <td height="18" width="48%">
            <div align="right"><font size="2"><a href="#"></a></font></div>
        </td>
    </tr>
    <tr>
        <td colspan="5">&nbsp;</td>
        <td width="48%">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="5"><%=add1%></td>
        <td width="48%">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="5"><%=add2%></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td colspan="5"><%=add3%></td>
        <td width="48%">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="5"><%=add4%></td>
        <td width="48%">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="6"><%=add5%></td>
    </tr>
    <tr>
        <td colspan="6" height="16"><%=add6%></td>
    </tr>
    <tr>
        <td colspan="6" height="16">
            <div align="center"><b><font size="6" face="Times New Roman, Times, serif">Rechnung</font></b></div>
        </td>
    </tr>
    <tr>
        <td colspan="5">&nbsp;</td>
        <td width="48%" align="right">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="5"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Rechnungs-Nr
            :</font> <%=tranno%></td>
        <td width="48%" align="right"><%=MyDate.formateDate(MyDate.getCurrentSQLDate(),MyDate.ALPHANUMERIC,MyDate.DEUTSCH)%></td>
    </tr>
    <tr>
        <td colspan="5">&nbsp;</td>
        <td width="48%" align="right">&nbsp;</td>
    </tr>
    <tr>
        <td width="14%" align="left">&nbsp;</td>
        <td width="26%" align="left">&nbsp;</td>
        <td colspan="4">&nbsp;</td>
    </tr>
    <tr>
        <td width="14%" align="left">&nbsp;</td>
        <td width="26%" align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Geb&uuml;hrbeschreibung</font></b></td>
        <td colspan="4"><%=cost.getCostDesc()%></td>
    </tr>
    <tr>
        <td width="14%" align="left">&nbsp;</td>
        <td width="26%" align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Registrierungsgeb&uuml;hr</font></b></td>
        <td colspan="4"> <%=cost.getActualFee()%> &euro;</td>
    </tr>
    <tr>
        <td width="14%" align="left">&nbsp;</td>
        <td width="26%" align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Geleistete
            Zahlungen</font></b></td>
        <td colspan="4"><%=pay.getTotalPay()%> &euro;</td>
    </tr>
    <tr>
        <td width="14%" align="left">&nbsp;</td>
        <td width="26%" align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">F&auml;lliger
            Betrag</font></b></td>
        <td colspan="4"><%=((cost.getActualFee()-pay.getTotalPay()))%> &euro;</td>
    </tr>
    <tr>
        <td width="14%" align="left">&nbsp;</td>
        <td width="26%" align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Rechnungsbetrag</font></b></td>
        <td colspan="4"><%=student.getTotalPay()%> &euro;</td>
    </tr>
    <tr align="left">
        <td colspan="6">&nbsp;</td>
    </tr>
    <tr align="left">
        <td colspan="6">&nbsp;</td>
    </tr>
    <tr align="left">
        <td colspan="6">&nbsp;</td>
    </tr>
    <tr align="left">
        <td colspan="6">&nbsp;</td>
    </tr>
    <tr align="left">
        <td colspan="6"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Wir
            danken Ihnen f&uuml;r Ihren Auftrag,</font></td>
    </tr>
    <tr align="left">
        <td colspan="6">&nbsp;</td>
    </tr>
    <tr align="left">
        <td colspan="6"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">mit
            freundlichen Gr&uuml;&szlig;en</font></td>
    </tr>
    <tr align="left">
        <td colspan="6"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">-Rheinland
            Privatschule-</font></td>
    </tr>
    <tr align="left">
        <td colspan="6">&nbsp;</td>
    </tr>
    <tr align="left">
        <td colspan="6"><%=rps.getLoginUser().getUserFirstName()+" "+rps.getLoginUser().getUserLastName()%></td>
    </tr>
    <tr align="left">
        <td colspan="6">&nbsp;</td>
    </tr>
    <tr align="left">
        <td colspan="6">&nbsp;</td>
    </tr>
    <tr align="left">
        <td colspan="6">&nbsp;</td>
    </tr>
    <tr align="left" valign="top">
        <td colspan="6">&nbsp; </td>
    </tr>
    <tr align="left">
        <td colspan="6" height="2"></td>
    </tr>
</table>
</body>
</html>
