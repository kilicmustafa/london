<html>
<head>
    <title>Senden Mahnung</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <SCRIPT TYPE="text/javascript">
    </SCRIPT>
</head>
<%@ page import="java.util.*" %>
<%@ page import="com.rheinlandprivatschule.repository.MahnungDao" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>

<%@ page session="true" %>

<body bgcolor="#FFFFFF" text="#000000">
<%
    String cid= request.getParameter("courseid");
    String uid= request.getParameter("userid");

    RPS rps=(RPS)session.getAttribute("handler");

    MahnungDao mdb= (MahnungDao) request.getAttribute("mdb");
    int cidN=Integer.parseInt(cid);
    int uidN=Integer.parseInt(uid);
    if(mdb.sendImKaso(uidN,cidN,rps.getLoginUser().getUserID())){
        response.sendRedirect("versendlist");
    }else{
        String err=mdb.getError();
        session.setAttribute("err",err);
        session.setAttribute("lin","../map.jsp");
        response.sendRedirect("/error");
    }
%>
</body>
</html>
