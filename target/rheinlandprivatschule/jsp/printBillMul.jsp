<html>
<head>
    <title>Print Bill</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%@ page import="java.util.*" %>
<%@ page import="com.rheinlandprivatschule.*" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="com.rheinlandprivatschule.repository.StudentDao" %>
<%@ page import="com.rheinlandprivatschule.repository.CourseDao" %>
<%@ page import="com.rheinlandprivatschule.repository.PlaceDao" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.model.*" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ page session="true" %>
<%
    RPS rps=(RPS)session.getAttribute("handler");
    if(rps==null){
        String err="Sitzung lief Ab";
        session.setAttribute("err",err);
        session.setAttribute("lin","../index.jsp");
        response.sendRedirect("error.jsp");
    }else{
        session.setAttribute("handler",rps);
    }

    Vector v=(Vector)session.getAttribute("tr");
    String add1="";
    String add2="";
    String add3="";
    String add4="";
    String add5="";
    String add6="";

%>
<table width="100%" border="0" cellspacing="1" cellpadding="1" height="896">
    <%


        StudentDao sdb=new StudentDao();
        CourseDao cdb=new CourseDao();
        PlaceDao pdb=new PlaceDao();
        for(int i=0;i<v.size();i++){

            String courseName="";
            String startDate="";
            String endDate="";
            String courseFee="";
            String hasPaid="";
            String balance="";
            String amount="";

            Transaction t=(Transaction)v.elementAt(i);
            Student student=sdb.getStudentForSubProcess(t.getStudentID());
            String co=student.getUserCO();
            if(student.getUserCO()==null){
                add1=student.getUserFirstName()+" "+student.getUserLastName();
                add2=student.getUserAddress();
                add3="";
                add4=student.getUserPostCode()+" "+student.getUserCity();
                add5="";
                add6="";
            }else{
                add1=student.getUserFirstName()+" "+student.getUserLastName();
                add2="c\\o "+co;
                add3=student.getUserAddress();
                add4="";
                add5=student.getUserPostCode()+" "+student.getUserCity();
                add6="";
            }

            Place place=pdb.getPlace(t.getPlaceID());
            Course course=new Course();
            CourseRegistration cr=new CourseRegistration();
            if(t.getCourseID()>0){
                course=cdb.getCourse(t.getCourseID());
                cr=sdb.getRegistrationByStudent(course.getCourseID(),student.getUserID());
                courseName=course.getCourseName();
                startDate= MyDate.formateDate(course.getCourseStartDate(),MyDate.NUMERIC,MyDate.DEUTSCH);
                endDate=MyDate.formateDate(course.getCourseEndDate(),MyDate.NUMERIC,MyDate.DEUTSCH);
                courseFee=MyCurrency.getDisplayString(cr.getCourseFee());
                hasPaid= MyCurrency.getDisplayString(cr.getCourseFee()-cr.getCourseBalance());
                balance=MyCurrency.getDisplayString(cr.getCourseBalance());
                amount=MyCurrency.getDisplayString(t.getPaid());
            }else{
                courseName="Einzelunterricht";
                startDate="";
                endDate="";
                courseFee="";
                hasPaid="";
                balance="";
                amount=MyCurrency.getDisplayString(t.getPaid());
            }
    %>
    <tr>
        <td height="875">
            <table width="100%" border="0" height="895">
                <tr>
                    <td height="22" width="13%" rowspan="4">&nbsp;</td>
                    <td height="22" colspan="3" valign="top" rowspan="4"><b><font face="Times New Roman, Times, serif" color="#FFFFFF">
                    </font><font face="Times New Roman, Times, serif">&nbsp;</font></b></td>
                    <td width="4%" height="22" rowspan="4">&nbsp;</td>
                    <td width="52%" height="10">
                        <div align="right" style="font:Arial, Helvetica, sans-serif;"><font size="2"><%=place.getBillSchool()%></font></div>
                    </td>
                </tr>
                <tr>
                    <td width="52%" height="10">
                        <div align="right"><font size="2"><%=place.getPlaceAddress()%> </font></div>
                    </td>
                </tr>
                <tr>
                    <td width="52%" height="22">
                        <div align="right"><font size="2"><%=place.getPlacePostCode()%> <%=place.getPlaceCity()%></font></div>
                    </td>
                </tr>
                <tr>
                    <td width="52%" height="22">
                        <div align="right"><font size="2">Fon: <%=place.getPlaceTelephone()%></font></div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" height="4">&nbsp;</td>
                    <td width="1%" height="4">&nbsp;</td>
                    <td width="5%" height="4">&nbsp;</td>
                    <td width="4%" height="4">&nbsp;</td>
                    <td width="52%" height="4">
                        <div align="right"><font size="2">Fax: <%=place.getPlaceFax()%></font></div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" height="20">&nbsp;</td>
                    <td width="1%" height="20">&nbsp;</td>
                    <td width="5%" height="20">&nbsp;</td>
                    <td width="4%" height="20">&nbsp;</td>
                    <td width="52%" height="20">
                        <div align="right"><font size="2">e-Mail:<%=place.getPlaceEmail()%></font></div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" height="2">&nbsp;</td>
                    <td width="1%" height="2">&nbsp;</td>
                    <td width="5%" height="2">&nbsp;</td>
                    <td width="4%" height="2">&nbsp;</td>
                    <td width="52%" height="2">
                        <div align="right"><font size="2"><%=place.getBillURL()%></font></div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" height="18" style="font-size:12px;"><u><%=place.getBillAddress()%></u></td>
                    <td height="18" width="1%">&nbsp;</td>
                    <td height="18" width="5%">&nbsp;</td>
                    <td height="18" width="4%">&nbsp;</td>
                    <td height="18" width="52%">
                        <div align="right"><font size="2"><a href="#"></a></font></div>
                    </td>
                </tr>
                <tr>
                    <td colspan="5" height="13">&nbsp;</td>
                    <td width="52%" height="13">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="5" height="13"><%=add1%></td>
                    <td width="52%" height="13">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="5" height="2"><%=add2%></td>
                    <td height="2">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="5" height="2"><%=add3%></td>
                    <td width="52%" height="2">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="5" height="15"><%=add4%></td>
                    <td width="52%" height="15">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="6" height="2"><%=add5%></td>
                </tr>
                <tr>
                    <td colspan="6" height="2"><%=add6%></td>
                </tr>
                <tr>
                    <td colspan="6" height="35">
                        <div align="center"><b><font size="6" face="Times New Roman, Times, serif">Rechnung</font></b></div>
                    </td>
                </tr>
                <tr>
                    <td colspan="5" height="11">&nbsp;</td>
                    <td width="52%" align="right" height="11">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="5" height="11"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Rechnungs-Nr
                        :</font> <%=t.getTransactionNo()%></td>
                    <td width="52%" align="right" height="11"><%=MyDate.formateDate(t.getPaymentDate(),MyDate.ALPHANUMERIC,MyDate.DEUTSCH)%></td>
                </tr>
                <tr>
                    <td colspan="5" height="9">&nbsp;</td>
                    <td width="52%" align="right" height="9">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="5" height="9">&nbsp;</td>
                    <td width="52%" align="right" height="9">&nbsp;</td>
                </tr>
                <tr>
                    <td width="13%" align="left" height="4">&nbsp;</td>
                    <td width="25%" align="left" height="4"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Kurs</font></b></td>
                    <td colspan="4" height="4"><%=courseName%></td>
                </tr>
                <tr>
                    <td width="13%" align="left" height="8">&nbsp;</td>
                    <td width="25%" align="left" height="8"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Kursbeginn</font></b></td>
                    <td colspan="4" height="8"><%=startDate%></td>
                </tr>
                <tr>
                    <td width="13%" align="left" height="4">&nbsp;</td>
                    <td width="25%" align="left" height="4"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Kursende</font></b></td>
                    <td colspan="4" height="4"><%=endDate%></td>
                </tr>
                <tr>
                    <td width="13%" align="left" height="15">&nbsp;</td>
                    <td width="25%" align="left" height="15"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Registrierungsgeb&uuml;hr</font></b></td>
                    <td colspan="4" height="15"><%=courseFee%> &euro;</td>
                </tr>
                <tr>
                    <td width="13%" align="left" height="10">&nbsp;</td>
                    <td width="25%" align="left" height="10"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Geleistete
                        Zahlungen</font></b></td>
                    <td colspan="4" height="10"><%=hasPaid%> &euro;</td>
                </tr>
                <tr>
                    <td width="13%" align="left" height="12">&nbsp;</td>
                    <td width="25%" align="left" height="12"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">F&auml;lliger
                        Betrag</font></b></td>
                    <td colspan="4" height="12"><%=balance%> &euro;</td>
                </tr>
                <tr>
                    <td width="13%" align="left" height="7">&nbsp;</td>
                    <td width="25%" align="left" height="7"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Rechnungsbetrag</font></b></td>
                    <td colspan="4" height="7"><%=amount%> &euro;</td>
                </tr>
                <tr align="left">
                    <td colspan="6" height="15">&nbsp;</td>
                </tr>
                <tr align="left">
                    <td colspan="6" height="15">&nbsp;</td>
                </tr>
                <tr align="left">
                    <td colspan="6" height="15">&nbsp;</td>
                </tr>
                <tr align="left">
                    <td colspan="6" height="15">&nbsp;</td>
                </tr>
                <tr align="left">
                    <td colspan="6" height="8"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Wir
                        danken Ihnen f&uuml;r Ihren Auftrag,</font></td>
                </tr>
                <tr align="left">
                    <td colspan="6" height="14">&nbsp;</td>
                </tr>
                <tr align="left">
                    <td colspan="6" height="2"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">mit
                        freundlichen Gr&uuml;&szlig;en</font></td>
                </tr>
                <tr align="left">
                    <td colspan="6" height="9"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">-Rheinland
                        Privatschule-</font></td>
                </tr>
                <tr align="left">
                    <td colspan="6" height="9">&nbsp;</td>
                </tr>
                <tr align="left">
                    <td colspan="6" height="2"><%=t.getLoginUserCompleteName()%></td>
                </tr>
                <tr align="left">
                    <td colspan="6" height="2">&nbsp;</td>
                </tr>
                <tr align="left">
                    <td colspan="6" height="2">&nbsp;</td>
                </tr>
                <tr align="left">
                    <td colspan="6" height="2">&nbsp;</td>
                </tr>
                <tr align="left" valign="top">
                    <td colspan="6" height="82">&nbsp; </td>
                </tr>
                <tr align="left">
                    <td colspan="6" height="2"></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td height="2">&nbsp;</td>
    </tr>
    <tr>
        <td height="2">&nbsp;</td>
    </tr>
    <%
        }
    %>
</table>
</body>
</html>
