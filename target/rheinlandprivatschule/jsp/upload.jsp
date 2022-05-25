<%@ page import="com.rheinlandprivatschule.helper.FileManage" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Datei Hochladen  ::</title>
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
        function addfile()
        {
            document.form1.action = "upload?cmd=r";
            document.form1.submit();
        }
    </script>
</head>
<body>
<%
    FileManage fm= (FileManage) request.getAttribute("fileManage");

    String msg="Hochladen";

    try{
        String cmd= request.getParameter("cmd");
        if(cmd.equalsIgnoreCase("r")){
            msg="Fertig";
        }
    }catch(Exception e)	{
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
                        <table width="101%" border="0" cellspacing="0" cellpadding="0" height="434">
                            <tr>
                                <td valign="top" height="488" bgcolor="D9E5F4" width="83%">
                                    <table width="100%" border="0" cellspacing="1" cellpadding="1" height="87">
                                        <tr>
                                            <td valign="top" colspan="2"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">
                                            </font>
                                                <div align="right"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">
                                                    &nbsp; </font></div>
                                            </td>
                                        </tr>
                                        <tr bgcolor="657A9A">
                                            <td valign="top" colspan="2"><font color="#FFFFFF">W&auml;hlen
                                                Sie eine Vertrag aus :</font></td>
                                        </tr>
                                        <tr>
                                            <td valign="top" bgcolor="657A9A" height="3" width="48%"><font size="2" color="#FFFFFF"><b>Hochladen
                                                Nachricht</b></font></td>
                                            <td valign="top" bgcolor="AEBACD" height="3" width="52%"><font size="2" color="#000033"><%=msg%></font></td>
                                        </tr>
                                        <tr>
                                            <td valign="top" bgcolor="AEBACD" height="3" colspan="2">
                                                <form style="width: 100%;" name="form1" method="post" action="" ENCTYPE="multipart/form-data">
                                                    <input type="file" name="fileName" size="30">
                                                </form>
                                                <div align="right"> </div>
                                                <div align="center"> </div>
                                                <div align="center"> </div>
                                                <div align="center"> </div>
                                                <div align="center"> </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top" bgcolor="AEBACD" height="4" colspan="2">
                                                <input class="btn btn-primary" type="button" name="attach" value="Hochladen" onClick="addfile()">
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
