<html>
<head>
    <title>Print Bill</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%@ page import="java.util.*" %>
<%@ page import="com.rheinlandprivatschule.repository.ResidenceDao" %>
<%@ page import="com.rheinlandprivatschule.model.Residence" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%
    ResidenceDao residenceDB= (ResidenceDao) request.getAttribute("residenceDao");

    String totalpay="";
    String pcode="";
    String tranno="";
    String co="";

    String add1="";
    String add2="";
    String add3="";
    String add4="";
    String add5="";
    String add6="";

    Residence presidence=(Residence)session.getAttribute("presidence");
    RPS rps=(RPS)session.getAttribute("handler");
    session.setAttribute("presidence",presidence);
    pcode=rps.getLoginPlace().getPlacePostCode()+" "+rps.getLoginPlace().getPlaceCity();
    tranno=(String)session.getAttribute("tranno");


    Vector myv=new Vector();
    myv=residenceDB.getRentOutPrintMain(tranno);
    for(int i=0;i<myv.size();i++){
        double cre=0;
        Residence tt=(Residence)myv.elementAt(i);
        cre=tt.getAmountPaid();
        totalpay=""+cre;

        double amount= 0;
        double rent=0;
        double balance = 0;
        double topay = 0;
        String rentDate="";
        String firstname="";
        String address="";
        String postcode ="";
        String city ="";
        String mark ="";

        int month = tt.getRentMonth();
        int year = tt.getRentYear();
        amount = tt.getAmountPaid();
        rentDate=MyDate.formateDate(tt.getRentDate(), MyDate.ALPHANUMERIC,MyDate.DEUTSCH);
        rent = tt.getResidenceRent();
        balance = tt.getAmountBalance();
        topay = rent - balance;
        firstname = tt.getUserFirstName();
        address = tt.getUserAddress();
        postcode = tt.getUserPostCode();
        city = tt.getUserCity();
        mark = tt.getResidenceMark();

        //tranno=(String)session.getAttribute("tranno");

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
        <td colspan="5" height="13"><font size="2"><%=firstname%></font></td>
        <td width="48%">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="5" height="2"><%=address%></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td colspan="5" height="2"><font size="2"><%=postcode%> , <%=city%></font></td>
        <td width="48%">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="5">&nbsp;</td>
        <td width="48%">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="6" height="16">&nbsp;</td>
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
        <td width="25%" align="left" height="4"><b><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Zimmer</font></b></td>
        <td colspan="4" height="4"><font size="3"><%=mark%></font></td>
    </tr>
    <tr>
        <td width="14%" align="left">&nbsp;</td>
        <td width="25%" align="left" height="8"><b><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Monat</font></b></td>
        <td colspan="4" height="8"><font size="3"><%=MyDate.getMonthName(month,MyDate.DEUTSCH)%>, <%=year%></font></td>
    </tr>
    <tr>
        <td width="14%" align="left">&nbsp;</td>
        <td width="25%" align="left" height="4"><b><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Miete</font></b></td>
        <td colspan="4" height="4"><font size="3"><%=rent%> &euro;</font></td>
    </tr>
    <tr>
        <td width="14%" align="left">&nbsp;</td>
        <td width="25%" align="left" height="15"><b> <font size="2" face="Verdana, Arial, Helvetica, sans-serif">Mahngeb&uuml;hren</font> </b></td>
        <td colspan="4" height="15">&euro;</td>
    </tr>
    <tr>
        <td width="14%" align="left">&nbsp;</td>
        <td width="25%" align="left" height="10"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Geleistete Zahlungen</font></b></td>
        <td colspan="4" height="10"><font size="3"><%=balance%></font> &euro;</td>
    </tr>
    <tr>
        <td width="14%" align="left">&nbsp;</td>
        <td width="25%" align="left" height="12"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">F&auml;lliger Betrag</font></b></td>
        <td colspan="4" height="12"><font size="3"><%=topay%></font> &euro;</td>
    </tr>
    <tr>
        <td width="14%" align="left">&nbsp;</td>
        <td width="25%" align="left" height="7"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Rechnungsbetrag</font></b></td>
        <td colspan="4" height="7"><font size="3"> <%=amount%> &euro;</font></td>
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
    <%
        }
    %>
</table>
</body>
</html>
