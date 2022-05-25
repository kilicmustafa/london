<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.repository.ExpenseDao" %>
<%@ page import="com.rheinlandprivatschule.model.ExpenseCategory" %>
<%@ page import="com.rheinlandprivatschule.repository.PlaceDao" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.model.Place" %>
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
        function goback()
        {
            window.location="expenseCatList"
        }

    </script>
</head>
<body>
<%
    ExpenseDao edb= (ExpenseDao) request.getAttribute("expenseDao");
    PlaceDao placeDB= (PlaceDao) request.getAttribute("placeDao");
    ExpenseCategory cat=new ExpenseCategory();

    String isdir="0";

    String daySet="01";
    String monthSet="01";
    String yearSet="2006";

    String dayEnd ="01";
    String yearEnd="01";
    String monthEnd="2006";

    Vector cities= placeDB.getAllPlaces();

    String nameS=(String)request.getParameter("txtName");
    String typeS=(String)request.getParameter("selType");

    String dayS=(String)request.getParameter("selDay");
    String monthS=(String)request.getParameter("selMonth");
    String yearS=(String)request.getParameter("selYear");

    String dayE=(String)request.getParameter("selEDay");
    String monthE=(String)request.getParameter("selEMonth");
    String yearE=(String)request.getParameter("selEYear");

    String amountS=(String)request.getParameter("txtAmount");

    if(nameS!=null){

        String isdirS=request.getParameter("isdir");
        cat.setExpenseName(nameS);
        cat.setExpensePaymentType(Integer.parseInt(typeS));
        cat.setExpenseStartDate(MyDate.getSQLDateFromStrings(dayS,monthS,yearS,MyDate.DEUTSCH));

        if(Integer.parseInt(dayE)==0){
            cat.setExpenseEndDate(null);
        }else{
            cat.setExpenseEndDate(MyDate.getSQLDateFromStrings(dayE,monthE,yearE,MyDate.DEUTSCH));
        }

        cat.setExpenseAmount(Double.parseDouble(amountS));
        cat.setExpenseParent(Integer.parseInt(isdirS));

        Vector newPlacesVec=new Vector();
        String newplaces[]=request.getParameterValues("place");
        if(newplaces!=null){
            for(int iii=0;iii<newplaces.length;iii++){
                try{
                    Integer tempValue=new Integer((String)newplaces[iii]);
                    newPlacesVec.addElement(tempValue);
                }catch(Exception eee){
                }
            }
        }
        cat.setSchoolID(newPlacesVec);
        if(edb.addExpenseCategory(cat)){
            response.sendRedirect("expenseCatList");
        }else{
            String err=edb.getError();
            session.setAttribute("err",err);
            session.setAttribute("lin","expenseCatList");
            response.sendRedirect("/error");
        }
    }else{
        isdir=request.getParameter("isdir");
        dayEnd="0";
        monthEnd="0";
        yearEnd="0";
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="goback()">Zurück</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width: 100%;" name="form1" method="post" action="newExpenseCat">
                            <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                <tr bgcolor="657A9A">
                                    <td height="22" colspan="2">
                                        <div align="center"><b><font color="#FFFFFF">Bilanz Kategorie</font></b></div>
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="11" bgcolor="657A9A" width="21%"><b><font size="2" color="#FFFFFF">Kategoriename
                                    </font></b></td>
                                    <td height="11" bgcolor="AEBACD" width="79%">
                                        <input type="text" name="txtName">
                                        <input name="isdir" type="hidden" id="isdir" value="<%=isdir%>">
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Zahlungsoptionen</font></strong></td>
                                    <td height="6" bgcolor="AEBACD"><select name="selType" id="selType">
                                        <option value="1">St&uuml;ndliche</option>
                                        <option value="2">T&auml;glich</option>
                                        <option value="3">W&ouml;chentlich</option>
                                        <option value="4">Vierzehnt&auml;gig</option>
                                        <option value="5" selected>Monatlich</option>
                                        <option value="6">Viertelj&auml;hrlich</option>
                                        <option value="7">J&auml;hrlich</option>
                                    </select></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Anfangdatum</font></strong></td>
                                    <td height="6" bgcolor="AEBACD"><select name="selDay" id="selDay">
                                        <%
                                            for(int iSD=1;iSD<32;iSD++){
                                                if(iSD==Integer.parseInt(daySet))
                                                {
                                        %>
                                        <option selected><%=iSD%></option>
                                        <%
                                        }
                                        else
                                        {
                                        %>
                                        <option><%=iSD%></option>
                                        <%
                                                }
                                            }
                                        %>
                                    </select>
                                        <select name="selMonth" id="selMonth">
                                            <%
                                                Vector vtemp=new Vector();
                                                vtemp.addElement("Januar");
                                                vtemp.addElement("Februar");
                                                vtemp.addElement("M&auml;rz");
                                                vtemp.addElement("April");
                                                vtemp.addElement("Mai");
                                                vtemp.addElement("Juni");
                                                vtemp.addElement("Juli");
                                                vtemp.addElement("August");
                                                vtemp.addElement("September");
                                                vtemp.addElement("Oktober");
                                                vtemp.addElement("November");
                                                vtemp.addElement("Dezember");
                                                for(int iSM=0;iSM<vtemp.size();iSM++)
                                                {
                                                    String tempSM=(String)vtemp.elementAt(iSM);
                                                    if(monthSet.equalsIgnoreCase((iSM+1)+""))
                                                    {

                                            %>
                                            <option selected><%=tempSM%></option>
                                            <%
                                            }
                                            else
                                            {
                                            %>
                                            <option ><%=tempSM%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                        <select name="selYear" id="selYear">
                                            <%
                                                for(int iSY=2000;iSY<2029;iSY++)
                                                {
                                                    if(iSY==Integer.parseInt(yearSet))
                                                    {

                                            %>
                                            <option selected><%=iSY%></option>
                                            <%
                                            }
                                            else
                                            {
                                            %>
                                            <option ><%=iSY%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Endedatum</font></strong></td>
                                    <td height="6" bgcolor="AEBACD"><select name="selEDay">
                                        <%
                                            for(int iED=0;iED<32;iED++)
                                            {
                                                if(iED==Integer.parseInt(dayEnd))
                                                {
                                        %>
                                        <option selected><%=iED%></option>
                                        <%
                                        }
                                        else
                                        {
                                        %>
                                        <option><%=iED%></option>
                                        <%
                                                }
                                            }
                                        %>
                                    </select>
                                        <select name="selEMonth">
                                            <%
                                                Vector vtempE=new Vector();
                                                vtempE.addElement("0");
                                                vtempE.addElement("Januar");
                                                vtempE.addElement("Februar");
                                                vtempE.addElement("M&auml;rz");
                                                vtempE.addElement("April");
                                                vtempE.addElement("Mai");
                                                vtempE.addElement("Juni");
                                                vtempE.addElement("Juli");
                                                vtempE.addElement("August");
                                                vtempE.addElement("September");
                                                vtempE.addElement("Oktober");
                                                vtempE.addElement("November");
                                                vtempE.addElement("Dezember");
                                                for(int iEM=0;iEM<vtempE.size();iEM++)
                                                {
                                                    String tempEM=(String)vtempE.elementAt(iEM);
                                                    if(Integer.parseInt(monthEnd)==(iEM)){
                                            %>
                                            <option selected><%=tempEM%></option>
                                            <%
                                            }else{
                                            %>
                                            <option ><%=tempEM%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                        <select name="selEYear">
                                            <option >0</option>
                                            <%
                                                for(int iEY=2004;iEY<2029;iEY++)
                                                {
                                                    if(iEY==Integer.parseInt(yearEnd))
                                                    {
                                            %>
                                            <option selected><%=iEY%></option>
                                            <%
                                            }
                                            else
                                            {
                                            %>
                                            <option ><%=iEY%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Betrag</font></strong></td>
                                    <td height="6" bgcolor="AEBACD"><input name="txtAmount" type="text" id="txtAmount">                              </td>
                                </tr>
                                <tr >
                                    <td height="24" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Schule</font></strong></td>
                                    <td height="24" valign="top"><table width="100%"  border="0" cellspacing="1" cellpadding="1">
                                        <%
                                            for(int p=0;p<cities.size();p++){
                                                Place place=(Place)cities.elementAt(p);
                                        %>
                                        <tr bgcolor="AEBACD">
                                            <td width="10%" height="22"><input name="place" type="checkbox" id="place" value="<%=place.getPlaceID()%>"  checked></td>
                                            <td width="90%"><font color="#000033" size="2"><%=place.getPlaceName()%></font></td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                    </table></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6" bgcolor="657A9A" width="21%">&nbsp;</td>
                                    <td height="6" bgcolor="AEBACD" width="79%">
                                        <input class="btn btn-primary" type="submit" name="Submit" value="OK">
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
