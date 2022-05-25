<%@ page import="com.rheinlandprivatschule.model.Student" %>
<html>
<head>
    <title>Print Vertrag Bill</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <SCRIPT TYPE="text/javascript">
        function myOpen(){
            window.open("printIntegrationCostBill"); // params and stuff
            //window.open("printVertrag");
            window.location= document.form1.s.value;
        }
    </SCRIPT>
</head>


<body bgcolor="#FFFFFF" text="#000000" onLoad="myOpen()">
<%
    Student c=(Student)session.getAttribute("course");
    Student u=(Student)session.getAttribute("pstudent");
    session.setAttribute("pstudent",u);
    session.setAttribute("course",c);
    String li="integrationCosts?userid="+u.getUserID();

%>
<form name="form1" method="post" action="">
    <input type="hidden" name="s" value="<%=li%>">
</form>
</body>
</html>
