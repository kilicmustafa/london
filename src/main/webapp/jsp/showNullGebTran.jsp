<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.model.Place" %>
<%@ page import="com.rheinlandprivatschule.repository.PlaceDao" %>
<%@ page import="com.rheinlandprivatschule.repository.TransactionDao" %>
<%@ page import="com.rheinlandprivatschule.model.SystemUser" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="com.rheinlandprivatschule.repository.SystemUserDao" %>
<%@ page import="com.rheinlandprivatschule.model.Transaction" %>
<%@ page import="java.util.ArrayList" %>
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
            window.location="searchNullGebTran";
        }
    </script>
</head>
<body>
<%
    PlaceDao placeDB= (PlaceDao) request.getAttribute("placeDao");
    SystemUserDao systemUserDao = (SystemUserDao) request.getAttribute("systemUserDao");
    TransactionDao trdb= (TransactionDao) request.getAttribute("transactionDao");
    Place reqPlace=new Place();
    SystemUser reqAdmin=new SystemUser();
    RPS rps = (RPS) request.getAttribute("rps");

    ArrayList<Transaction> myTr=new ArrayList<>();

    int tranNo=0;
    double sume=0;
    String roundedEuro="";

    boolean canprint=false;

    canprint=trdb.canPrintBericht(rps.getLoginUser().getUserID());

    String cri=(String)request.getParameter("selC");
    String adminS=(String)request.getParameter("selAdmin");
    try{
        if(!adminS.equalsIgnoreCase("w�hlen Administrator")){
            int admin=Integer.parseInt(adminS);
            reqAdmin= systemUserDao.getSystemUser(admin);
        }
    }catch(Exception e){
    }

    String placename=(String)request.getParameter("selPlace");
    try{
        if(!placename.equalsIgnoreCase("w�hlen Schule")){
            int place=Integer.parseInt(placename);
            reqPlace= placeDB.getPlace(place);
        }
    }catch(Exception e){
    }


    //if(!placename.equalsIgnoreCase("w�hlen Schule")){
    //	Vector places=(new rps.places.PlaceDB()).getAllPlaces();
    //	for(int i=0;i<places.size();i++){
    //		rps.places.Place tempP=(rps.places.Place)places.elementAt(i);
    //		if(placename.equalsIgnoreCase(tempP.getPlaceName())){
    //			reqPlace=tempP;
    //		}
    //	}
    //}

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

    java.sql.Date d1=MyDate.getSQLDateFromStrings(sDay,sMonth,sYear,MyDate.DEUTSCH);
    java.sql.Date d2=MyDate.getSQLDateFromStrings(eDay,eMonth,eYear, MyDate.DEUTSCH);
    myTr=trdb.getNullGebTran(Integer.parseInt(cri),reqAdmin.getUserID(),d1,d2,reqPlace.getPlaceID(),tranNo);
    for(int x=0;x<myTr.size();x++){
        Transaction tx= myTr.get(x);
        sume=sume+tx.getPaid();
    }
    roundedEuro= MyCurrency.getDisplayString(sume);
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
                                    <td colspan="9" bgcolor="657A9A" height="8">
                                        <div align="center"><font size="4" color="#FFFFFF"><b>Bericht
                                            Ansicht</b></font></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="7" bgcolor="657A9A" colspan="2"><font size="2" color="#FFFFFF"><b>Sume</b></font></td>
                                    <td colspan="7" height="7" bgcolor="657A9A">
                                        <div align="right"><font size="2" color="#FFFFFF"><b><%=roundedEuro%></b></font></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="3%" height="7" bgcolor="657A9A"><b></b></td>
                                    <td width="6%" height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Bericht
                                        Nr</font></b></td>
                                    <td width="17%" height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Sch&uuml;ler
                                        Name</font></b></td>
                                    <td width="17%" height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Kurs
                                        Name</font></b></td>
                                    <td width="8%" height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Betrag</font></b></td>
                                    <td width="10%" height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Datum</font></b></td>
                                    <td width="11%" height="7" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Ordnung</font></b></td>
                                    <td width="15%" height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Admin
                                        Name</font></b></td>
                                    <td width="13%" height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Schule
                                        Name</font></b></td>
                                </tr>
                                <%
                                    for(int y=myTr.size()-1;y>=0;y--){
                                        Transaction tt=myTr.get(y);
                                        String ordnung="";
                                        if(tt.getPaymentType()==0){
                                            ordnung="Bar";
                                        }else if(tt.getPaymentType()==1){
                                            ordnung="Uberweisung";
                                        }else if(tt.getPaymentType()==2){
                                            ordnung="Online";
                                        }else if(tt.getPaymentType()==3){
                                            ordnung="Inkasso";
                                        }else if(tt.getPaymentType()==4){
                                            ordnung="BAMF";
                                        }
                                %>
                                <tr bgcolor="AEBACD">
                                    <td width="3%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">
                                        <input type="checkbox" name="dr" value="<%=tt.getTransactionNo()%>">
                                    </font></td>
                                    <td width="6%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=tt.getTransactionNo()%></font></td>
                                    <td width="17%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><a href="/schuler/showStudentPreciseD?userid=<%=tt.getStudentID()%>"><%=tt.getStudentCompleteName()%></a></font></td>
                                    <td width="17%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=tt.getCourseName()%></font></td>
                                    <td width="8%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=MyCurrency.getDisplayString(tt.getPaid())%></font></td>
                                    <td width="10%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=MyDate.formateDate(tt.getPaymentDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                    <td width="11%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=ordnung%></font></td>
                                    <td width="15%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=tt.getLoginUserCompleteName()%></font></td>
                                    <td width="13%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=tt.getPlaceName()%></font></td>
                                </tr>
                                <%
                                    }
                                %>
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
