<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>


    <title>:: Tätigkeitsliste ::</title>
    <jsp:include page="templates/headimports.jsp"/>

    <style>
        .topbar.navbar-light .navbar-nav .nav-item .nav-link {
            color: #4e73df !important;
        }

        .bg-white {
            background-color: #D6EAF8 !important;
        }

        #wrapper #content-wrapper {
            background-color: #D6EAF8;
        }


        .table-bordered td, .table-bordered th {
            border: 1px solid white;
        }
    </style>

    <script>

        function saveonly(msg)
        {
            if(!confirm(msg)){
                return false;
            }
            else{
                document.form1.action="saveActivity?only=only";
                document.form1.submit();
            }
        }

        function saveall(msg)
        {
            if(!confirm(msg)){
                return false;
            }
            else{
                document.form1.submit();
            }
        }

        function leave(msg,path)
        {
            if(!confirm(msg)){
                return false;
            }
            else {
                document.form1.action=path;
                document.form1.submit();
            }
        }
    </script>
</head>

<body id="page-top">

<!-- Page Wrapper -->
<div id="wrapper">

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

        <!-- Main Content -->
        <div id="content">

            <!-- Topbar -->
            <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                <!-- Sidebar Toggle (Topbar) -->
                <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                    <i class="fa fa-bars"></i>
                </button>

                <img style="height: 4.375rem;" src="https://unitutor.de/wp-content/uploads/2020/03/cropped-Rp-LOGO-13-1024x151-2-830x122-1.png">
                <div class="topbar-divider d-none d-sm-block"></div>
                <!--<a href="#" style="text-decoration:none;">Ihre Bemerkung</a>
                <div class="topbar-divider d-none d-sm-block"></div>
                <a href="#" style="text-decoration:none;">Mitarbeiter Anmeldung</a>
                <div class="topbar-divider d-none d-sm-block"></div>
                <a href="#" style="text-decoration:none;">Neu</a>
                <div class="topbar-divider d-none d-sm-block"></div>
                <ul class="navbar-nav">
                  <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown"
                      aria-haspopup="true" aria-expanded="false">
                      Duisburg
                    </a>
                    <div class="dropdown-menu dropdown-menu-right animated--grow-in" aria-labelledby="navbarDropdown">
                      <a class="dropdown-item" href="#">Dortmund</a>
                      <a class="dropdown-item" href="#">Duisburg</a>
                      <a class="dropdown-item" href="#">Düsseldorf</a>
                      <a class="dropdown-item" href="#">Essen</a>
                      <a class="dropdown-item" href="#">Köln</a>
                    </div>
                  </li>
                </ul> -->
                <!-- Topbar Navbar -->
                <ul class="navbar-nav ml-auto">

                    <!-- Nav Item - Search Dropdown (Visible Only XS) -->
                    <li class="nav-item dropdown no-arrow d-sm-none">
                        <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button" data-toggle="dropdown"
                           aria-haspopup="true" aria-expanded="false">
                            <i class="fas fa-search fa-fw"></i>
                        </a>
                        <!-- Dropdown - Messages -->
                        <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
                             aria-labelledby="searchDropdown">
                            <form class="form-inline mr-auto w-100 navbar-search">
                                <div class="input-group">
                                    <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..."
                                           aria-label="Search" aria-describedby="basic-addon2">
                                    <div class="input-group-append">
                                        <button class="btn btn-primary" type="button">
                                            <i class="fas fa-search fa-sm"></i>
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </li>


                    <div class="topbar-divider d-none d-sm-block"></div>

                    <!-- Nav Item - User Information -->
                    <li class="nav-item dropdown no-arrow">
                        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown"
                           aria-haspopup="true" aria-expanded="false">
                            <span class="mr-2 d-none d-lg-inline text-gray-600 small"><c:if test="${loginUserFullName eq null}">Logout</c:if>${loginUserFullName}</span>
                        </a>
                        <!-- Dropdown - User Information -->
                        <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">

                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                                <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                Logout
                            </a>
                        </div>
                    </li>

                </ul>

            </nav>
            <!-- End of Topbar -->

            <!-- Begin Page Content -->
            <!-- Begin Page Content -->
            <div class="container-fluid">


                <div class="wrapper" style="padding-left: 17.5%; padding-right: 17.5%;">

                    <div class="row" style="margin-bottom: 15px;">
                        <div class="col-md-12">
                            <div class="wrapper" style="float:right;">
                                <a style="margin-right: 5px;" class="btn btn-primary" href="javascript:history.back()">Zurück</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="table-responsive">
                                <form name="form1" method="post" action="saveModule">
                                    <input type="hidden" name="cmd" value="command">
                                    <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                        <tr bgcolor="657A9A">
                                            <td height="22" colspan="3">
                                                <div align="center"><b><font color="#FFFFFF">T&auml;tigkeitsliste</font></b></div>
                                            </td>
                                        </tr>
                                        <tr bgcolor="657A9A">
                                            <td height="6" width="10%">&nbsp;
                                            </td>
                                            <td height="6" width="72%"><b><font color="#FFFFFF" size="2">T&auml;tigkeitname</font></b></td>
                                            <td width="18%">&nbsp;</td>
                                        </tr>
                                        <c:forEach items="${asvm}" var="m">
                                            <c:choose>
                                                <c:when test="${m.activityHasPredecessor eq true and m.allowed eq true}">
                                                    <tr bgcolor="AEBACD">
                                                        <td height="5" width="10%"><font size="2" color="#000033">
                                                            <input name="cb" type="checkbox" id="cb" value="${m.activity.activityID}" disabled>
                                                        </font></td>
                                                        <td width="72%" height="5"><font size="2" color="#000033"><a href="activitySelection?activityid=${m.activity.activityID}&cmd=cmd">${m.activity.activityName}</a></font></td>
                                                        <td width="18%" height="5"><a href="#" onClick="leave('Wollen Sie ganze T�tigkeit zur�ckweisen?','saveActivity?activityid=${m.activity.activityID}&dis=dis')"><font size="2">Zur�ckweisen</font></a><font size="2"></font></font></td>
                                                    </tr>
                                                </c:when>
                                                <c:when test="${m.activityHasPredecessor eq true and m.allowed eq false}">
                                                    <tr bgcolor="AEBACD">
                                                        <td height="5" width="10%"><font size="2" color="#000033">
                                                            <input name="cb" type="checkbox" id="cb" value="${m.activity.activityID}">
                                                        </font></td>
                                                        <td width="72%" height="5"><font size="2" color="#000033"><a href="activitySelection?activityid=${m.activity.activityID}&cmd=cmd">${m.activity.activityName}</a></font></td>
                                                        <td width="18%" height="5">&nbsp;</td>
                                                    </tr>
                                                </c:when>
                                                <c:when test="${m.activityHasPredecessor eq false and m.allowed eq true}">
                                                    <tr bgcolor="AEBACD">
                                                        <td height="5" width="10%"><font size="2" color="#000033">
                                                            <input name="cb" type="checkbox" id="cb" value="${m.activity.activityID}" disabled>
                                                        </font></td>
                                                        <td width="72%" height="5"><font size="2" color="#000033">${m.activity.activityName}</font></td>
                                                        <td width="18%" height="5"><a href="#" onClick="leave('Wollen Sie ganze T�tigkeit zur�ckweisen?','saveActivity?activityid=${m.activity.activityID}&dis=dis')"><font size="2">Zur�ckweisen</font></a><font size="2"></font></font></td>
                                                    </tr>
                                                </c:when>
                                                <c:when test="${m.activityHasPredecessor eq false and m.allowed eq false}">
                                                    <tr bgcolor="AEBACD">
                                                        <td height="5" width="10%"><font size="2" color="#000033">
                                                            <input name="cb" type="checkbox" id="cb" value="${m.activity.activityID}">
                                                        </font></td>
                                                        <td width="72%" height="5"><font size="2" color="#000033">${m.activity.activityName}</font></td>
                                                        <td width="18%" height="5">&nbsp;</td>
                                                    </tr>
                                                </c:when>
                                            </c:choose>
                                        </c:forEach>

                                        <tr bgcolor="AEBACD">
                                            <td height="6" bgcolor="AEBACD" colspan="3">
                                                <input type="button" name="Submit2" value="Erlauben Sie nur dem" onClick="saveonly('Wollen Sie nur diese T�tigkeit erlauben?')">
                                                <input type="button" name="Button" value="Erlauben Sie ganz" onClick="saveall('Wollen Sie ganze T�tigkeit erlauben?')">
                                            </td>
                                        </tr>
                                    </table>

                                </form>
                            </div>
                        </div>

                    </div>
                </div>

            </div>
            <!-- /.container-fluid -->

        </div>
        <!-- End of Main Content -->
    </div>
</div>
</div>

</div>
<!-- /.container-fluid -->

</div>
<!-- End of Main Content -->

<!-- Footer -->
<footer class="sticky-footer bg-white">
    <div class="container my-auto">
        <div class="copyright text-center my-auto">
            <span>Copyright &copy; Your Rheinland Privatschule 2019</span>
        </div>
    </div>
</footer>
<!-- End of Footer -->

</div>
<!-- End of Content Wrapper -->

</div>
<!-- End of Page Wrapper -->

<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
</a>

<!-- Logout Modal-->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
            <div class="modal-footer">
                <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                <a class="btn btn-primary" href="login.html">Logout</a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="templates/bodyimports.jsp"/>

</body>

</html>