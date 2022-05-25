<%@ page import="com.rheinlandprivatschule.repository.MahnungDao" %>
<%@ page import="com.rheinlandprivatschule.model.MahnungElement" %>
<%@ page import="com.rheinlandprivatschule.model.Mahnung" %>
<html>
<head>
    <title>:: Print Mahnung ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <SCRIPT TYPE="text/javascript">
        function myOpen(){
            window.open("printMahnung"); // params and stuff
            window.location= document.form1.s.value;
        }
    </SCRIPT>
</head>

<body bgcolor="#FFFFFF" text="#000000" onLoad="myOpen()">
<%
    String cid=(String)request.getParameter("cid");
    String uid=(String)request.getParameter("uid");
    String li="";
    MahnungDao mdb= (MahnungDao) request.getAttribute("mahnungDao");
    int cidN=Integer.parseInt(cid);
    int uidN=Integer.parseInt(uid);
    MahnungElement e=mdb.getMahnung(cidN,uidN);
    Mahnung ma=mdb.getGedruckMahnung(cidN,uidN);
    session.setAttribute("mahnung",e);
    session.setAttribute("mahnid",ma);
    li="showStudentPreciseD?userid="+uidN;


%>
<form name="form1" method="post" action="">
    <input type="hidden" name="s" value="<%=li%>">
</form>
</body>
</html>
