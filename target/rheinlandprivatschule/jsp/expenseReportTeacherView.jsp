<%@ page import="com.rheinlandprivatschule.model.TeacherLohnReport" %>
<%@ page import="com.rheinlandprivatschule.model.SchoolLohnReport" %>
<%@ page import="java.sql.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: L&ouml;hne Ausrechnen  ::</title>
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
                            <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                <tr bgcolor="657A9A">
                                    <td height="22">
                                        <div align="center"><b><font size="3" color="#FFFFFF"><b>L&ouml;hne Ausrechnen </b></font></b></div>
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="66" valign="top" bgcolor="#FFFFFF"><table width="100%" height="65" border="0" cellpadding="1" cellspacing="1">
                                        <tr bgcolor="657A9A">
                                            <td width="38%"><strong><font color="#FFFFFF" size="2">Lehrer/in</font></strong><strong></strong></td>
                                            <td width="15%"><strong><font color="#FFFFFF" size="2">Kursestunden</font></strong></td>
                                            <td width="14%"><strong><font color="#FFFFFF" size="2">Privatstunden</font></strong></td>
                                            <td width="13%"><strong><font color="#FFFFFF" size="2">Gesamtstunden</font></strong></td>
                                            <td width="20%"><strong><font color="#FFFFFF" size="2">Auszahlungsbetrag (EUR) </font></strong></td>
                                        </tr>
                                        <%
                                            SchoolLohnReport reportByTeacher = (SchoolLohnReport) request.getAttribute("reportByTeacher");
                                            Date firstDate = (Date) request.getAttribute("firstDate");
                                            Date lastDate = (Date) request.getAttribute("lastDate");
                                            int placeID = (Integer) request.getAttribute("placeID");
                                        %>
                                        <%
                                            int totalNormalHoursBT=0;
                                            int totalPrivateHoursBT=0;
                                            int totalHoursBT=0;
                                            double totalPayableBT=0;
                                            for(int trackBT=0;trackBT<reportByTeacher.getTeacherReports().size();trackBT++){
                                                TeacherLohnReport teacherLohnReport= reportByTeacher.getTeacherReports().elementAt(trackBT);
                                                totalNormalHoursBT+=teacherLohnReport.getTotalHoursWorkedNormal();
                                                totalPrivateHoursBT+=teacherLohnReport.getTotalHoursWorkedPrivate();
                                                totalHoursBT=totalNormalHoursBT+totalPrivateHoursBT;
                                                totalPayableBT+=teacherLohnReport.getAmountPayable();
                                        %>
                                        <tr bgcolor="AEBACD">
                                            <td><font color="#000033" size="2"><a href="stlohnDetail.jsp?placeID=<%=placeID%>&firstDate=<%=firstDate%>&lastDate=<%=lastDate%>&teacherID=<%=teacherLohnReport.getTeacherID()%>"><%=teacherLohnReport.getTeacherName()%></a></font></td>
                                            <td><font color="#000033" size="2"><%=teacherLohnReport.getTotalHoursWorkedNormal()%></font></td>
                                            <td><font color="#000033" size="2"><%=teacherLohnReport.getTotalHoursWorkedPrivate()%></font></td>
                                            <td><font color="#000033" size="2"><%=teacherLohnReport.getTotalHoursWorkedNormal()+teacherLohnReport.getTotalHoursWorkedPrivate()%></font></td>
                                            <td><font color="#000033" size="2"><%=teacherLohnReport.getAmountPayable()%></font></td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                        <tr bgcolor="AEBACD">
                                            <td><font color="#000033" size="2">&nbsp;</font><font color="#000033" size="2">&nbsp;</font></td>
                                            <td bgcolor="AEBACD"><strong><font color="#000033" size="2"><%=totalNormalHoursBT%></font></strong></td>
                                            <td bgcolor="AEBACD"><strong><font color="#000033" size="2"><%=totalPrivateHoursBT%></font></strong></td>
                                            <td bgcolor="AEBACD"><strong><font color="#000033" size="2"><%=totalHoursBT%></font></strong></td>
                                            <td><strong><font color="#000033" size="2"><%=totalPayableBT%></font></strong></td>
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
