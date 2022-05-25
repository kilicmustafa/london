<html>
<head>
    <title>:: Vertrag ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body bgcolor="#FFFFFF" text="#000000">
<%@ page import="java.util.*" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="com.rheinlandprivatschule.model.Course" %>
<%@ page import="com.rheinlandprivatschule.model.Place" %>
<%@ page import="com.rheinlandprivatschule.model.SystemUser" %>
<%
    Student pstudent=(Student)session.getAttribute("pstudent");

    //CourseRegistration cr=(CourseRegistration)session.getAttribute("cr");
    //Vector fver=(Vector)session.getAttribute("fver");
    Vector onlyfver=(Vector)session.getAttribute("onlyfver");
    Course course=(Course)session.getAttribute("course");
    Vector price=(Vector)session.getAttribute("pri");
    Place city=new Place();
    SystemUser loginUser=new SystemUser();

    //String topay=(String)session.getAttribute("ap");
    city=(Place)session.getAttribute("city");
    loginUser.setUserFirstName("Aydin");
    loginUser.setUserLastName("Öztürk");
%>
<table width="100%" border="0">
    <tr>
        <td colspan="6">&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td colspan="3">&nbsp;</td>
        <td colspan="2">&nbsp;</td>
    </tr>
    <tr>
        <td width="14%">&nbsp;</td>
        <td colspan="3">&nbsp;</td>
        <td colspan="2">&nbsp;</td>
    </tr>
    <tr>
        <td width="14%"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Name
            : </font></td>
        <td colspan="3"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><%=pstudent.getUserLastName()%></font></td>
        <td colspan="2">&nbsp;</td>
    </tr>
    <tr>
        <td width="14%"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Vorname<font color="#FFFFFF">
        </font>:</font></td>
        <td colspan="3"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><%=pstudent.getUserFirstName()%></font></td>
        <td colspan="2">&nbsp;</td>
    </tr>
    <tr>
        <td width="14%"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Geburtsdatum<font color="#FFFFFF">.</font>:</font></td>
        <td colspan="3"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><%=MyDate.formateDate(pstudent.getUserBirthDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
        <td colspan="2">&nbsp;</td>
    </tr>
    <tr>
        <td width="14%"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Geburtsort<font color="#FFFFFF">
        </font>:</font></td>
        <td colspan="3"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><%=pstudent.getUserBirthPlace()%></font></td>
        <td colspan="2">&nbsp;</td>
    </tr>
    <tr>
        <td width="14%">&nbsp;</td>
        <td colspan="3">&nbsp;</td>
        <td colspan="2">&nbsp;</td>
    </tr>
    <tr>
        <td width="14%" height="22" align="right">
            <div align="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Kunden-Nr.:</font></div>
        </td>
        <td align="left" height="22" colspan="3"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><%=pstudent.getUserID()%></font></td>
        <td align="right" height="22" width="15%">&nbsp;</td>
        <td align="right" height="22" width="23%"><%=MyDate.formateDate(MyDate.getCurrentSQLDate(),MyDate.ALPHANUMERIC,MyDate.DEUTSCH)%></td>
    </tr>
    <tr>
        <td colspan="6">
            <div align="center"><b></b></div>
        </td>
    </tr>
    <tr>
        <td colspan="4">&nbsp;</td>
        <td align="right" colspan="2">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="6">
            <div align="center"><b><font size="5">Schulungsvertrag</font></b></div>
        </td>
    </tr>
    <tr>
        <td colspan="6">
            <div align="center"><b>Deutschkurse f&uuml;r Studienbewerber aus dem Ausland</b></div>
        </td>
    </tr>
    <tr>
        <td colspan="6">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="6">
            <div align="center"><font size="2" face="Times New Roman, Times, serif">&quot;Dieser
                Vertag gilt <b>NICHT</b> zur Vorlage bei der Ausl&auml;nderbh&ouml;rde
                zwecks Visumsverl&auml;ngerung&quot;</font></div>
        </td>
    </tr>
    <tr>
        <td colspan="4">&nbsp;</td>
        <td align="right" colspan="2">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="6"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">&sect;1) Zahlung</font></b><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><br>
            Die Kursgeb&uuml;hren f&uuml;r die ersten beiden Stufen m&uuml;ssen bei der Anmeldung gezahlt werden. Die folgenden Kurse sind nach erhalten des Visums sofort f&auml;llig. Eine versp&auml;tete Zahlung kann durch eine Mahngeb&uuml;hr belastet werden. Die Kosten f&uuml;r weitere Zahlungsaufforderung durch die Rechtsabteilung hat der Kursteilnehmer zu tragen.</font> </td>
    </tr>
    <tr>
        <td colspan="6">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="6"><b><font size="2" face="Verdana, Arial, Helvetica, sans-serif">&sect;2) Zahlung / Abmeldung</font></b><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><br>
        </font><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Bei Nichterteilung eines Visums kann der Kurs gek&uuml;ndigt werden. Dabei muss der Kursteilnehmer nachweisen, dass er sich ordnungsgem&auml;&szlig; f&uuml;r ein Visum beworben hat. Dabei ist ein Sperrkonto oder eine Verpflichtungserkl&auml;rung zwingend notwendig. Nach Erteilung eines Visums sind die bereits gebuchten Kurse nicht mehr K&uuml;ndbar. </font><font size="2"> </font> </td>
    </tr>
    <tr>
        <td colspan="6">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="6"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Die
            / Der Sch&uuml;ler(in) wird in den folgende(n) Kursteil(e) eingestuft:</font></td>
    </tr>
    <tr>
        <td colspan="6">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="2" align="left">
            <div align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Kurs</font></b></div>
        </td>
        <td width="13%">
            <div align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Kursbeginn</font></b></div>
        </td>
        <td width="11%">
            <div align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Kursende</font></b></div>
        </td>
        <td width="15%">
            <div align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Schulungsort</font></b></div>
        </td>
        <td width="23%"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">
            Kursgeb&uuml;hr</font></b></td>
    </tr>
    <%

        for(int g=0;g<onlyfver.size();g++){
            Course d=(Course)onlyfver.elementAt(g);
    %>
    <tr>
        <td colspan="2" align="left">
            <div align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%=d.getCourseName()%></font></b></div>
        </td>
        <td width="13%">
            <div align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%=MyDate.formateDate(d.getCourseStartDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></div>
        </td>
        <td width="11%">
            <div align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%=MyDate.formateDate(d.getCourseEndDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></div>
        </td>
        <td width="15%">
            <div align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%=city.getPlaceName()%></font></div>
        </td>
        <td width="23%"><%=(String)price.elementAt(g)%>,-&euro;</td>
    </tr>
    <%
        }
    %>
    <tr>
        <td align="right" colspan="6"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
    </tr>
    <tr>
        <td colspan="6" align="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Die AGB's (allgemeinen Gesch&auml;ftsbedingungen) sowie die Hausordnung sind Kurs- und Vertragsbestandteil.</font></td>
    </tr>
    <tr>
        <td colspan="6" align="left">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="6" align="left">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="4" align="left">mit freundlichen Gr&uuml;&szlig;en</td>
        <td colspan="2" rowspan="2" align="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Unterschrift Kunde / Anmeldende </font><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Person</font></td>
    </tr>
    <tr>
        <td colspan="4" align="left">-Rheinland Privatschule-</td>
    </tr>
    <tr>
        <td colspan="4" align="left">&nbsp;</td>
        <td align="left">&nbsp;</td>
        <td align="left">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="4" align="left">&nbsp;</td>
        <td align="left" bordercolor="#000000">Name:</td>
        <td align="left" bordercolor="#000000">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="4" align="left">&nbsp;</td>
        <td align="left" bordercolor="#000000">Adresse:</td>
        <td align="left" bordercolor="#000000">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="4" align="left"><%=loginUser.getUserFirstName()+" "+loginUser.getUserLastName()%></td>
        <td align="left" bordercolor="#000000">Tel.:</td>
        <td align="left" bordercolor="#000000">&nbsp;</td>
    </tr>
</table>
</body>
</html>
