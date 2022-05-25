<%@ page import="com.rheinlandprivatschule.repository.StudentDao" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Mit welscher Stufe m&ouml;chten Sie Starten? ::</title>
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
        function goback(){
            window.history.back();
        }

        function first()
        {
            document.form1.Submit.disabled=false;
        }
        function leave(msg)
        {
            if(!confirm(msg)) return false
            else document.form2.submit()
        }

        function SubmitMyForm()
        {
            document.same.submit()
        }
    </script>
</head>
<body>
<%
    int userid=0;
    Student u=(Student)session.getAttribute("pstudent");
    StudentDao studentDB= (StudentDao) request.getAttribute("studentDao");

    if(u==null){
        String err="Wählen Sie Schüler Zuerst aus";
        session.setAttribute("err",err);
        session.setAttribute("lin","seacrhStudent");
        response.sendRedirect("error");
    }else{
        session.setAttribute("pstudent",u);
        userid=u.getUserID();
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width: 100%;" name="form1" method="post" action="makeVertrag">
                            <table width="100%" border="0" height="97" cellpadding="1" cellspacing="1">

                                <tr bgcolor="657A9A">
                                    <td colspan="3" height="19">
                                        <div align="center"><font size="2"><b><font color="#FFFFFF" size="3">Sind sie zur Zeit in Deutschland?</font></b></font></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="14" bgcolor="657A9A" width="8%">
                                        <input type="radio" name="rdLocation" value="1" onClick="first()">
                                    </td>
                                    <td height="14" bgcolor="AEBACD" valign="middle" width="92%" align="left"><font size="2" color="#000033">Ja</font></td>
                                </tr>
                                <tr>
                                    <td height="14" bgcolor="657A9A" width="8%">
                                        <input type="radio" name="rdLocation" value="2" onClick="first()">
                                    </td>
                                    <td height="14" bgcolor="AEBACD" valign="middle" width="92%" align="left"><font size="2" color="#000033">Nein</font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td colspan="3" height="18">&nbsp;</td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td colspan="3" height="18">
                                        <input class="btn btn-primary" type="submit" name="Submit" value="Weiter" disabled>
                                        <input class="btn btn-primary" type="button" name="Submit3" value="Zur&uuml;ck" onClick="goback()">
                                        <input type="hidden" name="sss" value="showStudentPreciseD?userid=<%=userid%>">
                                    </td>
                                </tr>
                            </table>
                        </form>
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
