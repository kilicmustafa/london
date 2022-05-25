<%@ page import="com.rheinlandprivatschule.repository.InsuranceDao" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.rheinlandprivatschule.model.Insurance" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Krankenversicherung Liste ::</title>
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
        function newinsurance()
        {
            window.location="newInsurance";
        }

    </script>
</head>
<body>
<%
    InsuranceDao idb= (InsuranceDao) request.getAttribute("insuranceDao");
    ArrayList insuranceList=idb.getAllInsurances();

    Student u=(Student)session.getAttribute("pstudent");
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="newinsurance()">Neue Krankenversicherung</a>

                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <table width="100%" border="0" cellpadding="1" cellspacing="1">
                            <tr bgcolor="657A9A">
                                <td height="22" colspan="3">
                                    <div align="center"><b><font color="#FFFFFF">Krankenversicherung Liste</font></b></div>
                                </td>
                            </tr>
                            <tr bgcolor="657A9A">
                                <td height="6" width="67%"><b><font color="#FFFFFF" size="2">Krankenversicherung</font></b></td>
                                <td height="6" width="17%"><b><font color="#FFFFFF" size="2">Zahl
                                    von Studenten</font></b></td>
                                <td height="6" width="16%">&nbsp;</td>
                            </tr>
                            <%
                                Iterator insuranceListIT=insuranceList.iterator();
                                while(insuranceListIT.hasNext())
                                {
                                    Insurance insurance=(Insurance)insuranceListIT.next();
                                    int tempCount=idb.countAssociatedInsurances(insurance.getInsuranceID());
                            %>
                            <tr bgcolor="AEBACD">
                                <td height="5" width="67%"><font size="2" color="#000033"><a href="insuranceStudentList?wid=<%=insurance.getInsuranceID()%>"><%=insurance.getInsuranceName()%></a></font></td>
                                <td height="5" width="17%"><font size="2" color="#000033"><%=tempCount%></font></td>
                                <td height="5" width="16%"><font size="2" color="#000033"><a href="viewInsurance?id=<%=insurance.getInsuranceID()%>">Aktualisierung</a></font></td>
                            </tr>
                            <%
                                }
                            %>
                            <tr bgcolor="AEBACD">
                                <td height="6" bgcolor="AEBACD" colspan="3">&nbsp; </td>
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
