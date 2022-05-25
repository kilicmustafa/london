<html>
<head>
    <title>Senden Mahnung</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <SCRIPT TYPE="text/javascript">
        function myOpen(){
            window.location= document.form1.s.value;
        }
    </SCRIPT>
</head>
<%@ page import="com.rheinlandprivatschule.repository.MahnungDao" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page session="true" %>

<body bgcolor="#FFFFFF" text="#000000" onLoad="myOpen()">
<%
    String cid=(String)request.getParameter("cid");
    String uid=(String)request.getParameter("uid");
    String li="";

    MahnungDao mdb = (MahnungDao) request.getAttribute("mdb");
    RPS rps = (RPS) request.getSession().getAttribute("handler");
    int cidN=Integer.parseInt(cid);
    int uidN=Integer.parseInt(uid);
    if(!mdb.sendMahung(cidN,uidN,rps.getLoginUser().getUserID())){
        String err=mdb.getError();
        session.setAttribute("err",err);
        session.setAttribute("lin","../map.jsp");
        response.sendRedirect("/error");
    }
    li="mahnunglist";
%>
<form name="form1" method="post" action="">
    <input type="hidden" name="s" value="<%=li%>">
</form>
</body>
</html>
