<%@ page import="java.util.Vector" %>
<html>
<head>
    <title>:: Remove Book ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%

    String ids= request.getParameter("bid");
    Vector v=(Vector)session.getAttribute("booktrag");
    int track=-1;
    for(int i=0;i<v.size();i++)
    {
        int temp=Integer.parseInt((String)v.elementAt(i));
        if(temp==Integer.parseInt(ids))
        {
            track=i;
        }
    }
    if(track>=0)
    {
        v.remove(track);
    }

    session.setAttribute("booktrag",v);
    response.sendRedirect("bookTra");
%>
</body>
</html>
