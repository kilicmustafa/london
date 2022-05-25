
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Neue Kurse ::</title>
    <style>
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
    </script>
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
                        <a style="margin-right: 5px;" class="btn btn-primary" href="moduleList">Modul</a>
                        <a style="margin-right: 5px;" class="btn btn-primary" href="courseList">Zurück</a>
                        <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                    </div>
                    <form name="form1" method="post" action="/courses/addCourseProcess" onsubmit="MM_validateForm('txtFee','','RisNum','strength','','RisNum','hours','','RisNum','totalhour','','RisNum');return document.MM_returnValue">
                        <table width="100%" height="320" border="0" cellpadding="1" cellspacing="1">
                            <tbody>
                            <tr>
                                <td colspan="2" bgcolor="657A9A"><div align="center"><b><font color="#FFFFFF">Der neue Kurs</font></b></div></td>
                            </tr>
                            <tr>
                                <td width="29%" bgcolor="657A9A" height="12"><b><font size="2" color="#FFFFFF">Kursname</font></b></td>
                                <td width="71%" height="12" bgcolor="AEBACD"><select name="selCo">
                                    <option selected="">wählen</option>

                                    <option value="1">Grundstufe I</option>

                                    <option value="2">Grundstufe II</option>

                                    <option value="3">Mittelstufe I</option>

                                    <option value="4">Mittelstufe II</option>

                                    <option value="5">oberstufe</option>

                                    <option value="6">DSH</option>

                                    <option value="7">Studienkolleg</option>

                                </select>
                                </td>
                            </tr>
                            <tr>
                                <td width="29%" bgcolor="657A9A" height="13"><b><font size="2" color="#FFFFFF">Kursbeschreibung </font></b></td>
                                <td width="71%" height="13" bgcolor="AEBACD"><input type="text" name="txtDes" value="Deutschkurs">
                                </td>
                            </tr>
                            <tr>
                                <td width="29%" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Anfangdatum</font></b></td>
                                <td width="71%" bgcolor="AEBACD"><select name="selSDay">

                                    <option>1</option>

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
                                    <select name="selSMonth">

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
                                    <select name="selSYear">

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
                                </td>
                            </tr>
                            <tr>
                                <td width="29%" bgcolor="657A9A" height="19"><b><font size="2" color="#FFFFFF">Endedatum</font></b></td>
                                <td width="71%" bgcolor="AEBACD" height="19"><select name="selEDay">

                                    <option>1</option>

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
                                    <select name="selEMonth">

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
                                    <select name="selEYear">

                                        <option>2004</option>

                                        <option>2005</option>

                                        <option>2006</option>

                                        <option>2007</option>

                                        <option>2008</option>

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
                                </td>
                            </tr>
                            <tr>
                                <td width="29%" bgcolor="657A9A" height="19"><b><font size="2" color="#FFFFFF">Zeit</font></b></td>
                                <td width="71%" height="19" bgcolor="AEBACD"><select name="txtTim">
                                    <option selected="">Vormittag</option>
                                    <option>Nachmittag</option>
                                    <option>Abendkurs</option>
                                </select>
                                </td>
                            </tr>
                            <tr>
                                <td width="29%" bgcolor="657A9A" height="7"><b><font size="2" color="#FFFFFF">Kursgebühr</font></b></td>
                                <td width="71%" height="7" bgcolor="AEBACD"><input type="text" name="txtFee">
                                </td>
                            </tr>
                            <tr>
                                <td width="29%" bgcolor="657A9A" height="5"><b><font size="2" color="#FFFFFF">Kursplätze</font></b></td>
                                <td width="71%" height="5" bgcolor="AEBACD"><input type="text" name="strength" value="20">
                                </td>
                            </tr>
                            <tr>
                                <td width="29%" bgcolor="657A9A" height="20"><b><font size="2" color="#FFFFFF">Wochenumfang</font></b></td>
                                <td width="71%" height="20" bgcolor="AEBACD"><input type="text" name="hours" value="25">
                                </td>
                            </tr>
                            <tr>
                                <td bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Gesamtumfang</font></b></td>
                                <td bgcolor="AEBACD"><input type="text" name="totalhour" value="200">
                                </td>
                            </tr>
                            <tr>
                                <td bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Zusatz</font></b></td>
                                <td bgcolor="AEBACD"><input name="Bamfnr" type="text" id="Bamfnr">
                                </td>
                            </tr>
                            <tr>
                                <td bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Kürzel</font></b></td>
                                <td bgcolor="AEBACD"><input type="text" name="courseinit" maxlength="5">
                                </td>
                            </tr>
                            <tr>
                                <td width="29%" bgcolor="657A9A"><b><font size="2" color="#FFFFFF"><b>Unterricht Pro Tag </b></font> </b></td>
                                <td width="71%" bgcolor="AEBACD"><input name="dailyhour" type="text" id="dailyhour" value="5">
                                </td>
                            </tr>
                            <tr>
                                <td width="29%" bgcolor="AEBACD">&nbsp;</td>
                                <td width="71%" bgcolor="AEBACD"><input class="btn btn-primary" type="submit" name="Submit" value="OK">
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" bgcolor="AEBACD" height="51"><font size="1" color="#000033"> <font size="2">&nbsp; Vormittag: 8:30 - 12:00 und Nachmittag: 12:00 - 18:00 und Abendkurs: 18:00 - 21:00</font></font> </td>
                            </tr>
                            </tbody></table>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="templates/footer.jsp"/>
<jsp:include page="templates/bodyimports.jsp"/>
</body>
</html>
