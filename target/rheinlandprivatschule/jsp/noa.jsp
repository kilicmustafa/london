<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ page import="com.rheinlandprivatschule.repository.StudentDao" %>
<html>
<head>
    <title>Print Registration</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <SCRIPT TYPE="text/javascript">
        window.onload = function() {
            window.open("printRegistration"); // params and stuff
            window.location= document.form1.s.value;
        };
    </SCRIPT>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<%
    Student u=(Student)session.getAttribute("pstudent");
    RPS rps=(RPS)session.getAttribute("handler");
    StudentDao studentDB= (StudentDao) request.getAttribute("studentDao");
    String courseids=(String)request.getParameter("cid");
    String txtBal=(String)request.getParameter("bal");
    double paid= MyCurrency.getDoubleValue(txtBal);
    int courseID=0;

    courseID=Integer.parseInt(courseids);

    int tranno=studentDB.addPrintRegRecord(paid,0,u.getUserID(),courseID,rps.getLoginPlace().getPlaceID(),rps.getLoginUser().getUserID());
    session.setAttribute("pstudent",u);
    String li="showStudentPreciseD?userid="+u.getUserID();

%>
<form name="form1" method="post" action="">
    <input type="hidden" name="s" value="<%=li%>">
</form>
</body>
</html>
