<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ page import="com.rheinlandprivatschule.model.Course" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="com.rheinlandprivatschule.repository.RegistrationDao" %>
<%@ page import="com.rheinlandprivatschule.repository.StudentDao" %>
<%@ page import="java.util.Vector" %>
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
            color: black;
            margin-top: auto;
            margin-bottom: auto;
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

        function first()
        {
            document.form2.Submit.disabled=false;
        }

        function SubmitMyForm()
        {
            document.same.submit()
        }


        function MM_findObj(n, d) { //v4.0
            var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
                d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
            if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
            for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
            if(!x && document.getElementById) x=document.getElementById(n); return x;
        }
    </script>
</head>
<%
    Student u=(Student)session.getAttribute("pstudent");
    double addition=0;
    double paid=0;
    double fee=0;
    boolean canipay=false;
    int paymentType=0;
    int registrationType=0;
    Course coras=new Course();

    session.setAttribute("pstudent",u);
    StudentDao sdb=new StudentDao();



    coras=(Course)session.getAttribute("erstk");
    Vector fver=(Vector)session.getAttribute("fver");
    String addi=(String)session.getAttribute("addi");
    String txtBal=(String)session.getAttribute("txtPay");
    session.setAttribute("ap",txtBal);

    try{
        addition= MyCurrency.getDoubleValue(addi);
        fee=coras.getCourseFee();

        boolean success=false;
        success=sdb.updateCourseRegistrationOnline(coras.getCourseID(),u.getUserID(),fee,0, RegistrationDao.SYSTEMPAYMENTMODE,addition,RegistrationDao.O_ONLINE,fver);
        if(success){
        }else{
            String err=sdb.getError();
            session.setAttribute("err",err);
            session.setAttribute("lin","../../../index.jsp");
            response.sendRedirect("error");
        }
    }catch(Exception e)
    {}
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
                                    <h1 class="h4 text-gray-900 mb-4"></h1>
                                </div>
                                <div class="container">
                                    <div class="form-group row">

                                        <label class="text-center">Informationen</label>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-sm-5 m-auto">
                                            <label><strong>Vorname</strong></label>
                                        </div>
                                        <div class="col-sm-7">
                                            <label><%=u.getUserFirstName()%></label>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-sm-5 m-auto">
                                            <label><strong>Nachname</strong></label>
                                        </div>
                                        <div class="col-sm-7">
                                            <label><%=u.getUserLastName()%></label>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-sm-5 m-auto">
                                            <label><strong>Betrag</strong></label>
                                        </div>
                                        <div class="col-sm-7">
                                            <label><%=coras.getCourseFee()+addition%></label>
                                        </div>
                                    </div>
                                    <div class="form-group row">

                                        <label class="text-center">Kurs Informationen</label>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-sm-5 m-auto">
                                            <label><strong>Kursname</strong></label>
                                        </div>
                                        <div class="col-sm-7">
                                            <label><%=coras.getCourseName()%></label>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-sm-5 m-auto">
                                            <label><strong>Kursgebühr</strong></label>
                                        </div>
                                        <div class="col-sm-7">
                                            <label><%=coras.getCourseFee()+addition%></label>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-md-6">
                                            <input class="btn btn-primary" type="button" name="Submit3" value="Zur&uuml;ck" onClick="goback()">
                                        </div>
                                       <div class="col-md-6">
                                           <form action="https://www.paypal.com/cgi-bin/webscr" method="post">
                                               <input type="hidden" name="cmd" value="_ext-enter">
                                               <input type="hidden" name="redirect_cmd" value="_xclick">
                                               <input type="hidden" name="business" value="info@unitutor.de">
                                               <input type="hidden" name="amount" value="<%=coras.getCourseFee()+addition%>">
                                               <input type="hidden" name="item_name" value="<%=coras.getCourseName()%>">
                                               <input type="hidden" name="cancel_return" value="www.unitutor.de">
                                               <input type="hidden" name="return" value="www.unitutor.de/student/studentArea.jsp">
                                               <input type="hidden" name="currency_code" value="EUR">
                                               <input type="hidden" name="first_name" value="<%=u.getUserFirstName()%>">
                                               <input type="hidden" name="last_name" value="<%=u.getUserLastName()%>">
                                               <input type="hidden" name="address1" value="<%=u.getUserAddress()%>">
                                               <input type="hidden" name="address2" value="">
                                               <input type="hidden" name="city" value="<%=u.getUserCity()%>">
                                               <input type="hidden" name="state" value="">
                                               <input type="hidden" name="zip" value="<%=u.getUserPostCode()%>">
                                               <input type="image" src="https://www.paypal.com/en_US/i/btn/x-click-butcc.gif" border="0" name="submit" alt="Make payments with PayPal - it's fast, free and secure!">
                                               <input type="hidden" name="encrypted" value="-----BEGIN PKCS7-----
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
rw==
-----END PKCS7-----
">
                                           </form>
                                       </div>

                                    </div>
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <form name="form2" method="post" action="">
                                        <input type="hidden" name="sss" value="makeVertrag">
                                    </form>
                                    <hr>

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