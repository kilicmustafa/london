<html>
<head>
    <title>Unklar</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <SCRIPT TYPE="text/javascript">
        function myOpen(){
            // params and stuff
            window.location= document.form1.s.value;
        }
    </SCRIPT>
</head>
<%@ page import="java.util.*" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="com.rheinlandprivatschule.repository.MahnungDao" %>
<%@ page session="true" %>

<body bgcolor="#FFFFFF" text="#000000" onLoad="myOpen()">
<%
    String cid=(String)request.getParameter("cid");
    String uid=(String)request.getParameter("uid");
    String catid=(String)request.getParameter("select");
    String li="";
    RPS rps=(RPS)session.getAttribute("handler");
    MahnungDao mdb= (MahnungDao) request.getAttribute("mdb");
    int cidN=Integer.parseInt(cid);
    int uidN=Integer.parseInt(uid);
    int catidN=Integer.parseInt(catid);

    if(mdb.unklarMahnung(cidN,uidN,catidN,rps.getLoginUser().getUserID())){
        li="mahnunglist";
    }else{
        String err=mdb.getError();
        session.setAttribute("err",err);
        session.setAttribute("lin","../map.jsp");
        response.sendRedirect("/error");
    }
%>
<form name="form1" method="post" action="unklar">
    <input type="hidden" name="s" value="<%=li%>">
</form>
</body>
</html>
