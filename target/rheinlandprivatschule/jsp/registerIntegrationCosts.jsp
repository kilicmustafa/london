<%@ page import="com.rheinlandprivatschule.repository.IntegrationCostDao" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<HTML>
<HEAD>
    <TITLE>:: Anwesenheit Liste ::</TITLE>
    <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
    <!-- ImageReady Preload Script (Template.psd) -->
    <SCRIPT TYPE="text/javascript">
        
    </SCRIPT>
    <!-- End Preload Script -->
</HEAD>
<BODY BGCOLOR=#FFFFFF LEFTMARGIN=0 TOPMARGIN=0 MARGINWIDTH=0 MARGINHEIGHT=0 >
<%
    IntegrationCostDao studentDB=new IntegrationCostDao();
    String desc=(String)request.getParameter("txtDesc");
    String fee=(String)request.getParameter("txtFee");
    String valueS=(String)request.getParameter("txtuserid");
    double totalfee= MyCurrency.getDoubleValue(fee);
    java.sql.Date registerdate= MyDate.getCurrentSQLDate();
    int userID =0;
    userID=Integer.parseInt(valueS);
    Student student=new Student();
    student.setUserRemarks(desc);
    student.setUserID(userID);
    student.setUserRegDate(registerdate);
    student.setUserStundenLohn(totalfee);

    int userid=studentDB.addNewXtraCost(student);
    if(userid<=0){
        String err=studentDB.getError();
        session.setAttribute("err",err);
        session.setAttribute("lin","../map");
        response.sendRedirect("error");
    }else{
        session.setAttribute("newstudent",null);
        String lin="integrationCosts?userid="+userID;
        response.sendRedirect(lin);
    }
%>
<!-- End ImageReady Slices -->
</BODY>
</HTML>
