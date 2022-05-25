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
        
        .form-control {
            color: black;
            border: 2px solid black;
        }
        
        .p-0 {
            border: 5px solid black; 
        }

        .custom-select {
            border: 2px solid black;
        }

        .lb-title {
            font-weight: bold;
            font-size: 18px;
            color: #4e73df;
        }
    </style>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script>
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

        function MM_findObj(n, d) { //v4.01
            var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
                d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
            if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
            for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
            if(!x && d.getElementById) x=d.getElementById(n); return x;
        }
    </script>
</head>
<%
    StudentDao cryDB= (StudentDao) request.getAttribute("studentDao");
    RPS rps=(RPS)session.getAttribute("handler");
    if(rps==null){
        rps=new RPS();
    }
    session.setAttribute("handler",rps);

    Vector placeV=(new PlaceDao()).getAllPlaces();


    String firstname="";
    String lastname="";
    String birthday="1";
    String birthmonth="Janaury";
    String birthyear="1980";
    String usergender="1";
    String birthplace="";
    String nationality="";
    String co="";
    String address="";
    String postcode="";
    String city="";
    String country="";
    String homeno="";
    String mobileno="";
    String faxno="";
    String email="";
    int nationality1=0;

    ArrayList<Country> cry =cryDB.getAllCountries();
    Student u=(Student)session.getAttribute("newstudent");
    if(u!=null)	{

        firstname=u.getUserFirstName();
        lastname=u.getUserLastName();

        birthday= MyDate.getDay(u.getUserBirthDate());
        birthmonth=MyDate.getMonth(u.getUserBirthDate());
        birthyear=MyDate.getYear(u.getUserBirthDate());

        usergender=u.getUserGender()+"";
        birthplace=u.getUserBirthPlace();

        nationality=u.getUserNationality();
        co=u.getUserCO();
        address=u.getUserAddress();
        postcode=u.getUserPostCode();
        city=u.getUserCity();
        country=u.getUserCountry();
        homeno=u.getUserHomePhone();
        mobileno=u.getUserMobilePhone();
        faxno=u.getUserFax();
        email=u.getUserEmail();
    }else{
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
                            <div class="p-4">
                                <div class="text-center">
                                    <img style="margin-bottom: 5%;" src="https://unitutor.de/wp-content/uploads/2020/03/cropped-Rp-LOGO-13-1024x151-2-830x122-1.png" width="50%">
                                    <h1 class="h4 text-gray-900 mb-4">Persönliche Informationen</h1>
                                </div>
                                <div class="container">
                                    <form class="user form-horizontal" id="onlineStudentForm" action="/registerOnlineStudent" method="post" onSubmit="MM_validateForm('txtFirstName','','R','txtLastName','','R','txtBirthPlace','','R','txtNationality','','R','txtAddress','','R','txtPostCode','','R','txtCity','','R','txtCountry','','R','txtEmail','','NisEmail');return document.MM_returnValue">
                                        <div class="form-group row">
                                            <div class="col-sm-3 m-auto">
                                                <label>*Vorname</label>
                                            </div>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" name="txtFirstName"
                                                       aria-describedby="usernameHelp" placeholder="*Vorname..." value=<%=firstname%>>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-sm-3 m-auto">
                                                <label>*Nachname</label>
                                            </div>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" name="txtLastName"
                                                       aria-describedby="usernameHelp" placeholder="*Nachname..." value=<%=lastname%>>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-sm-3 m-auto">
                                                <label>Geburtsdatum</label>
                                            </div>
                                            <div class="col-sm-9">
                                                <select name="selDay" class="custom-select w-auto">
                                                    <%
                                                        for(int i=1;i<32;i++)
                                                        {
                                                            if(i==Integer.parseInt(birthday))
                                                            {
                                                    %>
                                                    <option selected><%=i%></option>
                                                    <%
                                                    }
                                                    else
                                                    {
                                                    %>
                                                    <option><%=i%></option>
                                                    <%
                                                            }
                                                        }
                                                    %>
                                                </select>
                                                <select name="selMonth" class="custom-select w-auto">
                                                    <%
                                                        Vector vtemp=new Vector();
                                                        vtemp.addElement("Januar");
                                                        vtemp.addElement("Februar");
                                                        vtemp.addElement("März");
                                                        vtemp.addElement("April");
                                                        vtemp.addElement("Mai");
                                                        vtemp.addElement("Juni");
                                                        vtemp.addElement("Juli");
                                                        vtemp.addElement("August");
                                                        vtemp.addElement("September");
                                                        vtemp.addElement("Oktober");
                                                        vtemp.addElement("November");
                                                        vtemp.addElement("Dezember");
                                                        for(int ii=0;ii<vtemp.size();ii++)
                                                        {
                                                            String temps=(String)vtemp.elementAt(ii);
                                                            if(temps.equalsIgnoreCase(birthmonth))
                                                            {
                                                    %>
                                                    <option selected><%=temps%></option>
                                                    <%
                                                    }
                                                    else
                                                    {
                                                    %>
                                                    <option><%=temps%></option>
                                                    <%
                                                            }
                                                        }
                                                    %>
                                                </select>
                                                <select name="selYear" class="custom-select w-auto">
                                                    <%
                                                        for(int iii=1950;iii<2030;iii++)
                                                        {
                                                            if(iii==Integer.parseInt(birthyear))
                                                            {
                                                    %>
                                                    <option selected><%=iii%></option>
                                                    <%
                                                    }
                                                    else
                                                    {
                                                    %>
                                                    <option><%=iii%></option>
                                                    <%
                                                            }
                                                        }
                                                    %>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-sm-3 m-auto">
                                                <label>Geburtsort</label>
                                            </div>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" name="txtBirthPlace"
                                                       aria-describedby="usernameHelp" placeholder="Geburtsort..." value="<%=birthplace%>">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-sm-3 m-auto">
                                                <label>*Geschlecht</label>
                                            </div>
                                            <div class="col-sm-9">
                                                m&auml;nnlich
                                                <%
                                                    if(usergender.equalsIgnoreCase("1")){
                                                %>
                                                <input type="radio" name="rdGender" value="1" checked>
                                                weiblich
                                                <input type="radio" name="rdGender" value="0">
                                                <%
                                                }else{
                                                %>
                                                <input type="radio" name="rdGender" value="1">
                                                weiblich
                                                <input type="radio" name="rdGender" value="0" checked>
                                                <%
                                                    }
                                                %>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-sm-3 m-auto">
                                                <label>*Nationalit&auml;t</label>
                                            </div>
                                            <div class="col-sm-9">
                                                <select class="custom-select" name="txtNationality">
                                                <option value="0" selected>w&auml;hlen</option>
                                                <%
                                                    for(int g=0;g<cry.size();g++)
                                                    {
                                                        Country uc=(Country)cry.get(g);
                                                        if(uc.getUserCountryID()== nationality1)
                                                        {
                                                %>
                                                <option value="<%=uc.getUserCountryID()%>" selected><%=uc.getUserCountryName()%></option>
                                                <%
                                                }
                                                else
                                                {
                                                %>
                                                <option value="<%=uc.getUserCountryID()%>"><%=uc.getUserCountryName()%></option>
                                                <%
                                                        }
                                                    }
                                                %>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-sm-3 m-auto">
                                                <label>C/O</label>
                                            </div>
                                            <div class="col-sm-9">
                                                <input class="form-control" name="txtCO" type="text" id="txtCO" value="<%=co%>">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-sm-3 m-auto">
                                                <label>*Adresse</label>
                                            </div>
                                            <div class="col-sm-9">
                                                <input class="form-control" type="text" name="txtAddress" value="<%=address%>">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-sm-3 m-auto">
                                                <label>*PLZ</label>
                                            </div>
                                            <div class="col-sm-9">
                                                <input class="form-control" type="text" name="txtPostCode" value="<%=postcode%>">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-sm-3 m-auto">
                                                <label>*Stadt</label>
                                            </div>
                                            <div class="col-sm-9">
                                                <input class="form-control" type="text" name="txtCity" value="<%=city%>">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-sm-3 m-auto">
                                                <label>*Land</label>
                                            </div>
                                            <div class="col-sm-9">
                                                <input class="form-control" type="text" name="txtCountry" value="<%=country%>">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-sm-3 m-auto">
                                                <label>Handy Nr</label>
                                            </div>
                                            <div class="col-sm-9">
                                                <input class="form-control" type="text" name="txtMobileNo" value="<%=mobileno%>">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-sm-3 m-auto">
                                                <label>E-mail</label>
                                            </div>
                                            <div class="col-sm-9">
                                                <input class="form-control" name="txtEmail" value="<%=email%>">
                                            </div>
                                        </div>
                                        <div style="color: black;" class="row">
                                            <div class="col-md-12 lb-title">In welcher Schule m&ouml;chten Sie studieren?</div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-sm-3 m-auto">
                                                <label>Stadt</label>
                                            </div>
                                            <div class="col-sm-9">
                                                <select class="custom-select" name="selpla">
                                                    <%
                                                        for(int q=0;q<placeV.size();q++)
                                                        {
                                                            Place pla=(Place)placeV.elementAt(q);
                                                    %>
                                                    <option value="<%=pla.getPlaceID()%>"><%=pla.getPlaceName()%></option>
                                                    <%
                                                        }
                                                    %>
                                                </select>
                                            </div>
                                        </div>
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <input type="submit" class="btn btn-primary btn-block" value="Weiter">
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
