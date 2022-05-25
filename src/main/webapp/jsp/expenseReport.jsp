<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.model.ExpenseCategory" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ page import="com.rheinlandprivatschule.model.Place" %>
<%@ page import="java.sql.Date" %>
<%@ page import="com.rheinlandprivatschule.repository.ExpenseDao" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Bilanz Bericht ::</title>
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="/balanz/expenseCatList">Bilanz Kategorie</a>
                            </div>
                            <div class="wrapper" style="margin-bottom: 5px; float:right;">

                                <a style="margin-right: 5px;" class="btn btn-primary" href="/bericht/searchFirstPay">Neue angemeldete Schüler/in</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="/bericht/searchNullGebTran">Null Gebühren</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="/bericht/searchEmployeeTimeSheet">Mitarbeiter ansicht</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="/stundenplan/stlohnEmployee">Mitarbeiter stundenlohn</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form name="form1" method="post" action="">
                            <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                <tr bgcolor="657A9A">
                                    <td height="22" colspan="2" bgcolor="657A9A"><div align="center"><strong><font color="#FFFFFF" size="3">Bilanz Bericht </font></strong></div></td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td width="17%" height="22" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Anfangdatum</font></strong></td>
                                    <td width="83%" bgcolor="AEBACD">
                                        <select name="selSDay">
                                            <c:forEach begin="1" end="31" var="i" varStatus="loop">
                                                <option <c:if test="${i eq day0}">selected</c:if> >${i}</option>
                                            </c:forEach>
                                        </select>
                                        <select name="selSMonth">

                                            <option <c:if test="${Integer.parseInt(month0) eq 1}">selected</c:if>>Januar</option>

                                            <option <c:if test="${Integer.parseInt(month0) eq 2}">selected</c:if>>Februar</option>

                                            <option <c:if test="${Integer.parseInt(month0) eq 3}">selected</c:if>>März</option>

                                            <option <c:if test="${Integer.parseInt(month0) eq 4}">selected</c:if>>April</option>

                                            <option <c:if test="${Integer.parseInt(month0) eq 5}">selected</c:if>>Mai</option>

                                            <option <c:if test="${Integer.parseInt(month0) eq 6}">selected</c:if>>Juni</option>

                                            <option <c:if test="${Integer.parseInt(month0) eq 7}">selected</c:if>>Juli</option>

                                            <option <c:if test="${Integer.parseInt(month0) eq 8}">selected</c:if>>August</option>

                                            <option <c:if test="${Integer.parseInt(month0) eq 9}">selected</c:if>>September</option>

                                            <option <c:if test="${Integer.parseInt(month0) eq 10}">selected</c:if>>Oktober</option>

                                            <option <c:if test="${Integer.parseInt(month0) eq 11}">selected</c:if>>November</option>

                                            <option <c:if test="${Integer.parseInt(month0) eq 12}">selected</c:if>>Dezember</option>

                                        </select>
                                        <select name="selSYear">
                                            <c:forEach begin="2004" end="2029" var="y">
                                                <option <c:if test="${y eq year0}">selected</c:if> >${y}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td height="22" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Endedatum</font></strong></td>
                                    <td height="22" bgcolor="AEBACD">
                                        <select name="selEDay">
                                            <c:forEach begin="1" end="31" var="i" varStatus="loop">
                                                <option <c:if test="${i eq day}">selected</c:if> >${i}</option>
                                            </c:forEach>
                                        </select>
                                        <select name="selEMonth">

                                            <option <c:if test="${Integer.parseInt(month) eq 1}">selected</c:if>>Januar</option>

                                            <option <c:if test="${Integer.parseInt(month) eq 2}">selected</c:if>>Februar</option>

                                            <option <c:if test="${Integer.parseInt(month) eq 3}">selected</c:if>>März</option>

                                            <option <c:if test="${Integer.parseInt(month) eq 4}">selected</c:if>>April</option>

                                            <option <c:if test="${Integer.parseInt(month) eq 5}">selected</c:if>>Mai</option>

                                            <option <c:if test="${Integer.parseInt(month) eq 6}">selected</c:if>>Juni</option>

                                            <option <c:if test="${Integer.parseInt(month) eq 7}">selected</c:if>>Juli</option>

                                            <option <c:if test="${Integer.parseInt(month) eq 8}">selected</c:if>>August</option>

                                            <option <c:if test="${Integer.parseInt(month) eq 9}">selected</c:if>>September</option>

                                            <option <c:if test="${Integer.parseInt(month) eq 10}">selected</c:if>>Oktober</option>

                                            <option <c:if test="${Integer.parseInt(month) eq 11}">selected</c:if>>November</option>

                                            <option <c:if test="${Integer.parseInt(month) eq 12}">selected</c:if>>Dezember</option>

                                        </select>
                                        <select name="selEYear">
                                            <c:forEach begin="2000" end="2029" var="y">
                                                <option <c:if test="${y eq year}">selected</c:if> >${y}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td height="22" bgcolor="657A9A"><input name="cmd" type="hidden" id="cmd" value="cmd"></td>
                                    <td height="22" bgcolor="AEBACD"><input class="btn btn-primary" type="submit" name="Submit" value="Bilanz"></td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td height="22" colspan="2" bgcolor="657A9A"><div align="center"><b><font color="#FFFFFF">Bilanz von ${displayFirstDate} - ${displayEndDate} </font></b></div></td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td height="6" colspan="2"><div align="center"><strong><font color="#FFFFFF">Kosten</font></strong></div></td>
                                </tr>
                                <tr >
                                    <td height="6" colspan="2">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                            <tr bgcolor="657A9A">
                                                <td width="417">
                                                    <b><font size="2" color="#FFFFFF">
                                                        Kategorie
                                                    </font></b>
                                                </td>
                                                <c:forEach items="${placeList}" var="p">
                                                    <td width="90" >
                                                        <b><font size="2" color="#FFFFFF">
                                                            ${p.placeName}
                                                        </font></b>
                                                    </td>
                                                </c:forEach>
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
                                                Vector placeList = (Vector) request.getAttribute("placeList");
                                                Vector catList = (Vector) request.getAttribute("catList");
                                                java.sql.Date firstDate = (Date) request.getAttribute("firstDate");
                                                java.sql.Date lastDate = (Date) request.getAttribute("lastDate");
                                            %>
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
                                                    ExpenseCategory tempCategory=(ExpenseCategory)catList.elementAt(i);

                                                    if(tempCategory.getExpenseID()==0){
                                                        subTotalDisplay=MyCurrency.getDisplayString(subTotal);
                                                        subTotal=0;
                                                        gesamt="";
                                            %>
                                            <tr bgcolor="AEBACD">
                                                <td bgcolor="AEBACD" width="417">
                                                    <font size="2" color="AEBACD">
                                                        <%=tempCategory.getIndentation()%>
                                                    </font>
                                                    <font size="2" color="#000033">Kategorie
                                                        <%=tempCategory.getExpenseName()%>
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

                                                if(tempCategory.getExpenseAmount()==0){
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
                                                        <a href="viewExpenseCat?id=<%=tempCategory.getExpenseID()%>"><%=tempCategory.getExpenseName()%></a>
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


                                            <tr bgcolor="AEBACD">
                                                <td><font color="#000033" size="2"><a href="../bericht/lohnExpenses">Lehrer/in Auszahlungsbetrag</a></font></td>
                                                <% ExpenseDao edb = (ExpenseDao) request.getAttribute("edb"); %>
                                                <%
                                                    subTotal=0;
                                                    for(int ii=0;ii<placeList.size();ii++){
                                                        Place tempPlace=(Place)placeList.elementAt(ii);
                                                        double tempValue =edb.paymentToTeachers(tempPlace.getPlaceID(),firstDate,lastDate);
                                                        lastTotal[ii] += tempValue;
                                                        subTotal+=tempValue;
                                                %>
                                                <td width="90">
                                                    <font size="2" color="#000033">
                                                        <a href="expenseReportTeacherView?placeID=<%=tempPlace.getPlaceID()%>&firstDate=<%=firstDate%>&lastDate=<%=lastDate%>"><%=MyCurrency.getDisplayString(tempValue)%></a>
                                                    </font>
                                                </td>
                                                <%
                                                    }
                                                    gesamt=MyCurrency.getDisplayString(subTotal);
                                                    lastGesamtTotal+=subTotal;
                                                %>
                                                <td>&nbsp;</td>
                                                <td ><font size="2" color="#000033"><%=gesamt%></font></td>
                                                <td bgcolor="AEBACD" ><b><font size="2" color="#000033"></font></b></td>
                                            </tr>
                                            <tr bgcolor="657A9A">
                                                <td bgcolor="657A9A"><strong><font color="#990000" size="2">Kostensumme</font></strong></td>
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
                                            <tr bgcolor="AEBACD">
                                                <td>&nbsp;</td>
                                                <%
                                                    for(int ii=0;ii<placeList.size();ii++){
                                                %>
                                                <td width="90">

                                                </td>
                                                <%
                                                    }

                                                %>
                                                <td>&nbsp;</td>
                                                <td >&nbsp;</td>
                                                <td >&nbsp;</td>
                                            </tr>
                                            <tr bgcolor="AEBACD">
                                                <td><font color="#000033" size="2">Einnahmen</font></td>
                                                <%
                                                    subTotal=0;
                                                    for(int ii=0;ii<placeList.size();ii++){
                                                        Place tempPlace=(Place)placeList.elementAt(ii);
                                                        double tempValue =edb.incomeOfSchool(tempPlace.getPlaceID(),firstDate,lastDate);
                                                        lastTotalBalance[ii] += tempValue;
                                                        subTotal+=tempValue;
                                                %>
                                                <td>
                                                    <font size="2" color="#000033">
                                                        <a href="incomeReportCourseView?placeID=<%=tempPlace.getPlaceID()%>&firstDate=<%=firstDate%>&lastDate=<%=lastDate%>"><%=MyCurrency.getDisplayString(tempValue)%></a>
                                                    </font>
                                                </td>
                                                <%
                                                    }
                                                    gesamt=MyCurrency.getDisplayString(subTotal);
                                                    lastGesamtTotalBalance+=subTotal;
                                                %>
                                                <td>&nbsp;</td>
                                                <td ><font size="2" color="#000033"><%=gesamt%></font></td>
                                                <td ><b><font size="2" color="#000033"></font></b></td>
                                            </tr>
                                            <tr bgcolor="657A9A">
                                                <td><strong><font color="#66CC00" size="2">Einnahmensumme</font></strong></td>
                                                <%
                                                    for(int ii=0;ii<placeList.size();ii++){
                                                        Place tempPlace=(Place)placeList.elementAt(ii);
                                                %>
                                                <td width="90">
                                                    <b><font size="2" color="#66CC00">
                                                        <%=MyCurrency.getDisplayString(lastTotalBalance[ii])%>
                                                    </font></b>
                                                </td>
                                                <%
                                                    }
                                                %>
                                                <td>&nbsp;</td>
                                                <td bgcolor="657A9A" ><b><font size="2" color="#66CC00"><%=MyCurrency.getDisplayString(lastGesamtTotalBalance)%></font></b></td>
                                                <td >&nbsp;</td>
                                            </tr>
                                            <tr bgcolor="AEBACD">
                                                <td>&nbsp;</td>
                                                <%
                                                    for(int ii=0;ii<placeList.size();ii++){
                                                %>
                                                <td width="90">

                                                </td>
                                                <%
                                                    }

                                                %>
                                                <td></td>
                                                <td >&nbsp;</td>
                                                <td >&nbsp;</td>
                                            </tr>
                                            <tr bgcolor="657A9A">
                                                <td><b><font color="#FFFFFF" size="2">Bilanz</font></b></td>
                                                <%
                                                    for(int ii=0;ii<placeList.size();ii++){
                                                        Place tempPlace=(Place)placeList.elementAt(ii);
                                                %>
                                                <td width="90">
                                                    <b><font size="2" color="#FFFFFF">
                                                        <%=MyCurrency.getDisplayString(lastTotalBalance[ii]-lastTotal[ii])%>
                                                    </font></b>
                                                </td>
                                                <%
                                                    }
                                                %>
                                                <td></td>
                                                <td bgcolor="657A9A" ><b><font size="2" color="#FFFFFF"><%=MyCurrency.getDisplayString(lastGesamtTotalBalance-lastGesamtTotal)%></font></b></td>
                                                <td ><b><font size="2" color="#FFFFFF"></font></b></td>
                                            </tr>
                                        </table>
                                    </td>
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
