<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Neue Kurse ::</title>
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
                        <a style="margin-right: 5px;" class="btn btn-primary" href="newAdminForm">Neue Allgemeine Benutzer</a>
                        <a style="margin-right: 5px;" class="btn btn-primary" href="newCat">Neue Benutzer Kategory</a>
                        <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                    </div>
                    <div class="table-responsive">
                        <table width="100%" border="0" cellpadding="1" cellspacing="1">
                            <tr bgcolor="657A9A">
                                <td height="22" colspan="2">
                                    <div align="center"><b><font color="#FFFFFF">                                Allgemeine Benutzer Kategorie Liste </font></b></div>
                                </td>
                            </tr>
                            <tr bgcolor="657A9A">
                                <td bgcolor="657A9A" height="22" colspan="2">
                                    <div align="left"><font color="#FFFFFF"><b><font size="2">Kategorie</font></b></font></div>
                                </td>
                            </tr>

                            <c:forEach items="${userCategories}" var="userCategory">
                                <tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6" width="79%"><font size="2" color="#000033"><a href="adminUserListAllge?catid=${userCategory.userCategoryID}">${userCategory.userCategoryName}</a></font></td>
                                    <td height="6" width="21%"><font size="2" color="#000033"><a href="updateCat?catid=${userCategory.userCategoryID}">Aktualisierung</a></font></td>
                                </tr>
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
