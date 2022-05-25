<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>:: Online-Kunde ::</title>

    <!-- Custom fonts for this template-->
    <link href="../resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
            href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
            rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="../resources/css/sb-admin-2.min.css" rel="stylesheet">
    <!-- Custom styles for this page -->
    <link href="../resources/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
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
                        <a style="margin-right: 5px;" class="btn btn-primary" href="/schuler/notregister/1">vorhandene Kd. Nr</a>
                        <a style="margin-right: 5px;" class="btn btn-primary" href="/schuler/notOnlinePaid">Online Schülern</a>
                        <a style="margin-right: 5px;" class="btn btn-primary" href="/schuler/newStudent">Neue Schüler</a>
                        <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                    </div>
                    <div class="row">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td valign="top" height="434" bgcolor="D9E5F4" width="81%">
                                    <table width="100%" border="0" cellspacing="1" cellpadding="1">
                                        <tr>
                                            <td><table width="100%" border="0" height="70" cellpadding="1" cellspacing="1">
                                                <tr bgcolor="657A9A">
                                                    <td width="9%" height="16"><strong><font color="#FFFFFF" size="2">Summe</font></strong></td>
                                                    <td height="16" colspan="8"><div align="right"><font size="2" color="#FFFFFF"><strong>${fromAgenturenViewModels.size()}</strong></font></div></td>
                                                </tr>
                                                <tr bgcolor="657A9A">
                                                    <td colspan="9" height="16"><div align="center"><b><font color="#FFFFFF">Sch&uuml;ler\in von Agenturen </font></b></div></td>
                                                </tr>
                                                <tr bgcolor="#405579">
                                                    <td height="17" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Kunden Nr.</font></strong> </td>
                                                    <td width="15%" height="17" bgcolor="657A9A"><font color="#FFFFFF"><b><font size="2">Vorname </font></b></font> <font color="#FFFFFF"><b><font size="2">Nachname </font></b></font> <font size="2" color="#FFFFFF">&nbsp;</font></td>
                                                    <td bgcolor="657A9A"><div align="center"><strong><font color="#FFFFFF" size="2">Uni Anmeldung </font></strong></div></td>
                                                    <td bgcolor="657A9A"><div align="center"><strong><font color="#FFFFFF" size="2">Wohnung</font></strong></div></td>
                                                    <td height="17" bgcolor="657A9A"><div align="center"><strong><font color="#FFFFFF" size="2">Anreise</font></strong></div></td>
                                                    <td bgcolor="657A9A"><div align="center"><font color="#FFFFFF"><strong><font size="2">Stadt</font></strong></font></div></td>
                                                    <td bgcolor="657A9A"><div align="center"><strong><font color="#FFFFFF" size="2">Agenturen</font></strong></div></td>
                                                    <td bgcolor="657A9A"><div align="center"><strong><font color="#FFFFFF" size="2">Bericht</font></strong></div></td>
                                                    <td bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Anmeldedatum</font></b></td>
                                                </tr>
                                                <c:forEach items="${fromAgenturenViewModels}" var="avm">
                                                    <tr bgcolor="AEBACD">
                                                        <td height="6"><font size="2" color="#000033"><a href="showStudentPreciseD?userid=${avm.agentStudent.studentID}">${avm.agentStudent.studentID}</a></font></td>
                                                        <td height="6"><font size="2" color="#000033"><a href="showStudentPreciseD?userid=${avm.agentStudent.studentID}">${avm.agentStudent.studentName}</a></font></td>
                                                        <td width="12%" height="6" bgcolor="AEBACD"><font color="#000033" size="2">${avm.uni}</font></td>
                                                        <td width="8%" height="6" bgcolor="AEBACD"><font color="#000033" size="2">${avm.wohnung}</font></td>
                                                        <td width="7%" bgcolor="AEBACD"><font color="#000033" size="2">${avm.arrivalDate}</font></td>
                                                        <td width="10%" bgcolor="AEBACD"><font color="#000033" size="2">${avm.city}</font></td>
                                                        <td width="16%" bgcolor="AEBACD"><font color="#000033" size="2"><a href="/user/adminRemarksF?adminid=${avm.agentStudent.agentID}">${avm.agentStudent.agentName}</a></font></td>
                                                        <td width="11%" bgcolor="AEBACD"><font color="#000033" size="2">${avm.agentDetail}</font></td>
                                                        <td width="12%" bgcolor="AEBACD"><font size="2" color="#000033">${avm.registrationDate}</font></td>
                                                    </tr>
                                                </c:forEach>
                                            </table></td>
                                        </tr>
                                    </table>
                                    <p>&nbsp;</p>
                                </td>
                            </tr>
                        </table>
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

<!-- Bootstrap core JavaScript-->
<script src="../resources/vendor/jquery/jquery.min.js"></script>
<script src="../resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="../resources/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="../resources/js/sb-admin-2.min.js"></script>

<!-- Page level plugins -->
<script src="../resources/vendor/datatables/jquery.dataTables.min.js"></script>
<script src="../resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>

<!-- Page level custom scripts -->
<script src="../resources/js/demo/datatables-demo.js"></script>

</body>

</html>