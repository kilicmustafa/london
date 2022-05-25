
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>


    <title>:: Online-Kunde ::</title>
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
                        <c:choose>
                            <c:when test="${isPageSent eq false}">
                                <c:set var="urlVal" value="../"></c:set>
                            </c:when>
                            <c:otherwise>
                                <c:set var="urlVal" value=""></c:set>
                            </c:otherwise>
                        </c:choose>
                        <a style="margin-right: 5px;" class="btn btn-primary" href="${urlVal}fromagenturen">Von Agenturen</a>
                        <a style="margin-right: 5px;" class="btn btn-primary" href="${urlVal}notRegister">vorhandene Kd. Nrn</a>
                        <a style="margin-right: 5px;" class="btn btn-primary" href="${urlVal}newStudent">Neue Schüler</a>
                        <a style="margin-right: 5px;" class="btn btn-primary" href="${urlVal}../index">Haupt</a>
                    </div>


                    <div class="row">
                        <div class="table-responsive">
                            <table width="100%" border="0" cellspacing="1" cellpadding="1">
                                <tr>
                                    <td>
                                        <table width="100%" border="0" cellspacing="1" cellpadding="1">
                                            <tr bgcolor="657A9A">
                                                <td colspan="6">
                                                    <div align="center"><font size="3" color="#FFFFFF"><b>Registriert
                                                        aber die Geb&uuml;hr nicht gezahlt</b></font></div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6">&nbsp;</td>
                                            </tr>
                                            <tr bgcolor="657A9A">
                                                <td><strong><font color="#FFFFFF" size="2">Summe</font></strong></td>
                                                <td colspan="5"><div align="right"><font color="#FFFFFF"><strong><font size="2">${onlinenotpaid.size()}</font></strong></font></div></td>
                                            </tr>
                                            <tr bgcolor="657A9A">
                                                <td width="12%"><b><font size="2" color="#FFFFFF">KundenNr.</font></b></td>
                                                <td width="18%"><b><font size="2" color="#FFFFFF">Vorname</font></b></td>
                                                <td width="18%"><b><font size="2" color="#FFFFFF">Nachname</font></b></td>
                                                <td width="20%"><b><font size="2" color="#FFFFFF">Geburtsdatum</font></b></td>
                                                <td width="16%"><b><font color="#FFFFFF" size="2">Email</font></b></td>
                                                <td width="16%"><b><font color="#FFFFFF" size="2">Anmeldedatum</font></b></td>
                                            </tr>
                                            <c:forEach items="${onlinenotpaid}" var="model">
                                                <tr bgcolor="AEBACD">
                                                    <td width="12%"><font size="2" color="#000033"><a href="showStudentNotPaid?userid=${model.student.userID}">${model.student.userID}</a></font></td>
                                                    <td width="18%"><font size="2" color="#000033"><a href="showStudentNotPaid?userid=${model.student.userID}">${model.student.userFirstName}</a></font></td>
                                                    <td width="18%"><font size="2" color="#000033">${model.student.userLastName}</font></td>
                                                    <td width="20%"><font size="2" color="#000033">${model.formatedBirthDate}</font></td>
                                                    <td width="16%"><font size="2" color="#000033">${model.student.userEmail}</font></td>
                                                    <td width="16%"><font size="2" color="#000033">${model.formatedRegDate}</font></td>
                                                </tr>
                                            </c:forEach>

                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table width="100%" border="0" cellspacing="1" cellpadding="1">
                                            <tr>
                                                <td colspan="6">&nbsp;</td>
                                            </tr>
                                            <tr bgcolor="657A9A">
                                                <td colspan="6">
                                                    <div align="center"><font size="3" color="#FFFFFF"><b>Online
                                                        -Kunde aber nicht Registriert</b></font></div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6">&nbsp;</td>
                                            </tr>
                                            <tr bgcolor="657A9A">
                                                <td><strong><font color="#FFFFFF" size="2">Summe</font></strong></td>
                                                <td colspan="5"><div align="right">
                                                    <div align="right"><font color="#FFFFFF"><strong><font size="2">${onlinenotregister.size()}</font></strong></font></div>
                                                </div></td>
                                            </tr>
                                            <tr bgcolor="657A9A">
                                                <td width="12%"><b><font size="2" color="#FFFFFF">KundenNr.</font></b></td>
                                                <td width="18%"><b><font size="2" color="#FFFFFF">Vorname</font></b></td>
                                                <td width="18%"><b><font size="2" color="#FFFFFF">Nachname</font></b></td>
                                                <td width="20%"><b><font size="2" color="#FFFFFF">Geburtsdatum</font></b></td>
                                                <td width="16%"><b><font color="#FFFFFF" size="2">Email</font></b></td>
                                                <td width="16%"><b><font color="#FFFFFF" size="2">Anmeldedatum</font></b></td>
                                            </tr>
                                            <c:forEach items="${onlinenotregister}" var="model">
                                                <tr bgcolor="AEBACD">
                                                    <td width="12%"><font size="2" color="#000033"><a href="/schuler/showStudentNotPaid?userid=${model.student.userID}">${model.student.userID}</a></font></td>
                                                    <td width="18%"><font size="2" color="#000033"><a href="/schuler/showStudentNotPaid?userid=${model.student.userID}">${model.student.userFirstName}</a></font></td>
                                                    <td width="18%"><font size="2" color="#000033">${model.student.userLastName}</font></td>
                                                    <td width="20%"><font size="2" color="#000033">${model.formatedBirthDate}</font></td>
                                                    <td width="16%"><font size="2" color="#000033">${model.student.userEmail}</font></td>
                                                    <td width="16%"><font size="2" color="#000033">${model.formatedRegDate}</font></td>
                                                </tr>
                                            </c:forEach>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="21">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                </tr>
                            </table>
                    </div>
                    <div class="row">

                            <!--<nav aria-label="userlist pagination">
                                <ul class="pagination">
                                    <c:choose>
                                        <c:when test="${isPageSent eq false}">
                                            <c:set var="sign" value="" />
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="sign" value="notregister/" />
                                        </c:otherwise>
                                    </c:choose>
                                    <li class="page-item"><a class="page-link" href="<c:if test="${page > 0}">${page}</c:if>">Previous</a></li>
                                    <li class="page-item"><a class="page-link" href="${sign}${page+1}">${page+1}</a></li>
                                    <li class="page-item"><a class="page-link" href="${sign}${page+2}">${page+2}</a></li>
                                    <li class="page-item"><a class="page-link" href="${sign}${page+3}">${page+3}</a></li>
                                </ul>
                            </nav>-->
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