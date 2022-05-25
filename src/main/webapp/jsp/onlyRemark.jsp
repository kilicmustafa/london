<%@ page import="com.rheinlandprivatschule.repository.ResidentDao" %>
<%@ page import="com.rheinlandprivatschule.model.Resident" %>
<html>
<head>
    <title>:: Update Remarks ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%
    ResidentDao residentDB= (ResidentDao) request.getAttribute("residentDao");
    Resident u=(Resident)session.getAttribute("president");
    if(u==null)	{
        String err="Wählen Sie Mieter Zuerst aus";
        session.setAttribute("err",err);
        session.setAttribute("lin","residentsList");
        response.sendRedirect("error");
    }else{
        session.setAttribute("president",u);
        String remarks=(String)request.getParameter("textfield");
        u.setUserRemarks(remarks);
        if(residentDB.updateResidentRemark(u)==1){
            response.sendRedirect("mieterEntryDetails?residentid="+u.getResidenceID());
        }else{
            String err=residentDB.getError();
            session.setAttribute("err",err);
            session.setAttribute("lin","../map.jsp");
            response.sendRedirect("error");
        }
    }
%>
</body>
</html>
