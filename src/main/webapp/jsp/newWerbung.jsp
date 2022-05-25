<%@ page import="com.rheinlandprivatschule.repository.WerbungDao" %>
<%@ page import="com.rheinlandprivatschule.model.Werbung" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Neur Werbung Klassifikation ::</title>
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
            window.location="werbungList"
        }


    </script>
</head>
<body>
<%
    WerbungDao wdb = (WerbungDao) request.getAttribute("werbungDao");
    Werbung werbung=new Werbung();
    String isdir="0";
    String werbungnameP=(String)request.getParameter("txtName");
    String werbungdetailP=(String)request.getParameter("detail");
    if(werbungnameP!=null){
        String isdirS=request.getParameter("isdir");
        werbung.setWerbungName(werbungnameP);
        werbung.setWerbungDetail(werbungdetailP);
        werbung.setWerbungParent(Integer.parseInt(isdirS));
        int parent=Integer.parseInt(isdirS);
        if(wdb.addWerbung(werbung)){
            if(parent!=0){
                wdb.updateWerbungParent(parent);
            }
            response.sendRedirect("werbungList");
        }else{
            String err=wdb.getError();
            session.setAttribute("err",err);
            session.setAttribute("lin","werbungList");
            response.sendRedirect("error");
        }
    }else{
        isdir=request.getParameter("isdir");
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
                        <form style="width: 100%;" name="form1" method="post" action="newWerbung">
                            <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                <tr bgcolor="657A9A">
                                    <td height="22" colspan="2">
                                        <div align="center"><b><font color="#FFFFFF">Neur
                                            Werbung</font></b></div>
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="11" bgcolor="657A9A" width="21%"><b><font size="2" color="#FFFFFF">Werbungname
                                    </font></b></td>
                                    <td height="11" bgcolor="AEBACD" width="79%">
                                        <input type="text" name="txtName">
                                        <input name="isdir" type="hidden" id="isdir" value="<%=isdir%>">
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Werbungbemerkung</font></strong></td>
                                    <td height="6" bgcolor="AEBACD"><textarea name="detail" cols="40" rows="3" id="detail"></textarea></td>
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
