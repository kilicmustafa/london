<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Ausgabe Kategorie Liste ::</title>
    <style>
        html {
            overflow-y: hidden;
        }

        table tr {
            border-bottom: 1px solid white;
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
                    <div class="wrapper" style="margin-bottom: 5px; float:right;">
                        <a style="margin-right: 5px;" class="btn btn-primary" href="/exp/newCat">Neue Kategorie</a>
                        <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                    </div>
                    <div class="table-responsive">
                        <table width="100%" border="0" cellpadding="1" cellspacing="1">
                            <tr bgcolor="657A9A">
                                <td height="22" bgcolor="657A9A">
                                    <div align="center"><b><font color="#FFFFFF">Ausgabe Kategorie Liste </font></b></div>
                                </td>
                            </tr>
                            <c:forEach items="${categories}" var="category">
                                <tr bgcolor="AEBACD">
                                    <td height="6" bgcolor="AEBACD"><font size="2" color="#000033"><a href="catView?id=${category.categoryID}">${category.categoryName}</a></font></td>
                                </tr>
                            </c:forEach>

                            <tr bgcolor="AEBACD">
                                <td height="6" bgcolor="AEBACD">&nbsp; </td>
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
