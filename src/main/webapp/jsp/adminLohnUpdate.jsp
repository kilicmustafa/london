<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Allgemeine Benutzer Stundenlohn  ::</title>
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

        <c:if test="${param.error eq 'invalidDate'}">
            <script>
                alert('Bitte schließen sie das vorherigen Lohndatum ab.');
            </script>
        </c:if>

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
                        <form name="form1" method="post" action="adminLohnUpdate" style="width: 100%;">
                            <table width="100%" border="0" cellspacing="1" cellpadding="1">
                                <tbody>
                                <tr bgcolor="657A9A">
                                    <td colspan="6">
                                        <div align="center"><font size="2"><b><font color="#FFFFFF"><b>Allgemeine Benutzer Stundenlohn</b> </font></b></font></div>
                                    </td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td colspan="6"><div align="center"><strong><font color="#FFFFFF" size="2">Neue Stundenlohn Anlegen </font></strong></div></td>
                                </tr>
                                <tr>
                                    <td width="14%" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Anfangdatum</font></strong></td>
                                    <td colspan="5" bgcolor="AEBACD">
                                        <select name="selSDay">
                                            <c:forEach begin="1" end="31" var="i" varStatus="loop">
                                                <option <c:if test="${i eq day}">selected</c:if> >${i}</option>
                                            </c:forEach>
                                        </select>
                                        <select name="selSMonth">

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
                                        <select name="selSYear">
                                            <c:forEach begin="2004" end="2029" var="y">
                                                <option <c:if test="${y eq year}">selected</c:if> >${y}</option>
                                            </c:forEach>
                                        </select>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Endedatum</font></strong></td>
                                    <td colspan="5" bgcolor="AEBACD"><select name="selEDay">
                                        <option selected="">-</option>

                                        <option>1</option>

                                        <option>2</option>

                                        <option>3</option>

                                        <option>4</option>

                                        <option>5</option>

                                        <option>6</option>

                                        <option>7</option>

                                        <option>8</option>

                                        <option>9</option>

                                        <option>10</option>

                                        <option>11</option>

                                        <option>12</option>

                                        <option>13</option>

                                        <option>14</option>

                                        <option>15</option>

                                        <option>16</option>

                                        <option>17</option>

                                        <option>18</option>

                                        <option>19</option>

                                        <option>20</option>

                                        <option>21</option>

                                        <option>22</option>

                                        <option>23</option>

                                        <option>24</option>

                                        <option>25</option>

                                        <option>26</option>

                                        <option>27</option>

                                        <option>28</option>

                                        <option>29</option>

                                        <option>30</option>

                                        <option>31</option>

                                    </select>
                                        <select name="selEMonth">
                                            <option selected="">-</option>

                                            <option>Januar</option>

                                            <option>Februar</option>

                                            <option>März</option>

                                            <option>April</option>

                                            <option>Mai</option>

                                            <option>Juni</option>

                                            <option>Juli</option>

                                            <option>August</option>

                                            <option>September</option>

                                            <option>Oktober</option>

                                            <option>November</option>

                                            <option>Dezember</option>

                                        </select>
                                        <select name="selEYear">
                                            <option selected="">-</option>

                                            <option>2004</option>

                                            <option>2005</option>

                                            <option>2006</option>

                                            <option>2007</option>

                                            <option>2008</option>

                                            <option>2009</option>

                                            <option>2010</option>

                                            <option>2011</option>

                                            <option>2012</option>

                                            <option>2013</option>

                                            <option>2014</option>

                                            <option>2015</option>

                                            <option>2016</option>

                                            <option>2017</option>

                                            <option>2018</option>

                                            <option>2019</option>

                                            <option>2020</option>

                                            <option>2021</option>

                                            <option>2022</option>

                                            <option>2023</option>

                                            <option>2024</option>

                                            <option>2025</option>

                                            <option>2026</option>

                                            <option>2027</option>
                                            <option>2028</option>
                                            <option>2029</option>



                                        </select></td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Lohn</font></strong></td>
                                    <td colspan="5" bgcolor="AEBACD"><input name="txtLohn" type="text" id="txtLohn" value="0"></td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Lohntyp</font></strong></td>
                                    <td colspan="5" bgcolor="AEBACD"><select name="selectType" id="selectType">
                                        <option value="1" selected="">Privat</option>
                                        <option value="2">Gruppe</option>
                                    </select></td>
                                </tr>
                                <tr>
                                    <td bgcolor="AEBACD" colspan="6"><input class="btn btn-primary" type="submit" name="Submit" value="OK"></td>
                                </tr>
                                <tr>
                                    <td bgcolor="AEBACD" colspan="6">&nbsp;</td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td colspan="6"><div align="center"><strong><font color="#FFFFFF" size="2">Privatstundenlöhnen</font></strong></div></td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td colspan="2"><strong><font color="#FFFFFF" size="2">Anfangdatum</font></strong></td>
                                    <td width="38%"><strong><font color="#FFFFFF" size="2">Endedatum</font></strong></td>
                                    <td width="18%"><strong><font color="#FFFFFF" size="2">Lohn</font></strong></td>
                                    <td colspan="2">&nbsp;</td>
                                </tr>
                                <c:forEach items="${privateLohnList}" var="privateLohn">
                                    <tr>
                                        <td colspan="2" bgcolor="AEBACD"><font color="#000033" size="2">${privateLohn.startDate}</font></td>
                                        <td bgcolor="AEBACD"><font color="#000033" size="2">${privateLohn.loopEndDate}</font></td>
                                        <td bgcolor="AEBACD"><font color="#000033" size="2">${privateLohn.teacherLohnDisplay}</font></td>
                                        <td width="9%" bgcolor="AEBACD"><font color="#000033" size="2"><a href="deleteLohn?userid=${privateLohn.teacherLohn.userID}&sdate=${privateLohn.teacherLohn.startDate}&edate=${privateLohn.teacherLohn.endDate}&ltype=1">Löschen</a></font></td>
                                        <td width="9%" bgcolor="AEBACD"><font color="#000033" size="2"><a href="adminLohnUpdate1?userid=${privateLohn.teacherLohn.userID}&sdate=${privateLohn.teacherLohn.startDate}&edate=${privateLohn.teacherLohn.endDate}&ltype=1&lohnpay=${privateLohn.teacherLohn.teacherLohn}">&Auml;ndern</a></font></td>
                                    </tr>
                                </c:forEach>

                                <tr bgcolor="657A9A">
                                    <td colspan="6"><div align="center"><strong><font color="#FFFFFF" size="2">Gruppestundenlöhnen</font></strong></div></td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td colspan="2"><strong><font color="#FFFFFF" size="2">Anfangdatum</font></strong></td>
                                    <td><strong><font color="#FFFFFF" size="2">Endedatum</font></strong></td>
                                    <td><strong><font color="#FFFFFF" size="2">Lohn</font></strong></td>
                                    <td colspan="2">&nbsp;</td>
                                </tr>

                                <c:forEach items="${groupLohnList}" var="groupLohn">
                                    <tr>
                                        <td colspan="2" bgcolor="AEBACD"><font color="#000033" size="2">${groupLohn.startDate}</font></td>
                                        <td bgcolor="AEBACD"><font color="#000033" size="2">${groupLohn.loopEndDate}</font></td>
                                        <td bgcolor="AEBACD"><font color="#000033" size="2">${groupLohn.teacherLohnDisplay}</font></td>
                                        <td bgcolor="AEBACD"><font color="#000033" size="2"><a href="deleteLohn?userid=${groupLohn.teacherLohn.userID}sdate=${groupLohn.teacherLohn.startDate}&edate=${groupLohn.teacherLohn.endDate}&ltype=2">Löschen</a></font></td>
                                        <td width="9%" bgcolor="AEBACD"><font color="#000033" size="2"><a href="adminLohnUpdate1?userid=${groupLohn.teacherLohn.userID}&sdate=${groupLohn.teacherLohn.startDate}&edate=${groupLohn.teacherLohn.endDate}&ltype=2&lohnpay=${groupLohn.teacherLohn.teacherLohn}">&Auml;ndern</a></font></td>
                                    </tr>
                                </c:forEach>


                                </tbody></table>
                            <input type="hidden" name="userid" value="${userid}">
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
