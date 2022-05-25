<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
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

        .p-0 {
            border: 5px solid black;
        }
    </style>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <SCRIPT TYPE="text/javascript">
        function goback(){
            window.history.back();
        }

        function weiter()
        {
            window.location="currentLocation";
        }

        function first()
        {
            document.form1.Submit.disabled=false;
        }
        function leave(msg)
        {
            if(!confirm(msg)) return false
            else document.form2.submit()
        }

        function SubmitMyForm()
        {
            document.same.submit()
        }
    </SCRIPT>
</head>
<%
    Student u=(Student)session.getAttribute("pstudent");
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
                                    <h1 class="h4 text-gray-900 mb-4">Willkommen
                                        zur Rheinland Privatschule</h1>
                                </div>
                                <div class="container">
                                    <form class="user form-horizontal" id="onlineStudentForm" action="" method="post">
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
                                                <label><strong>Geburtsdatum</strong></label>
                                            </div>
                                            <div class="col-sm-7">
                                                <label><%=MyDate.formateDate(u.getUserBirthDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></label>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-md-6">
                                                <input class="btn btn-primary btn-block" type="button" name="Submit3" value="Zur&uuml;ck" onClick="goback()">

                                            </div>
                                            <div class="col-md-6">
                                                <input class="btn btn-primary btn-block" type="button" name="Button" value="Weiter" onClick="weiter()">

                                            </div>
                                            <form name="form1" method="post" action="">
                                                <input type="hidden" name="sss" value="../../../../../index.htm">
                                            </form>
                                        </div>
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <hr>
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