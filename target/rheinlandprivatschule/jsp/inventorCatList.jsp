<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.model.InventorCategory" %>
<%@ page import="com.rheinlandprivatschule.repository.InventorDao" %>
<%@ page import="java.util.Vector" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: inventor Kategorie ::</title>
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
        function gotoreport(){
            window.location="inventorReport";
        }
        function back()
        {
            window.location="inventorCatList"
        }
        function newwerbungclass(){
            window.location="newInventorCat?isdir="+document.form1.isdir.value;
        }


    </script>
</head>
<body>
<%
    InventorDao edb= (InventorDao) request.getAttribute("inventorDao");

    String isdir="0";

    int parent=0;
    String parentS=request.getParameter("parent");
    if(parentS!=null){
        parent=Integer.parseInt(parentS);
        isdir=parentS;
    }
    Vector catList=edb.getAllInventorCategories(parent);
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="gotoreport()">Inventor Bericht</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="newwerbungclass()">Neuer inventorkategorie</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="back()">Zur&uuml;ck</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <table width="100%" border="0" height="120">
                            <tr>
                                <td height="423" valign="top">
                                    <form style="width: 100%;" name="form1" method="post" action="">
                                        <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                            <tr bgcolor="657A9A">
                                                <td height="22" colspan="6"><div align="center"><b><font color="#FFFFFF">inventor Kategorie</font></b></div></td>
                                            </tr>
                                            <tr bgcolor="657A9A">
                                                <td width="37%" height="6"><b><font color="#FFFFFF" size="2">Kategoriename</font></b>                                <input name="isdir" type="hidden" id="isdir" value="<%=isdir%>"></td>
                                                <td width="14%"><strong><font color="#FFFFFF" size="2">Zahlungsoptionen</font></strong></td>
                                                <td width="12%"><strong><font color="#FFFFFF" size="2">Anfangdatum</font></strong></td>
                                                <td width="12%"><strong><font color="#FFFFFF" size="2">Endedatum</font></strong></td>
                                                <td width="11%"><strong><font color="#FFFFFF" size="2">Betrag (EUR) </font></strong></td>
                                                <td height="6" width="14%">&nbsp;</td>
                                            </tr>
                                            <%
                                                double totalBetrag=0;
                                                String catType="";
                                                for(int i=0;i<catList.size();i++){
                                                    InventorCategory cat=(InventorCategory)catList.elementAt(i);
                                                    totalBetrag+=cat.getInventorAmount();
                                                    if(cat.getInventorPaymentType()==1){
                                                        catType="Stündliche";
                                                    }else if(cat.getInventorPaymentType()==2){
                                                        catType="Täglich";
                                                    }else if(cat.getInventorPaymentType()==3){
                                                        catType="Wöchentlich";
                                                    }else if(cat.getInventorPaymentType()==4){
                                                        catType="Vierzehntägig";
                                                    }else if(cat.getInventorPaymentType()==5){
                                                        catType="Monatlich";
                                                    }else if(cat.getInventorPaymentType()==6){
                                                        catType="Vierteljährlich";
                                                    }else if(cat.getInventorPaymentType()==7){
                                                        catType="Jährlich";
                                                    }

                                                    String endDate="";
                                                    if(cat.getInventorEndDate()==null){
                                                        endDate="--.--.----";
                                                    }else{
                                                        endDate=MyDate.formateDate(cat.getInventorEndDate(),MyDate.NUMERIC,MyDate.DEUTSCH);
                                                    }




                                            %>
                                            <tr bgcolor="AEBACD">
                                                <td height="5"><font size="2" color="#000033"><a href="../inventor/inventorCatList?parent=<%=cat.getInventorID()%>"><%=cat.getInventorName()%></a></font></td>
                                                <td height="5"><font color="#000033" size="2"><%=catType%></font></td>
                                                <td height="5"><font color="#000033" size="2"><%=MyDate.formateDate(cat.getInventorStartDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                                <td height="5"><font color="#000033" size="2"><%=endDate%></font></td>
                                                <td height="5"><font color="#000033" size="2"><%=MyCurrency.getDisplayString(cat.getInventorAmount())%></font></td>
                                                <td height="5" width="14%"><font size="2" color="#000033"><a href="../inventor/viewInventorCat?id=<%=cat.getInventorID()%>">Aktualisierung</a></font></td>
                                            </tr>
                                            <%
                                                }
                                            %>
                                            <tr bgcolor="AEBACD">
                                                <td height="6" bgcolor="AEBACD">&nbsp;</td>
                                                <td height="6" bgcolor="AEBACD">&nbsp;</td>
                                                <td height="6" bgcolor="AEBACD">&nbsp;</td>
                                                <td height="6" bgcolor="AEBACD">&nbsp;</td>
                                                <td height="6" bgcolor="AEBACD"><strong><font color="#000033" size="2"><%=totalBetrag%></font></strong></td>
                                                <td height="6" bgcolor="AEBACD">&nbsp;</td>
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
