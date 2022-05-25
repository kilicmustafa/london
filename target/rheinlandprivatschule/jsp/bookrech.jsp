<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="com.rheinlandprivatschule.repository.BuchDao" %>
<%@ page import="com.rheinlandprivatschule.model.Buch" %>
<html>
<head>
    <title>Print Certificate</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <SCRIPT TYPE="text/javascript">
        function myOpen(){
            var link = "printBuchMull?rechID="+document.form1.id.value;
            window.open(link); // params and stuff
            window.location= document.form1.s.value;
        }
    </SCRIPT>
</head>
<%@ page session="true" %>
<body bgcolor="#FFFFFF" text="#000000" onLoad="myOpen()">
<%
    Student pstudent=(Student)session.getAttribute("pstudent");
    BuchDao bdb=new BuchDao();
    Buch book=new Buch();

    session.setAttribute("pstudent",pstudent);

    int buyertype=0;
    String id=(String)request.getParameter("rechID");
    book = bdb.getBookRech(Integer.parseInt(id), buyertype);
    session.setAttribute("ID",id);
    session.setAttribute("bookrec",book);
    String li="showStudentPreciseD?userid="+pstudent.getUserID();

%>
<form name="form1" method="post" action="">
    <input type="hidden" name="s" value="<%=li%>">
    <input type="hidden" name="id" value="<%=id%>">
</form>
</body>
</html>
