<%@ page import="com.rheinlandprivatschule.repository.ResidenceDao" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.model.Resident" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Mieterliste ::</title>
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
        function newmieter(){
            window.location="newResidentForm";
        }
    </script>
</head>
<body>
<%
    ResidenceDao residentDB= (ResidenceDao) request.getAttribute("residenceDao");

    Vector students = residentDB.getAllResidentbyStudentReference();
    Vector mieters = residentDB.getAllResidentWithoutReference();
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="newmieter()">Neuer Mieter</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width: 100%;" name="form1" method="post" action="">
                            <table width="100%" border="0" cellpadding="1" cellspacing="1">

                                <tr>
                                    <td bgcolor="657A9A" height="17">
                                        <div align="center"><font size="3" color="#FFFFFF"><b>Mieterliste (Sch&uuml;ler) </b></font></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                            <tr>
                                                <td height="20" bgcolor="657A9A" width="41%"><font color="#FFFFFF" size="2"><b>Summe</b></font></td>
                                                <td height="20" bgcolor="657A9A" colspan="2">
                                                    <div align="right"><font size="2" color="#FFFFFF"><b><%=students.size()%></b></font></div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="20" bgcolor="657A9A" width="41%"><b><font size="2" color="#FFFFFF">Vorname</font></b></td>
                                                <td height="20" bgcolor="657A9A" width="39%"><b><font size="2" color="#FFFFFF">Nachname</font></b></td>
                                                <td height="20" bgcolor="657A9A" width="20%"><b><font size="2" color="#FFFFFF">Geburtsdatum</font></b></td>
                                            </tr>
                                            <%
                                                for(int i=0;i<students.size();i++){
                                                    Resident resident=(Resident)students.elementAt(i);
                                            %>
                                            <tr bgcolor="AEBACD">
                                                <td><font size="2" color="#000000"><a href="mieterDetails?residentid=<%= resident.getUserID()%>"><%=resident.getStudentReference().getUserFirstName()%></a></font></td>
                                                <td bgcolor="AEBACD"><font size="2" color="#000000"><%=resident.getStudentReference().getUserLastName()%></font></td>
                                                <td bgcolor="AEBACD"><font size="2" color="#000000"><%=MyDate.formateDate(resident.getStudentReference().getUserBirthDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                            </tr>
                                            <%
                                                }
                                            %>
                                            <tr bgcolor="AEBACD">
                                                <td colspan="3">&nbsp;</td>
                                            </tr>
                                            <tr bgcolor="657A9A">
                                                <td colspan="3"><div align="center"><font size="3" color="#FFFFFF"><b>Mieterliste (Nicht Sch&uuml;ler)</b></font></div></td>
                                            </tr>
                                            <tr bgcolor="657A9A">
                                                <td><font color="#FFFFFF" size="2"><b>Summe</b></font></td>
                                                <td colspan="2"><div align="right"><font size="2" color="#FFFFFF"><b><%=mieters.size()%></b></font></div></td>
                                            </tr>
                                            <tr bgcolor="657A9A">
                                                <td><b><font size="2" color="#FFFFFF">Vorname</font></b></td>
                                                <td><b><font size="2" color="#FFFFFF">Nachname</font></b></td>
                                                <td><b><font size="2" color="#FFFFFF">Geburtsdatum</font></b></td>
                                            </tr>
                                            <%
                                                for(int i=0;i<mieters.size();i++){
                                                    Resident resident=(Resident)mieters.elementAt(i);

                                            %>
                                            <tr bgcolor="AEBACD">
                                                <td><font size="2" color="#000000"><a href="mieterDetails?residentid=<%= resident.getUserID()%>"><%=resident.getUserFirstName()%></a></font></td>
                                                <td bgcolor="AEBACD"><font size="2" color="#000000"><%=resident.getUserLastName()%></font></td>
                                                <td bgcolor="AEBACD"><font size="2" color="#000000"><%=MyDate.formateDate(resident.getUserBirthDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                            </tr>
                                            <%
                                                }
                                            %>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <p>&nbsp;</p>
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
