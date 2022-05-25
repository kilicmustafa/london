<%@ page import="com.rheinlandprivatschule.repository.SingleClassDao" %>
<%@ page import="com.rheinlandprivatschule.repository.StudentDao" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ page import="com.rheinlandprivatschule.model.SingleClassBalance" %>
<%@ page import="com.rheinlandprivatschule.model.CourseRegistration" %>
<%@ page import="com.rheinlandprivatschule.model.Course" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<HTML>
<HEAD>
    <TITLE>:: Schulen ::</TITLE>
    <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
    <!-- ImageReady Preload Script (Template.psd) -->
    <SCRIPT TYPE="text/javascript">
    </SCRIPT>
    <!-- End Preload Script -->
</HEAD>
<BODY BGCOLOR=#FFFFFF LEFTMARGIN=0 TOPMARGIN=0 MARGINWIDTH=0 MARGINHEIGHT=0 ONLOAD="preloadImages();">
<%
    SingleClassDao sidb=new SingleClassDao();
//rps.TransactionDB trdb=new rps.TransactionDB();
    StudentDao studentDB= (StudentDao) request.getAttribute("studentDao");

    Student student=(Student)session.getAttribute("pstudent");
    RPS rps=(RPS)session.getAttribute("handler");
    try{
        String balanceS=(String)request.getParameter("paid");
        double bal= MyCurrency.getDoubleValue(balanceS);

        SingleClassBalance sc=sidb.getStudentRecord(student.getUserID());

        if(bal>0){
            sc.setStudentID(student.getUserID());
            int newid=sidb.updateBalance(sc,bal);

            if(newid>0)	{
                int tranno=studentDB.addTransaction(bal,0,student.getUserID(),0,rps.getLoginPlace().getPlaceID(),rps.getLoginUser().getUserID(),0);
                sidb.addTransaction(student.getUserID(),tranno);

                if(tranno>0 && newid>0)	{

                    session.setAttribute("ap",""+bal);
                    double tofee=sidb.getTotalPayableFee(student.getUserID());
                    Course coras=new Course();
                    coras.setCourseName("Einzelunterricht");
                    coras.setCourseFee(tofee);
                    session.setAttribute("course",coras);

                    CourseRegistration cr=new CourseRegistration();
                    cr.setCourseFee(tofee);
                    double neg=-1;
                    cr.setCourseBalance(neg*(sc.getBalance()+bal));
                    cr.setRegistrationType(0);
                    session.setAttribute("cr",cr);
                    session.setAttribute("myPrint","bill");
                    session.setAttribute("tranno",""+tranno);

                    response.sendRedirect("nov");
                }else{

                    String err="Problem, noch einmal versuchen";
                    session.setAttribute("err",err);
                    session.setAttribute("lin","showStudentPreciseD?userid="+student.getUserID());
                    response.sendRedirect("error");
                }
            }else{
                String err="Problem, noch einmal versuchen";
                session.setAttribute("err",err);
                session.setAttribute("lin","showStudentPreciseD?userid="+student.getUserID());
                response.sendRedirect("error");
            }
        }else{
            String err="Betrag kann nicht null oder minus sein.";
            session.setAttribute("err",err);
            session.setAttribute("lin","showStudentPreciseD?userid="+student.getUserID());
            response.sendRedirect("error");
        }
    }catch(Exception e){
        String err="Problem, noch einmal versuchen";
        session.setAttribute("err",err);
        session.setAttribute("lin","showStudentPreciseD?userid="+student.getUserID());
        response.sendRedirect("error");
    }
%>
<!-- End ImageReady Slices -->
</BODY>
</HTML>