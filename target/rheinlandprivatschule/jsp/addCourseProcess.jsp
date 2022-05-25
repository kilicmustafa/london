<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Neue Kurse ::</title>
    <style>
        table tr {
            border-bottom: 1px solid white;
        }
    </style>

    <script>

        function MM_findObj(n, d) { //v4.0
            var p, i, x;
            if (!d) d = document;
            if ((p = n.indexOf("?")) > 0 && parent.frames.length) {
                d = parent.frames[n.substring(p + 1)].document;
                n = n.substring(0, p);
            }
            if (!(x = d[n]) && d.all) x = d.all[n];
            for (i = 0; !x && i < d.forms.length; i++) x = d.forms[i][n];
            for (i = 0; !x && d.layers && i < d.layers.length; i++) x = MM_findObj(n, d.layers[i].document);
            if (!x && document.getElementById) x = document.getElementById(n);
            return x;
        }

        function MM_validateForm() { //v4.0
            var i, p, q, nm, test, num, min, max, errors = '', args = MM_validateForm.arguments;
            for (i = 0; i < (args.length - 2); i += 3) {
                test = args[i + 2];
                val = MM_findObj(args[i]);
                if (val) {
                    nm = val.name;
                    if ((val = val.value) != "") {
                        if (test.indexOf('isEmail') != -1) {
                            p = val.indexOf('@');
                            if (p < 1 || p == (val.length - 1)) errors += '- ' + nm + ' must contain an e-mail address.\n';
                        } else if (test != 'R') {
                            if (isNaN(val)) errors += '- ' + nm + ' must contain a number.\n';
                            if (test.indexOf('inRange') != -1) {
                                p = test.indexOf(':');
                                min = test.substring(8, p);
                                max = test.substring(p + 1);
                                if (val < min || max < val) errors += '- ' + nm + ' must contain a number between ' + min + ' and ' + max + '.\n';
                            }
                        }
                    } else if (test.charAt(0) == 'R') errors += '- ' + nm + ' is required.\n';
                }
            }
            if (errors) alert('The following error(s) occurred:\n' + errors);
            document.MM_returnValue = (errors == '');
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

                <div class="wrapper" style="padding-left: 17.5%; padding-right: 17.5%;">
                    <div class="wrapper" style="margin-bottom: 5px; float:right;">
                        <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                    </div>
                    <form name="form1" method="post" action="/courses/addCourseProcess"
                          onSubmit="MM_validateForm('txtFee','','RisNum','strength','','RisNum','hours','','R');return document.MM_returnValue">
                        <table width="100%" border="0" height="127">
                            <tr>
                                <td colspan="2" height="82">
                                    <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                        <tr bgcolor="657A9A">
                                            <td width="4%" bgcolor="657A9A"><b><font size="2"
                                                                                     color="#FFFFFF"></font></b></td>
                                            <td><b><font size="2" color="#FFFFFF">Normal Kurs
                                                Schule</font></b><font color="#FFFFFF"><b></b></font></td>
                                        </tr>
                                        <c:forEach items="${vector}" var="v">
                                            <tr bgcolor="AEBACD">
                                                <td width="4%"><font size="2" color="#000033">
                                                    <input type="checkbox" name="chk" value="${v.placeID}" checked>
                                                </font></td>
                                                <td><font size="2" color="#000033">${v.placeName}</font>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <tr bgcolor="657A9A">
                                            <td width="4%">&nbsp;</td>
                                            <td><font color="#FFFFFF"><b><font size="2">Elite
                                                Kurs Schule</font></b></font></td>
                                        </tr>
                                        <c:forEach items="${vector}" var="v">
                                            <tr bgcolor="AEBACD">
                                                <td width="4%">
                                                    <input type="checkbox" name="chk2" value="${v.placeID}">
                                                </td>
                                                <td><font size="2" color="#000033">${v.placeName}
                                                </font>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <tr bgcolor="AEBACD">
                                            <td width="4%" height="2">&nbsp;</td>
                                            <td height="2">
                                                <input type="submit" value="OK" name="Submit">
                                                <input type="hidden" name="hf" value="cmd">
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="templates/footer.jsp"/>
<jsp:include page="templates/bodyimports.jsp"/>
</body>
</html>
