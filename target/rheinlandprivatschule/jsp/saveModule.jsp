<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <title>:: Save Module ::</title>
</head>

<body>
<%@ page import="java.util.*" %>
<%@ page import="com.rheinlandprivatschule.helper.contentmanager.ContentManager" %>
<%@ page import="com.rheinlandprivatschule.helper.contentmanager.ModuleManager" %>
<%@ page import="com.rheinlandprivatschule.repository.PreviligeManager" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>

<%@ page session="true" %>
<%
    ContentManager contentManager=new ContentManager();
    ModuleManager moduleManager=new ModuleManager();
    PreviligeManager pm=new PreviligeManager();
    ArrayList moduleList=new ArrayList();
    int userID=0;

    RPS rps=(RPS)session.getAttribute("handler");

    ServletContext app = request.getSession().getServletContext();
    String path = app.getRealPath("/resources/Activity.xml");
    java.io.File fil=new java.io.File(path);
    moduleManager=contentManager.getModuleManager(fil);

    String userid=(String)session.getAttribute("processuser");
    userID=Integer.parseInt(userid);

    String dis=request.getParameter("dis");
    if(dis==null){
        String list[] =request.getParameterValues("cb");
        if(list!=null)
        {
            for(int i=0;i<list.length;i++)
            {
                pm.allowCompleteModule(userID, list[i],moduleManager);
            }
        }
    }else{
        String moduleid=request.getParameter("moduleid");
        pm.disAllowCompleteModule(userID,moduleid,moduleManager);
    }
    response.sendRedirect("moduleSelection?userid="+userID);
%>
</body>
</html>
