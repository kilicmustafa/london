<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ page import="com.rheinlandprivatschule.repository.TransactionDao" %>
<%@ page import="com.rheinlandprivatschule.repository.StudentDao" %>
<%@ page import="com.rheinlandprivatschule.model.CourseRegistration" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<html>
<head>
    <title>:: Null Geb&uuml;hr ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">

<%
    int userid=0;
    StudentDao studentDB= (StudentDao) request.getAttribute("studentDao");
    TransactionDao transDB=new TransactionDao();
    CourseRegistration cr=new CourseRegistration();

    Student u=(Student)session.getAttribute("pstudent");
    RPS rps = (RPS) session.getAttribute("handler");
    if(u==null){
        String err="Wählen Sie Schüler Zuerst aus";
        session.setAttribute("err",err);
        session.setAttribute("lin","seacrhStudent");
        response.sendRedirect("error");
    }
    session.setAttribute("pstudent",u);
    userid=u.getUserID();


    String courseids=(String)request.getParameter("cid");
    String txtBal=(String)request.getParameter("bal");
    String paytype=(String)request.getParameter("paytype");
    double paid= MyCurrency.getDoubleValue(txtBal);

    int courseID=0;
    try{
        courseID=Integer.parseInt(courseids);
    }catch(Exception e){
    }
    if(courseID!=0){
        boolean success=studentDB.makeBalanceNull(courseID,u.getUserID());
        int tranno=studentDB.addNullGebuhr(paid,0,u.getUserID(),courseID,rps.getLoginPlace().getPlaceID(),rps.getLoginUser().getUserID());
        if(success){
            response.sendRedirect("showStudentPreciseD?userid="+u.getUserID());
        }else{
            String err=studentDB.getError();
            session.setAttribute("err",err);
            session.setAttribute("lin","showStudentPreciseD?userid="+userid);
            response.sendRedirect("error");
        }

    }else{
        String err="Gebühr kann nicht Null werden";
        session.setAttribute("err",err);
        session.setAttribute("lin","showStudentPreciseD?userid="+userid);
        response.sendRedirect("error");
    }
%>
</BODY>
</HTML>
