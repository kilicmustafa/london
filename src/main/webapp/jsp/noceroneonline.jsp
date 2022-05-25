<html>
<head>
    <title>Print Certificate</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <SCRIPT TYPE="text/javascript">
        function myOpen(){
            window.open("printCertificateForOnline"); // params and stuff
            window.location= document.form1.s.value;
        }
    </SCRIPT>
</head>
<%@ page import="com.rheinlandprivatschule.repository.CertificateDao" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="com.rheinlandprivatschule.model.Certificate" %>
<body bgcolor="#FFFFFF" text="#000000" onLoad="myOpen()">
<%
    Student pstudent=(Student) session.getAttribute("pstudent");

    String id=(String)request.getParameter("zerid");
    CertificateDao cdb=new CertificateDao();
    Certificate c=cdb.getCertificate(Integer.parseInt(id));
    session.setAttribute("certificate",c);
    String li="showStudentPreciseD?userid="+pstudent.getUserID();

%>
<form name="form1" method="post" action="">
    <input type="hidden" name="s" value="<%=li%>">
</form>
</body>
</html>
