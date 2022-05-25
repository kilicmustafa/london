<%@ page import="com.rheinlandprivatschule.repository.IntegrationCostDao" %>
<%@ page import="com.rheinlandprivatschule.repository.StudentDao" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<HTML>
<HEAD>
    <TITLE>:: Anwesenheit Liste ::</TITLE>
    <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
    <!-- ImageReady Preload Script (Template.psd) -->
    <SCRIPT TYPE="text/javascript">
        myPopup = '';
        function druck()
        {
            window.open("anwesenD");
        }
        function activecourses()
        {
            window.location="courseList";
        }

        function popUp(loc,eyeD,X,Y){
            window.open(loc,eyeD,"toolbar=no,location=0,directories=no,status=no,menubar=0,scrollbars=yes,resizable=0,width=" + X + ",height=" + Y + "'");
        }
    </SCRIPT>
    <!-- End Preload Script -->
</HEAD>
<BODY BGCOLOR=#FFFFFF LEFTMARGIN=0 TOPMARGIN=0 MARGINWIDTH=0 MARGINHEIGHT=0 ONLOAD="preloadImages();">
<%
    IntegrationCostDao costDB=new IntegrationCostDao();
    StudentDao studentDB=(StudentDao) request.getAttribute("studentDao");
    Student student=new Student();

    Student u=(Student)session.getAttribute("pstudent");
    RPS rps=(RPS)session.getAttribute("handler");
    String txtBal=(String)request.getParameter("txtBal");
    String totalpaid=(String)request.getParameter("totalPaid");
    double totalPaid = MyCurrency.getDoubleValue(totalpaid);
//if(rps==null){
//	String err="Sitzung lief Ab";
//	session.setAttribute("err",err);
//	session.setAttribute("lin","../index");
//	response.sendRedirect("error");
//}else{
    String chkbox=(String)request.getParameter("checkbox");
    String Pay=(String)request.getParameter("txtPay");
    double topay = MyCurrency.getDoubleValue(Pay);
    String costDesc=(String)request.getParameter("txtCostDesc");

    boolean minusFlag=false;

    if(chkbox!=null){
        minusFlag=true;
        //boolean adminpreviligeminus=studentDB.payForTheCourseMinus(rps.getLoginUser().getUserID());
        //if(!adminpreviligeminus){
        //	adminprevilige=false;
        //}
    }

    Student cr=(Student)session.getAttribute("cr");
    Student course=(Student)session.getAttribute("course");

    //String txtBal=(String)request.getParameter("txtBal");
    String paytype=(String)request.getParameter("paytype");
    java.sql.Date registerdate= MyDate.getCurrentSQLDate();

    double paid=MyCurrency.getDoubleValue(txtBal);
    totalPaid = totalPaid+paid;
    try{
        if(minusFlag){
            paid=paid*(-1);
        }
        //if(!studentDB.updateCourseRegistrationSecondTime(cr.getCourseID(),cr.getStudentID(),cr.getCourseBalance(),cr.getCourseFee(),paid,Integer.parseInt(paytype),minusFlag)){
        //String err=studentDB.getError();
        //session.setAttribute("err",err);
        //session.setAttribute("lin","../map");
        //response.sendRedirect("error");
        //}else{


        int tranno=costDB.addXtraCostTran(cr.getCostID(),paid,Integer.parseInt(paytype),registerdate,totalPaid,cr.getUserID(),rps.getLoginPlace().getPlaceID(),rps.getLoginUser().getUserID());

        student.setUserID(cr.getUserID());
        student.setcostDesc(costDesc);
        student.setActualFee(topay);
        student.setCostID(cr.getCostID());


        int cost=costDB.updateXtraCost(student);
        //cr=studentDB.getRegistrationByStudent(cr.getCourseID(),cr.getStudentID());
        session.setAttribute("course",course);
        session.setAttribute("cr",cr);
        session.setAttribute("myPrint","bill");
        session.setAttribute("tranno",""+tranno);
        session.setAttribute("ap",""+paid);

        response.sendRedirect("integrationBillProcess");
        //}
    }catch(Exception e){
    }

    //else{
    //	String err=studentDB.getError();
    //	session.setAttribute("err",err);
    //	session.setAttribute("lin","../map");
    //	response.sendRedirect("error");


//}
%>
%>
<table border="0" cellspacing="0" cellpadding="0" align="center" width="757">
    <tr>
        <td>&nbsp;</td>
        <td>
            <table width=780 border=0 cellpadding=0 cellspacing=0>
                <tr>
                    <td colspan=12 rowspan="14" valign="top"> <a href="#"
                                                                 onMouseOver="changeImages('Template_39', 'images/Template_39-over.gif'); return true;"
                                                                 onMouseOut="changeImages('Template_39', 'images/Template_39.gif'); return true;">
                    </a> <a href="#"
                            onMouseOver="changeImages('Template_40', 'images/Template_40-over.gif'); return true;"
                            onMouseOut="changeImages('Template_40', 'images/Template_40.gif'); return true;">
                    </a> <a href="#"
                            onMouseOver="changeImages('Template_41', 'images/Template_41-over.gif'); return true;"
                            onMouseOut="changeImages('Template_41', 'images/Template_41.gif'); return true;">
                    </a> <a href="#"
                            onMouseOver="changeImages('Template_42', 'images/Template_42-over.gif'); return true;"
                            onMouseOut="changeImages('Template_42', 'images/Template_42.gif'); return true;">
                    </a> <a href="#"
                            onMouseOver="changeImages('Template_43', 'images/Template_43-over.gif'); return true;"
                            onMouseOut="changeImages('Template_43', 'images/Template_43.gif'); return true;">
                    </a>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td height="433" valign="top" bgcolor="D9E5F4"><b><font size="2"><b>
                                    <input name="txtBal" type="text" value="<%=txtBal%>" maxlength="20">
                                    <font size="2"><b>
                                        <input name="txtpayType" type="text" value="<%=paytype%>" maxlength="20">
                                        <font size="2"><b><font size="2"><b>
                                            <input name="txtPaid" type="text" value="<%=paid%>" maxlength="20">
                                            <font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b>
                                                <input name="txtCostID" type="text" value="<%=cr.getCostID()%>" maxlength="20">
                                                <font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b>
                                                    <input name="txtUserID" type="text" value="<%=cr.getUserID()%>" maxlength="20">
                                                    <font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b>
                                                        <input name="txtLoginPlace" type="text" value="<%=rps.getLoginPlace().getPlaceID()%>" maxlength="20">
                                                        <font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b>
                                                            <input name="txtLoginUser" type="text" value="<%=rps.getLoginUser().getUserID()%>" maxlength="20">
                                                            <font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b>
                                                                <input name="txtRegDate" type="text" value="<%=registerdate%>" maxlength="20">
                                                            </b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font>                  <font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b><font size="2"><b>
                                                        </b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font> </b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font> </b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font>                </b></font></b></font></b></font></b></font></b></font></b></font></b></font></b></font> </b></font></b></font></b></font></b></font> </b></font></b></font> </b></font> </b></font></b> </td>
                            </tr>
                        </table>
                    </td>
                    <td> <img src="images/spacer.gif" width=1 height=23 alt=""></td>
                </tr>
                <tr>
                    <td> <img src="images/spacer.gif" width=1 height=22 alt=""></td>
                </tr>
                <tr>
                    <td> <img src="images/spacer.gif" width=1 height=79 alt=""></td>
                </tr>
                <tr>
                    <td> <img src="images/spacer.gif" width=1 height=22 alt=""></td>
                </tr>
                <tr>
                    <td> <img src="images/spacer.gif" width=1 height=26 alt=""></td>
                </tr>
                <tr>
                    <td> <img src="images/spacer.gif" width=1 height=13 alt=""></td>
                </tr>
                <tr>
                    <td> <img src="images/spacer.gif" width=1 height=8 alt=""></td>
                </tr>
                <tr>
                    <td> <img src="images/spacer.gif" width=1 height=20 alt=""></td>
                </tr>
                <tr>
                    <td> <img src="images/spacer.gif" width=1 height=21 alt=""></td>
                </tr>
                <tr>
                    <td> <img src="images/spacer.gif" width=1 height=22 alt=""></td>
                </tr>
                <tr>
                    <td> <img src="images/spacer.gif" width=1 height=22 alt=""></td>
                </tr>
                <tr>
                    <td> <img src="images/spacer.gif" width=1 height=22 alt=""></td>
                </tr>
                <tr>
                    <td> <img src="images/spacer.gif" width=1 height=22 alt=""></td>
                </tr>
                <tr>
                    <td> <img src="images/spacer.gif" width=1 height=111 alt=""></td>
                </tr>
                <tr>
                    <td colspan=12> <img src="../images/Template_45.gif" width=780 height=15 alt=""></td>
                    <td> <img src="images/spacer.gif" width=1 height=15 alt=""></td>
                </tr>
                <tr>
                    <td colspan=12> <img src="../images/Template_46.gif" width=780 height=43 alt=""></td>
                    <td> <img src="images/spacer.gif" width=1 height=43 alt=""></td>
                </tr>
                <tr>
                    <td height="2"> <img src="images/spacer.gif" width=105 height=1 alt=""></td>
                    <td height="2"> <img src="images/spacer.gif" width=40 height=1 alt=""></td>
                    <td height="2"> <img src="images/spacer.gif" width=9 height=1 alt=""></td>
                    <td height="2"> <img src="images/spacer.gif" width=94 height=1 alt=""></td>
                    <td height="2"> <img src="images/spacer.gif" width=89 height=1 alt=""></td>
                    <td height="2"> <img src="images/spacer.gif" width=88 height=1 alt=""></td>
                    <td height="2"> <img src="images/spacer.gif" width=86 height=1 alt=""></td>
                    <td height="2"> <img src="images/spacer.gif" width=85 height=1 alt=""></td>
                    <td height="2"> <img src="images/spacer.gif" width=18 height=1 alt=""></td>
                    <td height="2"> <img src="images/spacer.gif" width=69 height=1 alt=""></td>
                    <td height="2"> <img src="images/spacer.gif" width=86 height=1 alt=""></td>
                    <td height="2"> <img src="images/spacer.gif" width=11 height=1 alt=""></td>
                    <td height="2"></td>
                </tr>
            </table>
        </td>
        <td>&nbsp;</td>
    </tr>
</table>
<!-- End ImageReady Slices -->
</BODY>
</HTML>
