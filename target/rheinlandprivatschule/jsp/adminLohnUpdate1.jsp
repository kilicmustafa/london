<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>::  Group Klasssifikation  ::</title>
    <style>
        table tr {
            border-bottom: 1px solid white;
        }

        html {
            overflow-y: hidden;
        }
    </style>


</head>
<body>
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="window.history.go(-1); return false;">Zurück</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form name="form1" method="post" action="updateLohn" style="width: 100%;">
                            <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                <tr bgcolor="657A9A">
                                    <td height="22" colspan="2">
                                        <div align="center"><b><font color="#FFFFFF">Group Klassifikation </font></b></div>
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="20" bgcolor="657A9A" width="26%"><b><font size="2" color="#FFFFFF">Klassifikation
                                        ID </font></b></td>
                                    <td height="20" bgcolor="AEBACD" width="74%">
                                        <select name="selSDay">
                                            <c:forEach begin="1" end="31" var="i" varStatus="loop">
                                                <option <c:if test="${i eq day0}">selected</c:if> >${i}</option>
                                            </c:forEach>
                                        </select>
                                        <select name="selSMonth">

                                            <option <c:if test="${Integer.parseInt(month0) eq 1}">selected</c:if>>Januar</option>

                                            <option <c:if test="${Integer.parseInt(month0) eq 2}">selected</c:if>>Februar</option>

                                            <option <c:if test="${Integer.parseInt(month0) eq 3}">selected</c:if>>März</option>

                                            <option <c:if test="${Integer.parseInt(month0) eq 4}">selected</c:if>>April</option>

                                            <option <c:if test="${Integer.parseInt(month0) eq 5}">selected</c:if>>Mai</option>

                                            <option <c:if test="${Integer.parseInt(month0) eq 6}">selected</c:if>>Juni</option>

                                            <option <c:if test="${Integer.parseInt(month0) eq 7}">selected</c:if>>Juli</option>

                                            <option <c:if test="${Integer.parseInt(month0) eq 8}">selected</c:if>>August</option>

                                            <option <c:if test="${Integer.parseInt(month0) eq 9}">selected</c:if>>September</option>

                                            <option <c:if test="${Integer.parseInt(month0) eq 10}">selected</c:if>>Oktober</option>

                                            <option <c:if test="${Integer.parseInt(month0) eq 11}">selected</c:if>>November</option>

                                            <option <c:if test="${Integer.parseInt(month0) eq 12}">selected</c:if>>Dezember</option>

                                        </select>
                                        <select name="selSYear">
                                            <c:forEach begin="2004" end="2029" var="y">
                                                <option <c:if test="${y eq year0}">selected</c:if> >${y}</option>
                                            </c:forEach>
                                        </select>
                                        <font size="2" color="#000033">
                                            <input type="hidden" name="hidID" value="${userIDN}">
                                            <input type="hidden" name="hlohntype" value="${lohnType}">
                                            <input type="hidden" name="sdate" value="${startdate}">
                                            <input type="hidden" name="edate" value="${enddate}">
                                        </font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6" bgcolor="657A9A" width="26%"><b><font size="2" color="#FFFFFF">Klassifikationname
                                    </font></b></td>
                                    <td height="6" bgcolor="AEBACD" width="74%">
                                        <select name="selEDay">
                                            <c:forEach begin="1" end="31" var="i" varStatus="loop">
                                                <option <c:if test="${i eq day}">selected</c:if> >${i}</option>
                                            </c:forEach>
                                        </select>
                                        <select name="selEMonth">

                                            <option <c:if test="${Integer.parseInt(month) eq 1}">selected</c:if>>Januar</option>

                                            <option <c:if test="${Integer.parseInt(month) eq 2}">selected</c:if>>Februar</option>

                                            <option <c:if test="${Integer.parseInt(month) eq 3}">selected</c:if>>März</option>

                                            <option <c:if test="${Integer.parseInt(month) eq 4}">selected</c:if>>April</option>

                                            <option <c:if test="${Integer.parseInt(month) eq 5}">selected</c:if>>Mai</option>

                                            <option <c:if test="${Integer.parseInt(month) eq 6}">selected</c:if>>Juni</option>

                                            <option <c:if test="${Integer.parseInt(month) eq 7}">selected</c:if>>Juli</option>

                                            <option <c:if test="${Integer.parseInt(month) eq 8}">selected</c:if>>August</option>

                                            <option <c:if test="${Integer.parseInt(month) eq 9}">selected</c:if>>September</option>

                                            <option <c:if test="${Integer.parseInt(month) eq 10}">selected</c:if>>Oktober</option>

                                            <option <c:if test="${Integer.parseInt(month) eq 11}">selected</c:if>>November</option>

                                            <option <c:if test="${Integer.parseInt(month) eq 12}">selected</c:if>>Dezember</option>

                                        </select>
                                        <select name="selEYear">
                                            <c:forEach begin="2004" end="2029" var="y">
                                                <option <c:if test="${y eq year}">selected</c:if> >${y}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Group bemerkung</font></strong></td>
                                    <td height="6" bgcolor="AEBACD"><input name="txtLohn" type="text" id="txtLohn" value="${lohnPay}"></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6" bgcolor="657A9A" width="26%">&nbsp;</td>
                                    <td height="6" bgcolor="AEBACD" width="74%">
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
