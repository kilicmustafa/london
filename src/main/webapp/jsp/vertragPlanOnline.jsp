<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.repository.StudentDao" %>
<%@ page import="com.rheinlandprivatschule.model.Place" %>
<%@ page import="com.rheinlandprivatschule.repository.CourseDao" %>
<%@ page import="com.rheinlandprivatschule.model.Course" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.model.CourseRegistration" %>
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
    Student u=(Student)session.getAttribute("pstudent");

    session.setAttribute("pstudent",u);

    int userid=u.getUserID();
    Vector vc=new Vector();
    Course c=new Course();
    CourseRegistration cr=new CourseRegistration();
    Vector myv=new Vector();
    vc=(Vector)session.getAttribute("planv");
    session.setAttribute("planv",vc);
    String selectS=(String)request.getParameter("radiobutton");
    String locationS=(String)request.getParameter("location");
    int selectN=0;
    int locN=0;
    int lasttrack=0;
    int finalchk=0;
    boolean bb=false;
    Course myCourse=new Course();
    locN=Integer.parseInt(locationS);
    try{
        if(selectS!=null){

            selectN=Integer.parseInt(selectS);
            for(int k=0;k<vc.size();k++){
                Course cc=(Course)vc.elementAt(k);
                if(cc.getCourseID()==selectN){
                    myCourse=cc;
                }
            }
            myv.addElement(myCourse);
            int track=myCourse.getCourseType()+1;
            while(track<=5){
                for(int h=0;h<vc.size();h++){
                    Course co=(Course)vc.elementAt(h);

                    if(co.getCourseType()==track && co.getCourseStartDate().after(myCourse.getCourseEndDate()))	{
                        myv.addElement(co);
                        myCourse=co;
                        break;
                    }
                }
                track++;
            }

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
                                    <h1 class="h4 text-gray-900 mb-4">Vertrag</h1>
                                </div>
                                <div class="container">
                                    <form class="user form-horizontal" id="onlineStudentForm" name="form2" method="post" action="/vertragFinal">
                                        <div class="row">
                                            <div class="col-md-6" style="padding-left: 0;">
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
                                            boolean mygh=true;
                                            for(int ii=0;ii<myv.size();ii++)
                                            {
                                                Course f=(Course)myv.elementAt(ii);
                                                if(mygh)
                                                {

                                        %>
                                        <div class="form-group row">
                                            <div class="col-md-6 custom-control custom-checkbox">
                                                <input type="checkbox" class="custom-control-input" id="defaultUnchecked<%=f.getCourseID()%>" name="checkbox" value="<%=f.getCourseID()%>" checked>
                                                <label class="custom-control-label" for="defaultUnchecked<%=f.getCourseID()%>"><%=f.getCourseName()%></label>
                                            </div>

                                            <div class="col-md-3">
                                                <label><%=MyDate.formateDate(f.getCourseStartDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></label>
                                            </div>
                                            <div class="col-md-3">
                                                <label><%=MyDate.formateDate(f.getCourseEndDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></label>
                                            </div>
                                        </div>
                                        <div class="row text-center lb-title">
                                            M&ouml;chten
                                            Sie die folgenden Stufen auch buchen?
                                        </div>
                                        <%
                                            mygh=false;
                                        }
                                        else
                                        {
                                        %>
                                        <div class="form-group row">
                                            <div class="col-md-6 custom-control custom-checkbox">
                                                <input type="checkbox" class="custom-control-input" id="defaultUnchecked<%=f.getCourseID()%>" name="checkbox" value="<%=f.getCourseID()%>">
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
                                                <input type="submit" name="Submit" class="btn btn-primary btn-block" value="Weiter">
                                            </div>
                                        </div>
                                        <input type="hidden" name="sss" value="makeVertrag.jsp">
                                        <input type="hidden" name="location" value="<%=locN%>">
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
