<%@ page import="com.rheinlandprivatschule.repository.ExpenseDao" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.model.ExpenseCategory" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Bilanz Kategorie ::</title>
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
            window.location="expenseReport";
        }
        function goback()
        {
            window.location="expenseCatList"
        }
        function newwerbungclass(){
            window.location="newExpenseCat?isdir="+document.form1.isdir.value;
        }
    </script>
</head>
<body>
<%
    ExpenseDao edb= (ExpenseDao) request.getAttribute("expenseDao");
    Vector catList=new Vector();


    String isdir="0";

    int parent=0;
    String parentS=request.getParameter("parent");
    if(parentS!=null){
        parent=Integer.parseInt(parentS);
        isdir=parentS;
    }
    catList=edb.getAllExpenseCategories(parent);
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="gotoreport()">Bilanz Bericht </a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="newwerbungclass()">Neuer Bilanzkategorie</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="goback()">Zurück</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width: 100%;" name="form1" method="post" action="">
                            <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                <tr bgcolor="657A9A">
                                    <td height="22" colspan="6"><div align="center"><b><font color="#FFFFFF">Bilanz Kategorie</font></b></div></td>
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
                                        ExpenseCategory cat=(ExpenseCategory)catList.elementAt(i);
                                        totalBetrag+=cat.getExpenseAmount();
                                        if(cat.getExpensePaymentType()==1){
                                            catType="St�ndliche";
                                        }else if(cat.getExpensePaymentType()==2){
                                            catType="T�glich";
                                        }else if(cat.getExpensePaymentType()==3){
                                            catType="W�chentlich";
                                        }else if(cat.getExpensePaymentType()==4){
                                            catType="Vierzehnt�gig";
                                        }else if(cat.getExpensePaymentType()==5){
                                            catType="Monatlich";
                                        }else if(cat.getExpensePaymentType()==6){
                                            catType="Viertelj�hrlich";
                                        }else if(cat.getExpensePaymentType()==7){
                                            catType="J�hrlich";
                                        }

                                        String endDate="";
                                        if(cat.getExpenseEndDate()==null){
                                            endDate="--.--.----";
                                        }else{
                                            endDate= MyDate.formateDate(cat.getExpenseEndDate(),MyDate.NUMERIC,MyDate.DEUTSCH);
                                        }




                                %>
                                <tr bgcolor="AEBACD">
                                    <td height="5"><font size="2" color="#000033"><a href="expenseCatList?parent=<%=cat.getExpenseID()%>"><%=cat.getExpenseName()%></a></font></td>
                                    <td height="5"><font color="#000033" size="2"><%=catType%></font></td>
                                    <td height="5"><font color="#000033" size="2"><%=MyDate.formateDate(cat.getExpenseStartDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                    <td height="5"><font color="#000033" size="2"><%=endDate%></font></td>
                                    <td height="5"><font color="#000033" size="2"><%=MyCurrency.getDisplayString(cat.getExpenseAmount())%></font></td>
                                    <td height="5" width="14%"><font size="2" color="#000033"><a href="viewExpenseCat?id=<%=cat.getExpenseID()%>">Aktualisierung</a></font></td>
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
