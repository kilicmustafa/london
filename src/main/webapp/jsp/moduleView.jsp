<%@ page import="com.rheinlandprivatschule.repository.ModuleDao" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.model.Module" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Module ::</title>
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
            window.location="moduleList";
        }
    </script>
</head>
<body>
<%
    ModuleDao expdb= (ModuleDao) request.getAttribute("expdb");
    Module c = new Module();

    String catid=(String)request.getParameter("id");
    if(catid!=null){
        c=expdb.getModule(Integer.parseInt(catid));
    }else{
        String catidP=(String)request.getParameter("hidID");
        String catnameP=(String)request.getParameter("txtName");
        c.setModuleID(Integer.parseInt(catidP));
        c.setModuleName(catnameP);
        expdb.updateModule(c);
        c=expdb.getModule(c.getModuleID());
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width: 100%;" name="form1" method="post" action="moduleView">
                            <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                <tr bgcolor="657A9A">
                                    <td height="22" colspan="2">
                                        <div align="center"><b><font color="#FFFFFF">Module</font></b></div>
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="20" bgcolor="657A9A" width="26%"><b><font size="2" color="#FFFFFF">Modul
                                        ID </font></b></td>
                                    <td height="20" bgcolor="AEBACD" width="74%"><font size="2" color="#000033"><%=c.getModuleID()%>
                                        <input type="hidden" name="hidID" value="<%=c.getModuleID()%>">
                                    </font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6" bgcolor="657A9A" width="26%"><b><font size="2" color="#FFFFFF">Modulname </font></b></td>
                                    <td height="6" bgcolor="AEBACD" width="74%">
                                        <input type="text" name="txtName" value="<%=c.getModuleName()%>">
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6" bgcolor="657A9A" width="26%">&nbsp;</td>
                                    <td height="6" bgcolor="AEBACD" width="74%">
                                        <input class="btn btn-primary" type="submit" name="Submit" value="OK">
                                        <input class="btn btn-primary" type="button" name="Button" value="Zur&uuml;ck" onClick="back()">
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
