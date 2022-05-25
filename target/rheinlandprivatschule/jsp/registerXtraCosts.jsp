<HTML>
<HEAD>
    <TITLE>:: Anwesenheit Liste ::</TITLE>
    <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
    <!-- ImageReady Preload Script (Template.psd) -->
    <SCRIPT TYPE="text/javascript">


    </SCRIPT>
    <!-- End Preload Script -->
</HEAD>
<BODY BGCOLOR=#FFFFFF LEFTMARGIN=0 TOPMARGIN=0 MARGINWIDTH=0 MARGINHEIGHT=0">
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="com.rheinlandprivatschule.repository.StudentDao" %>
<%@ page import="com.rheinlandprivatschule.repository.XtraCostDao" %>
<%
    StudentDao studentDB= (StudentDao) request.getAttribute("studentDao");

    XtraCostDao xtr=new XtraCostDao();
    String desc=(String)request.getParameter("txtDesc");
    String fee=(String)request.getParameter("txtFee");
    String valueS=(String)request.getParameter("txtuserid");
    //String userID=(String)request.getParameter("userid");
    double totalfee= MyCurrency.getDoubleValue(fee);
    java.sql.Date registerdate= MyDate.getCurrentSQLDate();
    //String desc="a";
    //String fee="2";
    //String userID="1";
    //double totalfee=MyCurrency.getDoubleValue(fee);
    int userID =0;
    userID=Integer.parseInt(valueS);
    Student student=new Student();
    student.setUserRemarks(desc);
    student.setUserID(userID);
    student.setUserRegDate(registerdate);
    student.setUserStundenLohn(totalfee);

    int userid=xtr.addNewXtraCost(student);
    if(userid<=0){
        String err=studentDB.getError();
        session.setAttribute("err",err);
        session.setAttribute("lin","../map");
        response.sendRedirect("error");
    }else{
        session.setAttribute("newstudent",null);
        //String lin="showStudentPreciseD?userid="+userid;
        String lin="showStudentPreciseD?userid="+userID;
        response.sendRedirect(lin);
    }
%>

<!-- End ImageReady Slices -->
</BODY>
</HTML>
