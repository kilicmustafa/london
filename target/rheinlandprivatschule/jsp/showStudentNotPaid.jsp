<%@ page import="java.util.ArrayList" %>
<%@ page import="com.rheinlandprivatschule.repository.StudentDao" %>
<%@ page import="com.rheinlandprivatschule.repository.CourseDao" %>
<%@ page import="com.rheinlandprivatschule.repository.TransactionDao" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.rheinlandprivatschule.model.CourseRegistration" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.model.Course" %>
<%@ page import="com.rheinlandprivatschule.model.Transaction" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Sch&uuml;ler Information ::</title>
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
        function studentpage(){
            window.location="/schuler/showStudentPreciseD?userid="+document.form1.userids.value;
        }
        function studentdetail()
        {
            window.location="/schuler/showStudentDetail?userid="+document.form1.userids.value;
        }


        function updateR()
        {
            window.location=document.form1.dr.value
        }

        function back()
        {
            window.location="/schuler/notOnlinePaid"
        }

        function leave(msg,cod)
        {
            if(!confirm(msg))
            {
                return false
            }
            else
            {
                //process
                window.location="abmelding?courseid="+cod
                return false
            }
        }
    </script>
</head>
<body>
<%
   
    String firstname="";
    String lastname="";
    String birthdate="";
    String customno="";
    String faxno="";
    Student u = null;
    int userid=0;
    ArrayList vc=new ArrayList();
    String remarks="";

    StudentDao sdb= (StudentDao) request.getAttribute("studentDao");
    CourseDao cdb= (CourseDao) request.getAttribute("courseDao");
    TransactionDao trdb= (TransactionDao) request.getAttribute("transactionDao");

    String valueS=(String)request.getParameter("userid");
    try{
        userid=Integer.parseInt(valueS);
        u=sdb.getStudentForSubProcess(userid);
        session.setAttribute("delstu",u);
        session.setAttribute("pstudent",u);
    }catch(Exception e){
    }

    if(u!=null)	{
        firstname=u.getUserFirstName();
        lastname=u.getUserLastName();
        birthdate= MyDate.formateDate(u.getUserBirthDate(),MyDate.NUMERIC,MyDate.DEUTSCH);
        customno=""+u.getUserID();
        if(u.getUserFax()!=null){
            faxno=u.getUserFax();
        }
        vc=sdb.getRegistrationByStudentID(u.getUserID(),1);
        session.setAttribute("regvec",vc);
        remarks=u.getUserRemarks();
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="studentdetail()">Sch&uuml;ler Information</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="back()">Zur&uuml;ck</a>

                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td valign="top" height="146" bgcolor="D9E5F4" width="81%">
                                    <table width="100%" height="376" border="0" cellpadding="1" cellspacing="1">
                                        <tr>
                                            <td colspan="5" bgcolor="657A9A">
                                                <div align="center"><b><font size="3" color="#FFFFFF">Sch&uuml;ler
                                                    Information</font></b></div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="14%" bgcolor="657A9A">
                                                <div align="center"><b><font size="2" color="#FFFFFF">Kunde
                                                    Nr</font></b></div>
                                            </td>
                                            <td width="25%" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Vor
                                                Name</font></b></td>
                                            <td width="25%" bgcolor="657A9A">
                                                <div align="center"><b><font size="2" color="#FFFFFF">Nach
                                                    Name</font></b></div>
                                            </td>
                                            <td width="16%" bgcolor="657A9A">
                                                <div align="center"><b><font size="2" color="#FFFFFF">Geburtsdatum</font></b></div>
                                            </td>
                                            <td width="20%" bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>Fax
                                                No</b></font></td>
                                        </tr>
                                        <tr>
                                            <td width="14%" bgcolor="AEBACD"><font size="2" color="#000033"><%=customno%></font></td>
                                            <td width="25%" bgcolor="AEBACD"><font size="2" color="#000033"><%=firstname%></font></td>
                                            <td width="25%" bgcolor="AEBACD"><font size="2" color="#000033"><%=lastname%></font></td>
                                            <td width="16%" bgcolor="AEBACD"><font size="2" color="#000033"><%=birthdate%></font></td>
                                            <td width="20%" bgcolor="AEBACD"><%=faxno%></td>
                                        </tr>
                                        <tr>
                                            <td colspan="5">&nbsp;</td>
                                        </tr>
                                        <tr bgcolor="657A9A">
                                            <td colspan="5" height="14">
                                                <div align="center"><font size="3"><b><font color="#FFFFFF">Kurs
                                                    Einzelheit</font></b></font></div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="5">
                                                <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                                    <tr bgcolor="657A9A">
                                                        <td width="28%"><b><font size="2" color="#FFFFFF">Kurs
                                                            Name</font></b></td>
                                                        <td width="14%"><b><font size="2" color="#FFFFFF">Anfang
                                                            Datum</font></b></td>
                                                        <td width="6%"><b><font size="2" color="#FFFFFF">Status</font></b></td>
                                                        <td width="7%"><b><font color="#FFFFFF" size="2">Geb&uuml;hr</font></b></td>
                                                        <td width="7%"><b><font size="2" color="#FFFFFF">bezahlt</font></b></td>
                                                        <td width="12%"><b><font size="2" color="#FFFFFF">Noch
                                                            Offen</font></b></td>
                                                        <td width="17%"><b><font size="2" color="#FFFFFF">Bericht
                                                            Nr</font></b></td>
                                                    </tr>
                                                    <%
                                                        Iterator liIT=vc.iterator();
                                                        while(liIT.hasNext()){
                                                            CourseRegistration cr=(CourseRegistration)liIT.next();
                                                            String mys="";
                                                            if(cr.getRegistrationStatus()==1)
                                                            {mys="R";}
                                                            else if(cr.getRegistrationStatus()==0)
                                                            {mys="V";}
                                                            else if(cr.getRegistrationStatus()==2)
                                                            {mys="A";}
                                                            else if(cr.getRegistrationStatus()==3)
                                                            {mys="O";}
                                                            Course cc=cdb.getCourse(cr.getCourseID());
                                                            ArrayList<Transaction> myv=trdb.getTransactions(u.getUserID(),cc.getCourseID());
                                                            String tempb="";
                                                            boolean b=true;
                                                            double cre=0;
                                                            for(int ii=0;ii<myv.size();ii++){
                                                                Transaction tt=(Transaction)myv.get(ii);
                                                                if(b){
                                                                    tempb=tempb+tt.getTransactionNo();
                                                                    cre=cre+tt.getPaid();
                                                                    b=false;
                                                                }else{
                                                                    tempb=tempb+","+tt.getTransactionNo();
                                                                    cre=cre+tt.getPaid();
                                                                }
                                                            }
                                                            if(cr.getRegistrationStatus()==0){
                                                    %>
                                                    <tr bgcolor="AEBACD">
                                                        <td width="28%"><font size="2" color="#000033"><%=cc.getCourseName()%></font></td>
                                                        <td width="14%"><font size="2" color="#000033"><%=MyDate.formateDate(cc.getCourseStartDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                                        <td width="6%"><font size="2" color="#000033"><%=mys%></font></td>
                                                        <td width="7%"><font size="2" color="#000033"><%=MyCurrency.getDisplayString(cr.getCourseFee())%></font></td>
                                                        <td width="7%"><font size="2" color="#000033"><%=MyCurrency.getDisplayString(cre)%></font></td>
                                                        <td width="12%"><font size="2" color="#000033"><%=MyCurrency.getDisplayString(cr.getCourseBalance())%></font></td>
                                                        <td width="17%"><font size="2" color="#000033"><%=tempb%></font></td>
                                                    </tr>
                                                    <%
                                                    }else if(cr.getRegistrationStatus()==1){
                                                    %>
                                                    <tr bgcolor="AEBACD">
                                                        <td width="28%"><font size="2" color="#000033"><%=cc.getCourseName()%></font></td>
                                                        <td width="14%"><font size="2" color="#000033"><%=MyDate.formateDate(cc.getCourseStartDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                                        <td width="6%"><font size="2" color="#000033"><%=mys%></font></td>
                                                        <td width="7%"><font size="2" color="#000033"><%=MyCurrency.getDisplayString(cr.getCourseFee())%></font></td>
                                                        <td width="7%"><font size="2" color="#000033"><%=MyCurrency.getDisplayString(cre)%></font></td>
                                                        <td width="12%"><font size="2" color="#000033"><%=MyCurrency.getDisplayString(cr.getCourseBalance())%></font></td>
                                                        <td width="17%"><font size="2" color="#000033"><%=tempb%></font></td>
                                                    </tr>
                                                    <%
                                                    }
                                                    else if(cr.getRegistrationStatus()==2){
                                                    %>
                                                    <tr bgcolor="AEBACD">
                                                        <td width="28%"><font size="2" color="#000033"><%=cc.getCourseName()%></font></td>
                                                        <td width="14%"><font size="2" color="#000033"><%=MyDate.formateDate(cc.getCourseStartDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                                        <td width="6%"><font size="2" color="#000033"><%=mys%></font></td>
                                                        <td width="7%"><font size="2" color="#000033"><%=MyCurrency.getDisplayString(cr.getCourseFee())%></font></td>
                                                        <td width="7%"><font size="2" color="#000033"><%=MyCurrency.getDisplayString(cre)%></font></td>
                                                        <td width="12%"><font size="2" color="#000033"><%=MyCurrency.getDisplayString(cr.getCourseBalance())%></font></td>
                                                        <td width="17%"><font size="2" color="#000033"><%=tempb%></font></td>
                                                    </tr>
                                                    <%
                                                    }
                                                    else if(cr.getRegistrationStatus()==3){
                                                    %>
                                                    <tr bgcolor="AEBACD">
                                                        <td width="28%"><font size="2" color="#000033"><%=cc.getCourseName()%></font></td>
                                                        <td width="14%"><font size="2" color="#000033"><%=MyDate.formateDate(cc.getCourseStartDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                                        <td width="6%"><font size="2" color="#000033"><%=mys%></font></td>
                                                        <td width="7%"><font size="2" color="#000033"><%=MyCurrency.getDisplayString(cr.getCourseFee())%></font></td>
                                                        <td width="7%"><font size="2" color="#000033"><%=MyCurrency.getDisplayString(cre)%></font></td>
                                                        <td width="12%"><font size="2" color="#000033"><%=MyCurrency.getDisplayString(cr.getCourseBalance())%></font></td>
                                                        <td width="17%"><font size="2" color="#000033"><%=tempb%></font></td>
                                                    </tr>
                                                    <%
                                                            }
                                                        }
                                                    %>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr bgcolor="657A9A">
                                            <td colspan="5">
                                                <div align="center"><b><font size="2" color="#FFFFFF">Bemerkung</font></b></div>
                                            </td>
                                        </tr>
                                        <tr bgcolor="AEBACD" valign="top">
                                            <td colspan="5" height="25">
                                                <form style="width: 100%;" name="form1" method="post" action="onlyRemark">
                                                    <textarea name="textfield" cols="80" rows="6"><%=remarks%></textarea>
                                                    <input type="hidden" name="dr" value="deleteR">
                                                    <input type="hidden" name="userids" value="<%=customno%>">
                                                </form>
                                            </td>
                                        </tr>
                                        <tr bgcolor="AEBACD">
                                            <td colspan="5">
                                                <input class="btn btn-primary" type="button" name="Button" value="L&ouml;schen Registrierung" onClick="updateR()">
                                            </td>
                                        </tr>
                                        <tr bgcolor="AEBACD">
                                            <td colspan="5" height="77"> <b><font size="2" color="#000033">Kurs
                                                Einzelheit....Status</font></b><font color="#000033"><br>
                                                <font size="2"><b>R:-</b> Registriert<br>
                                                    <b>A:-</b> Nicht Registriert<br>
                                                    <b>O:-</b> Online Registriert</font></font></td>
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
