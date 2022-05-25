<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.model.InventorCategory" %>
<%@ page import="com.rheinlandprivatschule.model.Place" %>
<%@ page import="com.rheinlandprivatschule.repository.InventorDao" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.repository.PlaceDao" %>
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
        function haupt()
        {
            window.location="../map";
        }
        function back()
        {
            window.location="inventorCatList"
        }

    </script>
</head>
<body>
<%
    InventorDao edb= (InventorDao) request.getAttribute("inventorDao");
    PlaceDao placeDao= (PlaceDao) request.getAttribute("placeDao");

    InventorCategory cat=new InventorCategory();

    String daySet="01";
    String monthSet="01";
    String yearSet="2006";

    String dayEnd ="01";
    String yearEnd="01";
    String monthEnd="2006";

    int catType=0;
    Vector cities= placeDao.getAllPlaces();

    String cid=(String)request.getParameter("id");
    if(cid!=null){
        cat=edb.getInventorCategory(Integer.parseInt(cid));
        daySet=MyDate.getDay(cat.getInventorStartDate());
        monthSet=MyDate.getMonth(cat.getInventorStartDate());
        yearSet=MyDate.getYear(cat.getInventorStartDate());

        if(cat.getInventorEndDate()==null){
            dayEnd="0";
            monthEnd="0";
            yearEnd="0";
        }else{
            dayEnd=MyDate.getDay(cat.getInventorEndDate());
            monthEnd=MyDate.getMonth(cat.getInventorEndDate());
            yearEnd=MyDate.getYear(cat.getInventorEndDate());
        }

        catType=cat.getInventorPaymentType();
    }else{
        String catidP=(String)request.getParameter("hidID");
        cat=edb.getInventorCategory(Integer.parseInt(catidP));

        String nameS=(String)request.getParameter("txtName");
        String typeS=(String)request.getParameter("selType");

        String dayS=(String)request.getParameter("selDay");
        String monthS=(String)request.getParameter("selMonth");
        String yearS=(String)request.getParameter("selYear");

        String dayE=(String)request.getParameter("selEDay");
        String monthE=(String)request.getParameter("selEMonth");
        String yearE=(String)request.getParameter("selEYear");

        String amountS=(String)request.getParameter("txtAmount");
        cat.setInventorName(nameS);
        cat.setInventorPaymentType(Integer.parseInt(typeS));
        cat.setInventorStartDate(MyDate.getSQLDateFromStrings(dayS,monthS,yearS,MyDate.DEUTSCH));

        if(Integer.parseInt(dayE)==0){
            cat.setInventorEndDate(null);
        }else{
            cat.setInventorEndDate(MyDate.getSQLDateFromStrings(dayE,monthE,yearE,MyDate.DEUTSCH));
        }

        cat.setInventorAmount(Double.parseDouble(amountS));

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

        if(!edb.updateInventorCategory(cat))	{
            String err=edb.getError();
            session.setAttribute("err",err);
            session.setAttribute("lin","inventorCatList");
            response.sendRedirect("error");
        }else{
            response.sendRedirect("inventorCatList");
        }
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="gotoreport()">Inventor Bericht</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="back()">Zur&uuml;ck</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <table width="100%" border="0" height="120">
                            <tr>
                                <td height="423" valign="top">
                                    <form style="width: 100%;" name="form1" method="post" action="../inventor/viewInventorCat">
                                        <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                            <tr bgcolor="657A9A">
                                                <td height="22" colspan="2">
                                                    <div align="center"><b><font color="#FFFFFF">inventar Kategorie</font></b></div>
                                                </td>
                                            </tr>
                                            <tr bgcolor="AEBACD">
                                                <td height="6" bgcolor="657A9A" width="26%"><b><font size="2" color="#FFFFFF">Kategoriename </font></b></td>
                                                <td height="6" bgcolor="AEBACD" width="74%">
                                                    <input name="txtName" type="text" value="<%=cat.getInventorName()%>">
                                                    <font size="2" color="#000033">
                                                        <input type="hidden" name="hidID" value="<%=cat.getInventorID()%>">
                                                    </font></td>
                                            </tr>
                                            <tr bgcolor="AEBACD">
                                                <td height="6" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Zahlungsoptionen</font></strong></td>
                                                <td height="6" bgcolor="AEBACD">
                                                    <select name="selType" id="selType">
                                                        <%

                                                            Vector cattypelist=new Vector();
                                                            cattypelist.addElement("Stündliche");
                                                            cattypelist.addElement("Täglich");
                                                            cattypelist.addElement("Wöchentlich");
                                                            cattypelist.addElement("Vierzehntägig");
                                                            cattypelist.addElement("Monatlich");
                                                            cattypelist.addElement("Vierteljährlich");
                                                            cattypelist.addElement("Jährlich");
                                                            for(int catM=0;catM<cattypelist.size();catM++)
                                                            {
                                                                String catTypeName=(String)cattypelist.elementAt(catM);
                                                                if(catType==(catM+1))
                                                                {


                                                        %>
                                                        <option value="<%=(catM+1)%>" selected><%=catTypeName%></option>
                                                        <%
                                                        }
                                                        else
                                                        {
                                                        %>
                                                        <option value="<%=(catM+1)%>"><%=catTypeName%></option>
                                                        <%
                                                                }
                                                            }
                                                        %>

                                                    </select>
                                                </td>
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
                                                <td height="6" bgcolor="AEBACD"><input name="txtAmount" type="text" id="txtAmount" value="<%=cat.getInventorAmount()%>"></td>
                                            </tr>
                                            <tr >
                                                <td height="6" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Schule</font></strong></td>
                                                <td height="6"><table width="100%"  border="0" cellspacing="1" cellpadding="1">
                                                    <%
                                                        for(int p=0;p<cities.size();p++){
                                                            Place place=(Place)cities.elementAt(p);
                                                            Vector cityToCheck=cat.getSchoolID();
                                                            boolean existFlag=false;
                                                            for(int k=0;k<cityToCheck.size();k++){
                                                                Integer integerValue=(Integer)cityToCheck.elementAt(k);
                                                                if(place.getPlaceID()==integerValue.intValue()){
                                                                    existFlag=true;
                                                                }
                                                            }
                                                            if(existFlag){
                                                    %>
                                                    <tr bgcolor="AEBACD">
                                                        <td width="10%" height="22"><input name="place" type="checkbox" id="place" value="<%=place.getPlaceID()%>"  checked></td>
                                                        <td width="90%"><font color="#000033" size="2"><%=place.getPlaceName()%></font></td>
                                                    </tr>
                                                    <%
                                                    }else{
                                                    %>
                                                    <tr bgcolor="AEBACD">
                                                        <td width="10%" height="22"><input name="place" type="checkbox" id="place" value="<%=place.getPlaceID()%>"></td>
                                                        <td width="90%"><font color="#000033" size="2"><%=place.getPlaceName()%></font></td>
                                                    </tr>
                                                    <%
                                                            }
                                                        }
                                                    %>
                                                </table></td>
                                            </tr>
                                            <tr bgcolor="AEBACD">
                                                <td height="6" bgcolor="657A9A" width="26%">&nbsp;</td>
                                                <td height="6" bgcolor="AEBACD" width="74%">
                                                    <input class="btn btn-primary" type="submit" name="Submit" value="OK">
                                                </td>
                                            </tr>
                                        </table>
                                    </form>
                                </td>
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
