<%@ page import="com.rheinlandprivatschule.repository.StudentDao" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="com.rheinlandprivatschule.model.*" %>
<%@ page import="com.rheinlandprivatschule.repository.CourseDao" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<html>
<head>
    <title>Print Mahnung</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%
    StudentDao sdb= (StudentDao) request.getAttribute("studentDao");
    CourseDao cdb = (CourseDao) request.getAttribute("courseDao");
    RPS rps=(RPS)session.getAttribute("handler");
    if(rps==null){
        String err="Sitzung lief Ab";
        session.setAttribute("err",err);
        session.setAttribute("lin","../index.jsp");
        response.sendRedirect("error.jsp");
    }else{
        session.setAttribute("handler",rps);
    }
    String add1="";
    String add2="";
    String add3="";
    String add4="";
    String add5="";
    String add6="";

    Place city=rps.getLoginPlace();
    String pcode=city.getPlacePostCode()+" "+city.getPlaceCity();

    MahnungElement me=(MahnungElement)session.getAttribute("mahnung");
    Mahnung mahnid=(Mahnung)session.getAttribute("mahnid");

    java.util.Calendar gc=new java.util.GregorianCalendar();
    gc.setTime(mahnid.getMahnngDate());
    gc.add(gc.DATE,14);
    java.sql.Date tempdate=new java.sql.Date(gc.getTime().getTime());

    Student pstudent=sdb.getStudentForSubProcess(me.getUserID());
    Course cour= cdb.getCourse(me.getCourseID());

    double fee=mahnid.getBalance();
    double total=mahnid.getBalance()+7.50;
    String schname="";
    int gender=pstudent.getUserGender();
    if(gender==0){
        schname="Herr"+" "+pstudent.getUserFirstName()+" "+pstudent.getUserLastName();
    }else{
        schname="Frau"+" "+pstudent.getUserFirstName()+" "+pstudent.getUserLastName();
    }
    String co=pstudent.getUserCO();
    if(pstudent.getUserCO()==null){
        add1=pstudent.getUserFirstName()+" "+pstudent.getUserLastName();
        add2=pstudent.getUserAddress();
        add3="";
        add4=pstudent.getUserPostCode()+" "+pstudent.getUserCity();
        add5="";
        add6="";
    }else{
        add1=pstudent.getUserFirstName()+" "+pstudent.getUserLastName();
        add2="c/o: "+co;
        add3=pstudent.getUserAddress();
        add4="";
        add5=pstudent.getUserPostCode()+" "+pstudent.getUserCity();
        add6="";
    }
%>
<table width="100%" border="0" height="822">
    <tr>
        <td height="22" width="14%" rowspan="4">&nbsp;</td>
        <td height="22" colspan="3" valign="top" rowspan="4"><b><font face="Times New Roman, Times, serif" color="#FFFFFF">
        </font><font face="Times New Roman, Times, serif">&nbsp;&nbsp;</font></b><br>
        </td>
        <td width="4%" height="22" rowspan="4">&nbsp;</td>
        <td width="48%" height="10">
            <div align="right"><b><font face="Times New Roman, Times, serif">R</font></b><font face="Times New Roman, Times, serif">heinland</font><b><font face="Times New Roman, Times, serif">
                P</font></b><font face="Times New Roman, Times, serif">rivatschule</font></div>
        </td>
    </tr>
    <tr>
        <td width="48%" height="10">
            <div align="right"><font size="2"><%=city.getPlaceAddress()%></font></div>
        </td>
    </tr>
    <tr>
        <td width="48%" height="22">
            <div align="right"><font size="2"><%=pcode%></font></div>
        </td>
    </tr>
    <tr>
        <td width="48%" height="22">
            <div align="right"><font size="2">Fon: <%=city.getPlaceTelephone()%></font></div>
        </td>
    </tr>
    <tr>
        <td colspan="2">&nbsp;</td>
        <td width="2%">&nbsp;</td>
        <td width="6%">&nbsp;</td>
        <td width="4%">&nbsp;</td>
        <td width="48%">
            <div align="right"><font size="2">Fax: <%=city.getPlaceFax()%></font></div>
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
        <td colspan="6" height="16"><%=add5%></td>
    </tr>
    <tr>
        <td colspan="6" height="16"><%=add6%></td>
    </tr>
    <tr>
        <td colspan="5"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Mahnung-Nr
            :</font> <%=mahnid.getMahnungID()%></td>
        <td width="48%" align="right"><%=MyDate.formateDate(mahnid.getMahnngDate(),MyDate.ALPHANUMERIC,MyDate.DEUTSCH)%></td>
    </tr>
    <tr>
        <td colspan="5">&nbsp;</td>
        <td width="48%" align="right">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="6" align="left">Forderung: Kursgeb&uuml;hr Rheinland Privatschule
            / <%=schname%></td>
    </tr>
    <tr>
        <td colspan="6" align="left">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="6" align="left">Sehr geehrte <%=schname%>,</td>
    </tr>
    <tr>
        <td colspan="6" align="left">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="6" align="left">seit der ersten Woche des Kurses <%=cour.getCourseName()%> befinden Sie sich mit der Zahlung der <br>
            Kursgeb&uuml;hr in unten genannter H&ouml;he in Verzug.<br>
            In Ihrem eigenen Interesse und um Ihnen weitere anfallende Kosten zu ersparen,
            wenden wir uns heute<br>
            an Sie mit der Aufforderung, folgende Betr&auml;ge </td>
    </tr>
    <tr>
        <td colspan="6" align="left">
            <div align="center"><b>bis sp&auml;testens zum <%=MyDate.getDay(tempdate)%>. <%=MyDate.getMonth(tempdate)%>  <%=MyDate.getYear(tempdate)%> zu &uuml;berweisen</b></div>
        </td>
    </tr>
    <tr>
        <td colspan="6" align="left"><b>Derzeitige Forderung</b></td>
    </tr>
    <tr align="left">
        <td>Hauptforderung </td>
        <td>&nbsp;</td>
        <td colspan="4"><%=fee%>,- EUR</td>
    </tr>
    <tr align="left">
        <td height="8">Mahngeb&uuml;hren </td>
        <td height="8">&nbsp;</td>
        <td colspan="4" height="8">7,50 EUR</td>
    </tr>
    <tr align="left">
        <td colspan="6" height="14">-----------------------------------------------------------------------------</td>
    </tr>
    <tr align="left">
        <td><b>Gesamt:</b></td>
        <td>&nbsp;</td>
        <td colspan="4"> <b><%=total%> EUR</b></td>
    </tr>
    <tr align="left">
        <td colspan="6">&nbsp;</td>
    </tr>
    <tr align="left">
        <td colspan="6">F&uuml;r den Fall nicht rechtzeitiger Zahlung k&uuml;ndigen
            wir bereits jetzt die sofortige gerichtliche <br>
            Durchsetzung des Anspruches an. Die dadurch entstehenden Kosten in nicht
            unerheblicher H&ouml;he<br>
            werden Sie dann zus&auml;tzlich zu tragen haben. <br>
            Wir weisen jetzt darauf hin, dass gegebenenfalls eine Meldung an die zust&auml;ndige
            Ausl&auml;nderbeh&ouml;rde <br>
            durch uns get&auml;tigt wird. </td>
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
        <td colspan="6"><font face="Times New Roman, Times, serif" color="#000000"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Dipl.
            -Ing. Frank Schwarz</font></font></td>
    </tr>
    <tr align="left">
        <td colspan="6">&nbsp;</td>
    </tr>
    <tr align="left">
        <td colspan="6" height="2"></td>
    </tr>
</table>
</body>
</html>
