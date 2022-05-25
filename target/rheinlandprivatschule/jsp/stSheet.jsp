<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Stundenplan ::</title>
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
        function popUp(loc,eyeD,X,Y){
            var openedWindow = window.open(loc,eyeD,"toolbar=no,location=0,directories=no,status=no,menubar=0,scrollbars=yes,resizable=0,width=" + X + ",height=" + Y + "'");
            openedWindow.onbeforeunload = function() {
                window.location.reload();
            }
        }
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

                <div class="wrapper" style="padding-left: 10%; padding-right: 10%;">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="wrapper" style="margin-bottom: 5px; float:right;">
                                <a style="margin-right: 5px;" class="btn btn-primary" href="/stundenplan/selectStufe">Stundenbemerkung</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <table class="table table-bordered" width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tbody><tr>
                                <td height="433" valign="top" bgcolor="D9E5F4">
                                    <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                        <tbody>
                                        <tr>
                                            <td height="18" colspan="2"><font size="2" color="#000033"><a href="stSheet?week=${trackP}">Letzte
                                                Woche </a></font> </td>
                                            <td colspan="7" height="18">
                                                <div align="right"><font size="2" color="#000033"><a href="stSheet?week=${trackN}">Nächste
                                                    Woche</a></font></div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="9" height="18" bgcolor="657A9A">
                                                <div align="center"><font size="3" color="#FFFFFF"><b>Stundenplan
                                                    Für</b></font><font size="2" color="#FFFFFF"> ${hd1} - ${hd2} ${bv}</font></div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="18" bgcolor="657A9A">&nbsp;</td>
                                            <td height="18" bgcolor="657A9A">&nbsp;</td>
                                            <td height="18" bgcolor="657A9A"><div align="center"><font size="2"><font color="#FFFFFF">${monday}</font></font></div></td>
                                            <td height="18" bgcolor="657A9A"><div align="center"><font size="2"><font color="#FFFFFF">${tuesday}</font></font></div></td>
                                            <td height="18" bgcolor="657A9A"><div align="center"><font size="2"><font color="#FFFFFF">${wednessday}</font></font></div></td>
                                            <td height="18" bgcolor="657A9A"><div align="center"><font size="2"><font color="#FFFFFF">${thursday}</font></font></div></td>
                                            <td height="18" bgcolor="657A9A"><div align="center"><font size="2"><font color="#FFFFFF">${friday}</font></font></div></td>
                                        </tr>
                                        <tr>
                                            <td width="15%" height="18" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Zeit</font></b></td>
                                            <td width="20%" height="18" bgcolor="657A9A">
                                                <div align="center"><b><font size="2" color="#FFFFFF">Kursname</font></b></div>
                                            </td>
                                            <td width="13%" height="18" bgcolor="657A9A">
                                                <div align="center"><b><font size="2" color="#FFFFFF">Montag</font></b></div>
                                            </td>
                                            <td width="13%" height="18" bgcolor="657A9A">
                                                <div align="center"><b><font size="2" color="#FFFFFF">Dienstag</font></b></div>
                                            </td>
                                            <td width="13%" height="18" bgcolor="657A9A">
                                                <div align="center"><b><font size="2" color="#FFFFFF">Mittwoch</font></b></div>
                                            </td>
                                            <td width="13%" height="18" bgcolor="657A9A">
                                                <div align="center"><b><font size="2" color="#FFFFFF">Donnerstag</font></b></div>
                                            </td>
                                            <td width="13%" height="18" bgcolor="657A9A">
                                                <div align="center"><b><font size="2" color="#FFFFFF">Freitag</font></b></div>
                                            </td>
                                        </tr>

                                        <c:forEach items="${stSheetViewModelList1}" var="v">
                                            <tr>
                                                <td width="9%" bgcolor="AEBACD"><font size="2" color="#000033">8:30
                                                    - 12:45</font></td>
                                                <td width="20%" bgcolor="AEBACD"><font size="2" color="#000033">${v.course.courseName}${v.init}</font></td>
                                                <td width="14%" bgcolor="AEBACD"><font size="2" color="#000033"><a href="javascript:popUp('teacherSelection?d=${v.stundenPlan.date1}&cid=${v.stundenPlan.courseID}&tid=${v.stundenPlan.teacher1ID}','Selection','700','350')">${v.t1Temp}</a></font></td>
                                                <td width="14%" bgcolor="AEBACD"><font size="2" color="#000033"><a href="javascript:popUp('teacherSelection?d=${v.stundenPlan.date2}&cid=${v.stundenPlan.courseID}&tid=${v.stundenPlan.teacher2ID}','Selection','700','350')">${v.t2Temp}</a></font></td>
                                                <td width="14%" bgcolor="AEBACD"><font size="2" color="#000033"><a href="javascript:popUp('teacherSelection?d=${v.stundenPlan.date3}&cid=${v.stundenPlan.courseID}&tid=${v.stundenPlan.teacher3ID}','Selection','700','350')">${v.t3Temp}</a></font></td>
                                                <td width="15%" bgcolor="AEBACD"><font size="2" color="#000033"><a href="javascript:popUp('teacherSelection?d=${v.stundenPlan.date4}&cid=${v.stundenPlan.courseID}&tid=${v.stundenPlan.teacher4ID}','Selection','700','350')">${v.t4Temp}</a></font></td>
                                                <td width="14%" bgcolor="AEBACD"><font size="2" color="#000033"><a href="javascript:popUp('teacherSelection?d=${v.stundenPlan.date5}&cid=${v.stundenPlan.courseID}&tid=${v.stundenPlan.teacher5ID}','Selection','700','350')">${v.t5Temp}</a></font></td>
                                            </tr>
                                        </c:forEach>

                                        <tr>
                                            <td width="9%" bgcolor="#CCCCCC">&nbsp;</td>
                                            <td width="20%" bgcolor="#CCCCCC">&nbsp;</td>
                                            <td width="14%" bgcolor="#CCCCCC">&nbsp;</td>
                                            <td width="14%" bgcolor="#CCCCCC">&nbsp;</td>
                                            <td width="14%" bgcolor="#CCCCCC">&nbsp;</td>
                                            <td width="15%" bgcolor="#CCCCCC">&nbsp;</td>
                                            <td width="14%" bgcolor="#CCCCCC">&nbsp;</td>
                                        </tr>
                                        <c:forEach items="${stSheetViewModelList2}" var="v">
                                            <tr>
                                                <td width="9%" bgcolor="AEBACD"><font size="2" color="#000033">13:10
                                                    - 17:30</font></td>
                                                <td width="20%" bgcolor="AEBACD"><font size="2" color="#000033">${v.course.courseName}${v.init}</font></td>
                                                <td width="14%" bgcolor="AEBACD"><font size="2" color="#000033"><a href="javascript:popUp('teacherSelection?d=${v.stundenPlan.date1}&cid=${v.stundenPlan.courseID}&tid=${v.stundenPlan.teacher1ID}','Selection','700','350')">${v.t1Temp}</a></font></td>
                                                <td width="14%" bgcolor="AEBACD"><font size="2" color="#000033"><a href="javascript:popUp('teacherSelection?d=${v.stundenPlan.date2}&cid=${v.stundenPlan.courseID}&tid=${v.stundenPlan.teacher2ID}','Selection','700','350')">${v.t2Temp}</a></font></td>
                                                <td width="14%" bgcolor="AEBACD"><font size="2" color="#000033"><a href="javascript:popUp('teacherSelection?d=${v.stundenPlan.date3}&cid=${v.stundenPlan.courseID}&tid=${v.stundenPlan.teacher3ID}','Selection','700','350')">${v.t3Temp}</a></font></td>
                                                <td width="15%" bgcolor="AEBACD"><font size="2" color="#000033"><a href="javascript:popUp('teacherSelection?d=${v.stundenPlan.date4}&cid=${v.stundenPlan.courseID}&tid=${v.stundenPlan.teacher4ID}','Selection','700','350')">${v.t4Temp}</a></font></td>
                                                <td width="14%" bgcolor="AEBACD"><font size="2" color="#000033"><a href="javascript:popUp('teacherSelection?d=${v.stundenPlan.date5}&cid=${v.stundenPlan.courseID}&tid=${v.stundenPlan.teacher5ID}','Selection','700','350')">${v.t5Temp}</a></font></td>
                                            </tr>
                                        </c:forEach>

                                        <tr>
                                            <td width="9%" bgcolor="#CCCCCC">&nbsp;</td>
                                            <td width="20%" bgcolor="#CCCCCC">&nbsp;</td>
                                            <td width="14%" bgcolor="#CCCCCC">&nbsp;</td>
                                            <td width="14%" bgcolor="#CCCCCC">&nbsp;</td>
                                            <td width="14%" bgcolor="#CCCCCC">&nbsp;</td>
                                            <td width="15%" bgcolor="#CCCCCC">&nbsp;</td>
                                            <td width="14%" bgcolor="#CCCCCC">&nbsp;</td>
                                        </tr>
                                        <c:forEach items="${stSheetViewModelList3}" var="v">
                                            <tr>
                                                <td width="9%" bgcolor="AEBACD"><font size="2" color="#000033">18:00
                                                    - 21:15</font></td>
                                                <td width="20%" bgcolor="AEBACD"><font size="2" color="#000033">${v.course.courseName}${v.init}</font></td>
                                                <td width="14%" bgcolor="AEBACD"><font size="2" color="#000033"><a href="javascript:popUp('teacherSelection?d=${v.stundenPlan.date1}&cid=${v.stundenPlan.courseID}&tid=${v.stundenPlan.teacher1ID}','Selection','700','350')">${v.t1Temp}</a></font></td>
                                                <td width="14%" bgcolor="AEBACD"><font size="2" color="#000033"><a href="javascript:popUp('teacherSelection?d=${v.stundenPlan.date2}&cid=${v.stundenPlan.courseID}&tid=${v.stundenPlan.teacher2ID}','Selection','700','350')">${v.t2Temp}</a></font></td>
                                                <td width="14%" bgcolor="AEBACD"><font size="2" color="#000033"><a href="javascript:popUp('teacherSelection?d=${v.stundenPlan.date3}&cid=${v.stundenPlan.courseID}&tid=${v.stundenPlan.teacher3ID}','Selection','700','350')">${v.t3Temp}</a></font></td>
                                                <td width="15%" bgcolor="AEBACD"><font size="2" color="#000033"><a href="javascript:popUp('teacherSelection?d=${v.stundenPlan.date4}&cid=${v.stundenPlan.courseID}&tid=${v.stundenPlan.teacher4ID}','Selection','700','350')">${v.t4Temp}</a></font></td>
                                                <td width="14%" bgcolor="AEBACD"><font size="2" color="#000033"><a href="javascript:popUp('teacherSelection?d=${v.stundenPlan.date5}&cid=${v.stundenPlan.courseID}&tid=${v.stundenPlan.teacher5ID}','Selection','700','350')">${v.t5Temp}</a></font></td>
                                            </tr>
                                        </c:forEach>

                                        </tbody></table>
                                </td>
                            </tr>
                            </tbody></table>
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
