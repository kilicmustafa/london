<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Schulen ::</title>
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="/school/addSchoolForm">Neue Schule</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <table width="100%" border="0" cellpadding="1" cellspacing="1">
                            <tr bgcolor="657A9A">
                                <td height="22">
                                    <div align="center"><b><font color="#FFFFFF">Schulen</font></b></div>
                                </td>
                            </tr>
                            <tr bgcolor="657A9A">
                                <td bgcolor="657A9A" height="22">
                                    <div align="left"><font color="#FFFFFF"><b><font size="2">Schule
                                    </font></b></font></div>
                                </td>
                            </tr>
                            <c:forEach items="${places}" var="place">
                                <tr bgcolor="AEBACD">
                                    <td height="6"><font size="2" color="#000033"><a href="updateSchoolForm?placeid=${place.placeID}">${place.placeName}</a></font></td>
                                </tr>
                            </c:forEach>
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
