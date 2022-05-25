<%@ page import="com.rheinlandprivatschule.repository.ResidenceOwnerDao" %>
<%@ page import="com.rheinlandprivatschule.repository.ResidenceDao" %>
<%@ page import="com.rheinlandprivatschule.model.Residence" %>
<%@ page import="com.rheinlandprivatschule.model.ResidenceOwner" %>
<%@ page import="com.rheinlandprivatschule.repository.ResidentEntryDao" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.model.Resident" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Wohnung Informationen ::</title>
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
        function addVer()
        {
            window.location="../../../../ResidenceVertrag/attachVertrag?residenceid="+document.form1.residenceid.value;
        }

        function back(){
            window.location="residencesList";
        }

        function residencedetail(){
            window.location="residenceUpdateForm?residenceid="+document.form1.residenceid.value;
        }
        function rentIncoming(){
            window.location="rentIncoming?residenceid="+document.form1.residenceid.value;
        }
        function rentOutgoing(){
            window.location="rentOutGoing?residenceid="+document.form1.residenceid.value;
        }
        function rechnungen(){
            window.location="showRentInTrans?residenceid="+document.form1.residenceid.value;
        }
        function neuemieter(){
            window.location="newResidentEntry?residenceid="+document.form1.residenceid.value;
        }
    </script>
</head>
<body>
<%
    Vector<Resident> mieters=new Vector();
    String mark="";
    String address="";
    String postcode="";
    String city="";
    String country="";

    String size="";
    String description="";
    double rent=0;
    double addcost=0;
    String meterno="";

    int owner=0;

    String rentstatus = "Nein";

    String lastDate="";
    int residenceid=0;

    ResidenceDao rdb= (ResidenceDao) request.getAttribute("residenceDao");
    ResidenceOwnerDao rodb= (ResidenceOwnerDao) request.getAttribute("residenceOwnerDao");
    Residence residence=new Residence();
    ResidenceOwner residenceOwner = new ResidenceOwner();
    ResidentEntryDao residentDB=new ResidentEntryDao();


    String residenceidS=(String)request.getParameter("residenceid");
    if(residenceidS!=null){
        residence=(Residence)rdb.getResidence(Integer.parseInt(residenceidS));
        mark=residence.getResidenceMark();
        address=residence.getResidenceAddress();
        postcode=residence.getResidencePostCode();
        city=residence.getResidenceCity();
        country=residence.getResidenceCountry();

        size=residence.getResidenceSize();
        description=residence.getResidenceDescription();
        rent=residence.getResidenceRent();
        addcost=residence.getResidenceSideCosts();
        meterno=residence.getResidenceMeterNumber();
        if(rdb.RESIDENCEBUSY==residence.getResidenceStatus()){
            rentstatus = "Ja";
        }
        if(residence.getVermieterMietEnd()!=null){
            lastDate= MyDate.formateDate(residence.getVermieterMietEnd(),MyDate.NUMERIC,MyDate.DEUTSCH);
        }
        owner=residence.getResidenceOwner();
        residenceOwner = rodb.getResidenceOwner(owner);
        residenceid=residence.getResidenceID();
        mieters = residentDB.getAllResidentWithoutReference(residenceid);
    }
    session.setAttribute("residenceid",residence);
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="rechnungen()">Rechnungen</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="rentIncoming()">Mieteinnahmen</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="rentOutgoing()">Mietausgaben</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="residencedetail()">Aktualisierung Wohnung</a>
                            </div>
                            <div class="wrapper" style="margin-bottom: 5px; float:right;">
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="addVer()">Vertrag</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="neuemieter()">Neue Mieter</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="back()">Z&uuml;ruck</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width: 100%;" name="form1" method="post" action="ownerDetails">
                            <input name="residenceid" type="hidden" id="residenceid" value="<%=residenceid%>">
                            <table width="100%" height="422" border="0" cellpadding="1" cellspacing="1">
                                <tr bgcolor="657A9A">
                                    <td colspan="5"><div align="center"><font size="2"><b><font color="#FFFFFF">Wohnung Informationen</font></b></font></div></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="22" colspan="5" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Wohnungsinformationen</font></strong></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="22" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Bezeichnung</font></strong></td>
                                    <td colspan="4"><font color="#000033" size="2"><%=mark%></font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td width="26%" height="22" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Addresse</font></b></td>
                                    <td colspan="4"><font color="#000033" size="2"><%=address%></font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="23" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">PLZ</font></b></td>
                                    <td colspan="4"><font color="#000033" size="2"><%=postcode%></font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="25" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Stadt</font></b></td>
                                    <td colspan="4"><font color="#000033" size="2"><%=city%></font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="20" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Land</font></b></td>
                                    <td colspan="4"><font color="#000033" size="2"><%=country%></font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="22" bgcolor="657A9A"><strong><b><font color="#FFFFFF" size="2">Gr&ouml;&szlig;e</font></b></strong></td>
                                    <td colspan="4"><font color="#000033" size="2"><%=size%></font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="20" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Warmmiete (Mieter)</font></b></td>
                                    <td colspan="4"><font color="#000033" size="2"><%=MyCurrency.getDisplayString(rent)%></font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="22" bgcolor="657A9A"><b><strong><font color="#FFFFFF" size="2">Z&auml;hlernummer</font></strong></b></td>
                                    <td colspan="4"><%=meterno%></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Vermietet</font></b></td>
                                    <td colspan="4"><font color="#000033" size="2"><%=rentstatus%></font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Bemerkung</font></b></td>
                                    <td colspan="4"><font color="#000033" size="2"><%=description%></font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td colspan="5" bgcolor="657A9A"><div align="center"><strong><font color="#FFFFFF" size="2">Vermietersinformationen</font></strong></div></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>Vermieter</b></font></td>
                                    <td colspan="4"><font color="#000033" size="2"><%=residenceOwner.getResidenceOwnerCompany()%></font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Warmmiete (Vermieter) </font></strong></td>
                                    <td colspan="4"><font color="#000033" size="2"><%=MyCurrency.getDisplayString(residence.getVermieterWarmMiete())%></font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>Nebenkosten (Mieter &amp; Vermieter)</b></font></td>
                                    <td colspan="4"><font color="#000033" size="2"><%=MyCurrency.getDisplayString(addcost)%></font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Kation (Vermieter) </font></strong></td>
                                    <td colspan="4"><font color="#000033" size="2"><%=MyCurrency.getDisplayString(residence.getVermieterKation())%></font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td bgcolor="657A9A"><font size="2" color="#FFFFFF"><strong><font color="#FFFFFF" size="2">Kation Bezahlt </font></strong></font></td>
                                    <td colspan="4"><font color="#000033" size="2"><%=MyDate.formateDate(residence.getVermieterKationPaidDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Mieteanfang</font></strong></td>
                                    <td colspan="4"><font color="#000033" size="2"><%=MyDate.formateDate(residence.getVermieterMietStart(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td bgcolor="657A9A"><font size="2"><strong><font color="#FFFFFF">Mieteende</font></strong></font></td>
                                    <td colspan="4"><font color="#000033" size="2"><%=lastDate%></font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td bgcolor="657A9A"><font size="2"><strong><font color="#FFFFFF">Wohnung Type</font></strong></font></td>
                                    <td colspan="4"><font color="#000033" size="2">
                                        <%
                                        if(residence.getResidenceType().equalsIgnoreCase("A")) {
                                        %>
                                        Gemietete Objekte
                                        <%
                                            } else if(residence.getResidenceType().equalsIgnoreCase("B")) {
                                        %>
                                        Eigene Objekte
                                        <%
                                            }
                                        %>
                                    </font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td colspan="5" bgcolor="657A9A"><div align="center"><font size="3" color="#FFFFFF"><b>Mieterliste</b></font></div></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td colspan="4" bgcolor="657A9A"><font color="#FFFFFF" size="2"><b>Summe</b></font> <div align="right"></div>                          <div align="right"><font size="2" color="#FFFFFF"></font></div><font size="2" color="#FFFFFF"></font></td>
                                    <td width="16%" bgcolor="657A9A"><div align="right"><font size="2" color="#FFFFFF"><b><%=mieters.size()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></font></div></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td colspan="2" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Vorname</font></b></td>
                                    <td width="35%" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Nachname</font></b></td>
                                    <td width="13%" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Mietanfang </font></b></td>
                                    <td bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Mietende</font></b></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <%
                                        for(int i=0;i<mieters.size();i++){
                                            Resident resident=(Resident)mieters.elementAt(i);

                                    %>
                                    <td colspan="2"><font size="2" color="#000033"><a href="mieterEntryDetails?residentid=<%= resident.getResidenceID()%>"><%=resident.getUserFirstName()%></a></font></td>
                                    <td ><font size="2" color="#000033"><%=resident.getUserLastName()%></font></td>
                                    <td ><font size="2" color="#000033"><%=MyDate.formateDate(resident.getMietStart(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                    <%
                                        if(resident.getMietEnd()==null){
                                    %>
                                    <td >&nbsp;</td>
                                    <%
                                    }else{
                                    %>
                                    <td ><font size="2" color="#000033"><%=MyDate.formateDate(resident.getMietEnd(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                    <%
                                        }
                                    %>
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
