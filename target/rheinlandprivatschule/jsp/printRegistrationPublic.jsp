<html>
<head>
    <title>Print Registration</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body bgcolor="#FFFFFF" text="#000000">
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.model.*" %>
<%@ page import="com.rheinlandprivatschule.repository.PlaceDao" %>
<%@ page import="com.rheinlandprivatschule.repository.StudentDao" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.rheinlandprivatschule.repository.CourseDao" %>
<%
    StudentDao studentDB= (StudentDao) request.getAttribute("studentDao");
    CourseDao courseDao= (CourseDao) request.getAttribute("courseDao");

    QRCodeInformation qrCodeInformation = (QRCodeInformation) request.getAttribute("qrCodeInformation");
    SystemUser loginUser = qrCodeInformation.getSystemUser();
    int studentId = qrCodeInformation.getStudentId();
    int courseId = qrCodeInformation.getCertificateId();

    String coursePlace="";
    ArrayList<Student> vertrags;
    int userid=0;

    Student pstudent=studentDB.getStudent(studentId, loginUser.getUserID());
    request.getSession().setAttribute("pstudent", pstudent);
    CourseRegistration cr=(CourseRegistration)session.getAttribute("cr");
    Course course= courseDao.getCourse(courseId);
    String topay=(String)session.getAttribute("ap");
    coursePlace=((new PlaceDao()).getPlace(course.getCoursePlace())).getPlaceName();
    userid=pstudent.getUserID();
    vertrags=studentDB.downloadBilder(userid,loginUser.getUserID());
    if(vertrags==null){
        vertrags=new ArrayList<Student>();
        String err=studentDB.getError();
        session.setAttribute("err",err);
        session.setAttribute("lin","../unitutor/rps/admin/map");
        response.sendRedirect("error");
    }

%>
<table width="100%" border="0" align="left">
    <tr>
        <td colspan="4">&nbsp;</td>
        <td colspan="2">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="4">&nbsp;</td>
        <td colspan="2">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="4">&nbsp;</td>
        <td colspan="2">&nbsp;</td>
    </tr>
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
        %>		 <td width="28%" rowspan="7"><div align="right"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><img src="/studentBilder/image?ver=<%=ver%>"<%=ver%> width="150" height="166"></font></div></td>

        <%
            }
        %>
    </tr>
    <tr>
        <td colspan="5">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="5">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="5">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="2"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Name
            : </font></td>
        <td colspan="2"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><%=pstudent.getUserLastName()%></font></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td colspan="2"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Vorname<font color="#FFFFFF">
        </font>:</font></td>
        <td colspan="2"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><%=pstudent.getUserFirstName()%></font></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td colspan="2"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Geburtsdatum<font color="#FFFFFF">.</font>:</font></td>
        <td colspan="2"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><%=MyDate.formateDate(pstudent.getUserBirthDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
        <td>&nbsp;</td>
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
        <td colspan="2">&nbsp;</td>
        <td colspan="2">&nbsp;</td>
        <td colspan="2">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="2" height="22" align="right">
            <div align="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Kunden-Nr.:</font></div>
        </td>
        <td align="left" height="22" colspan="2"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><%=pstudent.getUserID()%></font></td>
        <td align="right" height="22" width="6%">&nbsp;</td>
        <td align="right" height="22" width="28%"><%=MyDate.formateDate(MyDate.getCurrentSQLDate(),MyDate.ALPHANUMERIC,MyDate.DEUTSCH)%></td>
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
            <div align="center"><b><font size="6" face="Times New Roman, Times, serif">Anmeldebest&auml;tigung</font></b></div>
        </td>
    </tr>
    <tr>
        <td colspan="6" height="20">
            <div align="center"><b><font size="2">zum &quot;Intensivkurs f&uuml;r die Studienvorbereitung&quot; </font> </b> </div>
        </td>
    </tr>
    <tr>
        <td colspan="4">&nbsp;</td>
        <td align="right" colspan="2">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="6"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Hiermit
            best&auml;tigen wir, dass sich die oben genannte Person, bei uns f&uuml;r den
            folgenden Kurs verbindlich angemeldet hat.</font></td>
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
        <td width="19%" align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Kursort</font></b></td>
        <td width="8%">&nbsp;</td>
        <td colspan="3"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%=coursePlace%></font></td>
    </tr>
    <tr>
        <td width="3%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
        <td width="19%" align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Kursbeginn</font></b></td>
        <td width="8%">&nbsp;</td>
        <td colspan="3"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%=MyDate.formateDate(course.getCourseStartDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
    </tr>
    <tr>
        <td width="3%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
        <td width="19%" align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Kursende</font></b></td>
        <td width="8%">&nbsp;</td>
        <td colspan="3"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%=MyDate.formateDate(course.getCourseEndDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
    </tr>
    <tr>
        <td width="3%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
        <td width="19%" align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Gesamtumfang</font></b></td>
        <td width="8%">&nbsp;</td>
        <td colspan="3"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%=course.getCourseTotalHours()%>
            Std. </font></td>
    </tr>
    <tr>
        <td width="3%" align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
        <td width="19%" align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Wochenumfang</font></b></td>
        <td width="8%">&nbsp;</td>
        <td colspan="3"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><%=course.getCourseHours()%>
            Std. </font></td>
    </tr>
    <tr>
        <td align="right" colspan="2"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
        <td colspan="2"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
        <td colspan="2">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="6" align="left">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="6" align="left"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Wir
            danken Ihnen f&uuml;r Ihren Auftrag.</font></td>
    </tr>
    <tr>
        <td colspan="6" align="left">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="6" align="left">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="6" align="left">Mit freundlichen Gr&uuml;&szlig;en,</td>
    </tr>
    <tr>
        <td colspan="6" align="left">-Rheinland Privatschule-</td>
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
</table>
</body>
</html>
