<html>
<head>
    <title>:: Update Fee ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ page import="com.rheinlandprivatschule.repository.StudentDao" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="com.rheinlandprivatschule.model.*" %>
<%@ page session="true" %>

<body bgcolor="#FFFFFF" text="#000000">
<%
    StudentDao studentDB= (StudentDao) request.getAttribute("studentDao");

    Student u=(Student)session.getAttribute("pstudent");
    RPS rps=(RPS)session.getAttribute("handler");
    String chkbox=(String)request.getParameter("checkbox");

    boolean minusFlag=false;

    boolean adminprevilige=studentDB.payForTheCourse(rps.getLoginUser().getUserID());
    if(chkbox!=null){
        minusFlag=true;
        boolean adminpreviligeminus=studentDB.payForTheCourseMinus(rps.getLoginUser().getUserID());
        if(!adminpreviligeminus){
            adminprevilige=false;
        }
    }

    if(adminprevilige){
        CourseRegistration cr=(CourseRegistration)session.getAttribute("cr");
        Course course=(Course)session.getAttribute("course");
        Place myPlace=rps.getLoginPlace();
        SystemUser loginuser=rps.getLoginUser();

        String txtBal=(String)request.getParameter("txtBal");
        String paytype=(String)request.getParameter("paytype");

        double paid= MyCurrency.getDoubleValue(txtBal);
        try{
            if(minusFlag){
                paid=paid*(-1);
            }
            if(!studentDB.updateCourseRegistrationSecondTime(cr.getCourseID(),cr.getStudentID(),cr.getCourseBalance(),cr.getCourseFee(),paid,Integer.parseInt(paytype),minusFlag)){
                String err=studentDB.getError();
                session.setAttribute("err",err);
                session.setAttribute("lin","../map.jsp");
                response.sendRedirect("error");
            }else{
                int tranno=studentDB.addTransaction(paid,Integer.parseInt(paytype),cr.getStudentID(),cr.getCourseID(),rps.getLoginPlace().getPlaceID(),rps.getLoginUser().getUserID(),0);
                cr=studentDB.getRegistrationByStudent(cr.getCourseID(),cr.getStudentID());
                session.setAttribute("course",course);
                session.setAttribute("cr",cr);
                session.setAttribute("myPrint","bill");
                session.setAttribute("tranno",""+tranno);
                session.setAttribute("ap",""+paid);

                response.sendRedirect("nov");
            }
        }catch(Exception e){
        }

    }else{
        String err=studentDB.getError();
        session.setAttribute("err",err);
        session.setAttribute("lin","../map.jsp");
        response.sendRedirect("error");
    }
%>

</body>
</html>
