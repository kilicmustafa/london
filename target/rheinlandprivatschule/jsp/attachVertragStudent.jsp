<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Vertrag Hochladen ::</title>
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
        function le(msg,ver)
        {
            if(!confirm(msg))
            {
                return false;
            }
            else
            {
                window.location="deleteVertrag?cmd="+ver;
            }
        }
        function haupt()
        {
            window.location="/courses/courseReportDetail?courseid="+document.form2.hd.value;
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
    Student student=(Student)session.getAttribute("pstudent");

    int userid= student.getUserID();
    String stname= student.getUserFirstName()+" "+student.getUserLastName();
    ArrayList vertrags= (ArrayList) request.getAttribute("vertrags");
    int track=1;

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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <table width="101%" border="0" cellspacing="0" cellpadding="0" height="434">
                            <tr>
                                <td valign="top" height="488" bgcolor="D9E5F4" width="83%">                <table width="100%" border="0" cellspacing="1" cellpadding="1" height="160">

                                    <tr>
                                        <td colspan="3" valign="top" bgcolor="657A9A"><font color="#FFFFFF">W&auml;hlen Sie eine Vertrag aus :</font></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" valign="top" bgcolor="AEBACD"><form name="form1" method="post" action="" enctype="multipart/form-data">
                                            <input type="file" name="fileName" size="30">
                                        </form>
                                            <div align="right"> </div>
                                            <div align="center"> </div>
                                            <div align="center"> </div>
                                            <div align="center"> </div>
                                            <div align="center"> </div></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" valign="top" bgcolor="AEBACD"><input type="button" name="attach" value="Hochladen" onClick="addfile()">
                                            <form name="form2" method="post" action="">
                                                <input type="hidden" name="hd" value="<%=userid%>">
                                            </form></td>
                                    </tr>
                                    <tr>
                                        <td width="10%" height="16" valign="top" bgcolor="657A9A"><p><font size="2"><b><font color="#FFFFFF">Schuler/in</font></b></font></p></td>
                                        <td valign="top" bgcolor="AEBACD" height="16" colspan="2"><font size="2" color="#000033"><%=stname%></font></td>
                                    </tr>
                                    <%
                                        Iterator vertragsIT=vertrags.iterator();
                                        while(vertragsIT.hasNext()){
                                            String ver=(String)vertragsIT.next();
                                    %>
                                    <tr bgcolor="AEBACD">
                                        <td valign="top" height="20"><font size="2" color="#000033"><%=track%></font> </td>
                                        <td width="73%" height="20" valign="top"><font size="2" color="#000033"><a href="vertrag?userId=<%=userid%>&ver=<%=ver%>"><%=ver%></a></font></td>
                                        <td colspan="2"><img src="<%=userid%>/<%=ver%>"<%=ver%> width="150" height="100"></td>
                                        <td width="17%" height="20" valign="top"><font size="2" color="#000033"><a href="deleteVertrag?cmd=<%=ver%>"> L&ouml;schen</a></font></td>
                                    </tr>
                                    <%
                                            track++;
                                        }
                                    %>
                                </table></td>
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
