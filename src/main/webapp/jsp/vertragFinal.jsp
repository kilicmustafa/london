<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.model.Course" %>
<%@ page import="com.rheinlandprivatschule.repository.CourseDao" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.model.CourseRegistration" %>
<%@ page import="com.rheinlandprivatschule.repository.StudentDao" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Vertragplan ::</title>
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

        function okk()
        {

            document.forms[0].action="vertragFinal";
            document.forms[0].submit()
        }

        function man()
        {
            if(document.form2.checkbox.checked==true)
            {
                document.form2.txtE.disabled=false;
                document.form2.ok.disabled=false;
                document.forms[0].action="vertragFinal";

            }
            else
            {
                document.form2.txtE.disabled=true;
                document.form2.ok.disabled=true;

            }
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
    StudentDao sdb= (StudentDao) request.getAttribute("studentDao");
    CourseDao cdb = (CourseDao) request.getAttribute("courseDao");

    Student student=new Student();

    boolean cananm=true;
    boolean local=false;
    boolean external=false;
    double add=0;
    Vector v=new Vector();
    boolean fort=false;
    double volfee=0;
    double erstk=0;
    boolean mayactiv=false;
    int regType=0;

    Student u=(Student)session.getAttribute("pstudent");
    RPS rps = (RPS) session.getAttribute("handler");
    if(u==null){
        String err="Wählen Sie Schüler Zuerst aus";
        session.setAttribute("err",err);
        session.setAttribute("lin","seacrhStudent");
        response.sendRedirect("error");
    }
    try{
        String fff=(String)request.getParameter("ok");
        if(fff.equalsIgnoreCase("ok")){
            local=true;
        }
    }catch(Exception e){
    }

    student=sdb.getStudentInformationExt(u.getUserID());

    if(student.getUserBamfNumber()==null){
        cananm=false;
    }else {
        cananm=true;
    }

    if(!local){
        regType=0;
        String par[]=request.getParameterValues("checkbox");
        for(int i=0;i<par.length;i++){
            String temp=par[i];
            Course tempC=cdb.getCourse(Integer.parseInt(temp));
            v.addElement(tempC);
        }
        Vector fver=new Vector();
        Vector onlyfver=new Vector();

        for(int uu=0;uu<v.size();uu++){
            Course cv=(Course)v.elementAt(uu);
            if(erstk==0){
                erstk=cv.getCourseFee();
                if(cdb.isCourseActive(cv)){
                    mayactiv=true;
                }else{
                    mayactiv=false;
                }
                onlyfver.addElement(cv);
                session.setAttribute("erstk",cv);
            }else{
                onlyfver.addElement(cv);
                fver.addElement(cv);
            }
            volfee+=cv.getCourseFee();
            if(cv.getCourseType()==5){
                fort=true;
            }
        }

        session.setAttribute("fver",fver);
        session.setAttribute("onlyfver",onlyfver);

        if((fort)){
            add=0;
        }else{
            add=100;
        }

        Vector price=new Vector();
        boolean ppp=true;
        for(int a=0;a<v.size();a++){
            Course asd=(Course)v.elementAt(a);
            if(ppp){
                price.addElement(""+(asd.getCourseFee()+add));
                ppp=false;
            }else{
                price.addElement(""+asd.getCourseFee());
            }
        }
        session.setAttribute("pri",price);
    }else{

        //again For Manuall First CourseFee
        if(sdb.canMakeVertragManuall(rps.getLoginUser().getUserID())){
            regType=1;
            String erstcourse=(String)request.getParameter("txtE");
            double newValue=Double.parseDouble(erstcourse);
            Vector onlyfver=(Vector)session.getAttribute("onlyfver");
            Vector fver=new Vector();
            v=fver;
            for(int uu=0;uu<onlyfver.size();uu++){
                Course cv=(Course)onlyfver.elementAt(uu);
                if(erstk==0){
                    erstk=newValue;
                    cv.setCourseFee(newValue);
                    if(cdb.isCourseActive(cv)){
                        mayactiv=true;
                    }else{
                        mayactiv=false;
                    }
                    session.setAttribute("erstk",cv);
                }else{
                    fver.addElement(cv);
                }
                volfee+=cv.getCourseFee();
                if(cv.getCourseType()==5)
                {
                    fort=true;
                }
            }
            session.setAttribute("onlyfver",onlyfver);
            session.setAttribute("fver",fver);

            if((fort)){
                add=0;
            }else{
                add=0;
            }
            Vector price=new Vector();
            boolean ppp=true;
            for(int a=0;a<onlyfver.size();a++){
                Course asd=(Course)onlyfver.elementAt(a);
                if(ppp){
                    price.addElement(""+(newValue));
                    ppp=false;
                }else{
                    price.addElement(""+asd.getCourseFee());
                }
            }
            session.setAttribute("pri",price);
        }else{
            String err=sdb.getError();
            session.setAttribute("err",err);
            session.setAttribute("lin","../map");
            response.sendRedirect("error");
        }
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form name="form2" method="post" action="registerVerFee" onSubmit="MM_validateForm('txtE','','RisNum','txtV','','RisNum','txtB','','RisNum');return document.MM_returnValue">
                            <table width="100%" border="0" cellspacing="1" cellpadding="1" height="186">
                                <tr bgcolor="657A9A">
                                    <td width="38%">
                                        <div align="center"><b><font size="2" color="#FFFFFF">Kurs
                                            Name</font></b></div>
                                    </td>
                                    <td width="24%" bgcolor="657A9A">
                                        <div align="center"><font size="2" color="#FFFFFF"><b>Anfang
                                            Datum</b></font></div>
                                    </td>
                                    <td width="21%">
                                        <div align="center"><font size="2" color="#FFFFFF"><b>Ende
                                            Datum</b></font></div>
                                    </td>
                                    <td width="17%">
                                        <div align="center"><b><font size="2" color="#FFFFFF">Remains</font></b></div>
                                    </td>
                                </tr>
                                <%
                                    for(int y=0;y<v.size();y++)
                                    {
                                        Course f=(Course)v.elementAt(y);
                                %>
                                <tr bgcolor="AEBACD">
                                    <td width="38%" height="9"><font size="2" color="#000033"><%=f.getCourseName()%></font></td>
                                    <td width="24%" height="9"><font size="2" color="#000033"><%=MyDate.formateDate(f.getCourseStartDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                    <td width="21%" height="9"><font size="2" color="#000033"><%=MyDate.formateDate(f.getCourseEndDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                    <td width="17%" height="9"><font size="2" color="#000033"><%=(f.getCourseStrength()-cdb.countStudentsByCourse(f.getCourseID()))%></font></td>
                                </tr>
                                <%
                                    }
                                %>
                                <tr bgcolor="AEBACD">
                                    <td colspan="4" height="2"><input type="hidden" name="location" value="<%=u.getCostID()%>" size="17"> </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="29" bgcolor="657A9A"><font size="2"><b><font color="#FFFFFF">Erste
                                        Kursgeb&uuml;hr</font></b></font></td>
                                    <td bgcolor="AEBACD" height="29" colspan="3">
                                        <%
                                            if(local)
                                            {
                                        %>
                                        <input type="text" name="txtE" value="<%=(erstk+add)%>" size="17">
                                        <%
                                        }
                                        else
                                        {
                                        %>
                                        <input type="text" name="txtE" value="<%=(erstk+add)%>" disabled size="17">
                                        <%
                                            }
                                        %>
                                        <%
                                            if(local)
                                            {
                                        %>
                                        <input type="checkbox" name="ok" value="ok" onClick="okk()">
                                        <%
                                        }
                                        else
                                        {
                                        %>
                                        <input type="checkbox" name="ok" value="ok" disabled onClick="okk()">
                                        <%
                                            }
                                        %>
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="2" bgcolor="657A9A"><font size="2"><b><font color="#FFFFFF">Volle
                                        Kursgeb&uuml;hr</font></b></font></td>
                                    <td colspan="3" height="2">
                                        <input type="text" name="txtV" value="<%=(volfee+add)%>" disabled size="17">
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="13" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Betrag</font></b></td>
                                    <td colspan="3" height="13">
                                        <%
                                            if(mayactiv)
                                            {

                                        %>
                                        <input type="text" name="txtPay" value="<%=(erstk+add)%>" disabled size="17">
                                        <%
                                        }
                                        else
                                        {
                                        %>
                                        <input type="text" name="txtPay" value="200" disabled size="17">
                                        <%
                                            }
                                        %>
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td bgcolor="657A9A" height="2"><font color="#FFFFFF"><b><font size="2">Zahlweise</font></b></font></td>
                                    <td colspan="3" height="2"><select name="paytype" disabled>
                                        <option value="0" selected>Bar</option>
                                        <option value="1">Uberweisung</option>
                                        <option value="2">Online</option>
                                        <option value="3">Inkasso</option>
                                    </select>
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td bgcolor="657A9A" height="2"><font color="#FFFFFF"><b><font size="2">Modul Nummer </font></b></font></td>
                                    <td colspan="3" height="2"><select name="moduleNumber" disabled>
                                        <option value="0" selected>Wählen</option>
                                        <option value="1">1</option>
                                        <option value="2" >2</option>
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
                                <tr bgcolor="AEBACD">
                                    <td height="2">
                                        <input type="hidden" name="addi" value="<%=add%>">
                                    </td>
                                    <td height="2"> <b> <font size="2">
                                        <%
                                            if(local)
                                            {
                                        %>
                                        <input type="checkbox" name="checkbox" value="checkbox" onClick="man()" checked>
                                        <%
                                        }
                                        else
                                        {
                                        %>
                                        <input type="checkbox" name="checkbox" value="checkbox" onClick="man()">
                                        <%
                                            }
                                        %>
                                    </font></b><font size="2">Manuell </font></td>
                                    <td height="2"><input name="regtype" type="hidden" id="regtype" value="<%=regType%>">
                                        <input type="hidden" name="anm" value="<%=cananm%>">
                                        <input type="hidden" name="integration" value="<%=student.getUserBamfNumber()%>" size="17"></td>
                                    <td height="2">
                                        <input type="hidden" name="sss" value="showStudentPreciseD?userid=<%=u.getUserID()%>">
                                        <input type="hidden" name="nationality" value=<%=student.getUserCountryID()%>>
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="2">&nbsp;</td>
                                    <td height="2"><b><font size="2">
                                    </font></b></td>
                                    <td height="2">&nbsp;</td>
                                    <td height="2">&nbsp;</td>
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
