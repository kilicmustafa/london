<%@ page import="com.rheinlandprivatschule.repository.StudentComplaintDao" %>
<%@ page import="com.rheinlandprivatschule.model.SystemUser" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Schulen ::</title>
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

    </script>
</head>
<body>
<%

    String status="0";
    String groupid="0";
    String userID="0";

    RPS rps=(RPS)session.getAttribute("handler");
    SystemUser u=rps.getLoginUser();
    try{
        status=(String)request.getParameter("status");
        groupid=(String)request.getParameter("wid");
        userID=(String)request.getParameter("userid");
        StudentComplaintDao sidb= (StudentComplaintDao) request.getAttribute("studentComplaintDao");

        if(sidb.setComplaintStatus(Integer.parseInt(groupid),Integer.parseInt(status))){
            response.sendRedirect("studentComplaintList?userid="+userID);
        }else{
            String err=sidb.getError();
            session.setAttribute("err",err);
            session.setAttribute("lin","studentComplaintList?userid="+userID);
            response.sendRedirect("error");

            //response.sendRedirect("messeStudentTelephoneFormInt.jsp?messeid="+messeid+"&studentID="+studentIDm);
        }
    }
    catch(Exception e){
        String err="Problem, noch einmal versuchen"+e.toString();
        session.setAttribute("err",err);
        session.setAttribute("lin","studentComplaintList?userid="+userID);
        response.sendRedirect("error");
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
                        <form name="form1" method="post" action="addEUnterrichtProcess.jsp" onSubmit="MM_validateForm('txtFee','','RisNum','strength','','RisNum','hours','','R');return document.MM_returnValue">
                            <table width="100%" border="0" height="127">
                                <tr>
                                    <td colspan="2" height="38">
                                        <div align="right"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">
                                        </font></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" height="82">&nbsp; </td>
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
