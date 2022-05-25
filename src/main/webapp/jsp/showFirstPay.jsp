<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.model.SystemUser" %>
<%@ page import="com.rheinlandprivatschule.repository.PlaceDao" %>
<%@ page import="com.rheinlandprivatschule.model.Place" %>
<%@ page import="com.rheinlandprivatschule.repository.TransactionDao" %>
<%@ page import="com.rheinlandprivatschule.model.Transaction" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Neue angemeldet Sch&uuml;ler/in Liste ::</title>
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
            window.location="searchFirstPay";
        }

    </script>
</head>
<body>
<%
    TransactionDao trdb= (TransactionDao) request.getAttribute("transactionDao");

    double sume=0;

    String placeid= request.getParameter("selPlace");
    String sDay= request.getParameter("selSDay");
    String sMonth= request.getParameter("selSMonth");
    String sYear= request.getParameter("selSYear");
    String eDay= request.getParameter("selEDay");
    String eMonth= request.getParameter("selEMonth");
    String eYear= request.getParameter("selEYear");

    java.sql.Date d1=MyDate.getSQLDateFromStrings(sDay,sMonth,sYear,MyDate.DEUTSCH);
    java.sql.Date d2=MyDate.getSQLDateFromStrings(eDay,eMonth,eYear,MyDate.DEUTSCH);
    ArrayList<Transaction> myTr=trdb.getFirstPayTransaction(d1,d2,Integer.parseInt(placeid));
		/*for(int x=0;x<myTr.size();x++){
			rps.transactions.Transaction tx=(rps.transactions.Transaction)myTr.elementAt(x);
			out.println("Paid: "+tx.getPaid());
			sume=sume+tx.getPaid();
		}*/

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
                        <form  style="width: 100%;" name="form1" method="post" action="berichtPrintProcess">
                            <table width="100%" border="0" cellspacing="1" cellpadding="1">
                                <tr>
                                    <td colspan="8" bgcolor="657A9A" height="8">
                                        <div align="center"><font size="4" color="#FFFFFF"><strong>Neue angemeldet Sch&uuml;ler/in Liste </strong></font></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="16%" height="7" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Sch&uuml;ler/in</font></strong></td>
                                    <td colspan="7" height="7" bgcolor="657A9A"><div align="right"><font color="#FFFFFF"><strong><font size="2"><%=myTr.size()%></font></strong></font></div></td>
                                </tr>
                                <tr>
                                    <td height="7" colspan="2" bgcolor="657A9A"><b></b><b></b><b><font color="#FFFFFF" size="2">Sch&uuml;ler
                                        Name</font></b></td>
                                    <td width="26%" height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Kurs
                                        Name</font></b></td>
                                    <td width="8%" height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Bezahlt </font></b></td>
                                    <td width="11%" height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Datum</font></b></td>
                                    <td width="7%" height="7" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Ordnung</font></b></td>
                                    <td width="17%" height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Admin
                                        Name</font></b></td>
                                    <td width="10%" height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Schule
                                        Name</font></b></td>
                                </tr>
                                <%
                                    for(int y=myTr.size()-1;y>=0;y--){
                                        Transaction tt= myTr.get(y);
                                        double haspaid=trdb.getPaidForCourse(tt.getStudentID(),tt.getCourseID());
                                        sume+=haspaid;
                                        String ordnung="";
                                        if(tt.getPaymentType()==0){
                                            ordnung="Bar";
                                        }else if(tt.getPaymentType()==1){
                                            ordnung="Uberweisung";
                                        }else if(tt.getPaymentType()==2){
                                            ordnung="Online";
                                        }
                                %>
                                <tr bgcolor="AEBACD">
                                    <td colspan="2"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">&nbsp;
                                    </font><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><a href="../schuler/showStudentPreciseD?userid=<%=tt.getStudentID()%>"><%=tt.getStudentCompleteName()%></a></font></td>
                                    <td width="26%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=tt.getCourseName()%></font></td>
                                    <td width="8%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=haspaid%></font></td>
                                    <td width="11%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=MyDate.formateDate(tt.getPaymentDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                    <td width="7%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=ordnung%></font></td>
                                    <td width="17%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=tt.getLoginUserCompleteName()%></font></td>
                                    <td width="10%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=tt.getPlaceName()%></font></td>
                                </tr>
                                <%
                                    }
                                %>
                                <tr bgcolor="AEBACD">
                                    <td colspan="2">&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td><strong><font color="#000033" size="2"><%=MyCurrency.getDisplayString(sume)%></font></strong></td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
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
