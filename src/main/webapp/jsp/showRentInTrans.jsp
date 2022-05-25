<%@ page import="com.rheinlandprivatschule.repository.ResidenceDao" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.model.Residence" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
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
        function leave1(){
            document.form1.submit();
        }

        function goback()
        {
            window.location="residenceDetails?residenceid="+document.form1.sid.value;
        }
    </script>
</head>
<body>
<%
    ResidenceDao rdb= (ResidenceDao) request.getAttribute("residenceDao");
    Vector image=new Vector();
    Vector myTr=new Vector();

    int tranNo=0;
    double sume=0;
    String roundedEuro="";
    boolean canprint=true;
    String residenceID="0";

    String residenceIDS=(String)request.getParameter("residenceid");
    residenceID=residenceIDS;

    int residenceidN=Integer.parseInt(residenceID);

    //myTr=(Vector)session.getAttribute("specifictr");
    myTr = rdb.getRentInSeparate(residenceidN);
    if(myTr!=null){
        for(int x=0;x<myTr.size();x++){
            Residence tx=(Residence)myTr.elementAt(x);
            sume=sume+tx.getAmountPaid();
        }
        roundedEuro= MyCurrency.getDisplayString(sume);
    }else{
        String err="System erfährt einige Probleme. Versuchen Sie noch einmal.";
        session.setAttribute("err",err);
        session.setAttribute("lin","../map");
        response.sendRedirect("error");
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="leave1()">Druck</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="goback()">Zur&uuml;ck</a>

                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width: 100%;" name="form1" method="post" action="rentInPrintProcess">
                            <table width="100%" border="0" cellspacing="1" cellpadding="1">
                                <tr>
                                    <td colspan="11">
                                        <div align="right">
                                            <input name="sid" id="sid" value="<%=residenceID%>">
                                            <input name="canberprint" type="hidden" id="canberprint" value="<%=canprint%>">
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="11" bgcolor="657A9A" height="8">
                                        <div align="center"><font size="4" color="#FFFFFF"><b>Bericht
                                            Ansicht</b></font></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="7" bgcolor="657A9A" colspan="2"><font size="2" color="#FFFFFF"><b>Sume</b></font></td>
                                    <td colspan="9" height="7" bgcolor="657A9A">
                                        <div align="right"><font size="2" color="#FFFFFF"><b><%=roundedEuro%></b></font></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="3%" height="7" bgcolor="657A9A"><b></b></td>
                                    <td width="6%" height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Bericht
                                        Nr</font></b></td>
                                    <td width="11%" height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2"><strong><font color="#FFFFFF" size="2">Bezeichnung</font></strong>
                                    </font></b></td>
                                    <td width="5%" height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Miet Jahr </font></b></td>
                                    <td width="9%" height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Miet Monat</font></b></td>
                                    <td width="8%" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Betrag</font></b></td>
                                    <td width="11%" bgcolor="657A9A"><b><strong><font color="#FFFFFF" size="2">Mietzahlung</font></strong><font color="#FFFFFF" size="2"> Datum </font></b></td>
                                    <td width="11%" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">ordnung</font></b></td>
                                    <td width="10%" bgcolor="657A9A"><font size="2"><strong><font color="#FFFFFF">Mieteende</font></strong></font></td>
                                    <td width="13%" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Admin Name</font></b></td>
                                    <td width="13%" height="7" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Schule Name</font></b></td>
                                </tr>
                                <%
                                    for(int y=myTr.size()-1;y>=0;y--){
                                        Residence tt=(Residence)myTr.elementAt(y);
                                        String ordnung="";
                                        if(tt.getPaymentModeID()==1){
                                            ordnung="Bar";
                                        }else if(tt.getPaymentModeID()==2){
                                            ordnung="Abbuchung";
                                        }else if(tt.getPaymentModeID()==3){
                                            ordnung="Uberweisung";
                                        }
                                        String lastDate="";

                                        if(tt.getVermieterMietEnd()!=null){
                                            lastDate= MyDate.formateDate(tt.getVermieterMietEnd(),MyDate.NUMERIC,MyDate.DEUTSCH);
                                        }
                                %>
                                <tr bgcolor="AEBACD">
                                    <td width="3%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">
                                        <input type="checkbox" name="dr" value="<%=tt.getRentIncomingID()%>">
                                    </font></td>
                                    <td width="6%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=tt.getRentIncomingID()%></font></td>
                                    <td height="6"><font size="2" color="#000033"><font size="2" color="#000033"><a href="residenceDetails?residenceid=<%=tt.getResidenceID()%>"><%=tt.getResidenceMark()%></a></font></font></td>
                                    <td width="5%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=tt.getRentYear()%></font></td>
                                    <td width="9%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=MyDate.getMonthName(tt.getRentMonth(),MyDate.DEUTSCH)%></font></td>
                                    <td width="8%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=MyCurrency.getDisplayString(tt.getAmountPaid())%></font></td>
                                    <td width="11%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=MyDate.formateDate(tt.getRentDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                    <td width="11%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=ordnung%></font></td>
                                    <td width="10%"><font color="#000033" size="2"><%=lastDate%></font></td>
                                    <td width="13%"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=tt.getLoginName()%></font></td>
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
