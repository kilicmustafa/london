<html>
<head>
    <title>:: Druck Buch Rechnung ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%@ page import="java.util.*" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="com.rheinlandprivatschule.model.SystemUser" %>
<%@ page import="com.rheinlandprivatschule.repository.BuchDao" %>
<%@ page import="com.rheinlandprivatschule.model.Buch" %>
<%@ page import="com.rheinlandprivatschule.model.Place" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ page session="true" %>
<%
    String pcode="";
    Vector books=new Vector();
    Student pstudent=new Student();
    String tp="";
    String tranno="";
    int transno=0;

    RPS rps=(RPS)session.getAttribute("handler");
    SystemUser loginUser=new SystemUser();
    BuchDao bdb=new BuchDao();
    Buch book=new Buch();
    loginUser=rps.getLoginUser();
    Place city=rps.getLoginPlace();

    pcode=city.getPlacePostCode()+" "+city.getPlaceCity();

    pstudent=(Student)session.getAttribute("pstudent");
    String rechid=(String)request.getParameter("rechID");

    transno= Integer.parseInt(rechid);
    books=bdb.getBooksSoldRecord(transno, 0);
%>
<table width="100%" border="0" height="822">
    <tr>
        <td height="22" width="14%" rowspan="4">&nbsp;</td>
        <td height="22" colspan="3" valign="top" rowspan="4"><b><font face="Times New Roman, Times, serif" color="#FFFFFF">
        </font><font face="Times New Roman, Times, serif">&nbsp;</font></b></td>
        <td width="4%" height="22" rowspan="4">&nbsp;</td>
        <td width="48%" height="10" colspan="2">
            <div align="right"><b><font face="Times New Roman, Times, serif">R</font></b><font face="Times New Roman, Times, serif">heinland</font><b><font face="Times New Roman, Times, serif">
                P</font></b><font face="Times New Roman, Times, serif">rivatschule</font></div>
        </td>
    </tr>
    <tr>
        <td width="48%" height="10" colspan="2">
            <div align="right"><font size="2"><%=city.getPlaceAddress()%></font></div>
        </td>
    </tr>
    <tr>
        <td width="48%" height="22" colspan="2">
            <div align="right"><font size="2"><%=pcode%></font></div>
        </td>
    </tr>
    <tr>
        <td width="48%" height="22" colspan="2">
            <div align="right"><font size="2">Fon: <%=city.getPlaceTelephone()%></font></div>
        </td>
    </tr>
    <tr>
        <td colspan="2">&nbsp;</td>
        <td width="2%">&nbsp;</td>
        <td width="6%">&nbsp;</td>
        <td width="4%">&nbsp;</td>
        <td width="48%" colspan="2">
            <div align="right"><font size="2">Fax: <%=city.getPlaceFax()%></font></div>
        </td>
    </tr>
    <tr>
        <td colspan="2">&nbsp;</td>
        <td width="2%">&nbsp;</td>
        <td width="6%">&nbsp;</td>
        <td width="4%">&nbsp;</td>
        <td width="48%" colspan="2">
            <div align="right"><font size="2">Mobil : 0172/ 23 61 98 1</font></div>
        </td>
    </tr>
    <tr>
        <td colspan="2">&nbsp;</td>
        <td width="2%">&nbsp;</td>
        <td width="6%">&nbsp;</td>
        <td width="4%">&nbsp;</td>
        <td width="48%" colspan="2">
            <div align="right"><font size="2">e-Mail: info@unitutor.de</font></div>
        </td>
    </tr>
    <tr>
        <td colspan="2" height="18"><font size="1"><a href="#"><font color="#000000">Aydin
            &Ouml;zt&uuml;rk * Viehofer Stra&szlig;e 14* 45127 Essen</font></a></font></td>
        <td height="18" width="2%">&nbsp;</td>
        <td height="18" width="6%">&nbsp;</td>
        <td height="18" width="4%">&nbsp;</td>
        <td height="18" width="48%" colspan="2">
            <div align="right"><font size="2"><a href="#"><font color="#000000">www.unitutor.de</font></a></font></div>
        </td>
    </tr>
    <tr>
        <td colspan="5">&nbsp;</td>
        <td width="48%" colspan="2">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="5"><%=pstudent.getUserFirstName()+" "+pstudent.getUserLastName()%></td>
        <td width="48%" colspan="2">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="5">&nbsp;</td>
        <td width="48%" colspan="2">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="5">&nbsp;</td>
        <td width="48%" colspan="2">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="7">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="7" height="16">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="7" height="16">
            <div align="center"><b><font size="6" face="Times New Roman, Times, serif">Rechnung</font></b></div>
        </td>
    </tr>
    <tr>
        <td colspan="5">&nbsp;</td>
        <td width="48%" align="right" colspan="2">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="5"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Rechnungs-Nr
            :</font> <%=transno%></td>
        <td width="48%" align="right" colspan="2"><%=MyDate.formateDate(MyDate.getCurrentSQLDate(),MyDate.ALPHANUMERIC,MyDate.DEUTSCH)%></td>
    </tr>
    <tr>
        <td colspan="5">&nbsp;</td>
        <td width="48%" align="right" colspan="2">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="7" align="left">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="7" align="left">
            <table width="100%" border="1" cellpadding="1" cellspacing="1">
                <tr>
                    <td width="10%"><b><font size="3" color="#000000">Pos</font></b></td>
                    <td width="30%"><b><font size="3" color="#000000">Art.-bezeichnung</font></b></td>
                    <td width="12%"><b><font size="3" color="#000000">Isbn Nr.</font></b></td>
                    <td width="7%"><b><font size="3" color="#000000">Stk. </font></b></td>
                    <td width="15%"><b><font size="3" color="#000000">Netto</font></b></td>
                    <td width="11%"><b><font size="3" color="#000000">MwSt. 7%</font></b></td>
                    <td width="15%"><b><font size="3" color="#000000">Brutto</font></b></td>
                </tr>
                <%
                    int stkSum=0;
                    double bruto=0;
                    double steur=0;
                    double neto=0;

                    int track=1;
                    int stk=1;
                    for(int i=0;i<books.size();i++)
                    {

                        Buch bu=(Buch)books.elementAt(i);

                        stkSum=stkSum+stk;
                        neto=neto+(bu.getPrice()-(bu.getPrice()*7/100));
                        steur=steur+(bu.getPrice()*7/100);
                        bruto=bruto+bu.getPrice();

                %>
                <tr>
                    <td width="10%"><font size="2" color="#000000"><%=track%></font></td>
                    <td width="30%"><font size="2" color="#000000"><%=bu.getBookName()%></font></td>
                    <td width="12%"><font size="2" color="#000000"><%=bu.getISBN()%></font></td>
                    <td width="7%"><font size="2" color="#000000"><%=stk%></font></td>
                    <td width="15%"><font size="2" color="#000000"><%=MyCurrency.getDisplayString((bu.getPrice()-(bu.getPrice()*7/100)))%>
                    </font><font face="Verdana, Arial, Helvetica, sans-serif" size="2">&euro;</font><font size="2" color="#000000">
                    </font></td>
                    <td width="11%"><font size="2" color="#000000"><%=MyCurrency.getDisplayString((bu.getPrice()*7/100))%>
                    </font><font face="Verdana, Arial, Helvetica, sans-serif" size="2">&euro;</font><font size="2" color="#000000">
                    </font><font size="2" color="#000000"> </font></td>
                    <td width="15%"><font size="2" color="#000000"><%=MyCurrency.getDisplayString(bu.getPrice())%> </font><font face="Verdana, Arial, Helvetica, sans-serif" size="2">&euro;</font><font size="2" color="#000000">
                    </font></td>
                </tr>
                <%
                        track++;
                    }
                %>
                <tr>
                    <td width="10%"><font size="3" color="#000000"><b>Summe</b></font></td>
                    <td width="30%">&nbsp;</td>
                    <td width="12%">&nbsp;</td>
                    <td width="7%"><font size="2" color="#000000"><%=stkSum%></font></td>
                    <td width="15%"><font size="2" color="#000000"><%=MyCurrency.getDisplayString(neto)%> </font><font face="Verdana, Arial, Helvetica, sans-serif" size="2">&euro;</font><font size="2" color="#000000">
                    </font></td>
                    <td width="11%"><font size="2" color="#000000"><%=MyCurrency.getDisplayString(steur)%> </font><font face="Verdana, Arial, Helvetica, sans-serif" size="2">&euro;</font><font size="2" color="#000000">
                    </font></td>
                    <td width="15%"><font size="2" color="#000000"><%=MyCurrency.getDisplayString(bruto)%> </font><font face="Verdana, Arial, Helvetica, sans-serif" size="2">&euro;</font><font size="2" color="#000000">
                    </font></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td colspan="7" align="left"><b></b></td>
    </tr>
    <tr>
        <td colspan="7" align="left"><b></b></td>
    </tr>
    <tr>
        <td colspan="7" align="left"><b></b></td>
    </tr>
    <tr align="left">
        <td colspan="7">&nbsp;</td>
    </tr>
    <tr align="left">
        <td colspan="7">&nbsp;</td>
    </tr>
    <tr align="left">
        <td colspan="7">&nbsp;</td>
    </tr>
    <tr align="left">
        <td colspan="7">&nbsp;</td>
    </tr>
    <tr align="left">
        <td colspan="7"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Wir
            danken Ihnen f&uuml;r Ihren Auftrag,</font></td>
    </tr>
    <tr align="left">
        <td colspan="7">&nbsp;</td>
    </tr>
    <tr align="left">
        <td colspan="7"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">mit
            freundlichen Gr&uuml;&szlig;en</font></td>
    </tr>
    <tr align="left">
        <td colspan="7"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">-Rheinland
            Privatschule-</font></td>
    </tr>
    <tr align="left">
        <td colspan="7">&nbsp;</td>
    </tr>
    <tr align="left">
        <td colspan="7"><%=loginUser.getUserFirstName()+" "+loginUser.getUserLastName()%></td>
    </tr>
    <tr align="left">
        <td colspan="7">&nbsp;</td>
    </tr>
    <tr align="left">
        <td colspan="7">&nbsp;</td>
    </tr>
    <tr align="left">
        <td colspan="7">&nbsp;</td>
    </tr>
    <tr align="left" valign="top">
        <td colspan="7">&nbsp; </td>
    </tr>
    <tr align="left">
        <td colspan="7" height="2"></td>
    </tr>
</table>
</body>
</html>
