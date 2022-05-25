<%@ page import="com.rheinlandprivatschule.model.SystemUser" %>
<%@ page import="com.rheinlandprivatschule.repository.*" %>
<html>
<head>
    <title>:: Verify User ::</title>

    <SCRIPT TYPE="text/javascript">

        function display(){
            if(document.form1.anmel.value==="true"){
                if(!confirm(
                        document.form1.dis.value))
                    return window.location="/index";
                else window.location="/stundenplan/addHoursSchedule";
            }
            else{
                window.alert(document.form1.dis.value);
                window.location="/index";
            }
        }

        window.onload = display;
    </SCRIPT>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

</head>

<%
    String city="1";
    boolean anm=true;
    LoginDao logindb = (LoginDao) request.getAttribute("loginDao");
    SystemUserDao sdb = (SystemUserDao) request.getAttribute("sdb");

    RPS rps = (RPS) session.getAttribute("handler");

    SystemUser u = rps.getLoginUser();

    EmployeeHours b=sdb.getEmployeeHoursExist(u.getUserID());
    EmployeeHours pause=sdb.getEmployeeBreakReg(u.getUserID());
    SystemUser tea=sdb.getEmployeeForVerificaiton(u.getUserID(),2,4,3);
    String yes ="yes";
    String display="";
    if(b.getUserID()>0)
    {
        if(pause.getDay().equals(yes)){
            display="Ihre letzte Anmeldezeit ist a"+logindb.getLoginDate()+" "+logindb.getLoginTime()+" Möchten Sie Anmelden?";
            anm=true;
        }else {
            display="Ihre letzte Anmeldezeit ist b"+logindb.getLoginDate()+" "+logindb.getLoginTime();
            anm=false;
        }

    }
    else if(b.getUserID()==0) {
        if(tea.getUserID()==0) {
            if(pause.getDay().equals("yes")){
                display="Ihre letzte Anmeldezeit ist c"+logindb.getLoginDate()+" "+logindb.getLoginTime()+" Möchten Sie Anmelden?";
            }else {
                display="Ihre letzte Anmeldezeit ist d"+logindb.getLoginDate()+" "+logindb.getLoginTime();
            }

            anm=false;
        }
        else {
            display="Ihre letzte Anmeldezeit ist e"+logindb.getLoginDate()+" "+logindb.getLoginTime()+" Möchten Sie Anmelden?";
            anm=true;

        }
    }
%>
<body bgcolor="#FFFFFF" text="#000000">
<form name="form1" method="post" action="">
    <input type="hidden" name="dis" value="<%=display%>">
    <input type="hidden" name="something" value="<%=b.getUserID()%>">
    <input type="hidden" name="anmel" value="<%=anm%>">
</form>
</body>
</html>
