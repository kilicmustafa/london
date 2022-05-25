<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.model.*" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ page import="com.rheinlandprivatschule.repository.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Einzelunterricht ::</title>
    <style>
        table tr {
            border-bottom: 1px solid white;
        }

        html {
            overflow-y: hidden;
        }

        table a {
            color: #0000EE;
            text-decoration: underline;
        }
    </style>
    <script>
        function myback()
        {
            window.location="showStudentPreciseD?userid="+document.form1.stid.value;
        }
        function popUp(loc,eyeD,X,Y){
            window.open(loc,eyeD,"toolbar=no,location=0,directories=no,status=no,menubar=0,scrollbars=yes,resizable=0,width=" + X + ",height=" + Y + "'");
        }

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
<%
    SystemUserDao sdb=new SystemUserDao();
    SingleClassDao sidb=new SingleClassDao();
    Vector tea=new Vector();
    String day="1";
    String month="1";
    String year="2050";

    Vector places=new Vector();
    String eubericht="";

    Student student=(Student)session.getAttribute("pstudent");

    RPS rps=(RPS)session.getAttribute("handler");
    Place myPlace=rps.getLoginPlace();


    Vector euv=sidb.getSingleClasses(student.getUserID());
    SingleClassBalance scb=sidb.getStudentRecord(student.getUserID());
    Vector eubev=scb.getTransactions();

    boolean bool=true;
    for(int ii=0;ii<eubev.size();ii++)	{
        Transaction tt=(Transaction)eubev.elementAt(ii);
        if(bool){
            eubericht=eubericht+tt.getTransactionNo();
            bool=false;
        }else{
            eubericht=eubericht+","+tt.getTransactionNo();

        }
    }
    PlaceDao placeDB = new PlaceDao();
    tea=sdb.getAllDSHLehrerByPlace(rps.getLoginPlace().getPlaceID(),4,3);

    day= MyDate.getDay(MyDate.getCurrentSQLDate());
    month=MyDate.getMonth(MyDate.getCurrentSQLDate());
    year=MyDate.getYear(MyDate.getCurrentSQLDate());
%>
<div id="wrapper" class="wrapper" style="height: 100%;">
    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">
        <jsp:include page="templates/navbar.jsp"/>

        <!-- Main Content -->
        <div id="content">
            <!-- Begin Page Content -->
            <div class="container-fluid">

                <div class="wrapper" style="padding-left: 17.5%; padding-right: 17.5%;">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="wrapper" style="margin-bottom: 5px; float:right;">
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="myback()">Z&uuml;ruck</a>

                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width: 100%;" name="form1" method="post" action="addEUnterrichtProcess" onSubmit="MM_validateForm('txtCName','','R','txtTime','','R','txtFee','','RisNum');return document.MM_returnValue">
                            <table width="100%" height="261" border="0" cellpadding="1" cellspacing="1">
                                                               <tr>
                                    <td colspan="2" bgcolor="657A9A" height="4">
                                        <div align="center"><font size="2" color="#FFFFFF"><b><font size="3">Einzelunterricht</font></b></font>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="29%" bgcolor="657A9A" height="13"><font color="#FFFFFF" size="2"><b>Sch&uuml;lername</b></font></td>
                                    <td width="71%" height="13" bgcolor="AEBACD"><font color="#000033" size="2"><%=student.getUserFirstName()+" "+student.getUserLastName()%></font></td>
                                </tr>
                                <tr>
                                    <td width="29%" bgcolor="657A9A" height="2"><b><font size="2" color="#FFFFFF">Kursname</font></b></td>
                                    <td width="71%" height="2" bgcolor="AEBACD">
                                        <input type="text" name="txtCName" value="Deutschkurs">
                                    </td>
                                </tr>
                                <tr>
                                    <td width="29%" bgcolor="657A9A" height="2"><b><font size="2" color="#FFFFFF">Unterrichtdatum</font></b></td>
                                    <td width="71%" bgcolor="AEBACD" height="2">
                                        <select name="selSDay">
                                            <%
                                                for(int iSD=1;iSD<32;iSD++)
                                                {
                                                    if(iSD==Integer.parseInt(day))
                                                    {
                                            %>
                                            <option selected><%=iSD%></option>
                                            <%
                                            }
                                            else
                                            {
                                            %>
                                            <option><%=iSD%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                        <select name="selSMonth">
                                            <%
                                                Vector vtemp=new Vector();
                                                vtemp.addElement("Januar");
                                                vtemp.addElement("Februar");
                                                vtemp.addElement("März");
                                                vtemp.addElement("April");
                                                vtemp.addElement("Mai");
                                                vtemp.addElement("Juni");
                                                vtemp.addElement("Juli");
                                                vtemp.addElement("August");
                                                vtemp.addElement("September");
                                                vtemp.addElement("Oktober");
                                                vtemp.addElement("November");
                                                vtemp.addElement("Dezember");
                                                for(int iSM=0;iSM<vtemp.size();iSM++)
                                                {
                                                    String tempSM=(String)vtemp.elementAt(iSM);
                                                    if(month.equalsIgnoreCase((iSM+1)+""))
                                                    {

                                            %>
                                            <option selected><%=tempSM%></option>
                                            <%
                                            }
                                            else
                                            {
                                            %>
                                            <option ><%=tempSM%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                        <select name="selSYear">
                                            <%
                                                for(int iSY=2004;iSY<2020;iSY++)
                                                {
                                                    if(iSY==Integer.parseInt(year))
                                                    {
                                            %>
                                            <option selected><%=iSY%></option>
                                            <%
                                            }
                                            else
                                            {
                                            %>
                                            <option ><%=iSY%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="29%" bgcolor="657A9A" height="2"><b><font size="2" color="#FFFFFF">Stunden</font></b></td>
                                    <td width="71%" height="2" bgcolor="AEBACD">
                                        <select name="txtTime">
                                            <option value="1">1</option>
                                            <option value="2" selected>2</option>
                                            <option value="3">3</option>
                                            <option value="4">4</option>
                                            <option value="5">5</option>
                                            <option value="6">6</option>
                                            <option value="7">7</option>
                                            <option value="8">8</option>
                                            <option value="9">9</option>
                                            <option value="10">10</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="29%" bgcolor="657A9A" height="7"><b><font size="2" color="#FFFFFF">Euro/Std</font></b></td>
                                    <td width="71%" height="7" bgcolor="AEBACD">
                                        <input type="text" name="txtFee" value="19">
                                        ,-&euro; </td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A" height="31"><strong><font color="#FFFFFF" size="2">Stadt</font></strong></td>
                                    <td bgcolor="AEBACD" height="31">
                                        <select name="selectCity" id="selectCity" onChange="changecity()">
                                            <%
                                                for(int i=0;i<places.size();i++){
                                                    Place temp=(Place)places.elementAt(i);
                                                    if(temp.getPlaceID()==myPlace.getPlaceID()){

                                            %>
                                            <option value="<%=temp.getPlaceID()%>" selected><%=temp.getPlaceName()%></option>
                                            <%
                                            }else{
                                            %>
                                            <option value="<%=temp.getPlaceID()%>"><%=temp.getPlaceName()%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select></td>
                                </tr>
                                <tr>
                                    <td width="29%" bgcolor="657A9A" height="31"><b><font size="2" color="#FFFFFF">Lehrer
                                        /Lehririn </font></b></td>
                                    <td width="71%" bgcolor="AEBACD" height="31">
                                        <select name="selTeacher">
                                            <option value="0" selected>w&auml;hlen</option>
                                            <%
                                                for(int i=0;i<tea.size();i++)
                                                {
                                                    SystemUser u=(SystemUser)tea.elementAt(i);
                                                    String na=u.getUserFirstName()+" "+u.getUserLastName();
                                            %>
                                            <option value="<%=u.getUserID()%>"> <%=na%> </option>
                                            <%

                                                }
                                            %>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="29%" bgcolor="AEBACD" height="26">&nbsp;</td>
                                    <td width="71%" bgcolor="AEBACD" height="26">
                                        <input type="submit" name="Submit" value="Add">
                                        <input type="hidden" name="stid" value="<%=student.getUserID()%>">
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" bgcolor="AEBACD" height="26"> </td>
                                </tr>
                                <tr valign="top">
                                    <td colspan="2" height="26">
                                        <table width="100%" cellpadding="1" cellspacing="1" border="0">
                                            <tr bgcolor="657A9A">
                                                <td height="21" colspan="8"><div align="center"><b><font color="#FFFFFF">Einzelunterricht Liste </font></b></div></td>
                                            </tr>
                                            <tr bgcolor="657A9A">
                                                <td bgcolor="657A9A" height="22" width="10%"><div align="left"><font color="#FFFFFF"><b><font size="2">U Nr. </font></b></font></div></td>
                                                <td width="15%" height="22" bgcolor="657A9A"><font size="2"><b></b></font><font color="#FFFFFF" size="2"><b>Kursname</b></font></td>
                                                <td bgcolor="657A9A" height="22" width="22%"><font size="2" color="#FFFFFF"><b>Lehrer/in name </b></font></td>
                                                <td bgcolor="657A9A" width="14%"><strong><font color="#FFFFFF" size="2">Stadt</font></strong></td>
                                                <td bgcolor="657A9A" height="22" width="11%"><font size="2" color="#FFFFFF"><b>Datum</b></font></td>
                                                <td bgcolor="657A9A" height="22" width="9%"><b><font size="2" color="#FFFFFF">Stunden</font></b></td>
                                                <td bgcolor="657A9A" height="22" width="9%"><font size="2" color="#FFFFFF"><b>Euro/Std.</b></font></td>
                                                <td bgcolor="657A9A" height="22" width="10%"><font size="2" color="#FFFFFF"><b>Summe</b></font></td>
                                            </tr>
                                            <%
                                                for(int i=0;i<euv.size();i++)
                                                {
                                                    SingleClass sc=(SingleClass)euv.elementAt(i);
                                                    SystemUser teacher=sdb.getSystemUser(sc.getTeacherID());
                                                    String teac=teacher.getUserFirstName()+" "+teacher.getUserLastName();
                                                    int cityid=sc.getPlaceID();
                                                    String cityname=(placeDB.getPlace(cityid)).getPlaceName();
                                                    boolean b=true;



                                            %>
                                            <tr bgcolor="AEBACD">
                                                <td height="6" width="10%"><font size="2" color="#000033"><a href="updateEUnterricht?classid=<%=sc.getClassID()%>"><%=sc.getClassID()%></a></font></td>
                                                <td height="6"><font size="2" color="#000033"><%=sc.getCourseName()%></font></td>
                                                <td width="22%" height="6"><font size="2" color="#000033"><%=teac%></font></td>
                                                <td width="14%" height="6"><font size="2" color="#000033"><%=cityname%></font></td>
                                                <td height="6" width="11%"><font size="2" color="#000033"><%=MyDate.formateDate(sc.getCLassDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                                <td height="6" width="9%"><font size="2" color="#000033"><%=sc.getClassTime()%></font></td>
                                                <td height="6" width="9%"><font size="2" color="#000033"><%=MyCurrency.getDisplayString(sc.getCourseFee())%></font></td>
                                                <td height="6" width="10%"><font size="2" color="#000033"><%=MyCurrency.getDisplayString(sc.getCourseFee()*sc.getClassTime())%></font></td>
                                            </tr>
                                            <%
                                                }
                                            %>
                                            <tr bgcolor="AEBACD">
                                                <td height="6" bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>Bericht Nrs</b></font></td>
                                                <td height="6" colspan="7" bgcolor="AEBACD"><font size="2" color="#000033"><a href="linkToBericht?studentID=<%=student.getUserID()%>"><%=eubericht%></a></font></td>
                                            </tr>
                                            <tr bgcolor="AEBACD">
                                                <td height="6" colspan="6" bgcolor="657A9A"><div align="right"><font size="2" color="#FFFFFF"><b>Einzelunterricht Geb&uuml;hr Guthaben</b></font></div></td>
                                                <td height="6" width="9%">&nbsp;</td>
                                                <td height="6" width="10%"><font size="2" color="#000033"><b><%=MyCurrency.getDisplayString(scb.getBalance())%></b></font></td>
                                            </tr>
                                            <tr bgcolor="AEBACD">
                                                <td height="6" colspan="8" bgcolor="657A9A"><div align="right"><font size="2" color="#FFFFFF"></font></div>
                                                    <div align="right"><font size="2" color="#000033">                                </font></div></td>
                                            </tr>
                                        </table></td>
                                </tr>
                            </table>
                        </form>
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
