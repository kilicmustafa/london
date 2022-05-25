<%@ page import="com.rheinlandprivatschule.repository.VocabulDao" %>
<html>
<head>
    <title>:: Update Sprach ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>


<body bgcolor="#FFFFFF" text="#000000">
<%
    VocabulDao vdb= (VocabulDao) request.getAttribute("vocabulDao");
    String name=(String)request.getParameter("txtName");
    String sprid=(String)request.getParameter("sp");
    int myid=Integer.parseInt(sprid);

    if(vdb.updateSprach(myid,name)){
        response.sendRedirect("sprach");
    }else{
        String err="Sprache kann nicht hinzugefügt werden. Noch einmal versuchen.";
        session.setAttribute("err",err);
        session.setAttribute("lin","sprach");
        response.sendRedirect("error");
    }
%>
</body>
</html>
