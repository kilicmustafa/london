<%@ page import="com.rheinlandprivatschule.repository.InsuranceDao" %>
<%@ page import="com.rheinlandprivatschule.model.Insurance" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Krankenversicherung ::</title>
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


        function back()
        {
            window.location="insuranceList"
        }
    </script>
</head>
<body>
<%
    InsuranceDao idb= (InsuranceDao) request.getAttribute("insuranceDao");
    Insurance insurance=new Insurance();


    String wid=(String)request.getParameter("id");
    if(wid!=null){
        insurance=idb.getInsurance(Integer.parseInt(wid));
    }else{
        String catidP=(String)request.getParameter("hidID");
        String catnameP=(String)request.getParameter("txtName");
        String catdescP=(String)request.getParameter("txtDesc");
        insurance.setInsuranceID(Integer.parseInt(catidP));
        insurance.setInsuranceName(catnameP);
        insurance.setInsuranceDescription(catdescP);
        if(!idb.updateInsurance(insurance))	{
            String err=idb.getError();
            session.setAttribute("err",err);
            session.setAttribute("lin","insuranceList");
            response.sendRedirect("error");
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="back()">Zur&uuml;ck</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td valign="top" height="146" bgcolor="D9E5F4" width="85%">
                                    <table width="100%" border="0" height="120">
                                        <tr>
                                            <td height="423" valign="top">
                                                <form style="width: 100%;" name="form1" method="post" action="viewInsurance">
                                                    <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                                        <tr bgcolor="657A9A">
                                                            <td height="22" colspan="2">
                                                                <div align="center"><b><font color="#FFFFFF">Krankenversicherung</font></b></div>
                                                            </td>
                                                        </tr>
                                                        <tr bgcolor="AEBACD">
                                                            <td height="20" bgcolor="657A9A" width="26%"><b><font size="2" color="#FFFFFF">Krankenversicherung
                                                                ID </font></b></td>
                                                            <td height="20" bgcolor="AEBACD" width="74%"><font size="2" color="#000033"><%=insurance.getInsuranceID()%>
                                                                <input type="hidden" name="hidID" value="<%=insurance.getInsuranceID()%>">
                                                            </font></td>
                                                        </tr>
                                                        <tr bgcolor="AEBACD">
                                                            <td height="6" bgcolor="657A9A" width="26%"><b><font size="2" color="#FFFFFF">Krankenversicherung N ame
                                                            </font></b></td>
                                                            <td height="6" bgcolor="AEBACD" width="74%">
                                                                <input type="text" name="txtName" value="<%=insurance.getInsuranceName()%>">
                                                            </td>
                                                        </tr>
                                                        <tr bgcolor="AEBACD">
                                                            <td height="6" bgcolor="657A9A" width="26%"><b><font size="2" color="#FFFFFF">Austatung</font></b></td>
                                                            <td height="6" bgcolor="AEBACD" width="74%">
                                                                <textarea name="txtDesc" cols="25" rows="5"><%=insurance.getInsuranceDescription()%></textarea>
                                                            </td>
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
