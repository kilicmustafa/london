<%@ page import="com.rheinlandprivatschule.model.Student" %>
<html>
<head>
    <title>Print Registration</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <SCRIPT TYPE="text/javascript">
        function myOpen(){
            window.open("printTeilnahmeW"); // params and stuff
            window.location= document.form1.s.value;
        }
    </SCRIPT>
</head>
<body bgcolor="#FFFFFF" text="#000000" onLoad="myOpen()">
<%
    Student u=(Student)session.getAttribute("pstudent");
    session.setAttribute("pstudent",u);
    String li="showStudentPreciseD?userid="+u.getUserID();

%>
<form name="form1" method="post" action="">
    <input type="hidden" name="s" value="<%=li%>">
</form>
</body>
</html>
