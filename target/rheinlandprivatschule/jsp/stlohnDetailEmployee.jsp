<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.model.ExpenseCategory" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ page import="com.rheinlandprivatschule.model.Place" %>
<%@ page import="java.sql.Date" %>
<%@ page import="com.rheinlandprivatschule.model.SystemUser" %>
<%@ page import="java.util.List" %>
<%@ page import="com.rheinlandprivatschule.repository.*" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
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

    </script>
</head>
<body>
<%
    String monS="";
    String yeaS="";
    String teaS="";
    EmployeeHours sdb=new EmployeeHours();
    StudentDao studentDB=new StudentDao();
    TeacherLohnDao tldb = new TeacherLohnDao();
    SingleClassDao scdb=new SingleClassDao();

    Vector teacherPrivateLohnList=new Vector();
    Vector teacherGroupLohnList=new Vector();
    Vector v=new Vector();
    Vector v1=new Vector();
    SystemUser u=new SystemUser();
    double lohn=0.0;
    String strLohn="0,0";
    double totalH=0;
    double totalHAdj=0;
    int totalEH=0;
    double totalAB=0;
    double totalABAdj=0;
    double totalEAB=0;
    double totalMinutes=0;
    double totalMinutesAdj=0;

    RPS rps=(RPS)session.getAttribute("handler");
    SystemUser loginuser=new SystemUser();
    Place myPlace=new Place();
    if(rps==null){
        String err="Sitzung lief Ab";
        session.setAttribute("err",err);
        session.setAttribute("lin","../index");
        response.sendRedirect("error");
    }else{

        session.setAttribute("handler",rps);
        loginuser=rps.getLoginUser();
        myPlace=rps.getLoginPlace();
        monS=(String)request.getParameter("selSMonth");
        yeaS=(String)request.getParameter("selSYear");
        teaS=(String)request.getParameter("tea");



        java.sql.Date d1= MyDate.getFirstMonthDate(monS,yeaS,MyDate.DEUTSCH);
        java.sql.Date d2=MyDate.getLastMonthDate(monS,yeaS,MyDate.DEUTSCH);
        int month = MyDate.getMonthNumber(monS,MyDate.DEUTSCH);
        int tea=Integer.parseInt(teaS);
        if(tea>0){
            v=sdb.EmployeeTimeSheet(month,Integer.parseInt(yeaS),tea);
            //v1=sdb.EmployeeHoursCalc(month,Integer.parseInt(yeaS),tea);
            u=(new SystemUserDao()).getSystemUser(tea);
            teacherGroupLohnList = tldb.getAllTeacherLohn(tea,tldb.GROUPLOHN);
        }
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
                                <td width="16%"><font size="2" color="#FFFFFF"><b>Mittarbeiter/in Name</b></font></td>
                                <td bgcolor="AEBACD"><font size="2" color="#000033"><%=u.getUserFirstName()+" "+u.getUserLastName()%></font></td>
                            </tr>
                            <tr bgcolor="657A9A">
                                <td colspan="2">
                                    <div align="center"><font size="3" color="#FFFFFF"><b>Mittarbeiter Stundenlohn</b></font></div>
                                </td>
                            </tr>
                            <tr valign="top">
                                <td height="22" colspan="2"><table width="100%" border="0" cellpadding="1" cellspacing="1">
                                    <tr>
                                        <td width="7%" height="16" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Datum</font></b></td>
                                        <td width="11%" height="16" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Tag</font></b></td>
                                        <td width="8%" height="16" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Beginn</font></b></td>
                                        <td width="9%" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Pause Beginn </font></strong></td>
                                        <td width="9%" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Pause Ende </font></strong></td>
                                        <td width="9%" height="16" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Ende</font></b></td>
                                        <td width="9%" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Stunden</font></strong></td>
                                        <td width="10%" height="16" bgcolor="657A9A"><font size="2" color="#FFFFFF"><strong><font color="#FFFFFF" size="2">Auszahlung</font></strong></font></td>
                                        <td width="9%" height="16" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Regulierte Ende</font></b></td>
                                        <td width="9%" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2"><b><font color="#FFFFFF" size="2">Regulierte</font></b> Stunden</font></strong></td>
                                        <td width="10%" height="16" bgcolor="657A9A"><font size="2" color="#FFFFFF"><strong><font color="#FFFFFF" size="2"><b><font color="#FFFFFF" size="2">Regulierte</font></b> Auszahlung</font></strong></font></td>
                                    </tr>
                                    <%
                                        for(int i=0;i<v.size();i++)
                                        {
                                            EmployeeHours sl=(EmployeeHours)v.elementAt(i);
                                            String tempTime="";

                                            double specificDateLohn = tldb.getTeacherLohnForSpecificDate(teacherGroupLohnList,sl.getLoginDate());
                                            double specificBetrag = (specificDateLohn*sl.getTotalTime()) + (specificDateLohn * (sl.getTotalMinutes()/60));
                                            double specificBetragMinutes= specificBetrag + specificDateLohn * sl.getTotalMinutes()/60;

                                            double specificBetragAdjust = (specificDateLohn*sl.getTotalHoursAdjust()) + (specificDateLohn * (sl.getTotalMinutesAdjust()/60));
                                            double specificBetragMinutesAdjust= specificBetragAdjust + specificDateLohn * sl.getTotalMinutesAdjust()/60;

                                            double totalHours = sl.getTotalTime();
                                            totalMinutes=(totalMinutes +sl.getTotalMinutes()*100/60)/100;
                                            totalH = (totalH + sl.getTotalTime()) + totalMinutes;

                                            double totalHoursAdj = sl.getTotalHoursAdjust();
                                            totalMinutesAdj=(totalMinutesAdj +sl.getTotalMinutesAdjust()*100/60)/100;
                                            totalHAdj = (totalHAdj + sl.getTotalHoursAdjust()) + totalMinutesAdj;

                                            totalAB=totalAB+specificBetragMinutes;
                                            totalABAdj=totalABAdj+specificBetragMinutesAdjust;


                                    %>
                                    <tr bgcolor="AEBACD">
                                        <td width="7%" height="16"><font size="2" color="#000033"><%=MyDate.formateDate(sl.getLoginDate(),MyDate.ALPHANUMERIC,MyDate.DEUTSCH)%></font></td>
                                        <td width="11%" height="16"><font size="2" color="#000033"><%=sl.getDay()%></font></td>
                                        <td width="8%" height="16"><font size="2" color="#000033"><%=sl.getLoginTime()%></font></td>
                                        <td width="9%" height="16"><font size="2" color="#000033"><%=sl.getBreakStartTime()%></font></td>
                                        <td width="9%" height="16"><font size="2" color="#000033"><%=sl.getBreakEndTime()%></font></td>
                                        <td width="9%" height="16"><font size="2" color="#000033"><%=sl.getLogoutTime()%></font></td>
                                        <td width="9%" height="16"><font size="2" color="#000033"><%=sl.getTotalTime()+":"+sl.getTotalMinutes()%></font></td>
                                        <td height="16"><font size="2" color="#000033"><%=MyCurrency.getDisplayString(specificBetragMinutes)%></font></td>
                                        <td height="16"><font size="2" color="#000033"><%=sl.getTimeAdjustTo()%></font></td>
                                        <td height="16"><font size="2" color="#000033"><%=sl.getTotalHoursAdjust()+":"+sl.getTotalMinutesAdjust()%></font></td>
                                        <td height="16"><font size="2" color="#000033"><%=MyCurrency.getDisplayString(specificBetragMinutesAdjust)%></font></td>
                                    </tr>
                                    <%

                                            //}
                                        }
                                    %>
                                    <tr bgcolor="657A9A">
                                        <td height="16" >&nbsp;</td>
                                        <td >&nbsp;</td>
                                        <td >&nbsp;</td>
                                        <td >&nbsp;</td>
                                        <td >&nbsp;</td>
                                        <td ><strong></strong></td>
                                        <td ><strong><font color="#FFFFFF" size="2"><%=MyCurrency.getDisplayString(totalH)%></font></strong></td>
                                        <td ><strong><font color="#FFFFFF" size="2"><%=MyCurrency.getDisplayString(totalAB)%></font></strong></td>
                                        <td >&nbsp;</td>
                                        <td ><strong><font color="#FFFFFF" size="2"><%=MyCurrency.getDisplayString(totalHAdj)%></font></strong></td>
                                        <td ><strong><font color="#FFFFFF" size="2"><%=MyCurrency.getDisplayString(totalABAdj)%></font></strong></td>
                                    </tr>
                                </table></td>
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
