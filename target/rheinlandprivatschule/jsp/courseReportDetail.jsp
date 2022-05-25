<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.repository.*" %>
<%@ page import="com.rheinlandprivatschule.model.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Liste von Sch&uuml;lern ::</title>
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
        function addVer()
        {
            window.location="/CourseVertrag/attachVertrag?courseid="+document.form1.cid.value;
        }
        function Enable() {
            document.form1.bamf.readOnly = false;
        }

        function Disable() {
            document.form1.bamf.readOnly = true;
        }

        function saving()
        {
            document.form2.action="anwesensave?courseid="+document.form1.cid.value;
            document.form2.submit();
        }
        function rem()
        {
            document.form2.action="onlyRemark?courseid="+document.form1.cid.value+"&desc="+document.form3.textfield.value;;
            document.form2.submit();
        }

        function anwesen()
        {
            document.form2.action="anwesen?courseid="+document.form1.cid.value;
            document.form2.submit();

        }
        function integration()
        {
            document.form2.action="integration?courseid="+document.form1.cid.value;
            document.form2.submit();

        }
        function haupt()
        {
            window.location="/index";
        }
        function activecourses()
        {
            window.location="courseList";
        }
        function coursedetail()
        {
            window.location="updateCourseForm?courseid="+document.form1.cid.value;
        }
        function coursedetail2()
        {
            window.location="courseReportDetail2?courseid="+document.form1.cid.value;
        }

        function integrationkurs()
        {
            window.location="updateCourseFormExample?courseid="+document.form1.cid.value;
        }


        function coursereport()
        {
            window.location="stlohnDetail?courseid="+document.form1.cid.value;
        }

        function deletecourse(msg)
        {
            if(!confirm(msg))
                return false
            else
                window.location="deleteCourse?courseid="+document.form1.cid.value;
        }
    </script>
</head>
<body>
<%
    StudentDao sdb= (StudentDao) request.getAttribute("sdb");
    CourseDao cdb= (CourseDao) request.getAttribute("cdb");
    TransactionDao trDB= (TransactionDao) request.getAttribute("trDB");
    WerbungDao werbungDB = (WerbungDao) request.getAttribute("werbungDB");
    StundDao stdb= (StundDao) request.getAttribute("stdb");

    double geb=0;
    double zahlend=0;
    double active=0;

    double geb1=0;
    int zahlend1=0;
    double active1=0;

    Vector v=new Vector();
    Vector v1=new Vector();
    Vector image=new Vector();
    Course cou=null;
    int idN=0;
    int courseid=0;
    int logchk=0;
    String bamfnr="";
    int nochHours=0;
    String totalHours="0";
    int completedHours=0;
    int module = 0;
    String modulename = "";
    String remarks="";

    RPS rps = (RPS) request.getSession().getAttribute("handler");

    logchk=rps.getLoginUser().getUserType();

    String id=(String)request.getParameter("courseid");

    try{
        idN=Integer.parseInt(id);
        courseid=idN;
    }catch(Exception e){
    }
    cou=cdb.getCourse(idN);
    v=cdb.getAllStudentsByCourse(idN);
    v1=cdb.getAllStudentsByCourseAb(idN);
    bamfnr = cou.getCourseBamfNr();
    module = cou.getCourseType();
    totalHours=""+cou.getCourseTotalHours();
    completedHours=stdb.getTotalStundenTillDate(idN,MyDate.getCurrentSQLDate());
    if (bamfnr == null){
        bamfnr = "";}
    nochHours=Integer.parseInt(totalHours)-completedHours;
    if(module ==1 & nochHours > 99){
        modulename  = "Modul 1";
    }
    if(module ==1 & nochHours < 99){
        modulename  = "Modul 2";
    }
    if(module ==2 & nochHours > 99){
        modulename  = "Modul 3";
    }
    if(module ==2 & nochHours < 99){
        modulename  = "Modul 4";
    }
    if(module ==3 & nochHours > 99){
        modulename  = "Modul 5";
    }
    if(module ==3 & nochHours < 99){
        modulename  = "Modul 6";
    }
    if(module ==4 & nochHours > 99){
        modulename  = "Modul 7";
    }
    if(module ==4 & nochHours < 99){
        modulename  = "Modul 8";
    }
    if(module ==5 & nochHours > 99){
        modulename  = "Modul 9";
    }
    if(module ==5 & nochHours < 99){
        modulename  = "Modul 10";
    }
    remarks=cou.getRemarks();
    if(remarks==null){
        remarks="";
    }
    session.setAttribute("pstudent",cou);
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="coursedetail()">Kursinformation</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="deletecourse()">Kurs L&ouml;schen</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="coursereport()">Kursbericht</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="coursedetail2()">Sch&uuml;lerliste</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="saving()">Anwesenheit Liste</a>

                            </div>
                            <div class="wrapper" style="margin-bottom: 5px; float:right;">
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="addVer()">Vertrag</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="integration()">Integrationskurs</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="activecourses()">Aktiv Kurse</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="goback()">Zur&uuml;ck</a>

                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <table width="100%" border="0" height="302">

                            <tr>
                                <td valign="top">
                                    <form name="form1" method="post" action="">
                                        <input type="hidden" name="cid" value="<%=courseid%>">
                                    </form>
                                </td>
                            </tr>
                            <tr>
                                <td height="21" valign="top">
                                    <form name="form2" method="post" action="">
                                        <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                            <tr bgcolor="657A9A">
                                                <td height="16" colspan="9">
                                                    <div align="left"><font color="#FF9900" size="2"><b><%=modulename%><div align="center"><%=cou.getCourseName()%></div></b></font></div>
                                                </td>
                                            </tr>
                                            <tr bgcolor="AEBACD">
                                                <td colspan="5" height="16"><div align="left"><font color="#FFFFFF" size="2"><b> Noch</b></font><font color="#FFFFFF" size="2"><b> <%=nochHours%>   Ust.</b></font><font color="#FF9900" size="2"></font></div>
                                                </td>
                                                <td height="16" colspan="4"><div align="right"><font color="#FFFFFF" size="2"><b><%=bamfnr%></b></font></div></td>
                                            </tr>
                                            <tr bgcolor="657A9A">
                                                <td colspan="9" height="16"><div align="center"><font size="2"><b><font color="#FFFFFF">Kursteilnehmer</font></b></font></div></td>
                                            </tr>
                                            <tr bgcolor="657A9A">
                                                <td width="21%" height="14"><font size="2" color="#FFFFFF"><b>Summe &nbsp;&nbsp;&nbsp; <%=v.size()%></b></font></td>
                                                <td colspan="8" height="14" bgcolor="657A9A"><div align="right"><font size="2" color="#FFFFFF"></font></div></td>
                                            </tr>
                                            <tr bgcolor="657A9A">
                                                <td width="21%" height="14"><div align="center"><font color="#FFFFFF"><b><font size="2">Vorname</font></b></font></div></td>
                                                <td width="20%" height="14" bgcolor="657A9A"><div align="center"><font color="#FFFFFF"><b><font size="2">Nachname </font></b></font></div></td>
                                                <td width="28%" height="14"><font size="2" color="#FFFFFF"><b>Werbung</b></font></td>
                                                <td width="3%"><strong><font color="#FFFFFF" size="2">Int.</font></strong></td>
                                                <td width="7%" height="14"><b><font color="#FFFFFF" size="2">Geb&uuml;hr</font></b></td>
                                                <td width="7%" height="14"><b><font color="#FFFFFF" size="2">Gezahlt</font></b></td>
                                                <td width="9%" height="14"><b><font size="2" color="#FFFFFF">Noch offen </font></b></td>
                                                <td width="5%" height="14" colspan="2"><strong><font color="#FFFFFF" size="2">Anw.</font></strong></td>
                                            </tr>
                                            <%

                                                for(int i=0;i<v.size();i++){
                                                    Student u=(Student)v.elementAt(i);
                                                    CourseRegistration cr=sdb.getRegistrationByStudent(courseid,u.getUserID());
                                                    Course c=cdb.getCourse(cr.getCourseID());
                                                    ArrayList<Transaction> paidVector=trDB.getTransactions(u.getUserID(),c.getCourseID());
                                                    Werbung werbung=werbungDB.getWerbungRelatedToStudent(u.getUserID());
                                                    String werbungName="";
                                                    String bamfnumber ="";
                                                    bamfnumber =u.getUserBamfNumber();
                                                    if(bamfnumber==null ){
                                                        bamfnumber = u.getUserVerifiedNumber();
                                                        if(bamfnumber==null ){
                                                            bamfnumber="0";
                                                        }
                                                    }
                                                    if(werbung.getWerbungName()!=null){
                                                        werbungName=werbung.getWerbungName();
                                                    }
                                                    double cre=0;
                                                    for(int pi=0;pi<paidVector.size();pi++){
                                                        Transaction tt=(Transaction)paidVector.get(pi);
                                                        cre=cre+tt.getPaid();
                                                    }
                                                    if(logchk==1){
                                                        active=active+cr.getCourseBalance();
                                                        geb=geb+cr.getCourseFee();
                                                        zahlend=zahlend+cre;
                                                    }
                                                    if(cr.getCourseBalance()>0){
                                            %>
                                            <tr bgcolor="#9999CC">
                                                <td width="21%" height="6"><font size="2" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><a href="/schuler/showStudentPreciseD?userid=<%=u.getUserID()%>"><%=u.getUserFirstName()%></a></font></td>
                                                <td width="20%" height="6"><font size="2" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=u.getUserLastName()%></font></td>
                                                <td width="28%" height="6"><font size="2" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=werbungName%></font></td>
                                                <td width="3%" height="6"><%
                                                    if(bamfnumber!="0"  ){
                                                %>
                                                    <input type="checkbox" name="bamf" value="1" disabled checked>
                                                    <%
                                                    }else{
                                                    %>
                                                    <input type="checkbox" name="bamf" value="0" disabled >
                                                    <%
                                                        }
                                                    %></td>
                                                <td height="6" width="7%"><font size="2" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=cr.getCourseFee()%></font></td>
                                                <td height="6" width="7%"><font size="2" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=cre%></font></td>
                                                <td height="6" width="9%"><font size="2" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=cr.getCourseBalance()%></font></td>
                                                <td width="5%" height="6" colspan="2"><%
                                                    if(u.getUserActive()==1){
                                                %>
                                                    <input type="checkbox" name="checkbox" value="<%=u.getUserID()%>" checked>
                                                    <%
                                                    }else{
                                                    %>
                                                    <input type="checkbox" name="checkbox" value="<%=u.getUserID()%>">
                                                    <%
                                                        }
                                                    %>
                                                </td>
                                            </tr>
                                            <%
                                            }else{
                                            %>
                                            <tr bgcolor="AEBACD">
                                                <td width="21%" height="6"><font size="2" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><a href="../schuler/showStudentPreciseD?userid=<%=u.getUserID()%>"><%=u.getUserFirstName()%></a></font></td>
                                                <td width="20%" height="6" bgcolor="AEBACD"><font size="2" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=u.getUserLastName()%></font></td>
                                                <td width="28%" height="6"><font size="2" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=werbungName%></font></td>
                                                <td width="3%" height="6"><%
                                                    if(bamfnumber!="0"){
                                                %>
                                                    <input type="checkbox" name="bamf1" value="1" disabled checked >
                                                    <%
                                                    }else{
                                                    %>
                                                    <input type="checkbox" name="bamf1" value="0" disabled>
                                                    <%
                                                        }
                                                    %></td>
                                                <td height="6" width="7%"><font size="2" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=cr.getCourseFee()%></font></td>
                                                <td height="6" width="7%"><font size="2" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=cre%></font></td>
                                                <td height="6" width="9%"><font size="2" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=cr.getCourseBalance()%></font></td>
                                                <td width="5%" height="6" colspan="2"><%
                                                    if(u.getUserActive()==1){
                                                %>
                                                    <input type="checkbox" name="checkbox" value="<%=u.getUserID()%>" checked>
                                                    <%
                                                    }else{
                                                    %>
                                                    <input type="checkbox" name="checkbox" value="<%=u.getUserID()%>">
                                                    <%
                                                        }
                                                    %>
                                                </td>
                                            </tr>
                                            <%
                                                    }
                                                }
                                            %>
                                            <tr bgcolor="#3399CC">
                                                <td width="21%" height="6"><font size="2" color="#000033"></font></td>
                                                <td width="20%" height="6"><font size="2" color="#000033"></font></td>
                                                <td height="6" colspan="2"><font size="2" color="#000033"></font></td>
                                                <td height="6" width="7%"><font size="2" color="#000033"><%=geb%></font></td>
                                                <td height="6" width="7%"><font size="2" color="#000033"><%=zahlend%></font></td>
                                                <td height="6" width="9%"><font size="2" color="#000033"><%=active%></font></td>
                                                <td width="5%" height="6" colspan="2">&nbsp;</td>
                                            </tr>
                                        </table>
                                    </form>
                                </td>
                            </tr>
                            <tr>
                                <td height="100" valign="top"><table width="100%" border="0" cellpadding="1" cellspacing="1">
                                    <tr bgcolor="657A9A">
                                        <td height="16" colspan="6"><div align="center"><font color="#FFFFFF" size="2"></font></div>
                                            <div align="center"><font color="#FF9900" size="2"><b><%=cou.getCourseName()%></b></font></div></td>
                                    </tr>
                                    <tr bgcolor="AEBACD">
                                        <td colspan="6" height="16">&nbsp;</td>
                                    </tr>
                                    <tr bgcolor="657A9A">
                                        <td colspan="6" height="16"><div align="center"><font size="2"><b><font color="#FFFFFF">Abmeldung Kursteilnehmer Liste</font></b></font></div></td>
                                    </tr>
                                    <tr bgcolor="657A9A">
                                        <td width="25%" height="14"><font size="2" color="#FFFFFF"><b>Summe</b></font></td>
                                        <td colspan="5" height="14" bgcolor="657A9A"><div align="right"><font size="2" color="#FFFFFF"><b><%=v1.size()%></b></font></div></td>
                                    </tr>
                                    <tr bgcolor="657A9A">
                                        <td width="25%" height="14"><div align="center"><font color="#FFFFFF"><b><font size="2">Vorname</font></b></font></div></td>
                                        <td width="25%" height="14" bgcolor="657A9A"><div align="center"><font color="#FFFFFF"><b><font size="2">Nachname </font></b></font></div></td>
                                        <td width="14%" height="14"><font size="2" color="#FFFFFF"><b>Geburtsdatum</b></font></td>
                                        <td width="9%" height="14"><b><font color="#FFFFFF" size="2">Geb&uuml;hr</font></b></td>
                                        <td width="11%" height="14"><b><font size="2" color="#FFFFFF">zahlend</font></b></td>
                                        <td width="16%" height="14"><b><font size="2" color="#FFFFFF">Noch offen </font></b></td>
                                    </tr>
                                    <%

                                        for(int i=0;i<v1.size();i++){
                                            Student u=(Student)v1.elementAt(i);
                                            CourseRegistration cr=sdb.getRegistrationByStudent(courseid,u.getUserID());
                                            Course c=cdb.getCourse(cr.getCourseID());
                                            int tempto=sdb.getTotalPay(cr.getStudentID(),cr.getCourseID());
                                            if(logchk==1)
                                            {
                                                active1=active1+cr.getCourseBalance();
                                                geb1=geb1+cr.getCourseFee();
                                                zahlend1=zahlend1+tempto;
                                            }

                                    %>
                                    <tr bgcolor="AEBACD">
                                        <td width="25%" height="6"><font size="2" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><a href="../schuler/showStudentPreciseD?userid=<%=u.getUserID()%>"><%=u.getUserFirstName()%></a></font></td>
                                        <td width="25%" height="6" bgcolor="AEBACD"><font size="2" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=u.getUserLastName()%></font></td>
                                        <td width="14%" height="6"><font size="2" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=MyDate.formateDate(u.getUserBirthDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                        <td height="6" width="9%"><font size="2" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=cr.getCourseFee()%></font></td>
                                        <td height="6" width="11%"><font size="2" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=tempto%></font></td>
                                        <td height="6" width="16%"><font size="2" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=cr.getCourseBalance()%></font></td>
                                    </tr>
                                    <%

                                        }
                                    %>
                                    <tr bgcolor="#3399CC">
                                        <td width="25%" height="6"><font size="2" color="#000033"></font></td>
                                        <td width="25%" height="6"><font size="2" color="#000033"></font></td>
                                        <td width="14%" height="6"><font size="2" color="#000033"></font></td>
                                        <td height="6" width="9%"><font size="2" color="#000033"><%=geb1%></font></td>
                                        <td height="6" width="11%"><font size="2" color="#000033"><%=zahlend1%></font></td>
                                        <td height="6" width="16%"><font size="2" color="#000033"><%=active1%></font></td>
                                    </tr>
                                    <tr>
                                        <td height="17" colspan="7" bgcolor="657A9A">
                                            <div align="center"><b><font size="2" color="#FFFFFF">Bemerkung</font></b></div>
                                        </td>
                                    </tr>
                                    <tr valign="top">
                                        <td colspan="7" height="25" bgcolor="AEBACD">
                                            <form name="form3" method="post" action="">
                                                <textarea name="textfield" cols="80" rows="6"><%=remarks%></textarea>
                                                <input type="hidden" name="userids" value="<%=courseid%>">
                                            </form>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="26" colspan="7" bgcolor="AEBACD">
                                            <input type="button" name="RemarksN" value="speichern" onClick="rem()">
                                        </td>
                                    </tr>
                                </table>
                                </td>
                            </tr>
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
