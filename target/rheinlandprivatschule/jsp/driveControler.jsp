<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.helper.FileManage" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Datei Hochladen  ::</title>
    <style>
        table tr {
            border-bottom: 1px solid white;
        }

        html {
            overflow-y: hidden;
        }

        table a {
            color: #0000EE;
            text-decoration: underline;
        }
    </style>
    <script>

        function ftp()
        {
            window.location="../unitutor/rps/admin/FTP Client/rpsftp.jar";
        }
        function leave1(msg,cid,uid,did)
        {
            if(!confirm(msg))
            {
                return false;
            }
            else
            {
                window.location="deleteFolder?pa="+cid+"&folder="+uid+"&myPath="+did;
            }
        }
        function leave(msg,cid,uid,did)
        {
            if(!confirm(msg))
            {
                return false;
            }
            else
            {
                window.location="deleteFile?pa="+cid+"&folder="+uid+"&myPath="+did;
            }
        }
        function up()
        {

        }
        function erst()
        {
            window.location="driveControler?folder=drives";
        }

        function myBack()
        {
            window.location="driveControler?folder="+document.form1.ofolder.value+"&myPath="+document.form1.opath.value;

        }

        function addfile()
        {
            document.form1.action = "attachVertrag?cmd=r";
            document.form1.submit();
        }
    </script>
</head>
<body>
<%
    FileManage fm= (FileManage) request.getAttribute("fileManage");
    Vector v=new Vector();
    String path="/opt/tomcat7/webapps/servlet/drive/";
    String display="";
    System.out.println("path => " + path);
    String currentFolder="";
    String currentPath="";

    String oldFolder="";
    String oldPath="";

    try{
        String fCMD=request.getParameter("folder");
        if(fCMD!=null){
            if(fCMD.equalsIgnoreCase("drives"))	{
                //path = application.getRealPath(request.getServletPath());
                //path=path.substring(0,path.lastIndexOf("driveControler")-1);
                path="/opt/tomcat7/webapps/servlet/drive/drives/";
                currentPath="/opt/tomcat7/webapps/servlet/drive";
                System.out.println("path 0 => " + path);

                int ix=path.indexOf("drives");
                System.out.println("path 1 => " + path);

                display=path.substring(ix,path.length());
                currentFolder=fCMD;
                System.out.println("path 2 => " + path);

                oldFolder=currentFolder;
                oldPath=currentPath;
                System.out.println("path 3 => " + path);

            }else{
                String cmdPath=(String)request.getParameter("myPath");
                path=cmdPath+"/"+fCMD;
                int ix=path.indexOf("drives");
                display=path.substring(ix,path.length());

                currentFolder=fCMD;
                currentPath=cmdPath;
                java.io.File fg=new java.io.File(path);
                String h=fg.getParent();
                oldFolder=h.substring(h.lastIndexOf("/")+1,h.length());
                oldPath=h.substring(0,h.lastIndexOf("/"));
            }
        }
        System.out.println("path 4 => " + path);
        //For Hochladen
        session.setAttribute("HmyPath",currentPath);
        session.setAttribute("Hfolder",currentFolder);
        System.out.println("path 5 => " + path);

        //Listing Files
        java.io.File f = new java.io.File(path);
        String[] temp=f.list();
        Arrays.sort(temp,String.CASE_INSENSITIVE_ORDER);
        for(int i=0;i<temp.length;i++){
            v.addElement(temp[i]);
            System.out.println("temp => " + temp[i]);
        }
    }catch(Exception e){
        System.out.println("Error: " + e.getMessage());
    }
%>
<div id="wrapper" class="wrapper" style="height: 100%;">
    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">
        <jsp:include page="templates/navbar.jsp"/>

        <!-- Main Content -->
        <div id="content">
            <!-- Begin Page Content -->
            <div class="container-fluid">

                <div class="wrapper" style="padding-left: 17.5%; padding-right: 17.5%;">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="wrapper" style="margin-bottom: 5px; float:right;">
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="ftp()">FTP Client</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="myBack()">Zur&uuml;ck</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="erst()">Erste Ordner</a>

                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <table width="101%" border="0" cellspacing="0" cellpadding="0" height="434">
                            <tr>
                                <td valign="top" height="488" bgcolor="D9E5F4" width="83%">
                                    <table width="100%" border="0" cellspacing="1" cellpadding="1" height="79">
                                        <tr>
                                            <td valign="top" colspan="5" height="30"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">
                                            </font>
                                                <div align="right"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">
                                                </font>
                                                    <form style="width: 100%;" name="form1" method="post" action="">
                                                        <input type="hidden" name="opath" value="<%=oldPath%>">
                                                        <input type="hidden" name="ofolder" value="<%=oldFolder%>">
                                                    </form>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top" bgcolor="657A9A" colspan="5" height="16">
                                                <p><font size="2"><b><font color="#FFFFFF">Ordener / Datei
                                                    ( <%=display%> ) </font></b></font></p>
                                            </td>
                                        </tr>
                                        <%
                                            for(int i=0;i<v.size();i++)
                                            {
                                                String ver=(String)v.elementAt(i);
                                                java.io.File tf = new java.io.File(path+"/"+ver);
                                                String tempo=path.substring(path.indexOf("drives"),path.length());
                                                if(tf.isDirectory())
                                                {

                                        %>
                                        <tr bgcolor="AEBACD">
                                            <td valign="top" height="15" width="68%"> <font size="2" color="#000033"><%=ver%></font>
                                            </td>
                                            <td valign="top" width="8%" height="15"><font size="2" color="#000033"><a href="driveControler?folder=<%=ver%>&myPath=<%=path%>">&Ouml;ffnen</a></font></td>
                                            <td valign="top" width="10%" height="15"><font size="2" color="#000033"><a href="#" onClick="leave1('Mchten Sie den Ordner Lschen?','<%=path+"/"+ver%>','<%=currentFolder%>','<%=currentPath%>');return false">L&ouml;schen</a></font></td>
                                            <td valign="top" width="14%" height="15"><font size="2" color="#000033"><a href="renameFolder?pa=<%=path+"/"+ver%>&folder=<%=currentFolder%>&myPath=<%=currentPath%>">Umbenennen</a></font></td>
                                        </tr>
                                        <%
                                        }
                                        else
                                        {
                                        %>
                                        <tr bgcolor="AEBACD">
                                            <td valign="top" height="15" width="68%"> <font size="2" color="#000033"><a href="/drive/drives?filePath=<%=tempo%>/<%=ver%>"><%=ver%></a></font>
                                            </td>
                                            <td valign="top" height="15" width="8%">&nbsp;</td>
                                            <td valign="top" height="15" width="10%"><font size="2" color="#000033"><a href="#" onClick="leave('Mchten Sie die Datei Lschen?','<%=path+"/"+ver%>','<%=currentFolder%>','<%=currentPath%>');return false">L&ouml;schen</a></font></td>
                                            <td valign="top" height="15" width="14%"><font size="2" color="#000033"><a href="renameFolder?pa=<%=path+"/"+ver%>&folder=<%=currentFolder%>&myPath=<%=currentPath%>">Umbenennen</a></font></td>
                                        </tr>
                                        <%
                                                }
                                            }
                                        %>
                                        <tr bgcolor="AEBACD">
                                            <td valign="top" height="15" colspan="4">
                                                <div align="center"><font size="2" color="#000033"><a href="newFolder?myPath=<%=path%>">Neue
                                                    Ordner</a></font> | <font size="2" color="#000033"><a  href="driveControler?folder=<%=currentFolder%>&myPath=<%=currentPath%>" onClick="window.open('upload?cmd=a','Hochladen','width=600,height=300,toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=no,copyhistory=yes,resizable=no')">Datei
                                                    Hochladen</a></font></div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="templates/footer.jsp"/>
<jsp:include page="templates/bodyimports.jsp"/>
</body>
</html>
