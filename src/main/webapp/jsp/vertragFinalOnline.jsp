<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.repository.StudentDao" %>
<%@ page import="com.rheinlandprivatschule.model.Place" %>
<%@ page import="com.rheinlandprivatschule.repository.CourseDao" %>
<%@ page import="com.rheinlandprivatschule.model.Course" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <title>:: Pers&ouml;nliche Informationen ::</title>

    <!-- Custom fonts for this template-->
    <link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
            href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
            rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">

    <style>
        label {
            color:black;
            margin-top: auto;
            margin-bottom: auto;
        }

        .lb-title {
            font-weight: bold;
            font-size: 18px;
            color: #4e73df;
        }

        .p-0 {
            border: 5px solid black;
        }
    </style>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script>
        function goback(){
            window.history.back();
        }


        function druck()
        {
            if(document.form2.location.value==1)
            {
                window.open("printVertrag");
                // acc.disabled=false; Update by Murat on 2016-03-14 because enabling button didn't work with chrome or Opera
                document.getElementById('acc').disabled = false;
            }
            else
            {
                window.open("printVertrag1");
                // acc.disabled=false; Update by Murat on 2016-03-14 because enabling button didn't work with chrome or Opera
                document.getElementById('acc').disabled = false;
            }
        }

        function unterschrift(){
            window.location="registerVerFee";
        }

        function SubmitMyForm()
        {

            document.form1.submit();
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
<%
    boolean mayactiv=false;
    boolean external=false;
    int locationN=0;

    Student u=(Student)session.getAttribute("pstudent");

    session.setAttribute("pstudent",u);

    StudentDao sdb=(StudentDao) request.getAttribute("studentDao");
    Student student=new Student();
    CourseDao cdb=new CourseDao();
    Course ccoo=new Course();

    student=sdb.getStudentInformationExt(u.getUserID());
    double add=0;
    Vector v=new Vector();
    boolean fort=false;
    double volfee=0;
    double erstk=0;

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
    session.setAttribute("addi",""+add);
    session.setAttribute("txtPay",""+(erstk+add));
    session.setAttribute("pri",price);
%>
<body class="bg-gradient-primary">

<div class="container">

    <!-- Outer Row -->
    <div class="row justify-content-center">

        <div class="col-xl-8 col-lg-10 col-md-7">

            <div class="card o-hidden border-0 shadow-lg my-5">
                <div class="card-body p-0">
                    <!-- Nested Row within Card Body -->
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="p-5">
                                <div class="text-center">
                                    <img style="margin-bottom: 5%;" src="https://unitutor.de/wp-content/uploads/2020/03/cropped-Rp-LOGO-13-1024x151-2-830x122-1.png" width="50%">
                                    <h1 class="h4 text-gray-900 mb-4">Vertrag</h1>
                                </div>
                                <div class="container">
                                    <form class="user form-horizontal" id="onlineStudentForm" name="form2" method="get" action="/registerVerFee" onSubmit="MM_validateForm('txtE','','RisNum','txtV','','RisNum');return document.MM_returnValue">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <label class="lb-title">Kursname</label>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="lb-title">Anfangsdatum</label>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="lb-title">Endedatum</label>
                                            </div>
                                        </div>
                                        <%
                                            for(int y=0;y<v.size();y++)
                                            {
                                                Course f=(Course)v.elementAt(y);
                                        %>
                                        <div class="form-group row">
                                            <div class="col-md-6">
                                                <label><%=f.getCourseName()%></label>
                                            </div>

                                            <div class="col-md-3">
                                                <label><%=MyDate.formateDate(f.getCourseStartDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></label>
                                            </div>
                                            <div class="col-md-3">
                                                <label><%=MyDate.formateDate(f.getCourseEndDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></label>
                                            </div>
                                        </div>
                                        <%
                                        }

                                        %>
                                        <div class="form-group row">
                                            <div class="col-md-6">
                                                <label>Erste Kursgebühr</label>
                                            </div>
                                            <div class="col-md-6">
                                                <input class="form-control" name="txtE2" value="<%=(erstk+add)%>" disabled>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-md-6">
                                                <label>Voll Kursgebühr</label>
                                            </div>
                                            <div class="col-md-6">
                                                <input class="form-control" name="txtV" value="<%=(volfee+add)%>" disabled>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-md-6">
                                                <label>Betrag</label>
                                            </div>
                                            <div class="col-md-6">
                                                <%
                                                    if(mayactiv)
                                                    {

                                                %>
                                                <input class="form-control" type="text" name="txtPay" value="<%=(erstk+add)%>" disabled>
                                                <%
                                                }
                                                else
                                                {
                                                %>
                                                <input class="form-control" type="text" name="txtPay" value="200" disabled>
                                                <%
                                                    }
                                                %>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-md-3">
                                                <input class="btn btn-primary btn-block" type="button" name="Submit3" value="Zur&uuml;ck" onClick="goback()">
                                            </div>
                                            <div class="col-md-6">
                                                <input class="btn btn-primary btn-block" type="button" id="acc" value="Kostenpflichtig buchen" onClick="unterschrift()" disabled>
                                            </div>
                                            <div class="col-md-3">
                                                <input class="btn btn-primary btn-block" type="button" name="dv" value="Vertrag Druck" onClick="druck()">
                                            </div>
                                        </div>
                                        <input type="hidden" name="addi" value="<%=add%>">
                                        <input type="hidden" name="sss" value="makeVertrag">
                                        <input type="hidden" name="nationality" value=<%=student.getUserCountryID()%>>
                                        <input type="hidden" name="location" value="<%=locationN%>">
                                        <input type="hidden" name="user" value=<%=u.getUserID()%>>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>

    </div>

</div>

</body>

</html>