<%@ page import="com.rheinlandprivatschule.model.Course" %>
<html>
<head>
    <title>Print Registration</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <SCRIPT TYPE="text/javascript">
        window.onload = function() {
            window.open("printFirstRegistration"); // params and stuff
            window.location= document.form1.s.value;
        };
    </SCRIPT>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<%
    Course u=(Course)session.getAttribute("pcourse");
    session.setAttribute("pcourse",u);
    String li="integration?courseid="+u.getCourseID();

%>
<form name="form1" method="post" action="">
    <input type="hidden" name="s" value="<%=li%>">
</form>
</body>
</html>
