<%@ page import="com.rheinlandprivatschule.helper.FileManage" %>
<html>
<head>
    <title>:: L&ouml;schen Datei ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <SCRIPT TYPE="text/javascript">
        function bo()
        {
            window.location="driveControler?folder="+document.form1.f.value+"&myPath="+document.form1.p.value;
        }
    </SCRIPT>
</head>
<%
    String fk="";
    String pk="";

    FileManage fm= (FileManage) request.getAttribute("fileManage");

    String path=(String)request.getParameter("pa");
    String cpath=(String)request.getParameter("myPath");
    String cfolder=(String)request.getParameter("folder");
    fk=cfolder;
    pk=cpath;
    java.io.File f=new java.io.File(path);
    f.delete();
%>
<body bgcolor="#FFFFFF" text="#000000" onLoad="bo()">
<form name="form1" method="post" action="">
    <input type="hidden" name="f" value="<%=fk%>">
    <input type="hidden" name="p" value="<%=pk%>">
</form>
</body>
</html>
