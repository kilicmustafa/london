<html>
<head>
    <title>Print Bill</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <SCRIPT TYPE="text/javascript">
        function myOpen(){
            window.open("printMahnung"); // params and stuff
            window.location= document.form1.s.value;
        }
    </SCRIPT>
</head>
<%@ page import="java.util.*" %>
<%@ page import="com.rheinlandprivatschule.repository.MahnungDao" %>
<%@ page import="com.rheinlandprivatschule.model.MahnungElement" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page session="true" %>

<body bgcolor="#FFFFFF" text="#000000" onLoad="myOpen()">
<%
    Vector image=new Vector();
    String cid=(String)request.getParameter("cid");
    String uid=(String)request.getParameter("uid");
    String li="";
    RPS rps = (RPS) request.getSession().getAttribute("handler");
    MahnungDao mdb= (MahnungDao) request.getAttribute("mdb");
    int cidN=Integer.parseInt(cid);
    int uidN=Integer.parseInt(uid);
    MahnungElement e=mdb.getMahnung(cidN,uidN);
    int myid=mdb.addMahnung(cidN,uidN,rps.getLoginUser().getUserID(),e.getBalance());
    if(myid<=0){
        String err=mdb.getError();
        session.setAttribute("err",err);
        session.setAttribute("lin","../map.jsp");
        response.sendRedirect("/error");
    }else{
        session.setAttribute("mahnung", e);
        session.setAttribute("mahnid",""+myid);
        li="mahnunglist";
    }
%>
<form name="form1" method="post" action="">
    <input type="hidden" name="s" value="<%=li%>">
</form>
</body>
</html>
