<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>


    <title>:: Aktive & Zukünftige Kurse ::</title>
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

        .border-bottom-special {
            border-bottom: .25rem solid #b2c338 !important;
        }

        .card-bottom-margin {
            margin-bottom: 2.5%;
        }

        .card {
            font-size: 20px;
        }

        .col-form-label {
            font-size: 18px;
        }

        .border-right-danger {
            border-right: .25rem solid #e74a3b !important;
        }

        .table-bordered td, .table-bordered th {
            border: 1px solid white;
        }
    </style>
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
                        <a style="margin-right: 5px;" class="btn btn-primary" href="addCourse">Neue Kurse</a>
                        <a style="margin-right: 5px;" class="btn btn-primary" href="courseListAll/1">Alle Kurse</a>
                        <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                    </div>


                    <div class="row">
                        <div class="table-responsive">
                            <table width="100%" border="0" height="77">

                                <tr>
                                    <td height="62" valign="top">
                                        <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                            <tr bgcolor="657A9A">
                                                <td colspan="7" height="16">
                                                    <div align="center"><font size="2"><b><font color="#FFFFFF">Liste
                                                        der aktiven Kurse</font></b></font></div>
                                                </td>
                                            </tr>
                                            <tr bgcolor="657A9A">
                                                <td width="27%" height="15">
                                                    <div align="center"><font color="#FFFFFF"><b><font size="2">Kursname</font></b></font></div></td>
                                                <td width="16%"><div align="center"><font color="#FFFFFF" size="2"><b>Zusatz</b></font></div></td>
                                                <td width="13%" height="15" bgcolor="657A9A">
                                                    <div align="center"><font color="#FFFFFF"><b><font size="2">Kursgeb&uuml;hr</font></b></font></div>
                                                </td>
                                                <td width="9%" height="15" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Kurspl&auml;tze</font></b></td>
                                                <td width="14%" height="15" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Verf&uuml;gbar</font></b></td>
                                                <td width="8%" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Anwesend</font></strong></td>
                                                <td width="13%" height="15" bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>Nochoffen</b></font>
                                                </td>
                                            </tr>
                                            <c:forEach items="${coursesByPlaceActiveModel.courses}" var="c">
                                                <tr bgcolor="AEBACD">
                                                    <td width="27%" height="6"><font size="2" color="#000033"><a href="courseReportDetail?courseid=${c.course.courseID}">${c.course.courseName}${c.init}</a></font></td>
                                                    <td width="16%" height="6"><font size="2" color="#000033">${c.bamfActive}</font></td>
                                                    <td height="6" width="13%"><font size="2" color="#000033">${c.course.courseFee}</font></td>
                                                    <td height="6" width="9%"><font size="2" color="#000033">${c.course.courseStrength}</font></td>
                                                    <td width="14%" height="6"><font size="2" color="#000033">${c.extractStrengthAndCountStudentByCourse}</font></td>
                                                    <td width="8%" height="6"><font size="2" color="#000033">${c.activeCount}</font></td>
                                                    <td height="6" width="13%"><font size="2" color="#000033">${c.anofano}</font></td>
                                                </tr>
                                            </c:forEach>
                                            <tr bgcolor="#9999CC">
                                                <td height="7" colspan="2"><font size="2" color="#000033"></font></td>
                                                <td height="7" width="13%"><font size="2" color="#000033"></font></td>
                                                <td height="7" width="9%"><font size="2" color="#000033"></font></td>
                                                <td height="7"><font size="2" color="#000033"></font></td>
                                                <td height="7"><font size="2" color="#000033">${coursesByPlaceActiveModel.totalAs}</font></td>
                                                <td height="7" width="13%"><font size="2" color="#000033">${coursesByPlaceActiveModel.activeFuture}</font></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="323" valign="top">
                                        <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                            <tr bgcolor="657A9A">
                                                <td colspan="7" height="16">
                                                    <div align="center"><font size="2"><b><font color="#FFFFFF">Liste
                                                        der zuk&uuml;nftige Kurse</font></b></font></div>
                                                </td>
                                            </tr>
                                            <tr bgcolor="657A9A">
                                                <td width="26%" height="17">
                                                    <div align="center"><font color="#FFFFFF"><b><font size="2">Kursname</font></b></font></div></td>
                                                <td width="17%"><div align="center"><font color="#FFFFFF"><b><font size="2">Zusatz</font></b></font></div></td>
                                                <td width="12%" height="17" bgcolor="657A9A">
                                                    <div align="center"><font color="#FFFFFF"><b><font size="2">Kursgeb&uuml;hr</font></b></font></div>
                                                </td>
                                                <td width="9%" height="17" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Kurspl&auml;tze</font></b></td>
                                                <td width="15%" height="17" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Verf&uuml;gbar</font></b></td>
                                                <td width="8%" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Anwesend</font></strong></td>
                                                <td width="13%" height="17" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Nochoffen</font></b></td>
                                            </tr>
                                            <c:forEach items="${coursesByFutureActiveModel.courses}" var="c">
                                                <tr bgcolor="AEBACD">
                                                    <td width="27%" height="6"><font size="2" color="#000033"><a href="courseReportDetail?courseid=${c.course.courseID}">${c.course.courseName}${c.init}</a></font></td>
                                                    <td width="16%" height="6"><font size="2" color="#000033">${c.bamfActive}</font></td>
                                                    <td height="6" width="13%"><font size="2" color="#000033">${c.course.courseFee}</font></td>
                                                    <td height="6" width="9%"><font size="2" color="#000033">${c.course.courseStrength}</font></td>
                                                    <td width="14%" height="6"><font size="2" color="#000033">${c.extractStrengthAndCountStudentByCourse}</font></td>
                                                    <td width="8%" height="6"><font size="2" color="#000033">${c.activeCount}</font></td>
                                                    <td height="6" width="13%"><font size="2" color="#000033">${c.anofano}</font></td>
                                                </tr>
                                            </c:forEach>
                                            <tr bgcolor="#9999CC">
                                                <td height="8" colspan="2"><font size="2" color="#000033"></font></td>
                                                <td height="8" width="12%"><font size="2" color="#000033"></font></td>
                                                <td height="8" width="9%"><font size="2" color="#000033"></font></td>
                                                <td height="8"><font size="2" color="#000033"></font></td>
                                                <td height="8"><font size="2" color="#000033">${coursesByFutureActiveModel.totalAs}</font></td>
                                                <td height="8"><font size="2" color="#000033">${coursesByFutureActiveModel.activeFuture}</font></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <!--<div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">vorhandene Kd. Nr</h6>
                            </div>
                            <div class="card-body" style="background-color: lavender; color: black;">
                                <div class="table-responsive">



                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                        <tr>
                                            <th>KundenNr.</th>
                                            <th>Vorname</th>
                                            <th>Nachname</th>
                                            <th>Email</th>
                                            <th>Anmeldedatum</th>
                                        </tr>
                                        </thead>
                                        <tfoot>
                                        <tr>
                                            <th>KundenNr.</th>
                                            <th>Vorname</th>
                                            <th>Nachname</th>
                                            <th>Email</th>
                                            <th>Anmeldedatum</th>
                                        </tr>
                                        </tfoot>
                                        <tbody>
                                        <c:forEach items="${notregisterUsers}" var="notregisterUser">
                                            <tr>
                                                <td><a href="/schuler/showStudentDetail?userid=${notregisterUser.userID}">${notregisterUser.userID}</a></td>
                                                <td><a href="/schuler/showStudentDetail?userid=${notregisterUser.userID}">${notregisterUser.userFirstName}</a></td>
                                                <td>${notregisterUser.userLastName}</td>
                                                <td>${notregisterUser.userEmail}</td>
                                                <td>${notregisterUser.userRegDate}</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>

                                </div>
                            </div>
                        </div>-->
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