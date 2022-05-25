<%@ page import="com.rheinlandprivatschule.repository.PlaceDao" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.repository.EmployeeHours" %>
<%@ page import="com.rheinlandprivatschule.repository.SystemUserDao" %>
<%@ page import="com.rheinlandprivatschule.model.SystemUser" %>
<%@ page import="com.rheinlandprivatschule.model.Place" %>
<%@ page import="com.rheinlandprivatschule.repository.TeacherLohnDao" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Bericht Ansicht ::</title>
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
        function goback()
        {
            window.location="searchEmployeeTimeSheet";
        }

    </script>
</head>
<body>
<%
    PlaceDao placeDB= (PlaceDao) request.getAttribute("placeDao");
    EmployeeHours hours= (EmployeeHours) request.getAttribute("hours");
    SystemUserDao systemUserDao = (SystemUserDao) request.getAttribute("systemUserDao");
    SystemUser reqAdmin = new SystemUser();
    Place reqPlace = new Place();
    TeacherLohnDao tldb = (TeacherLohnDao) request.getAttribute("teacherLohnDao");
    SystemUser u;

    Vector myTr=new Vector();
    Vector teacherGroupLohnList=new Vector();

    double lohn=0.0;
    String strLohn="0,0";
    double totalH=0;
    int totalEH=0;
    double totalAB=0;
    double totalEAB=0;
    double totalMinutes=0;

    int tranNo=0;
    double sume=0;
    String roundedEuro="";

    boolean canprint=false;


    String cri=(String)request.getParameter("selC");
    String adminS=(String)request.getParameter("selAdmin");
    try{
        if(!adminS.equalsIgnoreCase("wählen Administrator")){
            int admin=Integer.parseInt(adminS);
            reqAdmin= systemUserDao.getSystemUser(admin);
        }
    }catch(Exception e){
    }

    String placename=(String)request.getParameter("selPlace");
    try{
        if(!placename.equalsIgnoreCase("wählen Schule")){
            int place=Integer.parseInt(placename);
            reqPlace= placeDB.getPlace(place);
        }
    }catch(Exception e){
    }

    String tranno=(String)request.getParameter("tranNo");
    try{
        tranNo=Integer.parseInt(tranno);
    }catch(Exception ee){
    }
    String sDay=(String)request.getParameter("selSDay");
    String sMonth=(String)request.getParameter("selSMonth");
    String sYear=(String)request.getParameter("selSYear");
    String eDay=(String)request.getParameter("selEDay");
    String eMonth=(String)request.getParameter("selEMonth");
    String eYear=(String)request.getParameter("selEYear");

    java.sql.Date d1= MyDate.getSQLDateFromStrings(sDay,sMonth,sYear,MyDate.DEUTSCH);
    java.sql.Date d2=MyDate.getSQLDateFromStrings(eDay,eMonth,eYear,MyDate.DEUTSCH);
    myTr=hours.EmployeeTimeSheetSearch(Integer.parseInt(cri),reqAdmin.getUserID(),d1,d2,reqPlace.getPlaceID(),tranNo);



    //myTr=trdb.getTransactions(Integer.parseInt(cri),reqAdmin.getUserID(),d1,d2,reqPlace.getPlaceID(),tranNo);
    //for(int x=0;x<myTr.size();x++){
    //rps.stunden.EmployeeHours tx=(rps.stunden.EmployeeHours)myTr.elementAt(x);
    //sume=sume+tx.getPaid();
    //}
    //roundedEuro=MyCurrency.getDisplayString(sume);
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="goback()">Zur&uuml;ck</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width: 100%;" name="form1" method="post" action="berichtPrintProcess">
                            <table width="100%" border="0" cellspacing="1" cellpadding="1">
                                <input name="canberprint" type="hidden" id="canberprint" value="<%=canprint%>">
                                <tr>
                                    <td colspan="10" bgcolor="657A9A" height="8">
                                        <div align="center"><font size="4" color="#FFFFFF"><b>Mitarbeiter
                                            Ansicht</b></font></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="11%" height="16" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Datum</font></b></td>
                                    <td width="13%" height="16" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Name</font></b></td>
                                    <td width="12%" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Stadt</font></b></td>
                                    <td width="11%" height="16" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Tag</font></b></td>
                                    <td width="9%" height="16" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Beginn</font></b></td>
                                    <td width="11%" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Pause Beginn </font></strong></td>
                                    <td width="10%" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Pause Ende </font></strong></td>
                                    <td width="8%" height="16" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Ende</font></b></td>
                                    <td width="6%" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Stunden</font></strong></td>
                                    <td width="9%" bgcolor="657A9A"><strong><FONT color=#ffffff size=2><STRONG><FONT color=#ffffff
                                                                                                                     size=2>Auszahlung</FONT></STRONG></FONT></strong></td>
                                </tr>
                                <%
                                    for(int y=myTr.size()-1;y>=0;y--){
                                        EmployeeHours sl=(EmployeeHours)myTr.elementAt(y);

                                        String tempTime="";
                                        u= systemUserDao.getSystemUser(sl.getUserID());
                                        teacherGroupLohnList = tldb.getAllTeacherLohn(sl.getUserID(),tldb.GROUPLOHN);
                                        double specificDateLohn = tldb.getTeacherLohnForSpecificDate(teacherGroupLohnList,sl.getLoginDate());
                                        double specificBetrag = (specificDateLohn*sl.getTotalTime()) + (specificDateLohn * (sl.getTotalMinutes()/60));
                                        double specificBetragMinutes= specificBetrag + specificDateLohn * sl.getTotalMinutes()/60;

                                        double totalHours = sl.getTotalTime();
                                        totalMinutes=(totalMinutes +sl.getTotalMinutes()*100/60)/100;
                                        totalH = (totalH + sl.getTotalTime()) + totalMinutes;

                                        totalAB=totalAB+specificBetragMinutes;
                                        if (sl.getCount()==1){
                                %>
                                <tr bgcolor="AEBACD">
                                    <td height="16"><font size="2" color="#FF0000"><%=MyDate.formateDate(sl.getLoginDate(),MyDate.ALPHANUMERIC,MyDate.DEUTSCH)%></font></td>
                                    <td height="16"><font size="2" color="#FF0000"><%=sl.getUserName()%></font></td>
                                    <td><font size="2" color="#FF0000"><%=sl.getPlaceName()%></font></td>
                                    <td height="16"><font size="2" color="#FF0000"><%=sl.getDay()%></font></td>
                                    <td height="16"><font size="2" color="#FF0000"><%=sl.getLoginTime()%></font></td>
                                    <td height="16"><font size="2" color="#FF0000"><%=sl.getBreakStartTime()%></font></td>
                                    <td height="16"><font size="2" color="#FF0000"><%=sl.getBreakEndTime()%></font></td>
                                    <td height="16"><font size="2" color="#FF0000"><%=sl.getLogoutTime()%></font></td>
                                    <td height="16"><font size="2" color="#FF0000"><%=sl.getTotalTime()+":"+sl.getTotalMinutes()%></font></td>
                                    <td height="16"><font size="2" color="#FF0000"><%=MyCurrency.getDisplayString(specificBetragMinutes)%></font></td>
                                </tr>
                                <%
                                }else{
                                %>
                                <tr bgcolor="AEBACD">
                                    <td height="16"><font size="2" color="#000033"><%=MyDate.formateDate(sl.getLoginDate(),MyDate.ALPHANUMERIC,MyDate.DEUTSCH)%></font></td>
                                    <td height="16"><font size="2" color="#000033"><%=sl.getUserName()%></font></td>
                                    <td><font size="2" color="#000033"><%=sl.getPlaceName()%></font></td>
                                    <td height="16"><font size="2" color="#000033"><%=sl.getDay()%></font></td>
                                    <td height="16"><font size="2" color="#000033"><%=sl.getLoginTime()%></font></td>
                                    <td height="16"><font size="2" color="#000033"><%=sl.getBreakStartTime()%></font></td>
                                    <td height="16"><font size="2" color="#000033"><%=sl.getBreakEndTime()%></font></td>
                                    <td height="16"><font size="2" color="#000033"><%=sl.getLogoutTime()%></font></td>
                                    <td height="16"><font size="2" color="#000033"><%=sl.getTotalTime()+":"+sl.getTotalMinutes()%></font></td>
                                    <td height="16"><font size="2" color="#000033"><%=MyCurrency.getDisplayString(specificBetragMinutes)%></font></td>
                                </tr>
                                <%
                                        }}
                                %>
                                <tr bgcolor="657A9A">
                                    <td>&nbsp;</td>
                                    <td colspan="2">&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td><strong><font color="#FFFFFF" size="2"><%=MyCurrency.getDisplayString(totalH)%></font></strong></td>
                                    <td><strong><font color="#FFFFFF" size="2"><%=MyCurrency.getDisplayString(totalAB)%></font></strong></td>
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
