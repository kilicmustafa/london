<%@ page import="com.rheinlandprivatschule.repository.ResidentDao" %>
<%@ page import="com.rheinlandprivatschule.model.Resident" %>
<%@ page import="com.rheinlandprivatschule.repository.StudentDao" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Sch&uuml;ler Information ::</title>
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
        function back()
        {
            window.location="newResidentForm";
        }

        function updateR(msg)
        {
            if(!confirm(msg)) return false;
            else window.location="studentSearch?cmd=u&studentid="+document.form1.studentid.value;
        }
        function leave(msg,cod)
        {
            if(!confirm(msg))
            {
                return false
            }
            else
            {
                //process
                window.location="abmelding?courseid="+cod
                return false
            }
        }
    </script>
</head>
<body>
<%
    ResidentDao residentDB = (ResidentDao) request.getAttribute("residentDao");
    StudentDao studentDB = (StudentDao) request.getAttribute("studentDao");
    Resident resident = new Resident();
    Student student = new Student();
    int residentid=0;

    String valueS=(String)request.getParameter("cmd");
    try{
        if(valueS.equalsIgnoreCase("u")){
            int sid=Integer.parseInt((String)request.getParameter("studentid"));
            int result = residentDB.updateStudentToResident(sid);
            if(result>0){
                response.sendRedirect("residentsList");
            }else{
                String err=residentDB.getError();
                session.setAttribute("err",err);
                session.setAttribute("lin","../map");
                response.sendRedirect("error");
            }

        }else{
            int sid=Integer.parseInt((String)request.getParameter("studentid"));
            student=studentDB.getStudentForSubProcess(sid);
        }
    }catch(Exception e){
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="back()">Zur&uuml;ck</a>

                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <table width="100%" height="435" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td valign="top" height="146" bgcolor="D9E5F4" width="81%">
                                    <table width="100%" height="343" border="0" cellpadding="1" cellspacing="1">
                                        <tr>
                                            <td height="21" colspan="3" bgcolor="657A9A">
                                                <div align="center"><b><font size="3" color="#FFFFFF">Mieter
                                                    Information</font></b></div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="15%" height="17" bgcolor="657A9A">
                                                <div align="center"><b><font size="2" color="#FFFFFF">Sch&uuml;ler
                                                    Nr.</font></b></div>
                                            </td>
                                            <td width="43%" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Vorname</font></b></td>
                                            <td width="42%" bgcolor="657A9A">
                                                <div align="left"><b><font size="2" color="#FFFFFF">Nachname</font></b></div></td>
                                        </tr>
                                        <tr>
                                            <td width="15%" height="20" bgcolor="AEBACD"><font size="2" color="#000033"><%=student.getUserID()%></font></td>
                                            <td width="43%" bgcolor="AEBACD"><font size="2" color="#000033"><%=student.getUserFirstName()%></font></td>
                                            <td bgcolor="AEBACD"><font size="2" color="#000033"><%=student.getUserLastName()%></font></td>
                                        </tr>
                                        <tr>
                                            <td height="26" colspan="3" bgcolor="AEBACD">
                                                <form style="width: 100%;" name="form1" method="post" action="">
                                                    <input class="btn btn-primary" type="submit" name="Submit" value="&Uuml;bertragen" onClick="updateR('Wollen Sie der Sch&uuml;ler als Mieter &uuml;bertragen?');return false">
                                                    <input name="studentid" type="hidden" id="studentid" value="<%=student.getUserID()%>">
                                                </form>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">&nbsp;</td>
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
