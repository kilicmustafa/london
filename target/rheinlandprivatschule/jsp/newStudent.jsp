<%--
  Created by IntelliJ IDEA.
  User: cemasma
  Date: 3/27/2019
  Time: 1:29 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Neue Schüler ::</title>
    <style>
        table tr {
            border-bottom: 1px solid white;
        }
    </style>

    <script>
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
    </script>
</head>
<body>
<div id="wrapper" class="wrapper">
    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">
        <jsp:include page="templates/navbar.jsp"/>

        <!-- Main Content -->
        <div id="content">
            <!-- Begin Page Content -->
            <div class="container-fluid">

                <div class="wrapper" style="padding-left: 17.5%; padding-right: 17.5%;">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tbody><tr>
                            <td valign="top" height="146" bgcolor="D9E5F4" width="84%">
                                <form name="form1" method="post" action="registerStudent" onsubmit="MM_validateForm('txtFirstName','','R',
				  																						  'txtLastName','','R',
																										  'txtBirthPlace','','R',
																										  'txtNationality','','R',
																										  'txtAddress','','R',
																										  'txtPostCode','','NisNum',
																										  'txtFahrt','','NisNum',
																										  'txtCity','','R',
																										  'txtCountry','','R',
																										  'txtHomeNo','','NisNum',
																										  'txtMobileNo','','NisNum',
																										  'txtFax','','NisNum',
																										  'txtEmail','','NisEmail',
																										  'txtHomeCode','','NisHomeCode',
																										  'txtHomeRegion','','NisHomeRegion',
																										  'txtMobileCode','','NisMobileCode',
																										  'txtMobileRegion','','NisMobileRegion',
																										  'txtFaxCode','','NisFaxCode',
																										  'txtFaxRegion','','NisFaxRegion');return document.MM_returnValue">
                                    <table width="100%" height="596" border="0" cellpadding="1" cellspacing="1">
                                        <tbody><tr>
                                            <th colspan="2" height="17">
                                                <div align="right"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">
                                                    <a class="btn btn-primary" href="/teilnehmerList">Teilnehmer</a>
                                                    <input class="btn btn-primary" type="button" name="Nationality" value="Nationalität" onclick="nationality()">
                                                    <a class="btn btn-primary" href="../index">Haupt</a>
                                                </font></div>
                                            </th>
                                        </tr>
                                        <tr>
                                            <th colspan="2" height="17" bgcolor="657A9A"><center><b><font color="#FFFFFF">P</font><font color="#FFFFFF">ersönliche
                                                Informationen</font></b></center></th>
                                        </tr>
                                        <tr>
                                            <td width="26%" height="24" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Vorname</font></b></td>
                                            <td width="74%" height="24" bgcolor="AEBACD"><font color="#000033">
                                                <input type="text" name="txtFirstName" value="">
                                            </font></td>
                                        </tr>
                                        <tr>
                                            <td width="26%" height="21" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Nachname</font></b></td>
                                            <td width="74%" height="21" bgcolor="AEBACD"><font color="#000033">
                                                <input type="text" name="txtLastName" value="">
                                            </font></td>
                                        </tr>
                                        <tr>
                                            <td width="26%" height="19" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*<b><font color="#FFFFFF" size="2">Geburtsdatum</font></b></font></b></td>
                                            <td width="74%" height="19" bgcolor="AEBACD"><font color="#000033">
                                                <select name="selDay">

                                                    <option selected="">1</option>

                                                    <option>2</option>

                                                    <option>3</option>

                                                    <option>4</option>

                                                    <option>5</option>

                                                    <option>6</option>

                                                    <option>7</option>

                                                    <option>8</option>

                                                    <option>9</option>

                                                    <option>10</option>

                                                    <option>11</option>

                                                    <option>12</option>

                                                    <option>13</option>

                                                    <option>14</option>

                                                    <option>15</option>

                                                    <option>16</option>

                                                    <option>17</option>

                                                    <option>18</option>

                                                    <option>19</option>

                                                    <option>20</option>

                                                    <option>21</option>

                                                    <option>22</option>

                                                    <option>23</option>

                                                    <option>24</option>

                                                    <option>25</option>

                                                    <option>26</option>

                                                    <option>27</option>

                                                    <option>28</option>

                                                    <option>29</option>

                                                    <option>30</option>

                                                    <option>31</option>

                                                </select>
                                                <select name="selMonth">

                                                    <option>Januar</option>

                                                    <option>Februar</option>

                                                    <option>März</option>

                                                    <option>April</option>

                                                    <option>Mai</option>

                                                    <option>Juni</option>

                                                    <option>Juli</option>

                                                    <option>August</option>

                                                    <option>September</option>

                                                    <option>Oktober</option>

                                                    <option>November</option>

                                                    <option>Dezember</option>

                                                </select>
                                                <select name="selYear">

                                                    <option>1950</option>

                                                    <option>1951</option>

                                                    <option>1952</option>

                                                    <option>1953</option>

                                                    <option>1954</option>

                                                    <option>1955</option>

                                                    <option>1956</option>

                                                    <option>1957</option>

                                                    <option>1958</option>

                                                    <option>1959</option>

                                                    <option>1960</option>

                                                    <option>1961</option>

                                                    <option>1962</option>

                                                    <option>1963</option>

                                                    <option>1964</option>

                                                    <option>1965</option>

                                                    <option>1966</option>

                                                    <option>1967</option>

                                                    <option>1968</option>

                                                    <option>1969</option>

                                                    <option>1970</option>

                                                    <option>1971</option>

                                                    <option>1972</option>

                                                    <option>1973</option>

                                                    <option>1974</option>

                                                    <option>1975</option>

                                                    <option>1976</option>

                                                    <option>1977</option>

                                                    <option>1978</option>

                                                    <option>1979</option>

                                                    <option selected="">1980</option>

                                                    <option>1981</option>

                                                    <option>1982</option>

                                                    <option>1983</option>

                                                    <option>1984</option>

                                                    <option>1985</option>

                                                    <option>1986</option>

                                                    <option>1987</option>

                                                    <option>1988</option>

                                                    <option>1989</option>

                                                    <option>1990</option>

                                                    <option>1991</option>

                                                    <option>1992</option>

                                                    <option>1993</option>

                                                    <option>1994</option>

                                                    <option>1995</option>

                                                    <option>1996</option>

                                                    <option>1997</option>

                                                    <option>1998</option>

                                                    <option>1999</option>

                                                    <option>2000</option>

                                                    <option>2001</option>

                                                    <option>2002</option>

                                                    <option>2003</option>

                                                    <option>2004</option>

                                                    <option>2005</option>

                                                    <option>2006</option>

                                                    <option>2007</option>

                                                    <option>2008</option>

                                                    <option>2009</option>

                                                    <option>2010</option>

                                                </select>
                                            </font></td>
                                        </tr>
                                        <tr>
                                            <td width="26%" height="14" bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>*Geburtsort</b></font></td>
                                            <td width="74%" height="14" bgcolor="AEBACD">
                                                <input type="text" name="txtBirthPlace" value="">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="26%" height="14" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">*Geschlecht</font></b></td>
                                            <td width="74%" height="14" bgcolor="AEBACD"> <font style="color:white;" size="2">männlich

                                                <input type="radio" name="rdGender" value="0" checked="">
                                                weiblich
                                                <input type="radio" name="rdGender" value="1">

                                            </font> </td>
                                        </tr>
                                        <tr>
                                            <td width="26%" height="14" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Nationalität</font></b></td>
                                            <td width="74%" height="14" bgcolor="AEBACD"><font color="#000033">
                                                <select name="selCate">
                                                    <option value="0" selected="">wählen</option>

                                                    <option value="63">Aegypten</option>

                                                    <option value="65">Aequatorial-Guinea</option>

                                                    <option value="68">Aethiopien</option>

                                                    <option value="1">Afghanistan</option>

                                                    <option value="2">Albanien</option>

                                                    <option value="3">Algerien</option>

                                                    <option value="4">Amerikanisch-Samoa</option>

                                                    <option value="5">Andorra</option>

                                                    <option value="6">Angola</option>

                                                    <option value="7">Anguilla</option>

                                                    <option value="8">Antarktis</option>

                                                    <option value="9">Antigua und Barbuda</option>

                                                    <option value="10">Argentinien</option>

                                                    <option value="11">Armenien</option>

                                                    <option value="12">Aruba</option>

                                                    <option value="15">Aserbaidschan</option>

                                                    <option value="13">Australien</option>

                                                    <option value="16">Bahamas</option>

                                                    <option value="17">Bahrain</option>

                                                    <option value="18">Bangladesh</option>

                                                    <option value="19">Barbados</option>

                                                    <option value="20">Belarus</option>

                                                    <option value="21">Belgien</option>

                                                    <option value="22">Belize</option>

                                                    <option value="23">Benin</option>

                                                    <option value="24">Bermuda</option>

                                                    <option value="25">Bhutan</option>

                                                    <option value="26">Bolivien</option>

                                                    <option value="27">Bosnien und Herzegowina</option>

                                                    <option value="28">Botswana</option>

                                                    <option value="29">Bouvet Island</option>

                                                    <option value="30">Brasilien</option>

                                                    <option value="31">Britische Territorien im Indischen Ozean</option>

                                                    <option value="32">Brunei Darussalam</option>

                                                    <option value="33">Bulgarien</option>

                                                    <option value="34">Burkina Faso</option>

                                                    <option value="35">Burundi</option>

                                                    <option value="40">Cayman-Inseln</option>

                                                    <option value="43">Chile</option>

                                                    <option value="44">China</option>

                                                    <option value="50">Cook-Inseln</option>

                                                    <option value="247">Costa Rica</option>

                                                    <option value="57">Daenemark</option>

                                                    <option value="81">Deutschland</option>

                                                    <option value="58">Djibouti</option>

                                                    <option value="59">Dominica</option>

                                                    <option value="60">Dominikanische Republik</option>

                                                    <option value="62">Ecuador</option>

                                                    <option value="64">El Salvador</option>

                                                    <option value="52">Elfenbeinkueste</option>

                                                    <option value="66">Eritrea</option>

                                                    <option value="67">Estland</option>

                                                    <option value="70">Faeroeer</option>

                                                    <option value="69">Falkland-Inseln (Malvinen)</option>

                                                    <option value="71">Fidschi</option>

                                                    <option value="72">Finnland</option>

                                                    <option value="73">Frankreich</option>

                                                    <option value="74">Frankreich, Metropolitan</option>

                                                    <option value="75">Franzoesisch-Guyana</option>

                                                    <option value="76">Franzoesisch-Polynesien</option>

                                                    <option value="77">Franzoesische Suedterritorien</option>

                                                    <option value="78">Gabon</option>

                                                    <option value="79">Gambia</option>

                                                    <option value="248">Gaza</option>

                                                    <option value="80">Georgien</option>

                                                    <option value="82">Ghana</option>

                                                    <option value="83">Gibraltar</option>

                                                    <option value="86">Grenada</option>

                                                    <option value="84">Griechenland</option>

                                                    <option value="85">Groenland</option>

                                                    <option value="222">Grossbritannien (Vereinigtes Koenigreich)</option>

                                                    <option value="87">Guadeloupe</option>

                                                    <option value="88">Guam</option>

                                                    <option value="89">Guatemala</option>

                                                    <option value="90">Guinea</option>

                                                    <option value="91">Guinea-Bissau</option>

                                                    <option value="92">Guyana</option>

                                                    <option value="93">Haiti</option>

                                                    <option value="94">Heard and Mc Donald Islands</option>

                                                    <option value="95">Honduras</option>

                                                    <option value="96">Hong Kong</option>

                                                    <option value="99">Indien</option>

                                                    <option value="100">Indonesien</option>

                                                    <option value="102">Irak</option>

                                                    <option value="101">Iran (Islamische Republik)</option>

                                                    <option value="103">Irland</option>

                                                    <option value="98">Island</option>

                                                    <option value="104">Israel</option>

                                                    <option value="105">Italien</option>

                                                    <option value="106">Jamaika</option>

                                                    <option value="107">Japan</option>

                                                    <option value="235">Jemen</option>

                                                    <option value="108">Jordanien</option>

                                                    <option value="236">Jugoslawien</option>

                                                    <option value="231">Jungferninseln (Britisch)</option>

                                                    <option value="232">Jungferninseln (USA)</option>

                                                    <option value="36">Kambodscha</option>

                                                    <option value="37">Kamerun</option>

                                                    <option value="38">Kanada</option>

                                                    <option value="39">Kapverden</option>

                                                    <option value="109">Kasachstan</option>

                                                    <option value="110">Kenia</option>

                                                    <option value="115">Kirgisien</option>

                                                    <option value="111">Kiribati</option>

                                                    <option value="46">Kokosinseln</option>

                                                    <option value="47">Kolumbien</option>

                                                    <option value="48">Komoren</option>

                                                    <option value="49">Kongo</option>

                                                    <option value="112">Korea, Demokratische Volksrepublik</option>

                                                    <option value="113">Korea, Republik</option>

                                                    <option value="244">Kosovo</option>

                                                    <option value="51">Kostarika</option>

                                                    <option value="53">Kroatien</option>

                                                    <option value="54">Kuba</option>

                                                    <option value="114">Kuwait</option>

                                                    <option value="116">Laotische Demokratische Volksrepublik</option>

                                                    <option value="119">Lesotho</option>

                                                    <option value="117">Lettland</option>

                                                    <option value="118">Libanon</option>

                                                    <option value="120">Liberia</option>

                                                    <option value="121">Libyen</option>

                                                    <option value="122">Liechtenstein</option>

                                                    <option value="123">Litauen</option>

                                                    <option value="124">Luxemburg</option>

                                                    <option value="125">Macau</option>

                                                    <option value="127">Madagaskar</option>

                                                    <option value="128">Malawi</option>

                                                    <option value="129">Malaysia</option>

                                                    <option value="130">Malediven</option>

                                                    <option value="131">Mali</option>

                                                    <option value="132">Malta</option>

                                                    <option value="144">Marokko</option>

                                                    <option value="133">Marshall-Inseln</option>

                                                    <option value="134">Martinique</option>

                                                    <option value="135">Mauritanien</option>

                                                    <option value="136">Mauritius</option>

                                                    <option value="137">Mayotte</option>

                                                    <option value="126">Mazedonien</option>

                                                    <option value="138">Mexiko</option>

                                                    <option value="139">Mikronesien</option>

                                                    <option value="140">Moldawien</option>

                                                    <option value="141">Monaco</option>

                                                    <option value="142">Mongolei</option>

                                                    <option value="245">Montenegro</option>

                                                    <option value="143">Montserrat</option>

                                                    <option value="145">Mosambik</option>

                                                    <option value="146">Myanmar</option>

                                                    <option value="147">Namibia</option>

                                                    <option value="148">Nauru</option>

                                                    <option value="149">Nepal</option>

                                                    <option value="152">Neu-Kaledonien</option>

                                                    <option value="153">Neuseeland</option>

                                                    <option value="151">Niederlaendische Antillen</option>

                                                    <option value="150">Niederlande</option>

                                                    <option value="155">Niger</option>

                                                    <option value="156">Nigeria</option>

                                                    <option value="154">Nikaragua</option>

                                                    <option value="157">Niue</option>

                                                    <option value="159">Noerdliche Marianen</option>

                                                    <option value="158">Norfolk-Inseln</option>

                                                    <option value="160">Norwegen</option>

                                                    <option value="14">Oesterreich</option>

                                                    <option value="161">Oman</option>

                                                    <option value="61">Ost-Timor</option>

                                                    <option value="162">Pakistan</option>

                                                    <option value="243">Palästina</option>

                                                    <option value="163">Palau</option>

                                                    <option value="164">Panama</option>

                                                    <option value="165">Papua-Neuguinea</option>

                                                    <option value="166">Paraguay</option>

                                                    <option value="167">Peru</option>

                                                    <option value="168">Philippinen</option>

                                                    <option value="169">Pitcairn</option>

                                                    <option value="170">Polen</option>

                                                    <option value="171">Portugal</option>

                                                    <option value="172">Puerto Rico</option>

                                                    <option value="173">Qatar</option>

                                                    <option value="174">Reunion</option>

                                                    <option value="175">Rumaenien</option>

                                                    <option value="176">Russische Foederation</option>

                                                    <option value="177">Rwanda</option>

                                                    <option value="178">Saint Kitts and Nevis</option>

                                                    <option value="179">Saint Lucia</option>

                                                    <option value="180">Saint Vincent und die Grenadinen</option>

                                                    <option value="238">Sambia</option>

                                                    <option value="181">Samoa</option>

                                                    <option value="182">San Marino</option>

                                                    <option value="183">Sao Tome and Principe</option>

                                                    <option value="184">Saudi-Arabien</option>

                                                    <option value="203">Schweden</option>

                                                    <option value="204">Schweiz</option>

                                                    <option value="185">Senegal</option>

                                                    <option value="246">Serbien</option>

                                                    <option value="186">Seychellen</option>

                                                    <option value="187">Sierra Leone</option>

                                                    <option value="239">Simbabwe</option>

                                                    <option value="188">Singapur</option>

                                                    <option value="189">Slowakei</option>

                                                    <option value="190">Slowenien</option>

                                                    <option value="191">Solomon-Inseln</option>

                                                    <option value="192">Somalia</option>

                                                    <option value="194">South Georgia und die Suedlichen Sandwich-Inseln</option>

                                                    <option value="195">Spanien</option>

                                                    <option value="196">Sri Lanka</option>

                                                    <option value="197">St. Helena</option>

                                                    <option value="198">St. Pierre and Miquelon</option>

                                                    <option value="199">Sudan</option>

                                                    <option value="249">Südsudan</option>

                                                    <option value="193">Suedafrika</option>

                                                    <option value="200">Surinam</option>

                                                    <option value="201">Svalbard und Jan Mayen Inseln</option>

                                                    <option value="202">Swaziland</option>

                                                    <option value="205">Syrische Arabische Republik</option>

                                                    <option value="207">Tadschikistan</option>

                                                    <option value="206">Taiwan</option>

                                                    <option value="208">Tansania</option>

                                                    <option value="209">Thailand</option>

                                                    <option value="210">Togo</option>

                                                    <option value="211">Tokelau</option>

                                                    <option value="212">Tonga</option>

                                                    <option value="213">Trinidad und Tobago</option>

                                                    <option value="42">Tschad</option>

                                                    <option value="56">Tschechische Republik</option>

                                                    <option value="215">Tuerkei</option>

                                                    <option value="214">Tunesien</option>

                                                    <option value="216">Turkmenistan</option>

                                                    <option value="217">Turks und Caicos Inseln</option>

                                                    <option value="218">Tuvalu</option>

                                                    <option value="224">Ueberseeinseln der USA</option>

                                                    <option value="219">Uganda</option>

                                                    <option value="220">Ukraine</option>

                                                    <option value="97">Ungarn</option>

                                                    <option value="225">Uruguay</option>

                                                    <option value="226">Usbekistan</option>

                                                    <option value="227">Vanuatu</option>

                                                    <option value="228">Vatikan</option>

                                                    <option value="229">Venezuela</option>

                                                    <option value="221">Vereinigte Arabische Emirate</option>

                                                    <option value="223">Vereinigte Staaten (USA)</option>

                                                    <option value="230">Vietnam</option>

                                                    <option value="233">Wallis und Futuna</option>

                                                    <option value="45">Weihnachtsinseln</option>

                                                    <option value="250">Westjordanland</option>

                                                    <option value="234">Westsahara</option>

                                                    <option value="237">Zaire</option>

                                                    <option value="41">Zentralafrika</option>

                                                    <option value="55">Zypern</option>

                                                </select>
                                            </font>

                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="17" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">C/O</font></strong></td>
                                            <td height="17" bgcolor="AEBACD"><input name="txtCO" type="text" id="txtCO" value=""></td>
                                        </tr>
                                        <tr>
                                            <td width="26%" height="17" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Adresse</font></b></td>
                                            <td width="74%" height="17" bgcolor="AEBACD"><font color="#000033">
                                                <input type="text" name="txtAddress" value="">
                                            </font></td>
                                        </tr>
                                        <tr>
                                            <td width="26%" height="16" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*PLZ</font></b></td>
                                            <td width="74%" height="16" bgcolor="AEBACD"><font color="#000033">
                                                <input type="text" name="txtPostCode" value="">
                                            </font></td>
                                        </tr>
                                        <tr>
                                            <td width="26%" height="19" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Stadt</font></b></td>
                                            <td width="74%" height="19" bgcolor="AEBACD"><font color="#000033">
                                                <input type="text" name="txtCity" value="">
                                            </font></td>
                                        </tr>
                                        <tr>
                                            <td width="26%" height="14" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Land</font></b></td>
                                            <td width="74%" height="14" bgcolor="AEBACD"><font color="#000033">
                                                <input type="text" name="txtCountry" value="">
                                            </font></td>
                                        </tr>
                                        <tr>
                                            <td width="26%" height="11" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Handy
                                                Nr.</font></b></td>
                                            <td width="74%" height="11" bgcolor="AEBACD"><font color="#000033">
                                                00
                                                <input name="txtMobileCode" type="text" id="txtMobileCode" value="" size="4" maxlength="3">
                                                <input name="txtMobileRegion" type="text" id="txtMobileRegion" value="" size="6" maxlength="5">
                                                <input type="text" name="txtMobileNo" value="">
                                            </font></td>
                                        </tr>
                                        <tr id="topOK">
                                            <td height="23" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Email</font></b></td>
                                            <td height="23" bgcolor="AEBACD"><font color="#000033">
                                                <input type="text" name="txtEmail" value="">
                                                <input class="btn btn-primary" type="submit" align="right" name="Submit" value="OK">
                                            </font></td>
                                        </tr>
                                        <tr>
                                            <th colspan="2" height="17" bgcolor="657A9A"><center><b><font color="#FFFFFF"><a style="text-decoration: none; color:white; cursor:pointer;" onclick="showIkCollection();">Integrationkurs</a></font></b></center></th>
                                        </tr>
                                        <tr class="ik">
                                            <td height="23" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Bamfnummer</font></b></td>
                                            <td height="23" bgcolor="AEBACD"><font color="#000033" size="2">
                                                <input name="txtBamfNumber" type="text" value="" maxlength="20">
                                                PKZ

                                                <input type="radio" name="rdChoice" value="2" checked="">
                                                ABH
                                                <input type="radio" name="rdChoice" value="1">
                                                TGS
                                                <input type="radio" name="rdChoice" value="3">
                                                BVA
                                                <input type="radio" name="rdChoice" value="0">

                                            </font></td>
                                        </tr>
                                        <tr class="ik">
                                            <td height="23" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Nr. der Best. </font></b></td>
                                            <td height="23" bgcolor="AEBACD"><font color="#000033">
                                                <input name="txtVerified" type="text" id="txtVerified" value="">
                                            </font></td>
                                        </tr>
                                        <tr class="ik">
                                            <td height="23" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Ausweiss nummer</font></b></td>
                                            <td height="23" bgcolor="AEBACD"><font color="#000033">
                                                <input name="txtPassport" type="text" id="txtPassport" value="">
                                            </font></td>
                                        </tr>
                                        <tr class="ik">
                                            <td height="23" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Anzahl der Schuljahre </font></b></td>
                                            <td height="23" bgcolor="AEBACD"><font color="#000033">
                                                <input name="txtSchoolingYears" type="text" id="txtSchoolingYears" value="0" maxlength="3">
                                            </font></td>
                                        </tr>
                                        <tr class="ik">
                                            <td height="23" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Empfehlende Kursmodule</font></b></td>
                                            <td height="23" bgcolor="AEBACD"><font color="#000033">
                                                <select name="selModule">

                                                    <option>1</option>

                                                    <option>2</option>

                                                    <option>3</option>

                                                    <option>4</option>

                                                    <option>5</option>

                                                    <option>6</option>

                                                    <option>7</option>

                                                    <option>8</option>

                                                    <option>9</option>

                                                </select>
                                            </font></td>
                                        </tr>
                                        <tr class="ik">
                                            <td height="14" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Einstufungstest: 12,50</font></b><font color="#FFFFFF" size="2">&nbsp; </font><font color="#FFFFFF"><strong><font size="-1">€/TN</font></strong></font></td>
                                            <td height="14" bgcolor="AEBACD"><font size="2">JA

                                                <input type="radio" name="rdclass" value="1">
                                                NEIN
                                                <input type="radio" name="rdclass" value="0" checked="">

                                            </font><font color="#000033">
                                                <select name="selGraDay">

                                                    <option selected="">1</option>

                                                    <option>2</option>

                                                    <option>3</option>

                                                    <option>4</option>

                                                    <option>5</option>

                                                    <option>6</option>

                                                    <option>7</option>

                                                    <option>8</option>

                                                    <option>9</option>

                                                    <option>10</option>

                                                    <option>11</option>

                                                    <option>12</option>

                                                    <option>13</option>

                                                    <option>14</option>

                                                    <option>15</option>

                                                    <option>16</option>

                                                    <option>17</option>

                                                    <option>18</option>

                                                    <option>19</option>

                                                    <option>20</option>

                                                    <option>21</option>

                                                    <option>22</option>

                                                    <option>23</option>

                                                    <option>24</option>

                                                    <option>25</option>

                                                    <option>26</option>

                                                    <option>27</option>

                                                    <option>28</option>

                                                    <option>29</option>

                                                    <option>30</option>

                                                    <option>31</option>

                                                </select>
                                                <select name="selGraMonth">

                                                    <option>Januar</option>

                                                    <option>Februar</option>

                                                    <option>März</option>

                                                    <option>April</option>

                                                    <option>Mai</option>

                                                    <option>Juni</option>

                                                    <option>Juli</option>

                                                    <option>August</option>

                                                    <option>September</option>

                                                    <option>Oktober</option>

                                                    <option>November</option>

                                                    <option>Dezember</option>

                                                </select>
                                                <select name="selGraYear">

                                                    <option>2000</option>

                                                    <option>2001</option>

                                                    <option>2002</option>

                                                    <option>2003</option>

                                                    <option>2004</option>

                                                    <option>2005</option>

                                                    <option>2006</option>

                                                    <option>2007</option>

                                                    <option selected="">2008</option>

                                                    <option>2009</option>

                                                    <option>2010</option>

                                                    <option>2011</option>

                                                    <option>2012</option>

                                                    <option>2013</option>

                                                    <option>2014</option>

                                                    <option>2015</option>

                                                    <option>2016</option>

                                                    <option>2017</option>

                                                    <option>2018</option>

                                                    <option>2019</option>

                                                    <option>2020</option>

                                                    <option>2021</option>

                                                    <option>2022</option>

                                                    <option>2023</option>

                                                    <option>2024</option>

                                                    <option>2025</option>

                                                    <option>2026</option>

                                                    <option>2027</option>

                                                    <option>2028</option>

                                                    <option>2029</option>

                                                </select>
                                            </font><font size="2">&nbsp;                        </font><font size="2">&nbsp;                        </font></td>
                                        </tr>
                                        <tr class="ik">
                                            <td height="23" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Ergebnis des Einstufungstests </font></b></td>
                                            <td height="23" bgcolor="AEBACD"><font color="#000033">
                                                <input name="txtIntTest" type="text" id="txtIntTest" value="0" maxlength="2">
                                                <font size="2">keine einfachen kenntnisse
                                                </font>
                                                <font size="2">

                                                </font><font color="#000033"><font size="2">
                                                <input type="radio" name="rdInttestcheck" value="0" checked="">
                                            </font></font><font size="2"> mindestens einfache kenntnisse</font>
                                                <font size="2">
                                                    <input type="radio" name="rdInttestcheck" value="1">

                                                </font></font></td>
                                        </tr>
                                        <tr class="ik">
                                            <td height="23" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Angaben zur Schreibkundigkeit</font></b></td>
                                            <td height="23" bgcolor="AEBACD"><font color="#000033">                          <font size="2">nicht alphabetisiert</font>

                                                <input type="radio" name="rdProficency" value="2" checked="">
                                                <font size="2">nicht lateinisch alphabetisiert</font>
                                                <input type="radio" name="rdProficency" value="1">
                                                <font size="2">lateinisch alphabetisert</font>
                                                <input type="radio" name="rdProficency" value="0">

                                            </font></td>
                                        </tr>
                                        <tr class="ik">
                                            <td height="14" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Auftrag auf Kostenbefreiung wurde mit der anmeldung gestellt</font></b></td>
                                            <td height="14" bgcolor="AEBACD"> <font size="2">JA

                                                <input type="radio" name="rdSponsorship" value="1">
                                                NEIN
                                                <input type="radio" name="rdSponsorship" value="0" checked="">

                                            </font> </td>
                                        </tr>
                                        <tr class="ik">
                                            <td height="14" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">TN (Teilnehmer-) Typ </font></b></td>
                                            <td height="14" bgcolor="AEBACD"><font color="#000033">
                                                <select name="selIden" id="selIden">
                                                    <option value="0" selected="">wählen</option>

                                                    <option value="1">1 = Neuzuwandernde Auslaender</option>

                                                    <option value="2">2 = Bestandsauslaender (Verpflichtung durch ABH)</option>

                                                    <option value="3">3 = Bestandsauslaender/Eu-Buerger/Deutscher (Zulas</option>

                                                    <option value="4">4 = Spaetaussiedler</option>

                                                    <option value="5">5 = ALG II-Bezieher (Verpflichtung durch TGS)</option>

                                                    <option value="6">6 = Kurswiederholer</option>

                                                </select>
                                            </font> </td>
                                        </tr>
                                        <tr class="ik">
                                            <td height="14" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">KB (Kostenbeitrags-) Typ </font></b></td>
                                            <td height="14" bgcolor="AEBACD"><font color="#000033" size="2">

                                                <input type="radio" name="rdCost" value="2" checked="">
                                                mit Kostenbeitrag, 1,00</font><font size="-1"> € </font><font color="#000033" size="2"> Regelfall
                                                <input type="radio" name="rdCost" value="1">
                                                ohne Kostenbeitrag Bamf-Entsheidung

                                            </font>                         </td>
                                        </tr>
                                        <tr class="ik">
                                            <td height="14" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Abschlusstest: 78,65 </font></b><font color="#FFFFFF"><strong><font size="-1">€/TN </font></strong></font></td>
                                            <td bgcolor="AEBACD"><font color="#000033">
                                                <select name="selConclusionDay">

                                                    <option selected="">1</option>

                                                    <option>2</option>

                                                    <option>3</option>

                                                    <option>4</option>

                                                    <option>5</option>

                                                    <option>6</option>

                                                    <option>7</option>

                                                    <option>8</option>

                                                    <option>9</option>

                                                    <option>10</option>

                                                    <option>11</option>

                                                    <option>12</option>

                                                    <option>13</option>

                                                    <option>14</option>

                                                    <option>15</option>

                                                    <option>16</option>

                                                    <option>17</option>

                                                    <option>18</option>

                                                    <option>19</option>

                                                    <option>20</option>

                                                    <option>21</option>

                                                    <option>22</option>

                                                    <option>23</option>

                                                    <option>24</option>

                                                    <option>25</option>

                                                    <option>26</option>

                                                    <option>27</option>

                                                    <option>28</option>

                                                    <option>29</option>

                                                    <option>30</option>

                                                    <option>31</option>

                                                </select>
                                                <select name="selConclusionMonth">

                                                    <option>Januar</option>

                                                    <option>Februar</option>

                                                    <option>März</option>

                                                    <option>April</option>

                                                    <option>Mai</option>

                                                    <option>Juni</option>

                                                    <option>Juli</option>

                                                    <option>August</option>

                                                    <option>September</option>

                                                    <option>Oktober</option>

                                                    <option>November</option>

                                                    <option>Dezember</option>

                                                </select>
                                                <select name="selConclusionYear">

                                                    <option>2000</option>

                                                    <option>2001</option>

                                                    <option>2002</option>

                                                    <option>2003</option>

                                                    <option>2004</option>

                                                    <option>2005</option>

                                                    <option>2006</option>

                                                    <option>2007</option>

                                                    <option selected="">2008</option>

                                                    <option>2009</option>

                                                    <option>2010</option>

                                                    <option>2011</option>

                                                    <option>2012</option>

                                                    <option>2013</option>

                                                    <option>2014</option>

                                                    <option>2015</option>

                                                    <option>2016</option>

                                                    <option>2017</option>

                                                    <option>2018</option>

                                                    <option>2019</option>

                                                    <option>2020</option>

                                                    <option>2021</option>

                                                    <option>2022</option>

                                                    <option>2023</option>

                                                    <option>2024</option>

                                                    <option>2025</option>

                                                    <option>2026</option>

                                                    <option>2027</option>

                                                    <option>2028</option>

                                                    <option>2029</option>

                                                </select>
                                            </font></td>
                                        </tr>
                                        <tr class="ik">
                                            <td height="14" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Abschlusstest Orienterungkurs = 5</font></b> <font color="#FFFFFF"><strong><font size="-1">€ Pauschale</font></strong></font></td>
                                            <td bgcolor="AEBACD"><font color="#000033">
                                                <select name="selConCourseDay">

                                                    <option selected="">1</option>

                                                    <option>2</option>

                                                    <option>3</option>

                                                    <option>4</option>

                                                    <option>5</option>

                                                    <option>6</option>

                                                    <option>7</option>

                                                    <option>8</option>

                                                    <option>9</option>

                                                    <option>10</option>

                                                    <option>11</option>

                                                    <option>12</option>

                                                    <option>13</option>

                                                    <option>14</option>

                                                    <option>15</option>

                                                    <option>16</option>

                                                    <option>17</option>

                                                    <option>18</option>

                                                    <option>19</option>

                                                    <option>20</option>

                                                    <option>21</option>

                                                    <option>22</option>

                                                    <option>23</option>

                                                    <option>24</option>

                                                    <option>25</option>

                                                    <option>26</option>

                                                    <option>27</option>

                                                    <option>28</option>

                                                    <option>29</option>

                                                    <option>30</option>

                                                    <option>31</option>

                                                </select>
                                                <select name="selConCourseMonth">

                                                    <option>Januar</option>

                                                    <option>Februar</option>

                                                    <option>März</option>

                                                    <option>April</option>

                                                    <option>Mai</option>

                                                    <option>Juni</option>

                                                    <option>Juli</option>

                                                    <option>August</option>

                                                    <option>September</option>

                                                    <option>Oktober</option>

                                                    <option>November</option>

                                                    <option>Dezember</option>

                                                </select>
                                                <select name="selConCourseYear">

                                                    <option>2000</option>

                                                    <option>2001</option>

                                                    <option>2002</option>

                                                    <option>2003</option>

                                                    <option>2004</option>

                                                    <option>2005</option>

                                                    <option>2006</option>

                                                    <option>2007</option>

                                                    <option selected="">2008</option>

                                                    <option>2009</option>

                                                    <option>2010</option>

                                                    <option>2011</option>

                                                    <option>2012</option>

                                                    <option>2013</option>

                                                    <option>2014</option>

                                                    <option>2015</option>

                                                    <option>2016</option>

                                                    <option>2017</option>

                                                    <option>2018</option>

                                                    <option>2019</option>

                                                    <option>2020</option>

                                                    <option>2021</option>

                                                    <option>2022</option>

                                                    <option>2023</option>

                                                    <option>2024</option>

                                                    <option>2025</option>

                                                    <option>2026</option>

                                                    <option>2027</option>

                                                    <option>2028</option>

                                                    <option>2029</option>

                                                </select>
                                            </font></td>
                                        </tr>
                                        <tr class="ik">
                                            <td height="14" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Fahrtkosten</font></b></td>
                                            <td bgcolor="AEBACD"><font size="2" color="#405579">
                                                <input type="text" name="txtFahrt" size="8" value="0.0">
                                            </font><font color="#000033">&nbsp;
                                            </font></td>
                                        </tr>
                                        <tr id="bottomOK" style="visibility: hidden;">
                                            <td width="26%" height="13" bgcolor="657A9A"><b><font color="#FFFFFF" size="2"></font></b></td>
                                            <td width="74%" height="13" bgcolor="AEBACD">
                                                <input class="btn btn-primary" type="submit" name="Submit" value=" OK ">
                                                <b>                        </b>                        </td>
                                        </tr>
                                        </tbody></table>
                                </form>
                            </td>
                        </tr>
                        </tbody></table>
                </div>
            </div>
        </div>
    </div>
</div>

    <jsp:include page="templates/footer.jsp"/>
    <jsp:include page="templates/bodyimports.jsp"/>
</body>
</html>
