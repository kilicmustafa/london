<%@ page import="com.rheinlandprivatschule.repository.InventorDao" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.repository.PlaceDao" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.model.Place" %>
<%@ page import="com.rheinlandprivatschule.model.InventorCategory" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: inventor Bericht ::</title>
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
        function gotocat(){
            window.location="inventorCatList";
        }
        function employeeLohn()
        {
            window.location="../stundenplan/stlohnEmployee";
        }

        function lehrerLohn()
        {
            window.location="../stundenplan/stlohnLehrer";
        }

        function employeeLohnDetail()
        {
            window.location="../bericht/searchEmployeeTimeSheet";
        }

        function nullFees()
        {
            window.location="../bericht/searchNullGebTran";
        }
        function firstPay()
        {
            window.location="../bericht/searchFirstPay";
        }

    </script>
</head>
<body>
<%
    InventorDao edb= (InventorDao) request.getAttribute("inventorDao");
    PlaceDao placeDB = (PlaceDao) request.getAttribute("placeDao");
    Vector catList;
    Vector placeList= placeDB.getAllPlaces();

    java.sql.Date firstDate = new java.sql.Date(new java.util.Date().getTime());
    java.sql.Date lastDate = new java.sql.Date(new java.util.Date().getTime());

    int dayO=0;
    int yearO=0;
    String monthO="01";
    int day =0;
    int year=0;
    String month="01";
    String displayFirstDate="";
    String displayEndDate="";

    String cmd=(String)request.getParameter("cmd");
    if(cmd!=null){
        firstDate= MyDate.getSQLDateFromStrings((String)request.getParameter("selSDay"),(String)request.getParameter("selSMonth"),(String)request.getParameter("selSYear"),MyDate.DEUTSCH);
        dayO=Integer.parseInt(MyDate.getDay(firstDate));
        yearO=Integer.parseInt(MyDate.getYear(firstDate));
        monthO=MyDate.getMonth(firstDate);
        lastDate=MyDate.getSQLDateFromStrings((String)request.getParameter("selEDay"),(String)request.getParameter("selEMonth"),(String)request.getParameter("selEYear"),MyDate.DEUTSCH);
        day =Integer.parseInt(MyDate.getDay(lastDate));
        year=Integer.parseInt(MyDate.getYear(lastDate));
        month=MyDate.getMonth(lastDate);
        displayFirstDate=MyDate.formateDate(firstDate,MyDate.NUMERIC,MyDate.DEUTSCH);
        displayEndDate=MyDate.formateDate(lastDate,MyDate.NUMERIC,MyDate.DEUTSCH);

        catList=edb.combineCategories(firstDate,lastDate);
    }else{
        firstDate=MyDate.getFirstCurrentMonthDate();
        lastDate=MyDate.getLastCurrentMonthDate();
        dayO=Integer.parseInt(MyDate.getDay(firstDate));
        yearO=Integer.parseInt(MyDate.getYear(firstDate));
        monthO=MyDate.getMonth(firstDate);
        day =Integer.parseInt(MyDate.getDay(lastDate));
        year=Integer.parseInt(MyDate.getYear(firstDate));
        month=MyDate.getMonth(firstDate);
        displayFirstDate=MyDate.formateDate(firstDate,MyDate.NUMERIC,MyDate.DEUTSCH);
        displayEndDate=MyDate.formateDate(lastDate,MyDate.NUMERIC,MyDate.DEUTSCH);

        catList=edb.combineCategories(firstDate,lastDate);
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="gotocat()">Inventor Kategorie</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <table width="100%" border="0" height="455">
                            <tr>
                                <td height="423" valign="top">
                                    <form style="width: 100%;" name="form1" method="post" action="">
                                        <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                            <tr bgcolor="657A9A">
                                                <td width="100%" height="21" bgcolor="657A9A"><div align="center"><strong><font color="#FFFFFF" size="3">inventar Bericht </font></strong></div></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                                        <tr bgcolor="657A9A">
                                                            <td width="417">
                                                                <b><font size="2" color="#FFFFFF">
                                                                    Kategorie
                                                                </font></b>
                                                            </td>
                                                            <%
                                                                for(int ii=0;ii<placeList.size();ii++){
                                                                    Place tempPlace=(Place)placeList.elementAt(ii);
                                                            %>
                                                            <td width="90" >
                                                                <b><font size="2" color="#FFFFFF">
                                                                    <%=tempPlace.getPlaceName()%>
                                                                </font></b>
                                                            </td>
                                                            <%
                                                                }
                                                            %>
                                                            <td width="78" >
                                                            </td>
                                                            <td width="84" >
                                                                <b><font size="2" color="#FFFFFF">
                                                                    Gesamt
                                                                </font></b>
                                                            </td>
                                                            <td width="85" bgcolor="657A9A" >
                                                            </td>
                                                        </tr>
                                                        <%
                                                            double[] lastTotal=new double[placeList.size()];
                                                            double[] lastTotalBalance=new double[placeList.size()];

                                                            for(int iFTrack=0;iFTrack<placeList.size();iFTrack++){
                                                                lastTotal[iFTrack]=0;
                                                                lastTotalBalance[iFTrack]=0;
                                                            }
                                                            double lastGesamtTotal=0;
                                                            double lastGesamtTotalBalance=0;

                                                            double subTotal = 0;
                                                            String subTotalDisplay="";
                                                            String gesamt="";
                                                            for(int i=0;i<catList.size();i++){
                                                                InventorCategory tempCategory=(InventorCategory)catList.elementAt(i);

                                                                if(tempCategory.getInventorID()==0){
                                                                    subTotalDisplay= MyCurrency.getDisplayString(subTotal);
                                                                    subTotal=0;
                                                                    gesamt="";
                                                        %>
                                                        <tr bgcolor="AEBACD">
                                                            <td bgcolor="AEBACD" width="417">
                                                                <font size="2" color="AEBACD">
                                                                    <%=tempCategory.getIndentation()%>
                                                                </font>
                                                                <font size="2" color="#000033">Kategorie
                                                                    <%=tempCategory.getInventorName()%>
                                                                </font>
                                                            </td>
                                                            <%
                                                                for(int ii=0;ii<placeList.size();ii++){
                                                                    Place tempPlace=(Place)placeList.elementAt(ii);
                                                            %>
                                                            <td width="90">
                                                                <font size="2" color="#000033">&nbsp;
                                                                </font>
                                                            </td>
                                                            <%
                                                                }
                                                            %>
                                                            <td >&nbsp;

                                                            </td>
                                                            <td >
                                                                <font size="2" color="#000033">
                                                                    <%=gesamt%>
                                                                </font>
                                                            </td>
                                                            <td >
                                                                <font size="2" color="#000033">
                                                                    <%=subTotalDisplay%>
                                                                </font>
                                                            </td>
                                                        </tr>
                                                        <%
                                                        }else{
                                                            for(int iTrack=0;iTrack<placeList.size();iTrack++){
                                                                Place tempPlace=(Place)placeList.elementAt(iTrack);
                                                                lastTotal[iTrack]+=MyCurrency.getDoubleValue(tempCategory.getAmountForSchool(tempPlace.getPlaceID(),firstDate,lastDate));
                                                            }
                                                            subTotalDisplay="";

                                                            if(tempCategory.getInventorAmount()==0){
                                                                gesamt="";
                                                            }else{
                                                                double gesamtProc=0;
                                                                for(int totalTrack=0;totalTrack<placeList.size();totalTrack++){
                                                                    Place tempPlace=(Place)placeList.elementAt(totalTrack);
                                                                    gesamtProc+=MyCurrency.getDoubleValue(tempCategory.getAmountForSchool(tempPlace.getPlaceID(),firstDate,lastDate));
                                                                }
                                                                gesamt=MyCurrency.getDisplayString(gesamtProc);
                                                                lastGesamtTotal+=gesamtProc;
                                                                subTotal+=gesamtProc;
                                                            }


                                                        %>
                                                        <tr bgcolor="AEBACD">
                                                            <td bgcolor="AEBACD" width="417">
                                                                <font size="2" color="AEBACD">
                                                                    <%=tempCategory.getIndentation()%>
                                                                </font>
                                                                <font size="2" color="#000033">
                                                                    <a href="../inventor/viewInventorCat?id=<%=tempCategory.getInventorID()%>"><%=tempCategory.getInventorName()%></a>
                                                                </font>
                                                            </td>
                                                            <%
                                                                for(int ii=0;ii<placeList.size();ii++){
                                                                    Place tempPlace=(Place)placeList.elementAt(ii);
                                                            %>
                                                            <td width="90">
                                                                <font size="2" color="#000033">
                                                                    <%=tempCategory.getAmountForSchool(tempPlace.getPlaceID(),firstDate,lastDate)%>
                                                                </font>
                                                            </td>
                                                            <%
                                                                }
                                                            %>
                                                            <td bgcolor="AEBACD" >&nbsp;

                                                            </td>
                                                            <td bgcolor="AEBACD" >
                                                                <font size="2" color="#000033">
                                                                    <%=gesamt%>
                                                                </font>
                                                            </td>
                                                            <td >
                                                                <font size="2" color="#000033">
                                                                    <%=subTotalDisplay%>
                                                                </font>
                                                            </td>
                                                        </tr>

                                                        <%
                                                                }
                                                            }
                                                        %>
                                                        <tr bgcolor="657A9A">
                                                            <td bgcolor="657A9A"><strong><font color="#990000" size="2">Summe</font></strong></td>
                                                            <%
                                                                for(int ii=0;ii<placeList.size();ii++){
                                                                    Place tempPlace=(Place)placeList.elementAt(ii);
                                                            %>
                                                            <td width="90">
                                                                <b><font size="2" color="#990000">
                                                                    <%=MyCurrency.getDisplayString(lastTotal[ii])%>
                                                                </font></b>
                                                            </td>
                                                            <%
                                                                }
                                                            %>
                                                            <td>&nbsp;</td>
                                                            <td ><b><font size="2" color="#990000"><%=MyCurrency.getDisplayString(lastGesamtTotal)%></font></b></td>
                                                            <td >&nbsp;</td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </form></td>
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
