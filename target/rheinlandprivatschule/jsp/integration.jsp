<%@ page import="com.rheinlandprivatschule.repository.AnwesenDao" %>
<%@ page import="com.rheinlandprivatschule.repository.CourseDao" %>
<%@ page import="com.rheinlandprivatschule.model.Course" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.repository.InsuranceDao" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="com.rheinlandprivatschule.model.Anwesenheit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Module ::</title>
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
        function printRegistration()
        {
            document.form1.action="printRegistrationFormula1?courseid="+document.form1.cid.value;
            document.form1.submit();

        }
        function printAuszahl()
        {
            document.form1.action="printIntAuszahlung?courseid="+document.form1.cid.value;
            document.form1.submit();

        }
        function timetable()
        {
            window.location="../stundenplan/updateUnterrichtStunden";
        }
        function printFirstRegistration()
        {
            document.form1.action="registerPrintFormula1?courseid="+document.form1.cid.value;
            document.form1.submit();

        }
        function makevertrag(){
            window.location="courseVertragPlan?courseid="+document.form1.cid.value;
        }
        function druck()
        {
            window.open("anwesenD");
        }
        function activecourses()
        {
            window.location="courseList";
        }
    </script>
</head>
<body>
<%
    AnwesenDao adb= (AnwesenDao) request.getAttribute("adb");
    CourseDao cdb= (CourseDao) request.getAttribute("cdb");
    Course course=new Course();
    InsuranceDao insuranceDB= (InsuranceDao) request.getAttribute("insuranceDB");
    int totalcount=0;
    int week=0;
    int trackP=-1;
    int trackN=1;
    int endPoint=0;
    Vector v=new Vector();
    Vector image=new Vector();
    String hd1="";
    String hd2="";
    int idN=0;
    int selectN = 0;
    String selectS="";
    Vector vc=new Vector();

    String courseid=(String)request.getParameter("courseid");
    if(courseid!=null){
        idN=Integer.parseInt(courseid);
        course = cdb.getCourse(idN);
        session.setAttribute("courseid",courseid);
    }else{
        String tempcoid=(String)session.getAttribute("courseid");
        if(tempcoid!=null){
            idN=Integer.parseInt(tempcoid);
            course = cdb.getCourse(idN);
        }
    }
    session.setAttribute("pcourse",course);
    v=cdb.getAllStudentsByCourse(idN);

    String weekS=(String)request.getParameter("week");
    try{
        if(weekS==null){
            week=adb.getWeek(idN);
            int wee1=week;
            int wee2=week;
            wee1++;
            wee2--;
            trackN=wee1;
            trackP=wee2;
        }else{
            week=Integer.parseInt(weekS);
            int wee1=week;
            int wee2=week;
            wee1++;
            wee2--;
            trackN=wee1;
            trackP=wee2;
        }
    }catch(Exception e){

    }
    endPoint=adb.getLastWeek(idN);
    adb.setWeek(week,idN);
    hd1= MyDate.formateDate(adb.getFirstDate(),MyDate.ALPHANUMERIC,MyDate.DEUTSCH);
    hd2=MyDate.formateDate(adb.getLastDate(),MyDate.ALPHANUMERIC,MyDate.DEUTSCH);
    session.setAttribute("d1",hd1);
    session.setAttribute("d2",hd2);

    adb.synchronizedAnwesenheit(v,idN,adb.getFirstDate(),adb.getLastDate());

    Vector vec=new Vector();
    for(int pp=0;pp<v.size();pp++){
        Student st=(Student)v.elementAt(pp);
        if(st.getUserBamfNumber()!=null){
            vec.addElement(st);
        }
        if(st.getUserBamfNumber()==null && st.getUserVerifiedNumber() !=null){
            vec.addElement(st);
        }
    }
    v=vec;
    selectS=course.getCourseType()+"";

    selectN=Integer.parseInt(selectS);
    RPS rps = (RPS) request.getAttribute("rps");
    vc=cdb.getVertragByPlaceActiveF(rps.getLoginPlace().getPlaceID(),selectN);
    for(int i=0;i<vc.size();i++){
        Course c = (Course)vc.elementAt(i);
    }
    session.setAttribute("planv",vc);
    session.setAttribute("selstudent",v);
    session.setAttribute("idN",""+idN);
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <table width="100%" border="0" cellpadding="1" cellspacing="1">
                            <tr>
                                <td colspan="10">
                                    <div align="right">
                                        <font size="1" face="Verdana, Arial, Helvetica, sans-serif">
                                            <input name="Auszahlung" type ="button" id="Auszahlung" onClick="printAuszahl()" value="Auszahlungsbogen">
                                            <input type="submit" name="Timetable" value="Unterrichtstunden" onClick="timetable()">
                                            <input type="submit" name="Submit" value="Kurse Verbinden" onClick="makevertrag()">
                                        </font>
                                        <input type ="button" name="Anmeldung" value="Anmeldung" onClick="printFirstRegistration()">
                                        <input type ="button" name="Anderung" value="Änderung">
                                        <input type ="button" name="Rechnung" value="Rechnung" onClick="printRegistration()">
                                        <input type="button" name="Button" value="Aktiv Kurse" onClick="activecourses()">
                                        <input type="button" name="Submit22" value="Haupt" onClick="haupt()">
                                    </div></td>
                            </tr>
                            <tr>
                                <td valign="top">
                                    <form name="form1" method="post" action="">
                                        <input type="hidden" name="cid" value="<%=idN%>">
                                        <input type="hidden" name="selectS" value="<%=selectS%>">
                                    </form>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="10" height="18" bgcolor="657A9A"><div align="center"><font size="3" color="#FFFFFF"><b>Intergrationkurs<font size="3" color="#FFFFFF">liste</font></b></font></div></td>
                            </tr>
                            <tr>
                                <td height="18" bgcolor="657A9A">
                                    <div align="left"><font color="#FFFFFF" size="2"><strong>Summe</strong></font></div></td>
                                <td height="18" colspan="6" bgcolor="657A9A">&nbsp;</td>
                                <td height="18" colspan="3" bgcolor="657A9A"><div align="right"><strong><font color="#FFFFFF" size="2"><%=v.size()%></font></strong></div></td>
                            </tr>
                            <tr>
                                <td width="15%" height="18" bgcolor="657A9A"><b></b>
                                    <div align="center"><b><font size="2" color="#FFFFFF">Student</font></b></div>
                                </td>
                                <td width="15%" height="18" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Bamfnummer</font></b></td>
                                <td width="18%" height="18" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Status</font></b></td>
                                <td width="18%" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Anmeldedatum</font></b></td>
                                <td width="11%" height="18" bgcolor="657A9A">&nbsp;</td>
                                <td width="5%" height="18" bgcolor="657A9A">&nbsp;</td>
                                <td width="10%" height="18" bgcolor="657A9A">&nbsp;</td>
                                <td width="8%" height="18" bgcolor="657A9A">&nbsp;</td>
                            </tr>
                            <%
                                String myFarbe="#000033";
                                for(int d=0;d<v.size();d++){
                                    Student s=(Student)v.elementAt(d);
                                    Anwesenheit a=adb.getAnwesenheit(idN,s.getUserID(),adb.getFirstDate(),adb.getLastDate());
                                    int status = s.getUserCostSharing();
                                    String statusS="";
                                    if (status == 0)
                                        statusS = "";
                                    else if (status == 1)
                                        statusS = "mit Kostenbeitrag";
                                    else if (status == 2)
                                        statusS = "ohne Kostenbeitrag";
                                    if(!insuranceDB.isInsured(s.getUserID())){
                                        myFarbe="#FF0000";
                                    }

                                    String bamfnumber ="";
                                    bamfnumber =s.getUserBamfNumber();
                                    if(bamfnumber==null ){
                                        bamfnumber = s.getUserVerifiedNumber();
                                        if(bamfnumber==null ){
                                            bamfnumber="";
                                        }
                                    }
                                    if(s.getUserActive()>0){
                            %>
                            <tr bgcolor="#9999CC">
                                <td width="15%" height="18"><font size="2" color="<%=myFarbe%>"><a href="../schuler/showStudentPreciseD?userid=<%=s.getUserID()%>"><%=s.getUserFirstName()+" "+ s.getUserLastName()%></a></font><font size="2" color="#000033" face="Verdana, Arial, Helvetica, sans-serif">&nbsp;</font></td>
                                <td width="15%" height="18"><font size="2" color="#000033"><%=bamfnumber%></font></td>
                                <td height="18" ><font size="2" color="#000033"><%=statusS%></font></td>
                                <td ><font size="2" color="#000033"><%=s.getUserRegDate()%></font></td>
                                <td height="18" ><font size="2" color="#000033">Aktive</font></td>
                                <td width="5%" height="18">&nbsp;</td>
                                <td width="10%" height="18">&nbsp;</td>
                                <td width="8%" height="18">&nbsp;</td>
                            </tr>
                            <%
                            }else{
                            %>
                            <tr>
                                <td width="15%" height="18"><font size="2" color="<%=myFarbe%>"><a href="../schuler/showStudentPreciseD?userid=<%=s.getUserID()%>"><%=s.getUserFirstName()+" "+ s.getUserLastName()%></a></font></td>
                                <td width="15%" bgcolor="AEBACD" height="18"><font size="2" color="#000033"><%=bamfnumber%></font></td>
                                <td height="18" bgcolor="AEBACD"><font size="2" color="#000033"><%=statusS%></font></td>
                                <td bgcolor="AEBACD"><font size="2" color="#000033"><%=s.getUserRegDate()%></font></td>
                                <td height="18" bgcolor="AEBACD"><font size="2" color="#000033">Nicht Aktive</font></td>
                                <td bgcolor="AEBACD" width="5%" height="18">&nbsp;</td>
                                <td bgcolor="AEBACD" width="10%" height="18">&nbsp;</td>
                                <td bgcolor="AEBACD" width="8%" height="18">&nbsp;</td>
                            </tr>
                            <%
                                    }
                                }
                            %>
                        </table>
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
