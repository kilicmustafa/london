<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.repository.IntegrationCostDao" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <title>Untitled Document</title>
</head>

<body>
<%

    IntegrationCostDao XtraCostDB=new IntegrationCostDao();

    String costidS= request.getParameter("costid");
    int costid=0;
    try{
        costid=Integer.parseInt(costidS);
    }catch(Exception e){
    }
    Vector v=XtraCostDB.getXtraTran(costid);

    if(v!=null){
        session.setAttribute("specifictr",v);
        response.sendRedirect("showIntegrationCostTran?costid="+costid);
    }else{
        String err=XtraCostDB.getError();
        session.setAttribute("err",err);
        session.setAttribute("lin","../map");
        response.sendRedirect("error");
    }
%>

</body>
</html>
