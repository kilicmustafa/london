<%@ page import="com.rheinlandprivatschule.repository.MietenDB" %>
<%@ page import="com.rheinlandprivatschule.model.Resident" %>
<%@ page import="com.rheinlandprivatschule.model.Residence" %>
<%@ page import="com.rheinlandprivatschule.model.ResidenceMieten" %>
<%@ page import="com.rheinlandprivatschule.repository.ResidentDao" %>
<%@ page import="com.rheinlandprivatschule.repository.ResidenceDao" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: :: Sch&uuml;ler Information :: ::</title>
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
        function mietvertrag(){
            window.location="mietwizard?residentid="+document.form1.residentids.value;
        }

        function back()
        {
            window.location="residentsList";
        }
        function mieterinfo(){
            window.location=""+document.form1.updatestr.value;
        }



        function updateR(msg)
        {
            if(!confirm(msg)) return false
            else document.form1.submit()
        }
        function leave(msg,cod)
        {
            if(!confirm(msg))
            {
                return false
            }
            else
            {
                //process
                window.location="abmelding?courseid="+cod
                return false
            }
        }

    </script>
</head>
<body>
<%
    ResidentDao residentDB = (ResidentDao) request.getAttribute("residentDao");
    ResidenceDao rdb= (ResidenceDao) request.getAttribute("residenceDao");
    MietenDB mdb=new MietenDB();
    Resident resident = new Resident();
    Residence residence=new Residence();
    ResidenceMieten residenceMieten=new ResidenceMieten();

    String updatelink = "";

    int residentid=0;
    String firstname="";
    String lastname="";
    String birthdate="";
    String customno="";
    String remarks="";

    String mark="";
    String mietstart="";
    String mietend="";

    String valueS=(String)request.getParameter("residentid");
    try{
        residentid=Integer.parseInt(valueS);
        resident = residentDB.getResident(residentid);
        session.setAttribute("president",resident);
        if(resident.isStudent()==1){

            firstname=resident.getStudentReference().getUserFirstName();
            lastname=resident.getStudentReference().getUserLastName();
            updatelink = "../schuler/showStudentPreciseD?userid="+resident.getStudentReference().getUserID();
        }else{
            firstname=resident.getUserFirstName();
            lastname=resident.getUserLastName();
            updatelink = "residentUpdateForm?residentid="+residentid;
        }

        residenceMieten=mdb.getResidenceMietenByMieter(residentid);
        residence=rdb.getResidence(residenceMieten.getResidenceID());
        if(residence.getResidenceID()>0){
            mark=residence.getResidenceMark();
            mietstart= MyDate.formateDate(residenceMieten.getMietStart(),MyDate.NUMERIC,MyDate.DEUTSCH);
            if(residenceMieten.getMietEnd()!=null){
                mietend=MyDate.formateDate(residenceMieten.getMietEnd(),MyDate.NUMERIC,MyDate.DEUTSCH);
            }
        }

        remarks=resident.getUserRemarks();
    }catch(Exception e){
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="mietvertrag()">Mietvertrag</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="mieterinfo()">Mieter Informationen</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="back()">Zur&uuml;ck</a>

                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <table width="100%" height="343" border="0" cellpadding="1" cellspacing="1">
                            <tr bgcolor="657A9A">
                                <td height="21" colspan="3">
                                    <div align="center"><b><font size="3" color="#FFFFFF">Mieter
                                        Information</font></b></div>
                                </td>
                            </tr>
                            <tr>
                                <td width="15%" height="17" bgcolor="657A9A">
                                    <div align="center"><b><font size="2" color="#FFFFFF">Mieter
                                        Nr.</font></b></div>
                                </td>
                                <td width="43%" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Vorname</font></b></td>
                                <td width="42%" bgcolor="657A9A">
                                    <div align="left"><b><font size="2" color="#FFFFFF">Nachname</font></b></div></td>
                            </tr>
                            <tr>
                                <td width="15%" height="20" bgcolor="AEBACD"><font size="2" color="#000033"><%=residentid%></font></td>
                                <td width="43%" bgcolor="AEBACD"><font size="2" color="#000033"><%=firstname%></font></td>
                                <td bgcolor="AEBACD"><font size="2" color="#000033"><%=lastname%></font></td>
                            </tr>
                            <tr>
                                <td colspan="3" height="14" bgcolor="657A9A">
                                    <div align="center"><font color="#FFFFFF" size="3"><b>Miet Information </b></font></div>
                                </td>
                            </tr>
                            <tr valign="top">
                                <td height="43"  colspan="3"><table width="100%" height="78%" border="0" cellpadding="1" cellspacing="1">
                                    <tr bgcolor="657A9A">
                                        <td width="28%" height="20"><strong><font color="#FFFFFF" size="2">Bezeichnung</font></strong></td>
                                        <td width="39%"><strong><font color="#FFFFFF" size="2">Mieteanfang</font></strong></td>
                                        <td width="33%"><font size="2"><strong><font color="#FFFFFF">Mieteende</font></strong></font></td>
                                    </tr>
                                    <tr bgcolor="AEBACD">
                                        <td height="21"><font color="#000033" size="2"><%=mark%></font></td>
                                        <td><font color="#000033" size="2"><%=mietstart%></font></td>
                                        <td><font color="#000033" size="2"><%=mietend%></font></td>
                                    </tr>
                                </table></td>
                            </tr>
                            <tr>
                                <td height="17" colspan="3" bgcolor="657A9A">
                                    <div align="center"><b><font size="2" color="#FFFFFF">Bemerkung</font></b></div>
                                </td>
                            </tr>
                            <tr valign="top" bgcolor="AEBACD">
                                <td colspan="3" height="25">
                                    <form style="width: 100%;" name="form1" method="post" action="onlyRemark">
                                        <textarea name="textfield" cols="80" rows="6"><%=remarks%></textarea>
                                        <input name="residentids" type="hidden" id="residentids" value="<%=residentid%>">
                                        <input name="updatestr" type="hidden" id="updatestr" value="<%=updatelink%>">
                                    </form>
                                </td>
                            </tr>
                            <tr>
                                <td height="26" colspan="3" bgcolor="AEBACD">
                                    <input type="button" name="Button" value="speichern" onClick="updateR('Wollen Sie die bemerkung speisen?');return false">
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">&nbsp;
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
