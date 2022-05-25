<%@ page import="com.rheinlandprivatschule.model.Residence" %>
<html>
<head>
    <title>Print Vertrag Bill</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <SCRIPT TYPE="text/javascript">



            window.onload = function myOpen(){
                window.open("printRentInMain", "_blank"); // params and stuff
                //window.open("printVertrag.jsp");
                window.location= document.form1.s.value;
            }

    </SCRIPT>
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%
    Residence c=(Residence)session.getAttribute("presidence");
    session.setAttribute("presidence",c);
%>
<form name="form1" method="post" action="">
    <input type="hidden" name="s" value="mieterList">
</form>
</body>
</html>
