<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.rheinlandprivatschule.repository.*" %>
<%@ page import="com.rheinlandprivatschule.model.*" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Kurs Registrierung Einzelheit ::</title>
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
        function mahnung()
        {
            window.location="mahnungdatum?u="+document.form1.userids.value+"&c="+document.form1.courseid.value;
        }
        function changecourse()
        {
            window.location="changeCourse";
        }

        function studentdetail()
        {
            window.location="showStudentPreciseD?userid="+document.form1.userids.value;
        }

        function changeme()
        {
            if(document.form1.checkbox.checked){
                document.form1.checkbox.value="1";
            }else{
                document.form1.checkbox.value="0";
            }
        }

        function anmeld(){
            if(document.form1.anm.value=="true" && document.form1.canregprint.value=="true" && document.form1.freigabe.value=="true"){
                window.location="noa?cid="+document.form1.courseid.value+"&bal="+document.form1.balance.value;
            }else{
                if(document.form1.anm.value=="false"){
                    alert('Es ist nicht möglich, ohne vollgebühr zu zahlen.')
                }else if(document.form1.canregprint.value=="false"){
                    alert('Ihnen wird nicht erlaubt, das zu tun.')
                }else if(document.form1.freigabe.value=="false"){
                    alert('Der Schüler ist nicht freigegben.')
                }
            }
        }

        function anmeldint(){
            if(document.form1.anmint.value=="true" && document.form1.canregprint.value=="true" && document.form1.freigabe.value=="true"){
                window.location="noaIntegration?cid="+document.form1.courseid.value+"&bal="+document.form1.balance.value;
            }else{
                if(document.form1.anm.value=="false"){
                    alert('Es ist nicht möglich, ohne vollgebühr zu zahlen.')
                }else if(document.form1.canregprint.value=="false"){
                    alert('Ihnen wird nicht erlaubt, das zu tun.')
                }else if(document.form1.freigabe.value=="false"){
                    alert('Der Schüler ist nicht freigegben.')
                }
            }
        }

        function teil(){
            if(document.form1.anm.value=="true" && document.form1.canregprint.value=="true" && document.form1.freigabe.value=="true"){
                window.location="teil";
            }else{
                if(document.form1.anm.value=="false"){
                    alert('Es ist nicht möglich, ohne vollgebühr zu zahlen.')
                }else if(document.form1.canregprint.value=="false"){
                    alert('Ihnen wird nicht erlaubt, das zu tun.')
                }else if(document.form1.freigabe.value=="false"){
                    alert('Der Schüler ist nicht freigegben.')
                }
            }
        }

        function online(){
            if(document.form1.zerhid.value=="true" && document.form1.canzergenerate.value=="true" && document.form1.freigabe.value=="true")	{
                window.location="cerInputOnline?courseid="+document.form1.courseid.value;
            }else{
                if(document.form1.zerhid.value=="false"){
                    alert('Es ist nicht möglich, das ist zu früh.')
                }else if(document.form1.canzergenerate.value=="false"){
                    alert('Ihnen wird nicht erlaubt, das zu tun.')
                }else if(document.form1.freigabe.value=="false"){
                    alert('Der Schüler ist nicht freigegben.')
                }
            }
        }

        function teilT(){
            if(document.form1.anm.value=="true" && document.form1.canregprint.value=="true" && document.form1.freigabe.value=="true"){
                window.location="teilT";
            }else{
                if(document.form1.anm.value=="false"){
                    alert('Es ist nicht möglich, ohne vollgebühr zu zahlen.')
                }else if(document.form1.canregprint.value=="false"){
                    alert('Ihnen wird nicht erlaubt, das zu tun.')
                }else if(document.form1.freigabe.value=="false"){
                    alert('Der Schüler ist nicht freigegben.')
                }
            }
        }

        function teilM(){
            if(document.form1.anm.value=="true" && document.form1.canregprint.value=="true" && document.form1.freigabe.value=="true"){
                window.location="teilM";
            }else{
                if(document.form1.anm.value=="false"){
                    alert('Es ist nicht möglich, ohne vollgebühr zu zahlen.')
                }else if(document.form1.canregprint.value=="false"){
                    alert('Ihnen wird nicht erlaubt, das zu tun.')
                }else if(document.form1.freigabe.value=="false"){
                    alert('Der Schüler ist nicht freigegben.')
                }
            }
        }

        function teilW(){
            if(document.form1.anm.value=="true" && document.form1.canregprint.value=="true" && document.form1.freigabe.value=="true"){
                window.location="teilW";
            }else{
                if(document.form1.anm.value=="false"){
                    alert('Es ist nicht möglich, ohne vollgebühr zu zahlen.')
                }else if(document.form1.canregprint.value=="false"){
                    alert('Ihnen wird nicht erlaubt, das zu tun.')
                }else if(document.form1.freigabe.value=="false"){
                    alert('Der Schüler ist nicht freigegben.')
                }
            }
        }

        function teilG(){
            if(document.form1.anm.value=="true" && document.form1.canregprint.value=="true" && document.form1.freigabe.value=="true"){
                window.location="teilG";
            }else{
                if(document.form1.anm.value=="false"){
                    alert('Es ist nicht möglich, ohne vollgebühr zu zahlen.')
                }else if(document.form1.canregprint.value=="false"){
                    alert('Ihnen wird nicht erlaubt, das zu tun.')
                }else if(document.form1.freigabe.value=="false"){
                    alert('Der Schüler ist nicht freigegben.')
                }
            }
        }



        function zer(){
            if(document.form1.zerhid.value=="true" && document.form1.canzergenerate.value=="true" && document.form1.freigabe.value=="true")	{
                window.location="cerInput?courseid="+document.form1.courseid.value;
            }else{
                if(document.form1.zerhid.value=="false"){
                    alert('Es ist nicht möglich, das ist zu früh.')
                }else if(document.form1.canzergenerate.value=="false"){
                    alert('Ihnen wird nicht erlaubt, das zu tun.')
                }else if(document.form1.freigabe.value=="false"){
                    alert('Der Schüler ist nicht freigegben.')
                }
            }
        }

        function zernp(){
            if(document.form1.canzergenerate.value=="true" && document.form1.freigabe.value=="true")	{
                window.location="cerNPInput?courseid="+document.form1.courseid.value;
            }else{
                if(document.form1.canzergenerate.value=="false"){
                    alert('Ihnen wird nicht erlaubt, das zu tun.')
                }else if(document.form1.freigabe.value=="false"){
                    alert('Der Schüler ist nicht freigegben.')
                }
            }
        }

        function leave1(msg){
            if(document.form1.canmahprint.value=="true")	{
                window.location="mahnnom?cid="+msg;
            }else{
                alert('Ihnen wird nicht erlaubt, das zu tun.')
            }
        }

        function leave2(msg){
            if(document.form1.canseezer.value=="true")	{
                window.location="nocerone?zerid="+msg;
            }else{
                alert('Ihnen wird nicht erlaubt, das zu tun.')
            }
        }

        function leave2Online(msg){
            if(document.form1.canseezer.value=="true")	{
                window.location="noceroneonline?zerid="+msg;
            }else{
                alert('Ihnen wird nicht erlaubt, das zu tun.')
            }
        }

        function leave3(msg){
            if(document.form1.canseezer.value=="true")	{
                window.location="nocerNPone?zerid="+msg;
            }else{
                alert('Ihnen wird nicht erlaubt, das zu tun.')
            }
        }

        function leave(msg)
        {
            if(!confirm(msg)) return false
            else document.form1.submit()
        }
        function nullgeb(msg)
        {
            if(!confirm(msg))
                return false
            else
                window.location="nullgeb?cid="+document.form1.courseid.value+"&bal="+document.form1.balance.value;
        }
        function deleteco(msg)
        {
            if(!confirm(msg))
                return false
            else
                window.location="deleteRegis?cid="+document.form1.dele.value;
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

        function MM_preloadImages() { //v3.0
            var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
                var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
                    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
        }

        function createQR(studentId, certificateId) {
            window.location = 'createqr?studentId=' + studentId + '&certificateId=' + certificateId;
        }
    </script>
</head>
<body>
<%
    StudentDao studentDB= (StudentDao) request.getAttribute("studentDao");
    MahnungDao mdb= (MahnungDao) request.getAttribute("mahnungDao");
    CourseDao cdb= (CourseDao) request.getAttribute("courseDao");
    CertificateDao cerdb=new CertificateDao();
    CourseRegistration cr = new CourseRegistration();
    Student student =(Student)session.getAttribute("pstudent");
    Mahnung mahn=new Mahnung();
    Course c=new Course();
    Course freiCourse=new Course();
    TransactionDao trdb= new TransactionDao();
    Course frei=new Course();
    Vector image=new Vector();
    PlaceDao placeDB = new PlaceDao();
    ArrayList registrations=new ArrayList();
    Vector cerv=new Vector();
    Vector cerNP=new Vector();
    Vector cervOnline = new Vector();
    SystemUserDao sudb = new SystemUserDao();
    ArrayList<Transaction> myXtr= new ArrayList<Transaction>();

    int userid=0;
    int courseid=0;
    int delevalue=0;

    String myMsg="";
    String falligDate="";

    boolean inkasso=false;
    boolean mayactiv=false;
    boolean cananm=true;
    boolean cananmint=true;
    boolean zertifikat=false;
    boolean zertifikatNP=false;
    boolean cancerGenerate=false;
    boolean canregPrint=false;
    boolean canmahPrint=false;
    boolean canZerPrint=false;
    boolean freigegeben=false;
    java.sql.Date enddate= MyDate.getCurrentSQLDate();
    java.sql.Date freidate=null;
    double paid=0;
    int num=0;
    java.util.Date utilfreidate = new java.util.Date();
    java.util.Date utilenddate = new java.util.Date();
    Place place = new Place();


    RPS rps=(RPS)session.getAttribute("handler");
    //java.sql.Date enddate=MyDate.getCurrentSQLDate();
    freiCourse=cdb.getMaxCourseEndDate(student.getUserID());
    frei=cdb.isFreigegeben(student.getUserID());
    if(frei.getCourseEndDate()!=null){
        num=1;
    }else{
        num=0;
    }
    //num=utilfreidate.compareTo(utilenddate);
    freidate=student.getFreigabeDate();

    if(student.getFreigabeStatus()==0){
        freigegeben=false;
    }else if(student.getFreigabeStatus()==1 && MyDate.isEqual(freidate,enddate)==false){
        freigegeben=false;
    }else if(student.getFreigabeStatus()==2 && num==0){
        freigegeben=false;
    }else{
        freigegeben=true;
    }

    cancerGenerate=studentDB.canGenerateCertificate(rps.getLoginUser().getUserID());
    canregPrint=studentDB.canPrintRegistration(rps.getLoginUser().getUserID());
    canmahPrint=studentDB.canPrintMahnung(rps.getLoginUser().getUserID());
    canZerPrint=studentDB.canPrintCertificate(rps.getLoginUser().getUserID());

    userid=student.getUserID();
    if(student.getUserBamfNumber()==null){
        cananmint=false;
    }else {
        cananmint=true;
    }
    String courseidS=(String)request.getParameter("courseid");
    try	{
        courseid=Integer.parseInt(courseidS);

        cr=studentDB.getRegistrationByStudent(courseid,userid);
        if(cr.getFirstPayDate()!=null){
            falligDate=MyDate.formateDate(cr.getFirstPayDate(),MyDate.NUMERIC,MyDate.DEUTSCH);
        }


        mahn=mdb.getGedruckMahnung(courseid,userid);

        inkasso=studentDB.isInKasso(userid,courseid,rps.getLoginUser().getUserID());
        if(inkasso)	{
            myMsg="Schuler ist im inkasso Liste. Möchten Sie ";
        }else{
            myMsg="Haben Sie ";
        }

        c=cdb.getCourse(cr.getCourseID());
        mayactiv=studentDB.isRegisteredCourseActive(c);
        paid=studentDB.hasPaidForTheCourse(userid,courseid);
        if(cr.getCourseFee()==cr.getCourseBalance()){
            delevalue=cr.getCourseID();
        }

        //Zertifikat
        cerv=cerdb.getAllCertificate(userid,courseid);
        cervOnline = cerdb.getAllOnlineCertificate(userid, courseid);
        cerNP=cerdb.getAllCertificateNP(userid,courseid);
        if(cerdb.isCertificateAvailable(cr.getCourseID())){
            zertifikat=true;
            zertifikatNP=true;
        }else{
            zertifikat=false;
            zertifikatNP=false;
        }

        place=placeDB.getPlace(c.getCoursePlace());

        if(mayactiv){
            if(cr.getCourseBalance()>0 && student.getUserBamfNumber()==null){
                cananm=false;
            }else {
                cananm=true;
            }
        }else{
            if(paid>=200 || cr.getCourseBalance() == 0){
                cananm=true;
            }else {
                cananm=false;
            }
        }

        myXtr=trdb.getPrintRegRecord(userid,courseid);

        session.setAttribute("cr",cr);
        session.setAttribute("course",c);
        session.setAttribute("myPrint","reg");
    }catch(Exception e){
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onClick="teilG()">LN G</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onClick="teilW()">LN W</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onClick="teilM()">LN M</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onClick="teilT()">LN T</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onClick="studentdetail()">Zur&uuml;ck</a>

                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width: 100%;" name="form1" method="post" action="updateFee" onSubmit="MM_validateForm('txtBal','','RisNum');return document.MM_returnValue">
                            <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                <tr bgcolor="D9E5F4">
                                    <td height="26" colspan="6">
                                        <div align="right"> <font size="1" face="Verdana, Arial, Helvetica, sans-serif">
                                            <input type="hidden" name="userids" value="<%=userid%>">
                                            <input type="hidden" name="dele" value="<%=delevalue%>">
                                            <input type="hidden" name="balance" value="<%=MyCurrency.getDisplayString(cr.getCourseBalance())%>">
                                            <input type="button" name="Submit7" value="Null Geb&uuml;hr" onClick="nullgeb('Sind Sie sicher, um Nochoffen '+document.form1.balance.value+' zu 0 zu machen?');return false">
                                            <input type="button" name="Submit5" value="L&ouml;schen Kurs" onClick="deleteco('Sind Sie sicher, um kurs zu löschen?');return false">
                                            <input type="button" name="Submit4" value="&Auml;nderung kurs" onClick="changecourse()">
                                        </font></div>
                                    </td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td colspan="6" height="26">
                                        <div align="center"><font size="2"><b><font color="#FFFFFF">Kurs
                                            Registrierung Einzelheit</font></b></font></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="18" bgcolor="657A9A" colspan="2"><b><font size="2" color="#FFFFFF">Kursname</font></b></td>
                                    <td height="18" bgcolor="AEBACB" colspan="4"><font size="2" color="#000033"><%=c.getCourseName()%> ------ <%=num%>----<%=freigegeben%></font></td>
                                </tr>
                                <tr>
                                    <td height="18" bgcolor="657A9A" colspan="2"><b><font size="2" color="#FFFFFF">Kurs
                                        Einzelheit</font></b></td>
                                    <td height="18" bgcolor="AEBACB" colspan="4"><font size="2" color="#000033"><%=c.getCourseDesc()%></font></td>
                                </tr>
                                <tr>
                                    <td height="13" bgcolor="657A9A" colspan="2"><b><font size="2" color="#FFFFFF">Kurs
                                        Anfangdatum</font></b></td>
                                    <td height="13" bgcolor="AEBACB" colspan="4"><font size="2" color="#000033"><%=MyDate.formateDate(c.getCourseStartDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                </tr>
                                <tr>
                                    <td height="15" bgcolor="657A9A" colspan="2"><b><font size="2" color="#FFFFFF">Kurs
                                        Endedatum</font></b></td>
                                    <td height="15" bgcolor="AEBACB" colspan="4"><font size="2" color="#000033"><%=MyDate.formateDate(c.getCourseEndDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                </tr>
                                <tr>
                                    <td height="18" bgcolor="657A9A" colspan="2"><b><font size="2" color="#FFFFFF">Kursgeb&uuml;hr</font></b></td>
                                    <td height="18" bgcolor="AEBACB" colspan="4"><font size="2" color="#000033"><%=MyCurrency.getDisplayString(cr.getCourseFee())%></font></td>
                                </tr>
                                <tr>
                                    <td height="17" bgcolor="657A9A" colspan="2"><font size="2"><b><font size="2" color="#FFFFFF">Geb&uuml;hr</font><font color="#FFFFFF">
                                        bezahlt</font></b></font></td>
                                    <td height="17" bgcolor="AEBACB" colspan="4"><font size="2" color="#000033"><%=MyCurrency.getDisplayString(paid)%></font></td>
                                </tr>
                                <tr>
                                    <td height="17" bgcolor="657A9A" colspan="2"><b><font size="2" color="#FFFFFF">Bestand</font></b></td>
                                    <td height="17" bgcolor="AEBACB" colspan="4"><font size="2" color="#000033"><%=MyCurrency.getDisplayString(cr.getCourseBalance())%></font></td>
                                </tr>
                                <tr>
                                    <td height="13" bgcolor="657A9A" colspan="2"><b><font size="2" color="#FFFFFF">Schulungsort</font></b></td>
                                    <td height="13" bgcolor="AEBACB" colspan="4"><font size="2" color="#000033"><%=place.getPlaceName()%></font></td>
                                </tr>
                                <tr>
                                    <td height="13" bgcolor="657A9A" colspan="2"><b><font size="2" color="#FFFFFF">F&auml;lligkeitsdatum</font></b></td>
                                    <td height="13" bgcolor="AEBACB" colspan="4"><font size="2" color="#000033"><%=falligDate%></font></td>
                                </tr>
                                <tr>
                                    <td height="23" bgcolor="657A9A" colspan="2"><font size="2"><b><font color="#FFFFFF">Art
                                        der Bezahlung</font></b></font></td>
                                    <td height="23" bgcolor="AEBACB" colspan="4">
                                        <select name="paytype">
                                            <option value="0" selected>Bar</option>
                                            <option value="1">Uberweisung</option>
                                            <option value="2">Online</option>
                                            <option value="3">Inkasso</option>
                                            <option value="4">BAMF</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="23" bgcolor="657A9A" colspan="2"><b><font size="2" color="#FFFFFF">Rechnungsbetrag</font></b></td>
                                    <td height="23" bgcolor="AEBACB" colspan="4"> <font size="2" color="#405579">
                                        <%
                                            if(mayactiv || cr.getCourseBalance()<200)
                                            {
                                        %>
                                        <input type="text" name="txtBal" size="8" value="<%=cr.getCourseBalance()%>">
                                        <%
                                        }else{
                                        %>
                                        <input type="text" name="txtBal" size="8" value="200">
                                        <%
                                            }
                                        %>
                                        <input type="checkbox" name="checkbox" value="checkbox" onClick="changeme()">
                                    </font><font size="1" face="Verdana, Arial, Helvetica, sans-serif">Geldzurück</font></td>
                                </tr>
                                <tr>
                                    <td height="30" bgcolor="657A9A" colspan="2"><font size="2" color="#FFFFFF"><b>Aktualisierung
                                        <font size="2" color="#FFFFFF">Bestand</font></b></font></td>
                                    <td height="30" bgcolor="AEBACB" colspan="2">
                                        <input type="hidden" name="courseid" value="<%=cr.getCourseID()%>">
                                        <input type="submit" name="Submit" value="Zahlen" onClick="leave('<%=myMsg%>'+document.form1.txtBal.value+' Euro angenommen?');return false">
                                        <input type="hidden" name="anm" value="<%=cananm%>">
                                        <input type="hidden" name="anmint" value="<%=cananmint%>">
                                        <input type="hidden" name="zerhid" value="<%=zertifikat%>">
                                        <input type="hidden" name="zernphid" value="<%=zertifikatNP%>">
                                        <input type="hidden" name="freigabe" value="<%=freigegeben%>">
                                    </td>
                                    <td height="30" bgcolor="AEBACB" colspan="2"><b> </b></td>
                                </tr>
                                <tr>
                                    <td height="30" bgcolor="657A9A" colspan="2">&nbsp;</td>
                                    <td height="30" bgcolor="AEBACB" colspan="4"><b>
                                        <input type="button" name="Submit10" value="Ab" onClick="anmeldint()">
                                        <input type="button" name="Submit2" value="Ab selbstzahler" onClick="anmeld()">
                                        <input name="canregprint" type="hidden" id="canregprint" value="<%=canregPrint%>">
                                        <input name="canzergenerate" type="hidden" id="canzergenerate" value="<%=cancerGenerate%>">
                                        <input name="canmahprint" type="hidden" id="canmahprint" value="<%=canmahPrint%>">
                                        <input name="canseezer" type="hidden" id="canseezer" value="<%=canZerPrint%>">
                                        <input type="button" name="Submit3" value="Zertifikat" onClick="zer()"> &nbsp;&nbsp;
                                    </b>
                                        <input type="button" name="Submit6" value="Blockieren" onClick="mahnung()">                          &nbsp;&nbsp;<b>
                                            <input type="button" name="Submit2" value="Tb" onClick="teil()">
                                            <input type="button" name="Submit2" value="Zertifikat ONL" onClick="online()">
                                        </b>
                                        <b>
                                            <input type="button" name="Submit4" value="Zertifikat NP" onClick="zernp()">
                                        </b>                        </td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td colspan="6" height="15">
                                        <div align="center"><font size="3"><b><font color="#FFFFFF">Gedruckte
                                            Zertifikate</font></b></font></div>
                                    </td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td height="17" width="11%"><b><font size="2" color="#FFFFFF">Zertifikat
                                        Nr.:</font></b></td>
                                    <td height="17" width="18%"><b><font color="#FFFFFF" size="2">Note der Gesamtleistung </font></b></td>
                                    <td width="15%" height="17" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Note Bemerkung </font></b></td>
                                    <td height="17" bgcolor="657A9A" width="13%"><b><font size="2" color="#FFFFFF">Abwesende Stunden </font></b></td>
                                    <td width="13%" height="17" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Datum</font></b></td>
                                    <td height="17" bgcolor="657A9A" width="30%"><b><font size="2" color="#FFFFFF">Staffname
                                    </font></b></td>
                                    <td height="17" bgcolor="657A9A" width="30%"><b><font size="2" color="#FFFFFF">QR
                                    </font></b></td>
                                </tr>
                                <%
                                    for(int y=0;y<cerv.size();y++)
                                    {
                                        Certificate cc=(Certificate)cerv.elementAt(y);
                                        SystemUser su=sudb.getSystemUser(cc.getAdminID());
                                %>
                                <tr>
                                    <td height="15" bgcolor="AEBACB" width="11%"><font size="2" color="#000033"><a href="#" onClick="leave2('<%=cc.getCertificateID()%>');return false"><%=cc.getCertificateID()%></a></font></td>
                                    <td height="15" bgcolor="AEBACB" width="18%"><font size="2" color="#000033"><%=cc.getTotalPercentage()%></font></td>
                                    <td width="15%" height="15" bgcolor="AEBACB"><font size="2" color="#000033"><%=cc.getNote()%></font></td>
                                    <td width="13%" height="15" bgcolor="AEBACB"><font size="2" color="#000033"><%=cc.getStunden()%></font></td>
                                    <td width="13%" height="15" bgcolor="AEBACB"><font size="2" color="#000033"><%=MyDate.formateDate(cc.getIssueDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                    <td width="30%" height="15" bgcolor="AEBACB"><font size="2" color="#000033"><%=su.getUserFirstName()%></font></td>
                                    <td height="15" bgcolor="AEBACB" width="11%"><font size="2" color="#000033"><a href="#" onClick="createQR('<%=student.getUserID()%>','<%=cc.getCertificateID()%>');return false"><%=cc.getCertificateID()%></a></font></td>
                                </tr>
                                <%
                                    }
                                %>
                                <tr bgcolor="657A9A">
                                    <td colspan="6" height="15">
                                        <div align="center"><font size="3"><b><font color="#FFFFFF">Gedruckte
                                            Zertifikate Online</font></b></font></div>
                                    </td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td height="17" width="11%"><b><font size="2" color="#FFFFFF">Zertifikat
                                        Nr.:</font></b></td>
                                    <td height="17" width="18%"><b><font color="#FFFFFF" size="2">Note der Gesamtleistung </font></b></td>
                                    <td width="15%" height="17" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Note Bemerkung </font></b></td>
                                    <td height="17" bgcolor="657A9A" width="13%"><b><font size="2" color="#FFFFFF">Abwesende Stunden </font></b></td>
                                    <td width="13%" height="17" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Datum</font></b></td>
                                    <td height="17" bgcolor="657A9A" width="30%"><b><font size="2" color="#FFFFFF">Staffname
                                    </font></b></td>
                                    <td height="17" bgcolor="657A9A" width="30%"><b><font size="2" color="#FFFFFF">QR
                                    </font></b></td>
                                </tr>
                                <%
                                    for(int y=0;y<cervOnline.size();y++)
                                    {
                                        Certificate cc=(Certificate)cervOnline.elementAt(y);
                                        SystemUser su=sudb.getSystemUser(cc.getAdminID());
                                %>
                                <tr>
                                    <td height="15" bgcolor="AEBACB" width="11%"><font size="2" color="#000033"><a href="#" onClick="leave2Online('<%=cc.getCertificateID()%>');return false"><%=cc.getCertificateID()%></a></font></td>
                                    <td height="15" bgcolor="AEBACB" width="18%"><font size="2" color="#000033"><%=cc.getTotalPercentage()%></font></td>
                                    <td width="15%" height="15" bgcolor="AEBACB"><font size="2" color="#000033"><%=cc.getNote()%></font></td>
                                    <td width="13%" height="15" bgcolor="AEBACB"><font size="2" color="#000033"><%=cc.getStunden()%></font></td>
                                    <td width="13%" height="15" bgcolor="AEBACB"><font size="2" color="#000033"><%=MyDate.formateDate(cc.getIssueDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                    <td width="30%" height="15" bgcolor="AEBACB"><font size="2" color="#000033"><%=su.getUserFirstName()%></font></td>
                                    <td height="15" bgcolor="AEBACB" width="11%"><font size="2" color="#000033"><a href="#" onClick="createQR('<%=student.getUserID()%>','<%=cc.getCertificateID()%>');return false"><%=cc.getCertificateID()%></a></font></td>
                                </tr>
                                <%
                                    }
                                %>
                                <tr bgcolor="657A9A">
                                    <td colspan="6" height="15"><div align="center"><font size="3"><b><font color="#FFFFFF">Gedruckte Zertifikate Nur Pr&uuml;fungen </font></b></font></div></td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td height="17"><b><font size="2" color="#FFFFFF">Zertifikat Nr.:</font></b></td>
                                    <td height="17"><b><font color="#FFFFFF" size="2">Note der Gesamtleistung </font></b></td>
                                    <td height="17" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Note Bemerkung </font></b></td>
                                    <td height="17" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Abwesende Stunden </font></b></td>
                                    <td height="17" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Datum</font></b></td>
                                    <td height="17" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Staffname </font></b></td>
                                </tr>
                                <%
                                    for(int y=0;y<cerNP.size();y++)
                                    {
                                        Certificate cc=(Certificate)cerNP.elementAt(y);
                                        SystemUser su=sudb.getSystemUser(cc.getAdminID());
                                %>
                                <tr>
                                    <td height="15" bgcolor="AEBACB"><font size="2" color="#000033"><a href="#" onClick="leave3('<%=cc.getCertificateID()%>');return false"><%=cc.getCertificateID()%></a></font></td>
                                    <td height="15" bgcolor="AEBACB"><font size="2" color="#000033"><%=cc.getTotalPercentage()%></font></td>
                                    <td height="15" bgcolor="AEBACB"><font size="2" color="#000033"><%=cc.getNote()%></font></td>
                                    <td height="15" bgcolor="AEBACB"><font size="2" color="#000033"><%=cc.getStunden()%></font></td>
                                    <td height="15" bgcolor="AEBACB"><font size="2" color="#000033"><%=MyDate.formateDate(cc.getIssueDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                    <td height="15" bgcolor="AEBACB"><font size="2" color="#000033"><%=su.getUserFirstName()%></font></td>
                                </tr>
                                <%
                                    }
                                %>
                                <tr bgcolor="657A9A">
                                    <td height="15" colspan="6">
                                        <div align="center"><font size="3" color="#FFFFFF"><b>Mahnung</b></font></div>
                                    </td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td height="15" colspan="2"><font size="2" color="#FFFFFF"><b>Mahnung
                                        Nr.:</b></font></td>
                                    <td colspan="3" height="15"><font size="2" color="#FFFFFF"><b>Datum</b></font></td>
                                    <td width="30%" height="15">&nbsp;</td>
                                </tr>
                                <%
                                    if(mahn.getMahnungID()>0)
                                    {
                                        String kh="";
                                        if(mahn.getStatus()==1){
                                            kh="Geschikt";
                                        }else{
                                            kh="Nicht geschikt";
                                        }


                                %>
                                <tr>
                                    <td height="15" bgcolor="AEBACB" colspan="2"><font size="2" color="#000033"><a href="#" onClick="leave1('<%=mahn.getCourseID()%>&uid=<%=mahn.getUserID()%>');return false"><%=mahn.getMahnungID()%></a></font></td>
                                    <td colspan="3" height="15" bgcolor="AEBACB"><font size="2" color="#000033"><%=MyDate.formateDate(mahn.getMahnngDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                    <td width="30%" height="15" bgcolor="AEBACB"><font size="2" color="#000033"><%=kh%></font></td>
                                </tr>
                                <%
                                }else{
                                %>
                                <tr>
                                    <td height="15" bgcolor="AEBACB" colspan="2"><font size="2" color="#000033">&nbsp;</font></td>
                                    <td colspan="3" height="15" bgcolor="AEBACB"><font size="2" color="#000033">&nbsp;</font></td>
                                    <td width="30%" height="15" bgcolor="AEBACB"><font size="2" color="#000033">&nbsp;</font></td>
                                </tr>
                                <%
                                    }
                                %>
                                <tr bgcolor="657A9A">
                                    <td height="15" colspan="6">
                                        <div align="center"><font size="3" color="#FFFFFF"><b>Gedruckte Anmeldebest&auml;tigungen</b></font></div>
                                    </td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td height="15" colspan="2"><font size="2" color="#FFFFFF"><b>Nr.:</b></font></td>
                                    <td colspan="3" height="15"><font size="2" color="#FFFFFF"><b>Datum</b></font></td>
                                    <td width="30%" height="15">&nbsp;</td>
                                </tr>
                                <%
                                    for(int b=myXtr.size()-1;b>=0;b--){
                                        Transaction xtra=(Transaction)myXtr.get(b);
                                        Student sta=new Student();
                                %>
                                <tr>
                                    <td height="15" bgcolor="AEBACB" colspan="2"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=xtra.getTransactionNo()%></font><font size="2" color="#000033">&nbsp;</font></td>
                                    <td colspan="3" height="15" bgcolor="AEBACB"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=MyDate.formateDate(xtra.getPaymentDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                    <td width="30%" height="15" bgcolor="AEBACB"><font size="1" color="#000033" face="Verdana, Arial, Helvetica, sans-serif"><%=xtra.getLoginUserCompleteName()%></font></td>
                                </tr>
                                <%
                                    }
                                %>
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
