<html>
<head>
    <title>Print Registration</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body bgcolor="#FFFFFF" text="#000000">
<%@ page import="java.util.*" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.repository.*" %>
<%@ page import="com.rheinlandprivatschule.model.*" %>
<%
    StudentDao studentDB= (StudentDao) request.getAttribute("studentDao");
    CourseDao courseDao= (CourseDao) request.getAttribute("courseDao");

    QRCodeInformation qrCodeInformation = (QRCodeInformation) request.getAttribute("qrCodeInformation");
    SystemUser loginUser = qrCodeInformation.getSystemUser();
    int studentId = qrCodeInformation.getStudentId();
    int courseId = qrCodeInformation.getCertificateId();
    StundDao sdb=new StundDao();

    int userid=0;
    String status="";
    String abschluss="";
    int completedHours=0;

    Student pstudent=studentDB.getStudent(studentId, loginUser.getUserID());
    request.getSession().setAttribute("pstudent", pstudent);
    Course course=courseDao.getCourse(courseId);

    userid=pstudent.getUserID();
    ArrayList vertrags=studentDB.downloadBilder(userid,loginUser.getUserID());

    Date date = course.getCourseEndDate();
    Date currentdate = MyDate.getCurrentSQLDate();

    if(currentdate.before(date)){
        abschluss = "noch nicht geschrieben";
        status = "noch nicht zu bewerten";
        completedHours=sdb.getTotalStundenTillDate(course.getCourseID(),MyDate.getCurrentSQLDate());
    }
    else {
        abschluss = "";
        status ="";
        completedHours=Integer.parseInt(course.getCourseTotalHours());
    }

%>
<table width="100%" border="0" align="left">
    <tr>
        <td colspan="4">&nbsp;</td>
        <td colspan="2">&nbsp;</td>
    </tr>
    <tr>
        <td height="26" colspan="5">&nbsp;</td>
        <%

            for(int i=0;i<vertrags.size();i++){
                Student pp=(Student)vertrags.get(i);

//Iterator vertragsIT=vertrags.iterator();
//while(vertragsIT.hasNext()){
                String ver=pp.getBildName();
//
        %>		 <td width="28%" rowspan="7"><div align="right"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><img src="/studentBilder/image?ver=<%=ver%>" width="150" height="166"></font></div></td>

        <%
            }
        %>
    </tr>
    <tr>
        <td colspan="6">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="6">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="6">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="6">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="6">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="6">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="6">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="2"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Name
            : </font></td>
        <td colspan="2"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><%=pstudent.getUserLastName()%></font></td>
        <td colspan="2">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="2"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Vorname<font color="#FFFFFF">
        </font>:</font></td>
        <td colspan="2"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><%=pstudent.getUserFirstName()%></font></td>
        <td colspan="2">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="2"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Geburtsdatum<font color="#FFFFFF">.</font>:</font></td>
        <td colspan="2"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><%=MyDate.formateDate(pstudent.getUserBirthDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
        <td colspan="2">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="2"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Geburtsort<font color="#FFFFFF">
        </font>:</font></td>
        <td colspan="2"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><%=pstudent.getUserBirthPlace()%></font></td>
        <td colspan="2">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="2">&nbsp;</td>
        <td colspan="2">&nbsp;</td>
        <td colspan="2">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="2" height="22" align="right">
            <div align="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Kunden-Nr.:</font></div>
        </td>
        <td align="left" height="22" colspan="2"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><%=pstudent.getUserID()%></font></td>
        <td align="right" height="22" width="1%">&nbsp;</td>
        <td align="right" height="22" width="33%"><%=MyDate.formateDate(MyDate.getCurrentSQLDate(),MyDate.ALPHANUMERIC,MyDate.DEUTSCH)%></td>
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
            <div align="center"><b><font size="6" face="Times New Roman, Times, serif">Teilnahmebescheinigung</font></b></div>
            <div align="center"><b><font size="4" face="Times New Roman, Times, serif">F&uuml;r Studienbewerber aus dem Ausland</font></b></div>
        </td>
    </tr>
    <tr>
        <td colspan="6" height="20">
            <div align="center"><b> </b> </div>
        </td>
    </tr>
    <tr>
        <td colspan="4">&nbsp;</td>
        <td align="right" colspan="2">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="6"><div align="center"><b><font size="4">Hiermit bescheinigen wir, dass der oben genannte Sch&uuml;ler
            an folgenden Kursen an unserem Institut teilgenommen hat.</font></b></div></td>
    </tr>
    <tr>
        <td colspan="6">&nbsp;</td>
    </tr>
    <tr>
        <td align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
        <td align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Kurs</font></b></td>
        <td>&nbsp;</td>
        <td colspan="3"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%=course.getCourseName()%></font></b></td>
    </tr>
    <tr>
        <td width="3%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
        <td width="27%" align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Kursbeginn</font></b></td>
        <td width="2%">&nbsp;</td>
        <td colspan="3"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%=MyDate.formateDate(course.getCourseStartDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
    </tr>
    <tr>
        <td width="3%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
        <td width="27%" align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Kursende</font></b></td>
        <td width="2%">&nbsp;</td>
        <td colspan="3"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%=MyDate.formateDate(course.getCourseEndDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
    </tr>
    <tr>
        <td width="3%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
        <td width="27%" align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Wochenumfang</font></b></td>
        <td width="2%">&nbsp;</td>
        <td colspan="3"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%=course.getCourseHours()%>
            Std. </font></td>
    </tr>
    <tr>
        <td align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
        <td align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Gesamtunterricht</font></b></font></b></td>
        <td>&nbsp;</td>
        <td colspan="3"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"> <%=course.getCourseTotalHours()%> Std. </font></td>
    </tr>
    <tr>
        <td width="3%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
        <td width="27%" align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>Bis heute</b></font></b></td>
        <td width="2%">&nbsp;</td>
        <td colspan="3"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">
            <%=completedHours%> Std. </font></td>
    </tr>
    <tr>
        <td width="3%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
        <td width="27%" align="left">&nbsp;</td>
        <td width="2%">&nbsp;</td>
        <td colspan="3">&nbsp;</td>
    </tr>
    <tr>
        <td width="3%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
        <td width="27%" align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2"> <strong> Davon besuchte Stunden</strong> </font></b></font></b></td>
        <td width="2%">&nbsp;</td>
        <td colspan="3"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">
            regelm&auml;&szlig;ig </font></td>
    </tr>
    <tr>
        <td width="3%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
        <td width="27%" align="left">&nbsp;</td>
        <td width="2%">&nbsp;</td>
        <td colspan="3">&nbsp;</td>
    </tr>
    <tr>
        <td width="3%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
        <td width="27%" align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2"> <strong>    <strong> Abschlusstest</strong> </strong> </font></b></font></b></td>
        <td width="2%">&nbsp;</td>
        <td colspan="3"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">
            <%=abschluss%></font></td>
    </tr>
    <tr>
        <td width="3%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
        <td width="27%" align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2"> <strong>    <strong> Gesamtleistung</strong> </strong> </font></b></font></b></td>
        <td width="2%">&nbsp;</td>
        <td colspan="3"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">
            <%=status%></font></td>
    </tr>
    <tr>
        <td align="right" colspan="2"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b></b></font></td>
        <td colspan="2"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
        <td colspan="2">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="6" align="left">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="6" align="left">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="6" align="left">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="6" align="left"><%=loginUser.getUserFirstName()+" "+loginUser.getUserLastName()%></td>
    </tr>
    <tr>
        <td colspan="6" align="left">-Rheinland Privatschule


            - / Schulleitung</td>
    </tr>
    <tr>
        <td colspan="6" align="left">&nbsp;</td>
    </tr>
</table>
</body>
</html>
