<%@ page import="java.util.Vector" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>:: Benutzer-Informationen ::</title>

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

        table tr {
            border-bottom: 1px solid white;
        }
    </style>

    <script>
        function MM_findObj(n, d) { //v4.0
            var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
                d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
            if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
            for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
            if(!x && document.getElementById) x=document.getElementById(n); return x;
        }

        function MM_validateForm() { //v4.0
            var i,p,q,nm,test,num,min,max,errors='',args=MM_validateForm.arguments;
            for (i=0; i<(args.length-2); i+=3) { test=args[i+2]; val=MM_findObj(args[i]);
                if (val) { nm=val.name; if ((val=val.value)!="") {
                    if (test.indexOf('isEmail')!=-1) { p=val.indexOf('@');
                        if (p<1 || p==(val.length-1)) errors+='- '+nm+' must contain an e-mail address.\n';
                    } else if (test!='R') {
                        if (isNaN(val)) errors+='- '+nm+' must contain a number.\n';
                        if (test.indexOf('inRange') != -1) { p=test.indexOf(':');
                            min=test.substring(8,p); max=test.substring(p+1);
                            if (val<min || max<val) errors+='- '+nm+' must contain a number between '+min+' and '+max+'.\n';
                        } } } else if (test.charAt(0) == 'R') errors += '- '+nm+' is required.\n'; }
            } if (errors) alert('The following error(s) occurred:\n'+errors);
            document.MM_returnValue = (errors == '');
        }

        var ikCollection;

        window.onload = function() {
            ikCollection = document.getElementsByClassName("ik");
            for(var i = 0; i < ikCollection.length; i++) {
                ikCollection[i].style.visibility = "hidden";
            }
        }

        function showIkCollection() {
            for(var i = 0; i < ikCollection.length; i++) {
                ikCollection[i].style.visibility = "";
            }
            document.getElementById("topOK").remove();
            //document.getElementById("topOK").style.visibility = "hidden";
            document.getElementById("bottomOK").style.visibility = "";
        }

        function haupt() {
            window.location = "/index";
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
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td valign="top" height="146" bgcolor="D9E5F4" width="81%">
                                <form name="form1" method="post" action="updateStudent" onSubmit="MM_validateForm('txtFirstName','','R',
				  																						'txtLastName','','R',
																										'txtBirthPlace','','R',
																										'txtNationality','','R',
																										'txtAddress','','R',
																										'txtPostCode','','RisNum',
																										'txtCity','','R',
																										'txtCountry','','R',
																										'txtHomeNo','','RisNum',
																										'txtMobileNo','','RisNum',
																										'txtEmail','','RisEmail',
																										'txtLoginName','','R',
																										'txtPassword','','R',
																										'txtHomeCode','','R',
																										'txtMobileCode','','R',
																										'txtFaxCode','','R',
																										'txtHomeRegion','','R',
																										'txtMobileRegion','','R',
																										'txtFaxlRegion','','RisEmail');return document.MM_returnValue">
                                    <table width="100%" height="599" border="0" cellpadding="1" cellspacing="1">
                                        <tr>
                                            <th height="17">
                                                <div align="left">
                                                    <input type="hidden" name="userids" value="">
                                                </div>
                                            </th>
                                            <th height="17">
                                                <div align="right"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">
                                                    <input class="btn btn-primary" type="button" name="Submit3" value="Sch&uuml;ler Kurs Einzelheit" onClick="studentdetail()">
                                                    <input class="btn btn-primary" type="button" name="Submit2" value="Haupt" onClick="haupt()">
                                                </font></div>
                                            </th>
                                        </tr>
                                        <tr bgcolor="657A9A">
                                            <th colspan="2" height="17"><center><b><font color="#FFFFFF">P</font><font color="#FFFFFF">ers&ouml;nliche
                                                Informationen</font></b></center></th>
                                        </tr>
                                        <tr>
                                            <td width="25%" height="24" bgcolor="657A9A"><font color="#000033" size="2"><b><font color="#FFFFFF">*Vorname</font></b></font></td>
                                            <td width="75%" height="24" bgcolor="AEBACD"><font color="#000033">
                                                <input type="text" name="txtFirstName" value="${student.userFirstName}">
                                            </font></td>
                                        </tr>
                                        <tr>
                                            <td width="25%" height="21" bgcolor="657A9A"><font color="#FFFFFF" size="2"><b>*Nachname</b></font></td>
                                            <td width="75%" height="21" bgcolor="AEBACD"><font color="#000033">
                                                <input type="text" name="txtLastName" value="${student.userLastName}">
                                            </font></td>
                                        </tr>
                                        <tr>
                                            <td width="25%" height="19" bgcolor="657A9A"><font color="#FFFFFF" size="2"><b>*Geburtsdatum</b></font></td>
                                            <td width="75%" height="19" bgcolor="AEBACD"><font color="#000033">
                                                <select name="selDay">
                                                    <c:forEach begin="1" end="31" var="i" varStatus="loop">
                                                    <option <c:if test="${i eq birthDay}">selected</c:if> >${i}</option>
                                                    </c:forEach>
                                                </select>
                                                <select name="selMonth">

                                                    <option <c:if test="${birthMont eq 1}">selected</c:if>>Januar</option>

                                                    <option <c:if test="${birthMont eq 2}">selected</c:if>>Februar</option>

                                                    <option <c:if test="${birthMont eq 3}">selected</c:if>>März</option>

                                                    <option <c:if test="${birthMont eq 4}">selected</c:if>>April</option>

                                                    <option <c:if test="${birthMont eq 5}">selected</c:if>>Mai</option>

                                                    <option <c:if test="${birthMont eq 6}">selected</c:if>>Juni</option>

                                                    <option <c:if test="${birthMont eq 7}">selected</c:if>>Juli</option>

                                                    <option <c:if test="${birthMont eq 8}">selected</c:if>>August</option>

                                                    <option <c:if test="${birthMont eq 9}">selected</c:if>>September</option>

                                                    <option <c:if test="${birthMont eq 10}">selected</c:if>>Oktober</option>

                                                    <option <c:if test="${birthMont eq 11}">selected</c:if>>November</option>

                                                    <option <c:if test="${birthMont eq 12}">selected</c:if>>Dezember</option>

                                                </select>
                                                <select name="selYear">
                                                    <c:forEach begin="1950" end="2011" var="year">
                                                        <option <c:if test="${year eq birthYear}">selected</c:if> >${year}</option>
                                                    </c:forEach>
                                                </select>
                                            </font></td>
                                        </tr>
                                        <tr>
                                            <td width="25%" height="14" bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>*Geburtsort</b></font></td>
                                            <td width="75%" height="14" bgcolor="AEBACD">
                                                <input type="text" name="txtBirthPlace" value="${student.userBirthPlace}">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="25%" height="14" bgcolor="657A9A"><font size="2" color="#000033"><b><font color="#FFFFFF">*Geschlecht</font></b></font></td>
                                            <td width="75%" height="14" bgcolor="AEBACD"> <font size="2" color="#000033">M&auml;nnlich</font>

                                                <c:if test="${student.userGender eq 0}">
                                                    <input type="radio" name="rdGender" value="0" checked>
                                                    <font size="2" color="#000033">Weiblich</font>
                                                    <input type="radio" name="rdGender" value="1">
                                                </c:if>

                                                <c:if test="${student.userGender eq 1}">
                                                    <input type="radio" name="rdGender" value="0">
                                                    <font size="2" color="#000033">Weiblich</font>
                                                    <input type="radio" name="rdGender" value="1" checked>
                                                </c:if>

                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="25%" height="14" bgcolor="657A9A"><font color="#FFFFFF" size="2"><b>*Nationalit&auml;t</b></font></td>
                                            <td width="75%" height="14" bgcolor="AEBACD"><font color="#000033">
                                                <select name="selCate">
                                                    <option value="0" selected>w&auml;hlen</option>
                                                    <c:forEach begin="0" end="${countries.size()-1}" var="g">
                                                        <option value="${countries.get(g).userCountryID}"
                                                                <c:if test="${student.userCountryID eq countries.get(g).userCountryID}">selected</c:if>>
                                                                ${countries.get(g).userCountryName}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                                <!--<input type="text" name="txtNationality" value="${student.userCountry}">-->
                                            </font></td>
                                        </tr>
                                        <tr>
                                            <td height="17" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">C/O</font></strong></td>
                                            <td height="17" bgcolor="AEBACD"><input name="txtCO" type="text" id="txtCO" value="${student.userCO}"></td>
                                        </tr>
                                        <tr>
                                            <td width="25%" height="17" bgcolor="657A9A"><font color="#FFFFFF" size="2"><b>*Adresse</b></font></td>
                                            <td width="75%" height="17" bgcolor="AEBACD"><font color="#000033">
                                                <input type="text" name="txtAddress" value="${student.userAddress}">
                                            </font></td>
                                        </tr>
                                        <tr>
                                            <td width="25%" height="2" bgcolor="657A9A"> <font color="#FFFFFF" size="2"><b>*PLZ</b></font>
                                            </td>
                                            <td width="75%" height="2" bgcolor="AEBACD"><font color="#000033">
                                                <input type="text" name="txtPostCode" value="${student.userPostCode}">
                                            </font></td>
                                        </tr>
                                        <tr>
                                            <td width="25%" height="19" bgcolor="657A9A"><font color="#FFFFFF" size="2"><b>*Stadt</b></font></td>
                                            <td width="75%" height="19" bgcolor="AEBACD"><font color="#000033">
                                                <input type="text" name="txtCity" value="${student.userCity}">
                                            </font></td>
                                        </tr>
                                        <tr>
                                            <td width="25%" height="14" bgcolor="657A9A"><font color="#FFFFFF" size="2"><b>*Land</b></font></td>
                                            <td width="75%" height="14" bgcolor="AEBACD"><font color="#000033">
                                                <input type="text" name="txtCountry" value="${student.userCountry}">
                                            </font></td>
                                        </tr>
                                        <!--
                                        <tr>
                                            <td width="25%" height="17" bgcolor="657A9A"><font color="#FFFFFF" size="2"><b>Fest
                                                Nr.</b></font></td>
                                            <td width="75%" height="17" bgcolor="AEBACD"><font color="#000033">
                                                00
                                                <input name="txtHomeCode" type="text" id="txtHomeCode" value="${student.userHomeCode}" size="4" maxlength="3">
                                                <input name="txtHomeRegion" type="text" id="txtHomeRegion" value="${student.userHomeRegion}" size="6" maxlength="5">
                                                <input type="text" name="txtHomeNo" value="${student.userHomePhone}">
                                            </font></td>
                                        </tr>
                                        -->
                                        <tr>
                                            <td width="25%" height="11" bgcolor="657A9A"><font color="#FFFFFF" size="2"><b>Handy
                                                Nr.</b></font></td>
                                            <td width="75%" height="11" bgcolor="AEBACD"><font color="#000033">
                                                00
                                                <input name="txtMobileCode" type="text" id="txtMobileCode" value="${student.userMobileCode}" size="4" maxlength="4">
                                                <input name="txtMobileRegion" type="text" id="txtMobileRegion" value="${student.userMobilePhone}" size="6" maxlength="5">
                                                <input type="text" name="txtMobileNo" value="${student.userMobilePhone}">
                                            </font></td>
                                        </tr>
                                        <tr>
                                            <td width="25%" height="23" bgcolor="657A9A"><font color="#FFFFFF" size="2"><b>Email
                                            </b></font></td>
                                            <td width="75%" height="23" bgcolor="AEBACD"><font color="#000033">
                                                <input type="text" name="txtEmail" value="${student.userEmail}">
                                            </font></td>
                                        </tr>
                                        <tr bgcolor="657A9A">
                                            <th colspan="2" height="17"><center><b><font color="#FFFFFF"><a style="text-decoration: none; color:white; cursor:pointer;" onclick="showIkCollection();">Integrationkurs</a></font></b></center></th>
                                        </tr>
                                        <tr id="topOK">
                                            <td width="25%" height="30" bgcolor="657A9A">&nbsp;</td>
                                            <td width="75%" height="30" bgcolor="AEBACD">
                                                <input  class="btn btn-primary" type="submit" name="Submit" value="Sphichernn">
                                                <font color="#000033">
                                                    <input type="hidden" name="hiddenField" value="${student.userID}">
                                                </font>                        </td>
                                        </tr>
                                        <tr class="ik">
                                            <td height="23" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Bamfnummer</font></b></td>
                                            <td height="23" bgcolor="AEBACD"><font color="#000033">
                                                <input name="txtBamfNumber" type="text" value="${student.userBamfNumber}" maxlength="20">
                                                <font size="2">    </font><font color="#000033"><font size="2">PKZ
                                                <c:if test="${student.userBamfChoice eq 0}">
                                                    <input type="radio" name="rdChoice" value="0" checked>
                                                    ABH</font> <font size="2">
                                                    <input type="radio" name="rdChoice" value="1">
                                                    TGS
                                                    <input type="radio" name="rdChoice" value="3">
                                                    BVA
                                                    <input type="radio" name="rdChoice" value="2">
                                                </c:if>
                                                <c:if test="${student.userBamfChoice eq 1}">
                                                    <input type="radio" name="rdChoice" value="0">
                                                    ABH</font> <font size="2">
                                                    <input type="radio" name="rdChoice" value="1" checked>
                                                    TGS
                                                    <input type="radio" name="rdChoice" value="3">
                                                    BVA
                                                    <input type="radio" name="rdChoice" value="2">
                                                </c:if>
                                                <c:if test="${student.userBamfChoice eq 2}">
                                                    <input type="radio" name="rdChoice" value="0">
                                                    ABH</font> <font size="2">
                                                    <input type="radio" name="rdChoice" value="1" >
                                                    TGS
                                                    <input type="radio" name="rdChoice" value="3">
                                                    BVA
                                                    <input type="radio" name="rdChoice" value="2" checked>
                                                </c:if>
                                                <c:if test="${student.userBamfChoice eq 3}">
                                                    <input type="radio" name="rdChoice" value="0">
                                                    ABH</font> <font size="2">
                                                    <input type="radio" name="rdChoice" value="1" >
                                                    TGS
                                                    <input type="radio" name="rdChoice" value="3" checked>
                                                    BVA
                                                    <input type="radio" name="rdChoice" value="2" >
                                                </c:if>

                                            </font></font> </font></td>
                                        </tr>
                                        <tr class="ik">
                                            <td height="23" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Nr. der Best. </font></b></td>
                                            <td height="23" bgcolor="AEBACD"><font color="#000033">
                                                <input name="txtVerified" type="text" id="txtVerified" value="${student.userVerifiedNumber}">
                                            </font></td>
                                        </tr>
                                        <tr class="ik">
                                            <td height="23" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Ausweiss nummer</font></b></td>
                                            <td height="23" bgcolor="AEBACD"><font color="#000033">
                                                <input name="txtPassport" type="text" id="txtPassport" value="${student.userPassport}">
                                            </font></td>
                                        </tr>
                                        <tr class="ik">
                                            <td height="23" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Anzahl der Schuljahre </font></b></td>
                                            <td height="23" bgcolor="AEBACD"><font color="#000033">
                                                <input name="txtSchoolingYears" type="text" id="txtSchoolingYears" value="${student.userSchoolingYears}" maxlength="3">
                                            </font></td>
                                        </tr>
                                        <tr class="ik">
                                            <td height="23" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Empfehlende Kursmodule</font></b></td>
                                            <td height="23" bgcolor="AEBACD"><font color="#000033">
                                                <select name="selModule">
                                                    <c:forEach begin="1" end="10" var="i">
                                                        <option <c:if test="${i eq student.userModuleNr}">selected</c:if>>${i}</option>
                                                    </c:forEach>
                                                </select>
                                            </font></td>
                                        </tr>
                                        <tr class="ik">
                                            <td height="14" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Einstufungstest: 12,50</font></b><font color="#FFFFFF" size="2">&nbsp; </font><font color="#FFFFFF"><strong><FONT size=-1>&euro;/TN</FONT></strong></font></td>
                                            <td height="14" bgcolor="AEBACD"><font size="2">JA
                                                <c:if test="${student.userClassification eq 0}">
                                                    <input type="radio" name="rdclass" value="1">
                                                    NEIN
                                                    <input type="radio" name="rdclass" value="0" checked>
                                                </c:if>
                                                <c:if test="${student.userClassification eq 1}">
                                                    <input type="radio" name="rdclass" value="1"checked>
                                                    NEIN
                                                    <input type="radio" name="rdclass" value="0">
                                                </c:if>

                                            </font><font color="#000033">
                                                <select name="selGraDay">
                                                    <c:forEach begin="1" end="31" var="i">
                                                        <option <c:if test="${gradingDay eq i}">selected</c:if>>${i}</option>
                                                    </c:forEach>
                                                </select>
                                                <select name="selGraMonth">
                                                    <option <c:if test="${gradingMont eq 1}">selected</c:if>>Januar</option>

                                                    <option <c:if test="${gradingMont eq 2}">selected</c:if>>Februar</option>

                                                    <option <c:if test="${gradingMont eq 3}">selected</c:if>>März</option>

                                                    <option <c:if test="${gradingMont eq 4}">selected</c:if>>April</option>

                                                    <option <c:if test="${gradingMont eq 5}">selected</c:if>>Mai</option>

                                                    <option <c:if test="${gradingMont eq 6}">selected</c:if>>Juni</option>

                                                    <option <c:if test="${gradingMont eq 7}">selected</c:if>>Juli</option>

                                                    <option <c:if test="${gradingMont eq 8}">selected</c:if>>August</option>

                                                    <option <c:if test="${gradingMont eq 9}">selected</c:if>>September</option>

                                                    <option <c:if test="${gradingMont eq 10}">selected</c:if>>Oktober</option>

                                                    <option <c:if test="${gradingMont eq 11}">selected</c:if>>November</option>

                                                    <option <c:if test="${gradingMont eq 12}">selected</c:if>>Dezember</option>
                                                </select>
                                                <select name="selGraYear">
                                                    <c:forEach begin="2000" end="2030" var="i">
                                                        <option <c:if test="${gradingYear eq i}">selected</c:if>>${i}</option>
                                                    </c:forEach>
                                                </select>
                                            </font><font size="2">&nbsp;                        </font></td>
                                        </tr>
                                        <tr class="ik">
                                            <td height="23" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Ergebnis des Einstufungstests </font></b></td>
                                            <td height="23" bgcolor="AEBACD"><font color="#000033">
                                                <input name="txtIntTest" type="text" id="txtIntTest" value="${student.userIntTest}" maxlength="2">
                                                <font size="2">keine einfachen kenntnisse </font> <font size="2">
                                                <c:choose>
                                                    <c:when test="${student.userIntTestCheck eq 0}">

                                                        </font><font color="#000033"><font size="2">
                                                            <input type="radio" name="rdInttestcheck" value="0" checked>
                                                        </font></font><font size="2"> mindestens einfache kenntnisse</font> <font size="2">
                                                            <input type="radio" name="rdInttestcheck" value="1">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <input type="radio" name="rdInttestcheck" value="0">
                                                        mindestens einfache kenntnisse</font> <font size="2">
                                                        <input type="radio" name="rdInttestcheck" value="1" checked>
                                                    </c:otherwise>
                                                </c:choose>
                                            </font></font></td>
                                        </tr>
                                        <tr class="ik">
                                            <td height="23" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Angaben zur Schreibkundigkeit</font></b></td>
                                            <td height="23" bgcolor="AEBACD"><font color="#000033"> <font size="2">nicht alphabetisiert</font>
                                                <c:if test="${student.userProficency eq 0}">
                                                    <input type="radio" name="rdProficency" value="0" checked>
                                                    <font size="2">nicht lateinisch alphabetisiert</font>
                                                    <input type="radio" name="rdProficency" value="1">
                                                    <font size="2">lateinisch alphabetisert</font>
                                                    <input type="radio" name="rdProficency" value="2">
                                                </c:if>
                                                <c:if test="${student.userProficency eq 1}">
                                                    <input type="radio" name="rdProficency" value="0" >
                                                    <font size="2">nicht lateinisch alphabetisiert</font>
                                                    <input type="radio" name="rdProficency" value="1"checked>
                                                    <font size="2">lateinisch alphabetisert</font>
                                                    <input type="radio" name="rdProficency" value="2">
                                                </c:if>
                                                <c:if test="${student.userProficency eq 2}">
                                                    <input type="radio" name="rdProficency" value="0" >
                                                    <font size="2">nicht lateinisch alphabetisiert</font>
                                                    <input type="radio" name="rdProficency" value="1">
                                                    <font size="2">lateinisch alphabetisert</font>
                                                    <input type="radio" name="rdProficency" value="2" checked>
                                                </c:if>
                                            </font></td>
                                        </tr>
                                        <tr class="ik">
                                            <td height="14" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Auftrag auf Kostenbefreiung wurde mit der anmeldung gestellt</font></b></td>
                                            <td height="14" bgcolor="AEBACD"><font size="2">JA
                                                <c:if test="${student.userSponsorShip eq 0}">
                                                    <input type="radio" name="rdSponsorship" value="1">
                                                    NEIN
                                                    <input type="radio" name="rdSponsorship" value="0" checked>
                                                </c:if>
                                                <c:if test="${student.userSponsorShip eq 1}">
                                                    <input type="radio" name="rdSponsorship" value="1"checked>
                                                    NEIN
                                                    <input type="radio" name="rdSponsorship" value="0">
                                                </c:if>
                                            </font> </td>
                                        </tr>
                                        <tr class="ik">
                                            <td height="14" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">TN (Teilnehmer-) Typ </font></b></td>
                                            <td height="14" bgcolor="AEBACD"><font color="#000033">
                                                <select name="selIden" id="selIden">
                                                    <option value="0" selected>w&auml;hlen</option>
                                                    <c:forEach items="${identities}" var="item">
                                                        <option value="${item.userIdentityID}"
                                                                <c:if test="${student.userIdentityID eq item.userIdentityID}">selected</c:if>>
                                                                ${item.userIdentityName}</option>
                                                    </c:forEach>
                                                </select>
                                            </font> </td>
                                        </tr>
                                        <tr class="ik">
                                            <td height="14" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">KB (Kostenbeitrags-) Typ </font></b></td>
                                            <td height="14" bgcolor="AEBACD"><font color="#000033" size="2">

                                                <c:if test="${student.userCostSharing eq 0}">
                                                    mit Kostenbeitrag, 1,00</font><FONT size=-1> &euro; </FONT><font color="#000033" size="2"> Regelfall
                                                    <input type="radio" name="rdCost" value="1" checked>
                                                    ohne Kostenbeitrag Bamf-Entsheidung
                                                    <input type="radio" name="rdCost" value="2">
                                                </c:if>
                                                <c:if test="${student.userCostSharing eq 1}">
                                                mit Kostenbeitrag, 1,00 </font><FONT size=-1>&euro;</FONT><font color="#000033" size="2"> Regelfall
                                                <input type="radio" name="rdCost" value="1"checked>
                                                ohne Kostenbeitrag Bamf-Entsheidung
                                                <input type="radio" name="rdCost" value="2">
                                                </c:if>

                                               <c:if test="${student.userCostSharing eq 2}">
                                                mit Kostenbeitrag, 1,00 </font><FONT size=-1>&euro;</FONT><font color="#000033" size="2"> Regelfall
                                                <input type="radio" name="rdCost" value="1">
                                                ohne Kostenbeitrag Bamf-Entsheidung
                                                <input type="radio" name="rdCost" value="2" checked>
                                               </c:if>
                                            </font> </td>
                                        </tr>
                                        <tr class="ik">
                                            <td height="14" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Abschlusstest: 78,65 </font></b><font color="#FFFFFF"><strong><FONT size=-1>&euro;/TN </FONT></strong></font></td>
                                            <td bgcolor="AEBACD"><font color="#000033">
                                                <select name="selConclusionDay">

                                                    <c:forEach begin="1" end="31" var="i" varStatus="loop">
                                                        <option <c:if test="${i eq concDay}">selected</c:if> >${i}</option>
                                                    </c:forEach>

                                                </select>
                                                <select name="selConclusionMonth">
                                                    <option <c:if test="${concMont eq 1}">selected</c:if>>Januar</option>

                                                    <option <c:if test="${concMont eq 2}">selected</c:if>>Februar</option>

                                                    <option <c:if test="${concMont eq 3}">selected</c:if>>März</option>

                                                    <option <c:if test="${concMont eq 4}">selected</c:if>>April</option>

                                                    <option <c:if test="${concMont eq 5}">selected</c:if>>Mai</option>

                                                    <option <c:if test="${concMont eq 6}">selected</c:if>>Juni</option>

                                                    <option <c:if test="${concMont eq 7}">selected</c:if>>Juli</option>

                                                    <option <c:if test="${concMont eq 8}">selected</c:if>>August</option>

                                                    <option <c:if test="${concMont eq 9}">selected</c:if>>September</option>

                                                    <option <c:if test="${concMont eq 10}">selected</c:if>>Oktober</option>

                                                    <option <c:if test="${concMont eq 11}">selected</c:if>>November</option>

                                                    <option <c:if test="${concMont eq 12}">selected</c:if>>Dezember</option>

                                                </select>
                                                <select name="selConclusionYear">
                                                    <c:forEach begin="2000" end="2030" var="i">
                                                        <option <c:if test="${concYear eq i}">selected</c:if>>${i}</option>
                                                    </c:forEach>
                                                </select>
                                            </font></td>
                                        </tr>
                                        <tr class="ik">
                                            <td height="14" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Abschlusstest Orienterungkurs = 5</font></b> <font color="#FFFFFF"><strong><FONT size=-1>&euro; Pauschale</FONT></strong></font></td>
                                            <td bgcolor="AEBACD"><font color="#000033">
                                                <select name="selConCourseDay">

                                                    <c:forEach begin="1" end="31" var="i" varStatus="loop">
                                                        <option <c:if test="${i eq concCourseDay}">selected</c:if> >${i}</option>
                                                    </c:forEach>

                                                </select>
                                                <select name="selConCourseMonth">

                                                    <option <c:if test="${concCourseMont eq 1}">selected</c:if>>Januar</option>

                                                    <option <c:if test="${concCourseMont eq 2}">selected</c:if>>Februar</option>

                                                    <option <c:if test="${concCourseMont eq 3}">selected</c:if>>März</option>

                                                    <option <c:if test="${concCourseMont eq 4}">selected</c:if>>April</option>

                                                    <option <c:if test="${concCourseMont eq 5}">selected</c:if>>Mai</option>

                                                    <option <c:if test="${concCourseMont eq 6}">selected</c:if>>Juni</option>

                                                    <option <c:if test="${concCourseMont eq 7}">selected</c:if>>Juli</option>

                                                    <option <c:if test="${concCourseMont eq 8}">selected</c:if>>August</option>

                                                    <option <c:if test="${concCourseMont eq 9}">selected</c:if>>September</option>

                                                    <option <c:if test="${concCourseMont eq 10}">selected</c:if>>Oktober</option>

                                                    <option <c:if test="${concCourseMont eq 11}">selected</c:if>>November</option>

                                                    <option <c:if test="${concCourseMont eq 12}">selected</c:if>>Dezember</option>

                                                </select>
                                                <select name="selConCourseYear">

                                                    <c:forEach begin="2000" end="2030" var="i">
                                                        <option <c:if test="${concCourseYear eq i}">selected</c:if>>${i}</option>
                                                    </c:forEach>

                                                </select>
                                            </font></td>
                                        </tr>
                                        <tr class="ik">
                                            <td height="14" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Fahrtkosten</font></b></td>
                                            <td bgcolor="AEBACD"><font size="2" color="#405579">
                                                <input type="text" name="txtFahrt" size="8" value="${student.userFahrtKosten}">
                                            </font><font color="#000033">&nbsp; </font></td>
                                        </tr>
                                        <tr id="bottomOK" style="visibility: hidden;">
                                            <td width="25%" height="30" bgcolor="657A9A">&nbsp;</td>
                                            <td width="75%" height="30" bgcolor="AEBACD">
                                                <input class="btn btn-primary" type="submit" name="Submit" value="Sphichernn">
                                                <font color="#000033">
                                                    <input type="hidden" name="hiddenField" value="${student.userID}">
                                                </font>                        </td>
                                        </tr>
                                    </table>
                                </form>
                            </td>
                        </tr>
                    </table>
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