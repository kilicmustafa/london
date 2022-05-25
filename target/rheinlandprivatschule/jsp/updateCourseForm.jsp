<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.model.Course" %>
<%@ page import="com.rheinlandprivatschule.repository.CourseDao" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.repository.PlaceDao" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Aktualisierungskurs ::</title>
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
        function back(){
            window.location="courseReportDetail?courseid="+document.form1.cid.value;
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

    Vector v=new Vector();
    Course c=new Course();
    CourseDao cdb= (CourseDao) request.getAttribute("courseDao");
    String coursename="";
    String coursen="";
    String bamfnr="";
    String courseinit="";
    int id=0;
    int ct=0;
    boolean stat=false;
    String sDayN="";
    String sMonthN="";
    String sYearN="";
    String eDayN="";
    String eMonthN="";
    String eYearN="";

    String courseid=(String)request.getParameter("courseid");
    session.setAttribute("courseid",courseid);

    try{
        id=Integer.parseInt(courseid);
    }catch(Exception e){
    }

    v=(new PlaceDao()).getAllPlaces();
    c=cdb.getCourse(id);
    if(c.getCourseBamfNr()==null){
        bamfnr="";}else{
        bamfnr= c.getCourseBamfNr();
    }
    if(c.getCourseInit()==null){
        courseinit="";}else{
        courseinit= c.getCourseInit();
    }
    coursename=c.getCourseName();
    coursen="";
    stat=false;

    sDayN= MyDate.getDay(c.getCourseStartDate());
    sMonthN=MyDate.getMonth(c.getCourseStartDate());
    sYearN=MyDate.getYear(c.getCourseStartDate());

    eDayN=MyDate.getDay(c.getCourseEndDate());
    eMonthN=MyDate.getMonth(c.getCourseEndDate());
    eYearN=MyDate.getYear(c.getCourseEndDate());

    try{
        ct=c.getCourseType();
    }catch(Exception ee){
    }
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

                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="back()">Zur&uuml;ck</a>

                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width: 100%;" name="form1" method="post" action="updateCourse" onSubmit="MM_validateForm('txtFee','','RisNum','strength','','RisNum','hours','','RisNum','totalhour','','RisNum');return document.MM_returnValue">
                            <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                <input name="cid" type="hidden" id="cid" value="<%=id%>">

                                <tr>
                                    <td colspan="2" bgcolor="657A9A">
                                        <div align="center"><b><font size="3" color="#FFFFFF">Kurs
                                            Informationen</font></b></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="29%" bgcolor="657A9A"><font size="2"><b><font color="#FFFFFF">Kursname</font></b></font></td>
                                    <td width="71%" bgcolor="AEBACD">
                                        <select name="selCo">
                                            <%
                                                if(ct==1)
                                                {
                                            %>
                                            <option value="1" selected>Grundstufe I</option>
                                            <option value="2">Grundstufe II</option>
                                            <option value="3">Mittelstufe I</option>
                                            <option value="4">Mittelstufe II</option>
                                            <option value="5">Oberstufe</option>
                                            <%
                                            }
                                            else if(ct==2)
                                            {
                                            %>
                                            <option value="1">Grundstufe I</option>
                                            <option value="2" selected>Grundstufe II</option>
                                            <option value="3">Mittelstufe I</option>
                                            <option value="4">Mittelstufe II</option>
                                            <option value="5">Oberstufe</option>
                                            <%
                                            }
                                            else if(ct==3)
                                            {

                                            %>
                                            <option value="1" selected>Grundstufe I</option>
                                            <option value="2">Grundstufe II</option>
                                            <option value="3" selected>Mittelstufe I</option>
                                            <option value="4">Mittelstufe II</option>
                                            <option value="5">Oberstufe</option>
                                            <%
                                            }
                                            else if(ct==4)
                                            {
                                            %>
                                            <option value="1">Grundstufe I</option>
                                            <option value="2">Grundstufe II</option>
                                            <option value="3">Mittelstufe I</option>
                                            <option value="4" selected>Mittelstufe II</option>
                                            <option value="5">Oberstufe</option>
                                            <%
                                            }
                                            else if(ct==5)
                                            {
                                            %>
                                            <option value="1">Grundstufe I</option>
                                            <option value="2">Grundstufe II</option>
                                            <option value="3">Mittelstufe I</option>
                                            <option value="4">Mittelstufe II</option>
                                            <option value="5" selected>Oberstufe</option>
                                            <%
                                                }
                                            %>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="29%" bgcolor="657A9A" height="29"><b><font size="2" color="#FFFFFF">Kursbeschreibung </font></b></td>
                                    <td width="71%" height="29" bgcolor="AEBACD">
                                        <input type="text" name="txtDes" value="<%=c.getCourseDesc()%>">
                                    </td>
                                </tr>
                                <tr>
                                    <td width="29%" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Anfangdatum</font></b></td>
                                    <td width="71%" bgcolor="AEBACD">
                                        <select name="selSDay">
                                            <%
                                                for(int iSD=1;iSD<32;iSD++)
                                                {
                                                    if(iSD==Integer.parseInt(sDayN))
                                                    {
                                            %>
                                            <option Selected><%=iSD%></option>
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
                                                    String tempSMN=(iSM+1)+"";
                                                    if(tempSMN.equalsIgnoreCase(sMonthN)){
                                            %>
                                            <option Selected><%=tempSM%></option>
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
                                                for(int iSY=2014;iSY<2030;iSY++)
                                                {
                                                    if(iSY==Integer.parseInt(sYearN))
                                                    {
                                            %>
                                            <option Selected><%=iSY%></option>
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
                                    <td width="29%" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Endedatum</font></b></td>
                                    <td width="71%" bgcolor="AEBACD">
                                        <select name="selEDay">
                                            <%
                                                for(int iED=1;iED<32;iED++)
                                                {
                                                    if(iED==Integer.parseInt(eDayN))
                                                    {
                                            %>
                                            <option Selected><%=iED%></option>
                                            <%
                                            }
                                            else
                                            {
                                            %>
                                            <option><%=iED%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                        <select name="selEMonth">
                                            <%
                                                Vector vtempE=new Vector();
                                                vtempE.addElement("Januar");
                                                vtempE.addElement("Februar");
                                                vtempE.addElement("März");
                                                vtempE.addElement("April");
                                                vtempE.addElement("Mai");
                                                vtempE.addElement("Juni");
                                                vtempE.addElement("Juli");
                                                vtempE.addElement("August");
                                                vtempE.addElement("September");
                                                vtempE.addElement("Oktober");
                                                vtempE.addElement("November");
                                                vtempE.addElement("Dezember");
                                                for(int iEM=0;iEM<vtempE.size();iEM++)
                                                {
                                                    String tempEM=(String)vtempE.elementAt(iEM);
                                                    String tempEMN=(iEM+1)+"";
                                                    if(tempEMN.equalsIgnoreCase(eMonthN))
                                                    {
                                            %>
                                            <option Selected><%=tempEM%></option>
                                            <%
                                            }
                                            else
                                            {
                                            %>
                                            <option ><%=tempEM%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                        <select name="selEYear">
                                            <%
                                                for(int iEY=2014;iEY<2030;iEY++)
                                                {
                                                    if(iEY==Integer.parseInt(eYearN))
                                                    {
                                            %>
                                            <option Selected><%=iEY%></option>
                                            <%
                                            }else
                                            {
                                            %>
                                            <option ><%=iEY%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="29%" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Zeit</font></b></td>
                                    <td width="71%" bgcolor="AEBACD">
                                        <select name="txtTim">
                                            <%
                                                if(c.getCourseTiming().equalsIgnoreCase("8:30-12:00"))
                                                {
                                            %>
                                            <option selected>Vormittag</option>
                                            <option>Nachmittag</option>
                                            <option>Abendkurs</option>
                                            <%
                                            }
                                            else if(c.getCourseTiming().equalsIgnoreCase("12:00-18:00"))
                                            {
                                            %>
                                            <option>Vormittag</option>
                                            <option selected>Nachmittag</option>
                                            <option>Abendkurs</option>
                                            <%
                                            }
                                            else if(c.getCourseTiming().equalsIgnoreCase("18:00-21:00"))
                                            {
                                            %>
                                            <option>Vormittag</option>
                                            <option>Nachmittag</option>
                                            <option selected>Abendkurs</option>
                                            <%
                                                }
                                            %>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="29%" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Kursgeb&uuml;hr</font></b></td>
                                    <td width="71%" bgcolor="AEBACD">
                                        <input type="text" name="txtFee" value="<%=c.getCourseFee()%>">
                                    </td>
                                </tr>
                                <tr>
                                    <td width="29%" bgcolor="657A9A" height="16"><b><font size="2" color="#FFFFFF">Kurspl&auml;tze</font></b></td>
                                    <td width="71%" height="16" bgcolor="AEBACD">
                                        <input type="text" name="strength" value="<%=c.getCourseStrength()%>">
                                    </td>
                                </tr>
                                <tr>
                                    <td width="29%" bgcolor="657A9A" height="22"><b><font size="2" color="#FFFFFF">Wochenumfang</font></b></td>
                                    <td width="71%" height="22" bgcolor="AEBACD">
                                        <input type="text" name="hours" value="<%=c.getCourseHours()%>">
                                    </td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Gesamtumfang</font></b></td>
                                    <td bgcolor="AEBACD"><input type="text" name="totalhour" value="<%=c.getCourseTotalHours()%>">
                                    </td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Bamfnummer</font></b></td>
                                    <td bgcolor="AEBACD"><input type="text" name="bamfnr" value="<%=bamfnr%>">
                                    </td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><b><font size="2" color="#FFFFFF">K&uuml;rzel</font></b></td>
                                    <td bgcolor="AEBACD"><input type="text" name="courseinit" value="<%=courseinit%>"></td>
                                </tr>
                                <tr>
                                    <td width="29%" bgcolor="657A9A"><b><font size="2" color="#FFFFFF"><b>Unterricht Pro Tag</b></font></b></td>
                                    <td width="71%" bgcolor="AEBACD">
                                        <input name="dailyhour" type="text" id="dailyhour" value="<%=c.getCourseDailyHrs()%>">
                                    </td>
                                </tr>
                                <tr>
                                    <td width="29%" bgcolor="657A9A">&nbsp;</td>
                                    <td width="71%" bgcolor="AEBACD">
                                        <input class="btn btn-primary" type="submit" name="Submit" value="OK">
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td colspan="2" height="41"><font size="1" color="#000033"><font size="2">
                                        &nbsp;Vormittag: 8:30 - 12:00 und Nachmittag: 12:00
                                        - 18:00 und Abendkurs: 18:00 - 21:00</font></font> </td>
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
