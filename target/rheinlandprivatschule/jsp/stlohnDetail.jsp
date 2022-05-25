<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.repository.*" %>
<%@ page import="com.rheinlandprivatschule.model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Stundenlohn ::</title>
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

        function changeCity()
        {
            document.form2.submit()
        }

    </script>
</head>
<body>
<%

    StundDao sdb= (StundDao) request.getAttribute("stundDao");
    SystemUserDao systemUserDao = (SystemUserDao) request.getAttribute("systemUserDao");
    PlaceDao placeDB = (PlaceDao) request.getAttribute("placeDao");

    StudentDao studentDB=new StudentDao();
    TeacherLohnDao tldb = new TeacherLohnDao();
    SingleClassDao scdb=new SingleClassDao();

    String monS="";
    String yeaS="";
    String teaS="";


    Vector teacherPrivateLohnList=new Vector();
    Vector teacherGroupLohnList=new Vector();
    Vector v=new Vector();
    Vector v1=new Vector();
    SystemUser u=new SystemUser();
    double lohn=0.0;
    String strLohn="0,0";
    int totalH=0;
    int totalEH=0;
    double totalAB=0;
    double totalEAB=0;

    monS=(String)request.getParameter("selSMonth");
    yeaS=(String)request.getParameter("selSYear");
    teaS=(String)request.getParameter("tea");


    java.sql.Date d1=MyDate.getFirstMonthDate(monS,yeaS,MyDate.DEUTSCH);
    java.sql.Date d2=MyDate.getLastMonthDate(monS,yeaS, MyDate.DEUTSCH);

    int tea=Integer.parseInt(teaS);
    if(tea>0){
        v=sdb.getStundenLohn(d1,d2,tea);
        v1=scdb.getSCForTeacherAndMonth(tea,d1,d2);
        u=systemUserDao.getSystemUser(tea);
        lohn=u.getUserStundenLohn();
        strLohn= MyCurrency.getDisplayString(lohn);
        teacherPrivateLohnList = tldb.getAllTeacherLohn(tea,tldb.PRIVATELOHN);
        teacherGroupLohnList = tldb.getAllTeacherLohn(tea,tldb.GROUPLOHN);
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
                        <table width="100%" border="0" cellspacing="1" cellpadding="1">
                            <tr bgcolor="657A9A">
                                <td width="16%"><font size="2" color="#FFFFFF"><b>Lehrer/in Name</b></font></td>
                                <td bgcolor="AEBACD"><font size="2" color="#000033"><%=u.getUserFirstName()+" "+u.getUserLastName()%></font></td>
                            </tr>
                            <tr bgcolor="657A9A">
                                <td colspan="2">
                                    <div align="center"><font size="3" color="#FFFFFF"><b>Stundenlohn</b></font></div>
                                </td>
                            </tr>
                            <tr valign="top">
                                <td height="22" colspan="2"><table width="100%" border="0" cellpadding="1" cellspacing="1">
                                    <tr>
                                        <td width="11%" height="16" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Datum</font></b></td>
                                        <td width="10%" height="16" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Tag</font></b></td>
                                        <td width="27%" height="16" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Gruppe</font></b></td>
                                        <td width="10%" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Stadt</font></strong></td>
                                        <td width="10%" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Stundenlohn</font></strong></td>
                                        <td width="9%" height="16" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Stunden</font></b><b></b><b></b><b></b></td>
                                        <td width="11%" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Auszahlung</font></strong></td>
                                        <td width="12%" height="16" bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>Zeit</b></font></td>
                                    </tr>
                                    <%
                                        CourseDao cdb=new CourseDao();
                                        for(int i=0;i<v.size();i++)
                                        {
                                            StundenLohn sl=(StundenLohn)v.elementAt(i);
                                            String tempTime="";
                                            if((!sl.getDay().equalsIgnoreCase("Samstag")) && (!sl.getDay().equalsIgnoreCase("Sonntag")))
                                            {
                                                Course cov=cdb.getCourse(sl.getCourseID());
                                                double specificDateLohn = tldb.getTeacherLohnForSpecificDate(teacherGroupLohnList,sl.getStundenDate());
                                                double specificBetrag = specificDateLohn*sl.getTeacherStunden();
                                                totalH=totalH+sl.getTeacherStunden();
                                                totalAB=totalAB+specificBetrag;
                                                if(cov.getCourseTiming().equalsIgnoreCase("8:30-12:00")){
                                                    tempTime="Vormittag";
                                                }else if(cov.getCourseTiming().equalsIgnoreCase("12:00-18:00")){
                                                    tempTime="Nachmittag";
                                                }
                                    %>
                                    <tr bgcolor="AEBACD">
                                        <td width="11%" height="16"><font size="2" color="#000033"><%=MyDate.formateDate(sl.getStundenDate(),MyDate.ALPHANUMERIC,MyDate.DEUTSCH)%></font></td>
                                        <td width="10%" height="16"><font size="2" color="#000033"><%=sl.getDay()%></font></td>
                                        <td width="27%" height="16"><font size="2" color="#000033"><%=sl.getCourseName()%></font></td>
                                        <td width="10%" height="16"><font size="2" color="#000033"><%=sl.getCourseCity()%></font></td>
                                        <td width="10%" height="16"><font size="2" color="#000033"><%=MyCurrency.getDisplayString(specificDateLohn)%></font></td>
                                        <td width="9%" height="16"><font size="2" color="#000033"><%=sl.getTeacherStunden()%></font></td>
                                        <td width="11%" height="16"><font size="2" color="#000033"><%=MyCurrency.getDisplayString(specificBetrag)%></font></td>
                                        <td width="12%" height="16"><font size="2" color="#000033"><%=tempTime%></font></td>
                                    </tr>
                                    <%

                                            }
                                        }
                                    %>
                                    <tr bgcolor="657A9A">
                                        <td height="16" >&nbsp;</td>
                                        <td >&nbsp;</td>
                                        <td >&nbsp;</td>
                                        <td >&nbsp;</td>
                                        <td >&nbsp;</td>
                                        <td ><strong><font color="#FFFFFF" size="2"><%=totalH%></font></strong></td>
                                        <td ><strong><font color="#FFFFFF" size="2"><%=MyCurrency.getDisplayString(totalAB)%></font></strong></td>
                                        <td >&nbsp;</td>
                                    </tr>
                                </table></td>
                            </tr>
                            <tr valign="top" bgcolor="657A9A">
                                <td height="22" colspan="2">
                                    <div align="center"><font size="3" color="#FFFFFF"><b>Einzelunterricht</b></font>
                                    </div>
                                </td>
                            </tr>
                            <tr valign="top">
                                <td height="22" colspan="2">
                                    <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                        <tr>
                                            <td width="11%" height="16" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Datum</font></b></td>
                                            <td width="15%" height="16" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Name</font></b></td>
                                            <td width="22%" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Sch&uuml;lername</font></strong></td>
                                            <td width="10%" height="16" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Stadt</font></strong></td>
                                            <td width="10%" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Stundenlohn</font></strong></td>
                                            <td height="16" bgcolor="657A9A" width="9%"><b><font size="2" color="#FFFFFF">Stunden</font></b><b></b><b></b><b></b></td>
                                            <td height="16" bgcolor="657A9A" width="11%"><strong><font color="#FFFFFF" size="2">Auszahlung</font></strong></td>
                                            <td bgcolor="657A9A" width="12%">&nbsp;</td>
                                        </tr>
                                        <%

                                            for(int i=0;i<v1.size();i++)
                                            {
                                                SingleClass sc=(SingleClass)v1.elementAt(i);
                                                double specificDateLohn = tldb.getTeacherLohnForSpecificDate(teacherPrivateLohnList,sc.getCLassDate());
                                                double specificBetrag = specificDateLohn*sc.getClassTime();
                                                totalEAB=totalEAB+specificBetrag;
                                                totalEH=totalEH+sc.getClassTime();
                                                String placeName = placeDB.getPlace(sc.getPlaceID()).getPlaceName();
                                                Student student=studentDB.getStudentForSubProcess(sc.getStudentID());
                                                String studentName=student.getUserFirstName()+" "+student.getUserLastName();

                                        %>
                                        <tr>
                                            <td width="11%" bgcolor="AEBACD" height="16"><font size="2" color="#000033"><%=MyDate.formateDate(sc.getCLassDate(),MyDate.ALPHANUMERIC,MyDate.DEUTSCH)%></font></td>
                                            <td width="15%" height="16" bgcolor="AEBACD"><font size="2" color="#000033"><%=sc.getCourseName()%></font></td>
                                            <td width="22%" height="16" bgcolor="AEBACD"><font size="2" color="#000033"><%=studentName%></font></td>
                                            <td bgcolor="AEBACD"><font size="2" color="#000033"><%=placeName%></font></td>
                                            <td bgcolor="AEBACD"><font size="2" color="#000033"><%=specificDateLohn%></font></td>
                                            <td bgcolor="AEBACD" height="16"><font size="2" color="#000033"><%=sc.getClassTime()%></font></td>
                                            <td bgcolor="AEBACD" height="16"><font size="2" color="#000033"><%=specificBetrag%></font></td>
                                            <td bgcolor="AEBACD" height="16">&nbsp;</td>
                                        </tr>
                                        <%


                                            }
                                        %>
                                        <tr bgcolor="AEBACD">
                                            <td bgcolor="657A9A">&nbsp;</td>
                                            <td colspan="2" bgcolor="657A9A">&nbsp;</td>
                                            <td bgcolor="657A9A">&nbsp;</td>
                                            <td bgcolor="657A9A">&nbsp;</td>
                                            <td bgcolor="657A9A"><strong><font color="#FFFFFF" size="2"><%=totalEH%></font></strong></td>
                                            <td bgcolor="657A9A"><strong><font color="#FFFFFF" size="2"><%=MyCurrency.getDisplayString(totalEAB)%></font></strong></td>
                                            <td bgcolor="657A9A">&nbsp;</td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr valign="top">
                                <td height="22" colspan="2"><table width="100%" border="0" cellpadding="1" cellspacing="1">
                                    <tr>
                                        <td colspan="2">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" bgcolor="657A9A"><div align="center"><font size="3" color="#FFFFFF"><b>Gesamt Stunden Lohn</b></font></div></td>
                                    </tr>
                                    <tr>
                                        <td width="21%" bgcolor="657A9A"><font size="2" color="#FFFFFF"><b><font size="3">Gesamtstunden</font></b></font></td>
                                        <td width="79%" bgcolor="AEBACD"><font size="3" color="#000033"><%=totalH+totalEH%></font></td>
                                    </tr>
                                    <tr>
                                        <td width="21%" bgcolor="657A9A"><font size="2" color="#FFFFFF"><b><font size="3">Auszahlungsbetrag</font></b></font></td>
                                        <td width="79%" bgcolor="AEBACD"><font size="3" color="#000033"><%=MyCurrency.getDisplayString(totalAB+totalEAB)%></font></td>
                                    </tr>
                                </table>
                                </td>
                            </tr>
                        </table>
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
