<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.repository.PlaceDao" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="com.rheinlandprivatschule.repository.StudentDao" %>
<%@ page import="com.rheinlandprivatschule.model.Country" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.model.Place" %>
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
    <script>
        function goback(){
            window.history.back();
        }

        function first()
        {
            document.form1.Submit.disabled=false;
        }
    </script>
</head>
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
                                    <h1 class="h4 text-gray-900 mb-4">Sind Sie zur Zeit in Deutschland?</h1>
                                </div>
                                <div class="container">
                                    <form class="user form-horizontal" id="onlineStudentForm" action="/makeVertrag" method="post">
                                        <div class="form-group row">
                                            <div class="col-sm-6">
                                                <div class="custom-control custom-radio" style="float:right;">
                                                    <input type="radio" class="custom-control-input" id="defaultUnchecked" name="rdLocation" value="1" onclick="first()">
                                                    <label class="custom-control-label" for="defaultUnchecked">Ja</label>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="custom-control custom-radio">
                                                    <input type="radio" class="custom-control-input" id="defaultUnchecked1" name="rdLocation" value="2" onclick="first()">
                                                    <label class="custom-control-label" for="defaultUnchecked1">Nein</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-md-6">
                                                <input type="button" onclick="goback()" class="btn btn-primary btn-block" value="Zur&uuml;ck">

                                            </div>
                                            <div class="col-md-6">
                                                <input type="submit" class="btn btn-primary btn-block" value="Weiter">

                                            </div>
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