<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Benutzer-Informationen ::</title>

    <script>
        function changecity()
        {
            document.form1.submit();
        }

        function employeeSchedule()
        {
            window.location="/stundenplan/addHoursSchedule";
        }
    </script>
    <style>
        #kkk td {
            border: none;
        }

        @media only screen and (max-width: 1024px) {
            .wr-pad {
                padding-left: 10%;
                padding-right: 15%;
            }

            .card-height {
                height: 125px;
            }
        }

        @media only screen and (min-width: 1025px) {
            .wr-pad {
                padding-left: 16%;
                padding-right: 16%;
            }
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
            <jsp:include page="templates/navbar.jsp"/>
            <!-- End of Topbar -->

            <!-- Begin Page Content -->
            <div class="container-fluid">

                <div class="wrapper wr-pad">
                    <div class="row border-bottom-danger" style="margin-bottom:1.5%;">

                        <table id="kkk" width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tbody>
                            <tr>
                                <td  valign="top" width="83%">
                                    <table width="100%" border="0" height="86%">
                                        <tbody>
                                        <tr>
                                            <td  valign="top" height="100%">
                                                <table width="100%" border="0" cellspacing="1" cellpadding="0" height="100%">
                                                    <tbody>
                                                    <tr>
                                                        <td style="border-right:.25rem solid #e74a3b!important;" valign="top" width="379" height="129">
                                                            <form name="form2" method="post" action="schuler/searchStudent">
                                                                <input name="same" type="hidden" id="same" value="same">
                                                                <table width="100%" border="0" height="100%" cellpadding="1" cellspacing="1">
                                                                    <tbody>
                                                                    <tr>
                                                                        <td height="27" colspan="3">
                                                                            <div align="center">
                                                                                <font size="3" color="#FFFFFF"><b>
                                                                                </b></font>
                                                                                <font color="#000033">
                                                                                    <input type="hidden" name="max" value="14491">
                                                                                </font>
                                                                                <label class="col-form-label">Suche Kursteilnehmer</label>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td height="26" width="24%"><strong>
                                                                            <font size="2" style="font-size: 20px;">SuchKriterien</font>
                                                                        </strong></td>
                                                                        <td height="26"><select style="width:auto !important;"
                                                                                                class="custom-select " name="selCriteria">

                                                                            <option value="1">Aktiv Schüler\in</option>

                                                                            <option value="2" selected="">Vorname</option>

                                                                            <option value="3">Nachname</option>

                                                                            <option value="4">Geburtsdatum</option>

                                                                            <option value="5">KundenNr.</option>

                                                                            <option value="6">Keine Kriterien</option>

                                                                            <option value="7">Nicht Aktiv Schüler\in</option>

                                                                        </select>

                                                                            <input name="alle" type="checkbox" value="checkbox">

                                                                            <font size="2">Alle</font>
                                                                            <font size="1" face="Verdana, Arial, Helvetica, sans-serif">&nbsp;
                                                                            </font>
                                                                        </td>

                                                                    </tr>
                                                                    <tr>
                                                                        <td height="24">
                                                                            <font size="2" style="font-size: 20px;"><strong>Schlüsselwort</strong></font>
                                                                        </td>
                                                                        <td height="24" colspan="2">
                                                                            <input style="width:196.4px !important; display:inline-block;"
                                                                                   class="form-control" name="txtKeyWord" type="text" size="14">

                                                                            <input type="checkbox" name="recent" value="checkbox" checked="">

                                                                            <font size="2">Letzte Tausend</font>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="24%" height="24"><b>
                                                                            <font size="2" style="font-size: 20px;">Geburtsdatum</font>
                                                                        </b></td>
                                                                        <td width="59%" height="24">
                                                                            <font>
                                                                                <select name="selDay" class="form-control" name="selDay" style="
                                                  width: auto !important;
                                                  display: inline-block;
                                              ">

                                                                                    <option value="1" selected="">1</option>

                                                                                    <option value="2">2</option>

                                                                                    <option value="3">3</option>

                                                                                    <option value="4">4</option>

                                                                                    <option value="5">5</option>

                                                                                    <option value="6">6</option>

                                                                                    <option value="7">7</option>

                                                                                    <option value="8">8</option>

                                                                                    <option value="9">9</option>

                                                                                    <option value="10">10</option>

                                                                                    <option value="11">11</option>

                                                                                    <option value="12">12</option>

                                                                                    <option value="13">13</option>

                                                                                    <option value="14">14</option>

                                                                                    <option value="15">15</option>

                                                                                    <option value="16">16</option>

                                                                                    <option value="17">17</option>

                                                                                    <option value="18">18</option>

                                                                                    <option value="19">19</option>

                                                                                    <option value="20">20</option>

                                                                                    <option value="21">21</option>

                                                                                    <option value="22">22</option>

                                                                                    <option value="23">23</option>

                                                                                    <option value="24">24</option>

                                                                                    <option value="25">25</option>

                                                                                    <option value="26">26</option>

                                                                                    <option value="27">27</option>

                                                                                    <option value="28">28</option>

                                                                                    <option value="29">29</option>

                                                                                    <option value="30">30</option>

                                                                                    <option value="31">31</option>

                                                                                </select>
                                                                                <select name="selMonth" class="form-control" name="selDay" style="
                                                  width: 120px;
                                                  display: inline-block;
                                              ">

                                                                                    <option value="1" selected="">Januar</option>

                                                                                    <option value="2">Februar</option>

                                                                                    <option value="3">März</option>

                                                                                    <option value="4">April</option>

                                                                                    <option value="5">Mai</option>

                                                                                    <option value="6">Juni</option>

                                                                                    <option value="7">Juli</option>

                                                                                    <option value="8">August</option>

                                                                                    <option value="9">September</option>

                                                                                    <option value="10">Oktober</option>

                                                                                    <option value="11">November</option>

                                                                                    <option value="12">Dezember</option>

                                                                                </select>
                                                                                <select name="selYear" class="form-control" name="selDay" style="
                                                  width: auto !important;
                                                  display: inline-block;
                                              ">

                                                                                    <option value="1950" selected="">1950</option>

                                                                                    <option value="1951">1951</option>

                                                                                    <option value="1952">1952</option>

                                                                                    <option value="1953">1953</option>

                                                                                    <option value="1954">1954</option>

                                                                                    <option value="1955">1955</option>

                                                                                    <option value="1956">1956</option>

                                                                                    <option value="1957">1957</option>

                                                                                    <option value="1958">1958</option>

                                                                                    <option value="1959">1959</option>

                                                                                    <option value="1960">1960</option>

                                                                                    <option value="1961">1961</option>

                                                                                    <option value="1962">1962</option>

                                                                                    <option value="1963">1963</option>

                                                                                    <option value="1964">1964</option>

                                                                                    <option value="1965">1965</option>

                                                                                    <option value="1966">1966</option>

                                                                                    <option value="1967">1967</option>

                                                                                    <option value="1968">1968</option>

                                                                                    <option value="1969">1969</option>

                                                                                    <option value="1970">1970</option>

                                                                                    <option value="1971">1971</option>

                                                                                    <option value="1972">1972</option>

                                                                                    <option value="1973">1973</option>

                                                                                    <option value="1974">1974</option>

                                                                                    <option value="1975">1975</option>

                                                                                    <option value="1976">1976</option>

                                                                                    <option value="1977">1977</option>

                                                                                    <option value="1978">1978</option>

                                                                                    <option value="1979">1979</option>

                                                                                    <option value="1980">1980</option>

                                                                                    <option value="1981">1981</option>

                                                                                    <option value="1982">1982</option>

                                                                                    <option value="1983">1983</option>

                                                                                    <option value="1984">1984</option>

                                                                                    <option value="1985">1985</option>

                                                                                    <option value="1986">1986</option>

                                                                                    <option value="1987">1987</option>

                                                                                    <option value="1988">1988</option>

                                                                                    <option value="1989">1989</option>

                                                                                    <option value="1990">1990</option>

                                                                                    <option value="1991">1991</option>

                                                                                    <option value="1992">1992</option>

                                                                                    <option value="1993">1993</option>

                                                                                    <option value="1994">1994</option>

                                                                                    <option value="1995">1995</option>

                                                                                    <option value="1996">1996</option>

                                                                                    <option value="1997">1997</option>

                                                                                    <option value="1998">1998</option>

                                                                                    <option value="1999">1999</option>

                                                                                    <option value="2000">2000</option>

                                                                                    <option value="2001">2001</option>

                                                                                    <option value="2002">2002</option>

                                                                                    <option value="2003">2003</option>

                                                                                    <option value="2004">2004</option>

                                                                                    <option value="2005">2005</option>

                                                                                    <option value="2006">2006</option>

                                                                                    <option value="2007">2007</option>

                                                                                    <option value="2008">2008</option>

                                                                                    <option value="2009">2009</option>

                                                                                    <option value="2010">2010</option>

                                                                                </select>
                                                                            </font>
                                                                        </td>
                                                                        <td width="17%" height="24"><input class="btn btn-primary" type="submit"
                                                                                                           name="Submit" value="Suche">
                                                                        </td>
                                                                    </tr>
                                                                    </tbody>
                                                                </table>
                                                            </form>
                                                        </td>
                                                        <td width="400" height="129">
                                                            <form style="margin-left:5%;" name="form1" method="post" action="changeCity">
                                                                <table width="100%" style="vertical-align:top " border="0" cellspacing="1"
                                                                       cellpadding="1" height="100%">
                                                                    <tbody>
                                                                    <tr>
                                                                        <td colspan="3" height="21">
                                                                            <div align="center"><label class="col-form-label">Benutzer - Information </label></div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td width="66" height="26" >
                                                                            <font size="2" ></font>
                                                                            <font size="1">
                                                                                <font size="2"><b>
                                                                                    <font style="font-size: 20px;">Name</font>
                                                                                </b></font>
                                                                            </font>
                                                                        </td>
                                                                        <td width="139" height="26">
                                                                            <font size="2"  style="font-size: 20px;">${rps.loginUser.userFirstName} ${rps.loginUser.userLastName}</font>
                                                                        </td>
                                                                        <td width="171" height="26"><select style="width:210px !important;" class="custom-select" name="select"
                                                                                                            onchange="changecity()">

                                                                            <option value="5" <c:if test="${rps.loginPlace.placeID eq 5}">selected</c:if>>Dortmund</option>

                                                                            <option value="4" <c:if test="${rps.loginPlace.placeID eq 4}">selected</c:if>>Duisburg</option>

                                                                            <option value="2" <c:if test="${rps.loginPlace.placeID eq 2}">selected</c:if>>Düsseldorf</option>

                                                                            <option value="1" <c:if test="${rps.loginPlace.placeID eq 1}">selected</c:if>>Essen</option>

                                                                            <option value="3" <c:if test="${rps.loginPlace.placeID eq 3}">selected</c:if>>Online</option>

                                                                        </select>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td height="26">
                                                                            <font size="2"><b>
                                                                                <font  style="font-size: 20px;">Typ</font>
                                                                            </b></font>
                                                                        </td>
                                                                        <td height="26" >
                                                                            <font style="font-size: 20px;" size="2">Admin</font>
                                                                        </td>
                                                                        <td height="26" ><a style="width: 210px;" class="btn btn-primary" href="/logout">Abmeldung</a>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td height="25">
                                                                            <font size="2" style="font-size: 20px;"><a href="user/adminInfoView">IhreBemerkung</a></font>
                                                                        </td>
                                                                        <td height="9" >&nbsp;</td>

                                                                        <td height="25"><input style="width: 210px;" class="btn btn-primary" type="button" name="Button"
                                                                                               value="Mitarbeiter Anmeldung" onclick="employeeSchedule()"></td>
                                                                    </tr>
                                                                    </tbody>
                                                                </table>
                                                            </form>
                                                        </td>
                                                    </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>


                <div class="container-fluid" style="padding-left: 15%; padding-right: 15%;">
                    <div class="row card-bottom-margin">
                        <div class="col-md-3">
                            <a href="/schuler/notregister/1">
                                <div class="card border-bottom-primary shadow h-60 py-2 card-height">
                                    <div class="card-body">
                                        <center>
                                            <div class="row no-gutters align-items-center">
                                                <div class="col mr-2">
                                                    <div class="th5 mb-0 font-weight-bold text-gray-800">Online-Schüler</div>
                                                </div>
                                            </div>
                                        </center>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="col-md-3">
                            <a href="/courses/courseList">
                                <div class="card border-bottom-primary shadow h-60 py-2 card-height">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="th5 mb-0 font-weight-bold text-gray-800">Kurse</div>

                                            </div>
                                            
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="col-md-3">
                            <a href="/user/searchUser">
                                <div class="card border-bottom-primary shadow h-60 py-2 card-height">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="th5 mb-0 font-weight-bold text-gray-800">Benutzer</div>
                                            </div>
                                            
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="col-md-3">
                            <a href="/exp/ausgabe">
                                <div class="card border-bottom-primary shadow h-60 py-2 card-height">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="th5 mb-0 font-weight-bold text-gray-800">Ausgabe</div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="row card-bottom-margin">
                        <div class="col-md-3">
                            <a href="/school/schoolList">
                                <div class="card border-bottom-primary shadow h-60 py-2 card-height">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="th5 mb-0 font-weight-bold text-gray-800">Schulen</div>
                                            </div>
                                            
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="col-md-3">
                            <a href="/stundenplan/stSheet">
                                <div class="card border-bottom-primary shadow h-60 py-2 card-height">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="th5 mb-0 font-weight-bold text-gray-800">Stundenplan</div>
                                            </div>
                                            
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="col-md-3">
                            <div class="card border-bottom-primary shadow h-60 py-2 card-height">
                                <a href="/bericht/searchTransactions">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="th5 mb-0 font-weight-bold text-gray-800">Rechnung</div>
                                            </div>

                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <a href="/balanz/expenseReport">
                                <div class="card border-bottom-primary shadow h-60 py-2 card-height">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="th5 mb-0 font-weight-bold text-gray-800">Bilanz</div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="row card-bottom-margin">
                        <div class="col-md-3">
                            <a href="/mahnung/mahnunglist">
                                <div class="card border-bottom-primary shadow h-60 py-2 card-height">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="th5 mb-0 font-weight-bold text-gray-800">Mahnung</div>
                                            </div>
                                            
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="col-md-3">
                            <div class="card border-bottom-primary shadow h-60 py-2 card-height">
                                <a href="/complaints/searchComplaint">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="th5 mb-0 font-weight-bold text-gray-800">Beschwerden</div>
                                            </div>

                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <a href="/books/bookTra?cmd=f">
                                <div class="card border-bottom-primary shadow h-60 py-2 card-height">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="th5 mb-0 font-weight-bold text-gray-800">Bücher</div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="col-md-3">
                            <a href="/inventor/inventorReport">
                                <div class="card border-bottom-primary shadow h-60 py-2 card-height">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="th5 mb-0 font-weight-bold text-gray-800">Inventar</div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="row card-bottom-margin">
                        <div class="col-md-3">
                            <div class="card border-bottom-primary shadow h-60 py-2 card-height">
                                <a href="/vocabultrainer/sprach">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="th5 mb-0 font-weight-bold text-gray-800">Sprache</div>
                                            </div>
                                            
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <a href="/drive/driveControler?folder=drives">
                                <div class="card border-bottom-primary shadow h-60 py-2 card-height">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="th5 mb-0 font-weight-bold text-gray-800">Dateiverwaltung</div>
                                            </div>
                                            
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="col-md-3">
                            <a href="/stundenplan/stlohn">
                                <div class="card border-bottom-primary shadow h-60 py-2 card-height">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="th5 mb-0 font-weight-bold text-gray-800">Lehrerlohn</div>
                                            </div>
                                            
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="col-md-3">
                            <div class="card border-bottom-primary shadow h-60 py-2 card-height">
                                <a href="/werbung/werbungList">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="th5 mb-0 font-weight-bold text-gray-800">Werbung</div>
                                            </div>

                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>

                    </div>
                    <div class="row card-bottom-margin">
                        <div class="col-md-3">
                            <a href="/groupen/groupList">
                                <div class="card border-bottom-primary shadow h-60 py-2 card-height">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="th5 mb-0 font-weight-bold text-gray-800">Gruppen</div>
                                            </div>
                                            
                                        </div>
                                    </div>

                                </div>
                            </a>
                        </div>
                        <div class="col-md-3">
                            <a href="#">
                                <div class="card border-bottom-primary shadow h-60 py-2 card-height">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="th5 mb-0 font-weight-bold text-gray-800">Alle Bilder</div>
                                            </div>
                                            
                                        </div>
                                    </div>

                                </div>
                            </a>
                        </div>
                        <div class="col-md-3">
                            <div class="card border-bottom-primary shadow h-60 py-2 card-height">
                                <a href="/residence/mieterList">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="th5 mb-0 font-weight-bold text-gray-800">Mieteinkommen</div>
                                            </div>

                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <a href="/werbung/messeList">
                                <div class="card border-bottom-primary shadow h-60 py-2 card-height">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="th5 mb-0 font-weight-bold text-gray-800">Messen</div>
                                            </div>

                                        </div>
                                    </div>

                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</div>
<!-- /.container-fluid -->

</div>
<!-- End of Main Content -->

<!-- Footer -->
<jsp:include page="templates/footer.jsp"/>
<!-- End of Footer -->

</div>
<!-- End of Content Wrapper -->

</div>
<!-- End of Page Wrapper -->

<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
</a>



<jsp:include page="templates/bodyimports.jsp"/>

</body>

</html>