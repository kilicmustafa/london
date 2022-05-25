<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <title>:: Save Activity ::</title>
</head>
<%@ page import="java.util.*" %>
<%@ page import="com.rheinlandprivatschule.helper.contentmanager.ContentManager" %>
<%@ page import="com.rheinlandprivatschule.repository.PreviligeManager" %>
<%@ page import="com.rheinlandprivatschule.helper.contentmanager.ModuleManager" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>

<%@ page session="true" %>
<%
    ContentManager contentManager=new ContentManager();
    PreviligeManager pm=new PreviligeManager();
    ModuleManager moduleManager=new ModuleManager();
    ArrayList ActivityList=new ArrayList();
    int userID=0;
    RPS rps= (RPS) session.getAttribute("handler");

    String userid=(String)session.getAttribute("processuser");
    userID=Integer.parseInt(userid);

    ServletContext app = request.getSession().getServletContext();
    String path = app.getRealPath("/resources/Activity.xml");
    java.io.File fil=new java.io.File(path);
    moduleManager=contentManager.getModuleManager(fil);

    String dis=(String)request.getParameter("dis");
    if(dis==null){
        String list[] =request.getParameterValues("cb");
        String only=(String)request.getParameter("only");
        if(list!=null)
        {
            for(int i=0;i<list.length;i++)
            {
                if(only==null){
                    pm.allowCompleteActivity(userID,(String)list[i],moduleManager);
                }else{
                    pm.addPrivilageToSystemUser(userID,(String)list[i]);
                }

            }
        }
    }else{
        String activityid=request.getParameter("activityid");
        pm.disAllowCompleteActivity(userID,activityid,moduleManager);
    }

    response.sendRedirect("moduleSelection?userid="+userID);
%>
<body>

</body>
</html>
