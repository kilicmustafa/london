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
<%@ page import="java.util.*" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="com.rheinlandprivatschule.model.SystemUser" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.model.Certificate" %>
<%@ page import="com.rheinlandprivatschule.repository.CertificateDao" %>
<body bgcolor="#FFFFFF" text="#000000" onLoad="myOpen()">
<%
    String li="";
    RPS rps=(RPS)session.getAttribute("handler");
    Student u=(Student)session.getAttribute("pstudent");
    SystemUser loginuser=rps.getLoginUser();
    loginuser=rps.getLoginUser();
    CertificateDao cdb=new CertificateDao();
    if(rps==null){
        String err="Sitzung lief Ab";
        session.setAttribute("err",err);
        session.setAttribute("lin","../index");
        response.sendRedirect("error");
    }else{
        double hvT=Double.parseDouble((String)request.getParameter("hvT"));
        double tpT=Double.parseDouble((String)request.getParameter("tpT"));
        double lvT=Double.parseDouble((String)request.getParameter("lvT"));
        double wsT=Double.parseDouble((String)request.getParameter("wsT"));
        double mpT=Double.parseDouble((String)request.getParameter("mpT"));
        double fsT=Double.parseDouble((String)request.getParameter("fsT"));
        double ndgT= MyCurrency.getDoubleValue((String)request.getParameter("ndgT"));
        System.out.println(request.getParameter("ndgT") + "  "  + String.valueOf(ndgT));
        String courseid=(String)request.getParameter("courseid");
        if(ndgT<60){
            String err="Es ist nicht möglich, Note ist nicht Gut";
            session.setAttribute("err",err);
            session.setAttribute("lin","showStudentPreciseD?userid="+u.getUserID());
            response.sendRedirect("error");
        }
        else{
            int chk=cdb.addCertificate(u.getUserID(),Integer.parseInt(courseid),hvT,tpT,lvT,wsT,mpT,fsT,ndgT, MyDate.getCurrentSQLDate(),loginuser.getUserID());
            cdb.addOnlineCertificateRecord(chk);
            Certificate c=cdb.getCertificate(chk);
            session.setAttribute("certificate",c);
            li="showStudentPreciseD?userid="+u.getUserID();
        }
    }
%>
<form name="form1" method="post" action="">
    <input type="hidden" name="s" value="<%=li%>">
</form>
</body>
</html>
