<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.model.SystemUser" %>
<%@ page import="com.rheinlandprivatschule.model.Place" %>
<%@ page import="com.rheinlandprivatschule.model.StudentComplaint" %>
<%@ page import="com.rheinlandprivatschule.repository.*" %>
<%@ page import="com.rheinlandprivatschule.model.Complaint" %>
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

        function notactive() {
            window.location = "showComplaint.jsp?status=" + document.form1.status.value;
        }


        function leave1() {
            if (document.form1.canberprint.value == "true") {
                document.form1.submit();
            } else {
                alert('Ihnen wird nicht erlaubt, das zu tun.')
            }
        }

        function goback() {
            window.location = "searchNullGebTran";
        }
    </script>
</head>
<body>
<%
    PlaceDao placeDB= (PlaceDao) request.getAttribute("placeDao");
    SystemUserDao systemUserDao = (SystemUserDao) request.getAttribute("systemUserDao");
    StudentComplaintDao trdb= (StudentComplaintDao) request.getAttribute("trdb");
    SystemUser reqAdmin = new SystemUser();
    Place reqPlace = null;

    SystemUser loginuser;
    Place myPlace;

    Vector myTr=new Vector();

    int tranNo=0;
    double sume=0;
    String roundedEuro="";
    int pageStatus=-1;

    boolean canprint=false;

    int placeID =0;

    String placename="";
    String cri="";
    String adminS="";
    String tranno="";
    String sDay="";
    String sMonth="";
    String sYear="";
    String eDay="";
    String eMonth="";
    String eYear="";
    String flag="";

    cri=(String)request.getParameter("selC");
    adminS=(String)request.getParameter("selAdmin");
    try{
        if(!adminS.equalsIgnoreCase("wählen Administrator")){
            int admin=Integer.parseInt(adminS);
            reqAdmin= systemUserDao.getSystemUser(admin);
        }
    }catch(Exception e){
    }

    placename=(String)request.getParameter("selPlace");
    //try{
    //	if(!placename.equalsIgnoreCase("wählen Schule")){
    //		int place=Integer.parseInt(placename);
    //		reqPlace=(new rps.places.PlaceDB()).getPlace(place);
    //	}
    //}catch(Exception e){
    //}


    if(!placename.equalsIgnoreCase("wählen Schule")){
        Vector places=placeDB.getAllPlaces();
        for(int i=0;i<places.size();i++){
            Place tempP=(Place)places.elementAt(i);
            if(placename.equalsIgnoreCase(tempP.getPlaceName())){
                reqPlace=tempP;
            }
        }
    }

    if(!placename.equalsIgnoreCase("wählen Schule")){
        placeID = Integer.parseInt(placename);
    }

    tranno=(String)request.getParameter("tranNo");
    try{
        tranNo=Integer.parseInt(tranno);
    }catch(Exception ee){
    }
    sDay=(String)request.getParameter("selSDay");
    sMonth=(String)request.getParameter("selSMonth");
    sYear=(String)request.getParameter("selSYear");
    eDay=(String)request.getParameter("selEDay");
    eMonth=(String)request.getParameter("selEMonth");
    eYear=(String)request.getParameter("selEYear");

    java.sql.Date d1=MyDate.getSQLDateFromStrings(sDay,sMonth,sYear,MyDate.DEUTSCH);
    java.sql.Date d2=MyDate.getSQLDateFromStrings(eDay,eMonth,eYear,MyDate.DEUTSCH);

    flag=(String)request.getParameter("status");
    myTr=trdb.getComplaintSearch1(Integer.parseInt(cri),reqAdmin.getUserID(),d1,d2,placeID,tranNo,0);
    pageStatus=trdb.COMPLAINTACTIVE;

    //for(int x=0;x<myTr.size();x++){
    //	rps.transactions.Transaction tx=(rps.transactions.Transaction)myTr.elementAt(x);
    //	sume=sume+tx.getPaid();
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="complaintList">Katagorie</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="showComplaintN?status=1&tranNo=<%=tranno%>&selPlace=<%=placename%>&selC=<%=cri%>&selAdmin=<%=adminS%>&selSDay=<%=sDay%>&selSMonth=<%=sMonth%>&selSYear=<%=sYear%>&selEDay=<%=eDay%>&selEMonth=<%=eMonth%>&selEYear=<%=eYear%>">erledigt</a>
                                <input name="status" type="hidden" id="status" value="notactive">
                                <a style="margin-right: 5px;" class="btn btn-primary" href="showComplaint?status=null&tranNo=<%=tranno%>&selPlace=<%=placename%>&selC=<%=cri%>&selAdmin=<%=adminS%>&selSDay=<%=sDay%>&selSMonth=<%=sMonth%>&selSYear=<%=sYear%>&selEDay=<%=eDay%>&selEMonth=<%=eMonth%>&selEYear=<%=eYear%>">Nicht erledigt</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width: 100%;" name="form1" method="post" action="berichtPrintProcess.jsp">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td valign="top" height="146" bgcolor="D9E5F4" width="81%"><table width="100%" height="81" border="0" cellpadding="1" cellspacing="1">
                                        <tr bgcolor="657A9A">
                                            <th height="17" colspan="6"><b><font color="#FFFFFF">Beschwerden</font></b></th>
                                        </tr>
                                        <tr bgcolor="657A9A">
                                            <td height="10" colspan="5"><font color="#FFFFFF" size="2"><b>Summe </b></font></td>
                                            <td width="15%" height="10" colspan="-2">
                                                <div align="right"><font size="2" color="#FFFFFF"><b><%=myTr.size()%></b></font></div></td></tr>
                                        <tr bgcolor="657A9A">
                                            <td height="10"><b><font size="2" color="#FFFFFF">Katagorie Name </font></b></td>
                                            <td width="36%" height="10"><b><font size="2" color="#FFFFFF">Beschwerde Bemerkung </font></b></td>
                                            <td width="9%"><b><font color="#FFFFFF" size="2">Datum</font></b></td>
                                            <td width="13%"><b><font color="#FFFFFF" size="2">Admin</font></b></td>
                                            <td width="14%"><b><font color="#FFFFFF" size="2">Schule</font></b></td>
                                            <td height="10" colspan="-2"><b><font color="#FFFFFF" size="2">Status</font></b></td>
                                        </tr>
                                        <%
                                            for(int i=0;i<myTr.size();i++){
                                                StudentComplaint ec=(StudentComplaint)myTr.elementAt(i);
                                                ComplaintDao compDB=new ComplaintDao();
                                                Complaint comp=new Complaint();
                                                comp= compDB.getComplaints(ec.getComplaintID());
                                                loginuser = systemUserDao.getSystemUser(ec.getAdminID());
                                                myPlace = placeDB.getPlace(ec.getPlaceID());
                                                if(pageStatus==trdb.COMPLAINTNOTACTIVE){
                                        %>
                                        <tr bgcolor="AEBACD">
                                            <td><font size="2" color="#000033"><a href="complaintView?id=<%=ec.getComplaintID()%>"><%=comp.getComplaintName()%></a></font><font size="2" color="#000000">&nbsp;</font></td>
                                            <td><font size="2" color="#000033"><a href="studentComplaintView?id=<%=ec.getComStudentID()%>&userid=<%=tranNo%>"><%=ec.getRemarks()%></a></font></td>
                                            <td><font size="2" color="#000033"><%=ec.getComplaintDate()%></font></td>
                                            <td><font size="2" color="#000033"><%=loginuser.getUserFirstName()+ ' ' + loginuser.getUserLastName()%></font></td>
                                            <td><font size="2" color="#000033"><%=myPlace.getPlaceName()%></font></td>
                                            <td height="10"><div align="left"><font color="#000033" size="2"><a href="changeStudentCompStatus?wid=<%=ec.getComStudentID()%>&status=<%=trdb.COMPLAINTACTIVE%>&userid=<%=tranNo%>">erledigt</a></font></div></td>
                                        </tr>
                                        <%
                                        }else if(pageStatus==trdb.COMPLAINTACTIVE){
                                        %>
                                        <tr bgcolor="AEBACD">
                                            <td><font size="2" color="#000033"><a href="complaintView?id=<%=ec.getComplaintID()%>"><%=comp.getComplaintName()%></a></font><font size="2" color="#000000">&nbsp;</font></td>
                                            <td><font size="2" color="#000033"><a href="studentComplaintView?id=<%=ec.getComStudentID()%>&userid=<%=tranNo%>"><%=ec.getRemarks()%></a></font></td>
                                            <td><font size="2" color="#000033"><%=ec.getComplaintDate()%></font></td>
                                            <td><font size="2" color="#000033"><%=loginuser.getUserFirstName()+ ' ' + loginuser.getUserLastName()%></font></td>
                                            <td><font size="2" color="#000033"><%=myPlace.getPlaceName()%></font></td>
                                            <td height="10"><div align="left"><font color="#000033" size="2"><a href="changeStudentCompStatusSearch?wid=<%=ec.getComStudentID()%>&status=<%=trdb.COMPLAINTNOTACTIVE%>&tranNo=<%=tranno%>&selPlace=<%=placename%>&selC=<%=cri%>&selAdmin=<%=adminS%>&selSDay=<%=sDay%>&selSMonth=<%=sMonth%>&selSYear=<%=sYear%>&selEDay=<%=eDay%>&selEMonth=<%=eMonth%>&selEYear=<%=eYear%>">Nicht erledigt</a></font></div></td>
                                        </tr>
                                        <%
                                                }
                                            }
                                        %>
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
