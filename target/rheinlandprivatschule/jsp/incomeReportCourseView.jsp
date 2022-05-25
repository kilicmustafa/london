<%@ page import="com.rheinlandprivatschule.model.TeacherLohnReport" %>
<%@ page import="com.rheinlandprivatschule.model.SchoolLohnReport" %>
<%@ page import="java.sql.Date" %>
<%@ page import="com.rheinlandprivatschule.model.CourseLohnReport" %>
<%@ page import="com.rheinlandprivatschule.repository.CourseDao" %>
<%@ page import="com.rheinlandprivatschule.model.Course" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Einnahmen  ::</title>
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

    </script>
</head>
<body>
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="/balanz/expenseReport">Zurück</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width: 100%;" name="form1" method="post" action="newExpenseCat">
                            <table width="100%" height="92" border="0" cellpadding="1" cellspacing="1">
                                <tr bgcolor="657A9A">
                                    <td height="22">
                                        <div align="center"><b><font size="3" color="#FFFFFF">Einnahmen</font></b></div>
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="66" valign="top" bgcolor="#FFFFFF"><table width="100%" height="71" border="0" cellpadding="1" cellspacing="1">
                                        <tr bgcolor="657A9A">
                                            <td width="31%" height="23"><div align="left"><FONT color=#ffffff><B><FONT
                                                    size=2>Kursname</FONT></B></FONT><strong></strong></div></td>
                                            <td width="15%"><strong><font color="#FFFFFF" size="2">Stadt</font></strong></td>
                                            <td width="15%"><strong><font color="#FFFFFF" size="2">Gesamtumfang</font></strong></td>
                                            <td width="13%"><strong><font color="#FFFFFF" size="2">Kursstunden Unterricht </font></strong></td>
                                            <td width="13%"><strong><font color="#FFFFFF" size="2">Kursstunden Lehrer/in</font></strong></td>
                                            <td width="13%"><strong><font color="#FFFFFF" size="2">Einnahmen(EUR)</font></strong></td>
                                        </tr>
                                        <%
                                            SchoolLohnReport reportByCourse = (SchoolLohnReport) request.getAttribute("reportByCourse");
                                            Date firstDate = (Date) request.getAttribute("firstDate");
                                            Date lastDate = (Date) request.getAttribute("lastDate");
                                            int placeID = (int) request.getAttribute("placeID");
                                            CourseDao courseDB = (CourseDao) request.getAttribute("courseDao");
                                        %>
                                        <%
                                            double totalHours=0;
                                            double totalHoursCompleted=0;
                                            double totalHoursCompletedForTEA=0;
                                            double income=0;
                                            for(int trackBT=0;trackBT<reportByCourse.getCourseReports().size();trackBT++){
                                                CourseLohnReport courseLohnReport= reportByCourse.getCourseReports().elementAt(trackBT);
                                                double paymentReceived=courseDB.getTotalAngenomen(courseLohnReport.getCourseID());
                                                double totalHoursSC=courseDB.getCourseTotalHours(courseLohnReport.getCourseID());
                                                double totalHoursCompletedSC=courseLohnReport.getTotalHoursWorkedForCourse();
                                                Course tempCourse = courseDB.getCourse(courseLohnReport.getCourseID());
                                                if(totalHoursCompletedSC > totalHoursSC || firstDate.after(tempCourse.getCourseEndDate())){
                                                    totalHoursCompletedSC = totalHoursSC;
                                                }
                                                double totalHoursCompletedTEASC=courseLohnReport.getTotalHoursWorkedNormal();
                                                double incomeSC=(totalHoursCompletedSC*paymentReceived/totalHoursSC);
                                                totalHours+=totalHoursSC;
                                                totalHoursCompleted+=totalHoursCompletedSC;
                                                totalHoursCompletedForTEA+=totalHoursCompletedTEASC;
                                                income+=incomeSC;
                                        %>
                                        <tr bgcolor="AEBACD">
                                            <td><font color="#000033" size="2"><a href="../courses/courseReportDetail.jsp?courseid=<%=courseLohnReport.getCourseID()%>"><%=courseLohnReport.getCourseName()%></a></font></td>
                                            <td><font color="#000033" size="2"><%=courseLohnReport.getCoursePlace()%></font></td>
                                            <td><font color="#000033" size="2"><%=totalHoursSC%></font></td>
                                            <td><font color="#000033" size="2"><%=totalHoursCompletedSC%></font></td>
                                            <td><font color="#000033" size="2"><%=totalHoursCompletedTEASC%></font></td>
                                            <td><font color="#000033" size="2"><%=MyCurrency.getDisplayString(incomeSC)%></font></td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                        <tr bgcolor="AEBACD">
                                            <td><font color="#000033" size="2">&nbsp;</font></td>
                                            <td><font color="#000033" size="2">&nbsp;</font></td>
                                            <td bgcolor="AEBACD"><strong><font color="#000033" size="2"><%=totalHours%></font></strong></td>
                                            <td bgcolor="AEBACD"><strong><font color="#000033" size="2"><%=totalHoursCompleted%></font></strong></td>
                                            <td bgcolor="AEBACD"><strong><font color="#000033" size="2"><%=totalHoursCompletedForTEA%></font></strong></td>
                                            <td bgcolor="AEBACD"><strong><font color="#000033" size="2"><%=MyCurrency.getDisplayString(income)%></font></strong></td>
                                        </tr>
                                    </table>                                </td>
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
