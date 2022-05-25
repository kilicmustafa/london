<html>
<head>
    <title>Print Bill</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%@ page import="java.util.*" %>
<%@ page import="com.rheinlandprivatschule.repository.ResidenceDao" %>
<%@ page import="com.rheinlandprivatschule.model.Residence" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="com.rheinlandprivatschule.model.SystemUser" %>
<%@ page import="com.rheinlandprivatschule.model.Place" %>
<%


    Vector v=(Vector)session.getAttribute("tr");
    String add1="";
    String add2="";
    String add3="";
    String add4="";
    String add5="";
    String add6="";

%>
<table width="100%" border="0" cellspacing="1" cellpadding="1" height="896">
    <%


        ResidenceDao sdb= (ResidenceDao) request.getAttribute("residenceDao");
        //rps.courses.CourseDB cdb=new rps.courses.CourseDB();
        for(int i=0;i<v.size();i++){

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


            Residence t=(Residence)v.elementAt(i);
            int month = t.getRentMonth();
            int year = t.getRentYear();
            int rentid = t.getRentIncomingID();
            amount = t.getAmountPaid();
            rentDate= MyDate.formateDate(t.getRentDate(),MyDate.ALPHANUMERIC,MyDate.DEUTSCH);
            rent = t.getResidenceRent();
            balance = t.getAmountBalance();
            topay = rent - balance;
            firstname = t.getUserFirstName();
            address = t.getUserAddress();
            postcode = t.getUserPostCode();
            city = t.getUserCity();
            mark = t.getResidenceMark();
            //int transno = t.getRentIncomingID();

            RPS rps = (RPS) request.getSession().getAttribute("handler");

            SystemUser u= rps.getLoginUser();
            Place myPlace=rps.getLoginPlace();

    %>
    <tr>
        <td height="875">
            <table width="100%" border="0" height="576">
                <tr>
                    <td height="22" width="13%" rowspan="4">&nbsp;</td>
                    <td height="22" colspan="3" valign="top" rowspan="4"><b><font face="Times New Roman, Times, serif" color="#FFFFFF">
                    </font><font face="Times New Roman, Times, serif">&nbsp;</font></b></td>
                    <td width="4%" height="22" rowspan="4">&nbsp;</td>
                    <td width="52%" height="10">
                        <div align="right"><b><font face="Times New Roman, Times, serif">R</font></b><font face="Times New Roman, Times, serif">heinland</font><b><font face="Times New Roman, Times, serif">
                            P</font></b><font face="Times New Roman, Times, serif">rivatschule</font></div>
                    </td>
                </tr>
                <tr>
                    <td width="52%" height="10">
                        <div align="right"><font size="2"><%=myPlace.getPlaceAddress()%></font></div>
                    </td>
                </tr>
                <tr>
                    <td width="52%" height="22">
                        <div align="right"><font size="2"><%=myPlace.getPlacePostCode()%> <%=myPlace.getPlaceCity()%></font></div>
                    </td>
                </tr>
                <tr>
                    <td width="52%" height="22">

                        <div align="right"><font size="2">Fon: <%=myPlace.getPlaceTelephone()%></font></div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" height="4">&nbsp;</td>
                    <td width="1%" height="4">&nbsp;</td>
                    <td width="5%" height="4">&nbsp;</td>
                    <td width="4%" height="4">&nbsp;</td>
                    <td width="52%" height="4">
                        <div align="right"><font size="2">Fax: <%=myPlace.getPlaceFax()%></font></div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" height="20">&nbsp;</td>
                    <td width="1%" height="20">&nbsp;</td>
                    <td width="5%" height="20">&nbsp;</td>
                    <td width="4%" height="20">&nbsp;</td>
                    <td width="52%" height="20">
                        <div align="right"><font size="2">e-Mail: info@unitutor.de</font></div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" height="2">&nbsp;</td>
                    <td width="1%" height="2">&nbsp;</td>
                    <td width="5%" height="2">&nbsp;</td>
                    <td width="4%" height="2">&nbsp;</td>
                    <td width="52%" height="2">
                        <div align="right"><font size="2"><a href="#"><font color="#000000">www.unitutor.de</font></a></font></div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" height="18"><font size="1"><a href="#"><font color="#000000">Aydin
                        &Ouml;zt&uuml;rk * Viehofer Stra&szlig;e 14* 45127 Essen</font></a></font></td>
                    <td height="18" width="1%">&nbsp;</td>
                    <td height="18" width="5%">&nbsp;</td>
                    <td height="18" width="4%">&nbsp;</td>
                    <td height="18" width="52%">
                        <div align="right"><font size="2"><a href="#"></a></font></div>
                    </td>
                </tr>
                <tr>
                    <td colspan="5" height="13">&nbsp;</td>
                    <td width="52%" height="13">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="5" height="13"><font size="2"><%=firstname%></font></td>
                    <td width="52%" height="13">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="5" height="2"><%=address%></td>
                    <td height="2">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="5" height="2"><font size="2"><%=postcode%> , <%=city%></font></td>
                    <td width="52%" height="2">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="5" height="15">&nbsp;</td>
                    <td width="52%" height="15">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="6" height="35">
                        <div align="center"><b><font size="6" face="Times New Roman, Times, serif">Rechnung</font></b></div>
                    </td>
                </tr>
                <tr>
                    <td colspan="5" height="11">&nbsp;</td>
                    <td width="52%" align="right" height="11">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="5" height="11"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Rechnungs-Nr
                        :</font> <font size="3"><%=rentid%></font></td>
                    <td width="52%" align="right" height="11"><font size="3"><%=rentDate%></font></td>
                </tr>
                <tr>
                    <td colspan="5" height="9">&nbsp;</td>
                    <td width="52%" align="right" height="9">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="5" height="9">&nbsp;</td>
                    <td width="52%" align="right" height="9">&nbsp;</td>
                </tr>
                <tr>
                    <td width="13%" align="left" height="4">&nbsp;</td>
                    <td width="25%" align="left" height="4"><b><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Zimmer</font></b></td>
                    <td colspan="4" height="4"><font size="3"><%=mark%></font></td>
                </tr>
                <tr>
                    <td width="13%" align="left" height="8">&nbsp;</td>
                    <td width="25%" align="left" height="8"><b><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Monat</font></b></td>
                    <td colspan="4" height="8"><font size="3"><%=MyDate.getMonthName(month,MyDate.DEUTSCH)%>, <%=year%></font></td>
                </tr>
                <tr>
                    <td width="13%" align="left" height="4">&nbsp;</td>
                    <td width="25%" align="left" height="4"><b><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Miete</font></b></td>
                    <td colspan="4" height="4"><font size="3"><%=rent%> &euro;</font></td>
                </tr>
                <tr>
                    <td width="13%" align="left" height="15">&nbsp;</td>
                    <td width="25%" align="left" height="15"><b> <font size="2" face="Verdana, Arial, Helvetica, sans-serif">Mahngeb&uuml;hren</font> </b></td>
                    <td colspan="4" height="15"> &euro;</td>
                </tr>
                <tr>
                    <td width="13%" align="left" height="10">&nbsp;</td>
                    <td width="25%" align="left" height="10"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Geleistete
                        Zahlungen</font></b></td>
                    <td colspan="4" height="10"> <font size="3"><%=balance%></font> &euro;</td>
                </tr>
                <tr>
                    <td width="13%" align="left" height="12">&nbsp;</td>
                    <td width="25%" align="left" height="12"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">F&auml;lliger
                        Betrag</font></b></td>
                    <td colspan="4" height="12"> <font size="3"><%=topay%></font> &euro;</td>
                </tr>
                <tr>
                    <td width="13%" align="left" height="7">&nbsp;</td>
                    <td width="25%" align="left" height="7"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Rechnungsbetrag</font></b></td>
                    <td colspan="4" height="7"><font size="3">  <%=amount%> &euro;</font></td>
                </tr>
                <tr align="left">
                    <td colspan="6" height="15">&nbsp;</td>
                </tr>
                <tr align="left">
                    <td colspan="6" height="15">&nbsp;</td>
                </tr>
                <tr align="left">
                    <td colspan="6" height="15">&nbsp;</td>
                </tr>
                <tr align="left">
                    <td colspan="6" height="15">&nbsp;</td>
                </tr>
                <tr align="left">
                    <td colspan="6" height="8"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Wir
                        danken Ihnen f&uuml;r Ihren Auftrag,</font></td>
                </tr>
                <tr align="left">
                    <td colspan="6" height="14">&nbsp;</td>
                </tr>
                <tr align="left">
                    <td colspan="6" height="2"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">mit
                        freundlichen Gr&uuml;&szlig;en</font></td>
                </tr>
                <tr align="left">
                    <td colspan="6" height="9"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">-Rheinland
                        Privatschule-</font></td>
                </tr>
                <tr align="left">
                    <td colspan="6" height="9">&nbsp;</td>
                </tr>
                <tr align="left">
                    <td colspan="6" height="2"><font size="2"><%=u.getUserFirstName()+" "+u.getUserLastName()%></font></td>
                </tr>
                <tr align="left">
                    <td colspan="6" height="2">&nbsp;</td>
                </tr>
                <tr align="left">
                    <td colspan="6" height="2">&nbsp;</td>
                </tr>
                <tr align="left">
                    <td colspan="6" height="2">&nbsp;</td>
                </tr>
                <tr align="left" valign="top">
                    <td colspan="6" height="82">&nbsp; </td>
                </tr>
                <tr align="left">
                    <td colspan="6" height="2"></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td height="2">&nbsp;</td>
    </tr>
    <tr>
        <td height="2">&nbsp;</td>
    </tr>
    <%
        }
    %>
</table>
</body>
</html>
