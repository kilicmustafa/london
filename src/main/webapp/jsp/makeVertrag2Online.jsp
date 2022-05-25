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

        function first()
        {
            document.form2.Submit.disabled=false;
        }

        function SubmitMyForm()
        {
            document.same.submit()
        }
    </script>
</head>
<%
    Vector vc=new Vector();
    int selectN=0;
    int locationN=0;
    StudentDao studentDB= (StudentDao) request.getAttribute("studentDao");
    Student student=new Student();
    CourseDao cdb=new CourseDao();

    String selectS=(String)request.getParameter("radiobutton");
    String locationS=(String)request.getParameter("location");
    try{
        if(selectS!=null){
            selectN=Integer.parseInt(selectS);
            locationN =Integer.parseInt(locationS);
            Place city=(Place)session.getAttribute("city");
            vc=cdb.getVertragByPlaceActiveF(city.getPlaceID(),selectN);
            session.setAttribute("planv",vc);

        }
    }catch(Exception e){
    }
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
                                    <h1 class="h4 text-gray-900 mb-4">An
                                        welchem Datum m&ouml;chten Sie starten?</h1>
                                </div>
                                <div class="container">
                                    <form class="user form-horizontal" id="onlineStudentForm" name="form2" method="post" action="/vertragPlan">
                                        <div class="row">
                                            <div class="col-md-6" style="padding-left: 0;">
                                                <label class="lb-title">Kurs Name</label>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="lb-title">Anfang Datum</label>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="lb-title">Ende Datum</label>
                                            </div>
                                        </div>
                                        <%
                                            if(vc.size()==0 && selectN!=0)
                                            {
                                        %>
                                        <%
                                            }
                                        %>
                                        <%
                                            for(int ii=0;ii<vc.size();ii++)
                                            {
                                                Course f=(Course)vc.elementAt(ii);
                                                if(selectN==f.getCourseType())
                                                {

                                        %>
                                        <div class="form-group row">
                                            <div class="col-md-6 custom-control custom-radio">
                                                <input type="radio" class="custom-control-input" id="defaultUnchecked<%=f.getCourseID()%>" name="radiobutton" value="<%=f.getCourseID()%>" onClick="first()">
                                                <label class="custom-control-label" for="defaultUnchecked<%=f.getCourseID()%>"><%=f.getCourseName()%></label>
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
                                            }
                                        %>
                                        <div class="form-group row">
                                            <div class="col-md-6" style="padding-left: 0;">
                                                <input type="button" name="Submit3" onclick="goback()" class="btn btn-primary btn-block" value="Zur&uuml;ck">
                                            </div>
                                            <div class="col-md-6" style="padding-left: 0;">
                                                <input type="submit" name="Submit" class="btn btn-primary btn-block" value="Weiter" disabled>
                                            </div>
                                        </div>
                                        <input type="hidden" name="sss" value="makeVertrag.jsp">
                                        <input type="hidden" name="location" value="<%=locationN%>">
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