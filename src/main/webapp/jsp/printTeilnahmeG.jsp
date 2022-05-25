<html>
<head>
    <title>Print Registration</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body bgcolor="#FFFFFF" text="#000000">
<%@ page import="java.util.*" %>
<%@ page import="com.rheinlandprivatschule.repository.StundDao" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="com.rheinlandprivatschule.model.SystemUser" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="com.rheinlandprivatschule.model.CourseRegistration" %>
<%@ page import="com.rheinlandprivatschule.model.Course" %>
<%@ page import="com.rheinlandprivatschule.repository.StudentDao" %>
<%@ page import="com.rheinlandprivatschule.repository.PlaceDao" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%
    StundDao sdb=new StundDao();

    String coursePlace="";
    String status="";
    String abschluss="";
//Date date ="";
//Date currentdate ="";
    int date1=0;
    int currentdate1=0;
    int completedHours=0;
    RPS rps=(RPS)session.getAttribute("handler");
    SystemUser loginUser=rps.getLoginUser();

    Student pstudent=(Student)session.getAttribute("pstudent");
    CourseRegistration cr=(CourseRegistration)session.getAttribute("cr");
    Course course=(Course)session.getAttribute("course");
    StudentDao studentDB= (StudentDao) request.getAttribute("studentDao");

    int userid=pstudent.getUserID();
    ArrayList<Student> vertrags=studentDB.downloadBilder(userid,rps.getLoginUser().getUserID());

    String topay=(String)session.getAttribute("ap");
    coursePlace=((new PlaceDao()).getPlace(course.getCoursePlace())).getPlaceName();
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
        %>		 <td width="28%" rowspan="7"><div align="right"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><img src="/studentBilder/image"<%=ver%> width="150" height="166"></font></div></td>

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
        <td colspan="6"><div align="left"><b><font size="4">Hiermit bescheinigen wir, dass
            <%=pstudent.getUserLastName()%>, <%=pstudent.getUserFirstName()%> (Name, Vorname)
            geboren am <%=MyDate.formateDate(pstudent.getUserBirthDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%>
            in <%=pstudent.getUserBirthPlace()%> in unserem Institut an folgendem Kurs mit den jeweiligen Fächern und Unterrichtsstunden teilgenommen hat.</font></b></div>
        </td>
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
        <td align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Geschichte</font></b></font></b></td>
        <td>&nbsp;</td>
        <td colspan="3"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 200 Std. </font></td>
    </tr>

    <tr>
        <td align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
        <td align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Literatur</font></b></font></b></td>
        <td>&nbsp;</td>
        <td colspan="3"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 180 Std. </font></td>
    </tr>
    <tr>
        <td align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
        <td align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Sozialkunde</font></b></font></b></td>
        <td>&nbsp;</td>
        <td colspan="3"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 140 Std. </font></td>
    </tr>
    <tr>
        <td align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
        <td align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Politik</font></b></font></b></td>
        <td>&nbsp;</td>
        <td colspan="3"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 80 Std. </font></td>
    </tr>
    <tr>
        <td align="left"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></td>
        <td align="left"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Deutsch</font></b></font></b></td>
        <td>&nbsp;</td>
        <td colspan="3"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"> 200 Std. </font></td>
    </tr>

    <tr>
        <td colspan="6" align="left">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="6"><div align="left"><b><font size="4">Die Rheinland Privatschule
            führt seit 2012 erfolgreich Studienkollegs für die Fachrichtungen M, T, W und G durch.</font></b></div>
        </td>
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
