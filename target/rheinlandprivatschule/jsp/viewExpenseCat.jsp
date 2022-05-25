<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Bilanz Kategorie ::</title>
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

    </script>
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="/balanz/expenseReport">Bilanz Bericht</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="window.history.go(-1); return false;">Zurück</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width: 100%;" name="form1" method="post" action="viewExpenseCat">
                            <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                <tr bgcolor="657A9A">
                                    <td height="22" colspan="2">
                                        <div align="center"><b><font color="#FFFFFF">Bilanz Kategorie</font></b></div>
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6" bgcolor="657A9A" width="26%"><b><font size="2" color="#FFFFFF">Kategoriename </font></b></td>
                                    <td height="6" bgcolor="AEBACD" width="74%">
                                        <input name="txtName" type="text" value="${cat.expenseName}">
                                        <font size="2" color="#000033">
                                            <input type="hidden" name="hidID" value="${cat.expenseID}">
                                        </font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Zahlungsoptionen</font></strong></td>
                                    <td height="6" bgcolor="AEBACD">
                                        <select name="selType" id="selType">
                                            <c:forEach items="${cattypelist}" var="ctl">
                                                <c:if test="${catType eq cattypelist.indexOf(ctl) + 1}">
                                                    <option value="${catType}" selected>${ctl}</option>
                                                </c:if>
                                                <c:if test="${catType != cattypelist.indexOf(ctl) + 1}">
                                                    <option value="${cattypelist.indexOf(ctl) + 1}" >${ctl}</option>
                                                </c:if>
                                            </c:forEach>
                                        </select>
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Anfangdatum</font></strong></td>
                                    <td height="6" bgcolor="AEBACD">
                                        <select name="selSDay">
                                            <c:forEach begin="1" end="31" var="i" varStatus="loop">
                                                <option <c:if test="${i eq daySet}">selected</c:if> >${i}</option>
                                            </c:forEach>
                                        </select>
                                        <select name="selSMonth">

                                            <option <c:if test="${Integer.parseInt(monthSet) eq 1}">selected</c:if>>Januar</option>

                                            <option <c:if test="${Integer.parseInt(monthSet) eq 2}">selected</c:if>>Februar</option>

                                            <option <c:if test="${Integer.parseInt(monthSet) eq 3}">selected</c:if>>März</option>

                                            <option <c:if test="${Integer.parseInt(monthSet) eq 4}">selected</c:if>>April</option>

                                            <option <c:if test="${Integer.parseInt(monthSet) eq 5}">selected</c:if>>Mai</option>

                                            <option <c:if test="${Integer.parseInt(monthSet) eq 6}">selected</c:if>>Juni</option>

                                            <option <c:if test="${Integer.parseInt(monthSet) eq 7}">selected</c:if>>Juli</option>

                                            <option <c:if test="${Integer.parseInt(monthSet) eq 8}">selected</c:if>>August</option>

                                            <option <c:if test="${Integer.parseInt(monthSet) eq 9}">selected</c:if>>September</option>

                                            <option <c:if test="${Integer.parseInt(monthSet) eq 10}">selected</c:if>>Oktober</option>

                                            <option <c:if test="${Integer.parseInt(monthSet) eq 11}">selected</c:if>>November</option>

                                            <option <c:if test="${Integer.parseInt(monthSet) eq 12}">selected</c:if>>Dezember</option>

                                        </select>
                                        <select name="selSYear">
                                            <c:forEach begin="2004" end="2029" var="y">
                                                <option <c:if test="${y eq yearSet}">selected</c:if> >${y}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Endedatum</font></strong></td>
                                    <td height="6" bgcolor="AEBACD">
                                        <select name="selEDay">
                                            <c:forEach begin="1" end="31" var="i" varStatus="loop">
                                                <option <c:if test="${i eq dayEnd}">selected</c:if> >${i}</option>
                                            </c:forEach>
                                        </select>
                                        <select name="selEMonth">

                                            <option <c:if test="${Integer.parseInt(monthEnd) eq 1}">selected</c:if>>Januar</option>

                                            <option <c:if test="${Integer.parseInt(monthEnd) eq 2}">selected</c:if>>Februar</option>

                                            <option <c:if test="${Integer.parseInt(monthEnd) eq 3}">selected</c:if>>März</option>

                                            <option <c:if test="${Integer.parseInt(monthEnd) eq 4}">selected</c:if>>April</option>

                                            <option <c:if test="${Integer.parseInt(monthEnd) eq 5}">selected</c:if>>Mai</option>

                                            <option <c:if test="${Integer.parseInt(monthEnd) eq 6}">selected</c:if>>Juni</option>

                                            <option <c:if test="${Integer.parseInt(monthEnd) eq 7}">selected</c:if>>Juli</option>

                                            <option <c:if test="${Integer.parseInt(monthEnd) eq 8}">selected</c:if>>August</option>

                                            <option <c:if test="${Integer.parseInt(monthEnd) eq 9}">selected</c:if>>September</option>

                                            <option <c:if test="${Integer.parseInt(monthEnd) eq 10}">selected</c:if>>Oktober</option>

                                            <option <c:if test="${Integer.parseInt(monthEnd) eq 11}">selected</c:if>>November</option>

                                            <option <c:if test="${Integer.parseInt(monthEnd) eq 12}">selected</c:if>>Dezember</option>

                                        </select>
                                        <select name="selEYear">
                                            <c:forEach begin="2000" end="2029" var="y">
                                                <option <c:if test="${y eq yearEnd}">selected</c:if> >${y}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Betrag</font></strong></td>
                                    <td height="6" bgcolor="AEBACD"><input name="txtAmount" type="text" id="txtAmount" value="${cat.expenseAmount}"></td>
                                </tr>
                                <tr >
                                    <td height="6" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Schule</font></strong></td>
                                    <td height="6"><table width="100%"  border="0" cellspacing="1" cellpadding="1">
                                        <c:forEach items="${cities}" var="city">
                                            <c:set var="existFlag" value="false"/>
                                            <c:forEach items="${cat.schoolID}" var="cityToCheck">
                                                <c:if test="${cityToCheck.intValue() eq city.placeID}">
                                                    <c:set var="existFlag" value="true" />
                                                </c:if>
                                            </c:forEach>
                                            <c:if test="${existFlag eq true}">
                                                <tr bgcolor="AEBACD">
                                                    <td width="10%" height="22"><input name="place" type="checkbox" id="place" value="${city.placeID}"  checked></td>
                                                    <td width="90%"><font color="#000033" size="2">${city.placeName}</font></td>
                                                </tr>
                                            </c:if>
                                            <c:if test="${existFlag eq false}">
                                                <tr bgcolor="AEBACD">
                                                    <td width="10%" height="22"><input name="place" type="checkbox" id="place" value="${city.placeID}"></td>
                                                    <td width="90%"><font color="#000033" size="2">${city.placeName}</font></td>
                                                </tr>
                                            </c:if>
                                        </c:forEach>
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
