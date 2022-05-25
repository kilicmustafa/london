<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.model.Course" %>
<%@ page import="com.rheinlandprivatschule.model.StundenLohn" %>
<%@ page import="com.rheinlandprivatschule.repository.CourseDao" %>
<%@ page import="com.rheinlandprivatschule.repository.PlaceDao" %>
<%@ page import="com.rheinlandprivatschule.repository.StundDao" %>
<%@ page import="com.rheinlandprivatschule.repository.TeacherLohnDao" %><%@ page import="java.util.Vector"%>
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
        function back(){
            window.location="courseReportDetail?courseid="+document.form1.cid.value;
        }

    </script>
</head>
<body>
<%

    StundDao sdb= (StundDao) request.getAttribute("stundDao");
    TeacherLohnDao tldb = new TeacherLohnDao();
    PlaceDao placeDB =new PlaceDao();
    CourseDao cdb= (CourseDao) request.getAttribute("courseDao");

    Vector teacherGroupLohnList;
    Vector v=new Vector();
    Course course=new Course();

    String coursePlace="";
    String courseTime="";
    int totalH=0;
    int totalCH=0;
    double totalAB=0;

    String courseIDS= request.getParameter("courseid");

    int courseID=Integer.parseInt(courseIDS);
    if(courseID>0){
        course=cdb.getCourse(courseID);
        coursePlace=(placeDB.getPlace(course.getCoursePlace())).getPlaceName();
        if(course.getCourseTiming().equalsIgnoreCase("8:30-12:00")){
            courseTime="Vormittag";
        }else if(course.getCourseTiming().equalsIgnoreCase("12:00-18:00")){
            courseTime="Nachmittag";
        }
        v=sdb.getCourseStundenDetail(courseID);
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="back()">Zur&uuml;ck</a>

                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width: 100%;" name="form1" method="post" action="">
                            <table width="100%" border="0" cellspacing="1" cellpadding="1">
                                <input name="cid" type="hidden" id="cid" value="<%=course.getCourseID()%>">

                                <tr bgcolor="657A9A">
                                    <td><font size="2" color="#FFFFFF"><b>Kursname</b></font></td>
                                    <td bgcolor="AEBACD"><font size="2" color="#000033"><%=course.getCourseName()%></font></td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td><font size="2" color="#FFFFFF"><b>Zeit</b></font></td>
                                    <td bgcolor="AEBACD"><font size="2" color="#000033"><%=courseTime%></font></td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td><strong><font color="#FFFFFF" size="2">Stadt</font></strong></td>
                                    <td bgcolor="AEBACD"><font size="2" color="#000033"><%=coursePlace%></font></td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td><strong><font color="#FFFFFF" size="2">Anfangdatum</font></strong></td>
                                    <td bgcolor="AEBACD"><font size="2" color="#000033"><%=MyDate.formateDate(course.getCourseStartDate(),MyDate.ALPHANUMERIC,MyDate.DEUTSCH)%></font></td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td width="16%"><font size="2" color="#FFFFFF"><strong><font color="#FFFFFF" size="2">Endedatumdatum</font></strong></font></td>
                                    <td bgcolor="AEBACD"><font size="2" color="#000033"><%=MyDate.formateDate(course.getCourseEndDate(),MyDate.ALPHANUMERIC,MyDate.DEUTSCH)%></font></td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td colspan="2"><div align="center"><font size="3" color="#FFFFFF"><b>Stundenlohn</b></font></div></td>
                                </tr>
                                <tr valign="top">
                                    <td height="22" colspan="2"><table width="100%" border="0" cellpadding="1" cellspacing="1">
                                        <tr>
                                            <td width="12%" height="16" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Datum</font></b></td>
                                            <td width="13%" height="16" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Tag</font></b></td>
                                            <td width="31%" height="16" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Lehrer/in</font></b></td>
                                            <td width="10%" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Stundenlohn</font></strong></td>
                                            <td width="10%" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Kursstunden</font></strong></td>
                                            <td width="12%" height="16" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Lehrerstunden</font></b><b></b><b></b><b></b></td>
                                            <td width="12%" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Auszahlung</font></strong></td>
                                        </tr>
                                        <%
                                            for(int i=0;i<v.size();i++)
                                            {
                                                StundenLohn sl=(StundenLohn)v.elementAt(i);
                                                if((!sl.getDay().equalsIgnoreCase("Samstag")) && (!sl.getDay().equalsIgnoreCase("Sonntag")))
                                                {
                                                    teacherGroupLohnList = tldb.getAllTeacherLohn(sl.getTeacherID(),tldb.GROUPLOHN);
                                                    double specificDateLohn = tldb.getTeacherLohnForSpecificDate(teacherGroupLohnList,sl.getStundenDate());
                                                    double specificBetrag = specificDateLohn*sl.getTeacherStunden();
                                                    totalH=totalH+sl.getTeacherStunden();
                                                    totalCH=totalCH+sl.getStunden();
                                                    totalAB=totalAB+specificBetrag;
                                        %>
                                        <tr bgcolor="AEBACD">
                                            <td width="12%" height="16"><font size="2" color="#000033"><%=MyDate.formateDate(sl.getStundenDate(),MyDate.ALPHANUMERIC,MyDate.DEUTSCH)%></font></td>
                                            <td width="13%" height="16"><font size="2" color="#000033"><%=sl.getDay()%></font></td>
                                            <td width="31%" height="16"><font size="2" color="#000033"><%=sl.getCourseCity()%></font></td>
                                            <td width="10%" height="16"><font size="2" color="#000033"><%=MyCurrency.getDisplayString(specificDateLohn)%></font></td>
                                            <td width="10%" height="16"><font size="2" color="#000033"><%=sl.getStunden()%></font></td>
                                            <td width="12%" height="16"><font size="2" color="#000033"><%=sl.getTeacherStunden()%></font></td>
                                            <td width="12%" height="16"><font size="2" color="#000033"><%=MyCurrency.getDisplayString(specificBetrag)%></font></td>
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
                                            <td ><strong><font color="#FFFFFF" size="2"><%=totalCH%></font></strong></td>
                                            <td ><strong><font color="#FFFFFF" size="2"><%=totalH%></font></strong></td>
                                            <td ><strong><font color="#FFFFFF" size="2"><%=MyCurrency.getDisplayString(totalAB)%></font></strong></td>
                                        </tr>
                                    </table></td>
                                </tr>
                                <tr valign="top">
                                    <td height="21" colspan="2"><table width="100%" border="0" cellpadding="1" cellspacing="1">
                                        <tr>
                                            <td colspan="2" bgcolor="657A9A"><div align="center"><font size="3" color="#FFFFFF"><b>Gesamt Stunden Lohn</b></font></div></td>
                                        </tr>
                                        <tr>
                                            <td width="19%" bgcolor="657A9A"><font size="2" color="#FFFFFF"><b><font size="3">Gesamtlehrerstunden</font></b></font></td>
                                            <td width="81%" bgcolor="AEBACD"><font size="3" color="#000033"><%=totalH%></font></td>
                                        </tr>
                                        <tr>
                                            <td width="19%" bgcolor="657A9A"><font size="2" color="#FFFFFF"><b><font size="3">Auszahlungsbetrag</font></b></font></td>
                                            <td width="81%" bgcolor="AEBACD"><font size="3" color="#000033"><%=MyCurrency.getDisplayString(totalAB)%></font></td>
                                        </tr>
                                    </table></td>
                                </tr>
                            </table>
                        </form>
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
