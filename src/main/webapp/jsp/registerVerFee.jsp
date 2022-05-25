<html>
<head>
    <title>:: Course Vertrag Process ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<%@ page import="java.util.*" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="com.rheinlandprivatschule.model.Course" %>
<%@ page import="com.rheinlandprivatschule.repository.*" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ page import="com.rheinlandprivatschule.model.CourseRegistration" %>

<body bgcolor="#FFFFFF" text="#000000"><%
    Student u=(Student)session.getAttribute("pstudent");
    StudentDao sdb= (StudentDao) request.getAttribute("studentDao");

    RPS rps=(RPS)session.getAttribute("handler");

    double addition=0;
    double paid=0;
    double fee=0;
    boolean canipay=false;
    int paymentType=0;
    int registrationType=0;
    int nochHours=0;
    String totalHours="0";
    int completedHours=0;
    int module = 0;
    int modulename = 0;
    boolean cananm=true;

    Course coras=(Course)session.getAttribute("erstk");
    Vector fver=(Vector)session.getAttribute("fver");
    String addi=(String)request.getParameter("addi");
    String txtBal=(String)request.getParameter("txtPay");
    session.setAttribute("ap",txtBal);
    String paytype=(String)request.getParameter("paytype");
    String regtype=(String)request.getParameter("regtype");
    String moduleNumber=(String)request.getParameter("moduleNumber");
    String integr=(String)request.getParameter("integration");

    try{
        if(	sdb.canMakeVertrag(rps.getLoginUser().getUserID())){
            addition= MyCurrency.getDoubleValue(addi);
            fee=coras.getCourseFee();

            //if(u.getUserBamfNumber()==null){
            paid=MyCurrency.getDoubleValue(txtBal);
            //}else {
            //paid=0;
            //}
            paymentType=Integer.parseInt(paytype);
            module=Integer.parseInt(moduleNumber);
            registrationType=Integer.parseInt(regtype);
            boolean success=false;
            if(registrationType==0){
                success=sdb.updateCourseRegistrationFirstTime(coras.getCourseID(),u.getUserID(),fee,paid, RegistrationDao.SYSTEMPAYMENTMODE,addition,RegistrationDao.R_REGISTERED,fver,integr);
            }else if(registrationType==1){
                success=sdb.updateCourseRegistrationFirstTime(coras.getCourseID(),u.getUserID(),fee,paid,RegistrationDao.MANUALPAYMENTMODE,addition,RegistrationDao.R_REGISTERED,fver,integr);
            }

            if(success){
                //if(u.getUserBamfNumber()==null){
                int tranno=sdb.addTransaction(paid,paymentType,u.getUserID(),coras.getCourseID(),rps.getLoginPlace().getPlaceID(),rps.getLoginUser().getUserID(),module);
                CourseRegistration cr=sdb.getRegistrationByStudent(coras.getCourseID(),u.getUserID());
                session.setAttribute("course",coras);
                session.setAttribute("cr",cr);
                session.setAttribute("myPrint","bill");
                session.setAttribute("tranno",""+tranno);
                session.setAttribute("ap",""+paid);
                response.sendRedirect("nov");}
            //else{
            //response.sendRedirect("showStudentPreciseD.jsp?userid="+u.getUserID());
            //}
            //}
            else{
                String err=sdb.getError();
                session.setAttribute("err",err);
                session.setAttribute("lin","showStudentPreciseD?userid="+u.getUserID());
                response.sendRedirect("error.jsp");
            }
        }else{
            String err=sdb.getError();
            session.setAttribute("err",err);
            session.setAttribute("lin","../map");
            response.sendRedirect("error");
        }
    }catch(Exception e)
    {}
%>


</body>
</html>
