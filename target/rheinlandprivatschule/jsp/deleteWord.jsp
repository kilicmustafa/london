<html>
<head>
    <title>:: L&ouml;schen Wort ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<%@ page import="com.rheinlandprivatschule.repository.VocabulDao" %>

<body bgcolor="#FFFFFF" text="#000000">
<%

    VocabulDao vdb = (VocabulDao) request.getAttribute("vocabulDao");

    String lecidS=(String)request.getParameter("lecid");
    String wtrackS=(String)request.getParameter("wtrack");

    int lecID=Integer.parseInt(lecidS);
    int trackID=Integer.parseInt(wtrackS);
    if(vdb.deleteWord(lecID,trackID))
    {
        response.sendRedirect("lectureDetail.jsp?lecid="+lecID);
    }
    else
    {
        String err="Es konnte nicht gelöscht werden, noch einmal versuchen.";
        session.setAttribute("err",err);
        session.setAttribute("lin","lectureDetail?lecid="+lecID);
        response.sendRedirect("error");

    }
%>
</body>
</html>
