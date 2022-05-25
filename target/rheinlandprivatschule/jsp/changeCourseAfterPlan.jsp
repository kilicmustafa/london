<%@ page import="com.rheinlandprivatschule.model.CourseRegistration" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.rheinlandprivatschule.model.Course" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.repository.CourseDao" %>
<%@ page import="com.rheinlandprivatschule.repository.StudentDao" %>
<%@ page import="com.rheinlandprivatschule.repository.TransactionDao" %>
<%@ page import="com.rheinlandprivatschule.repository.PlaceDao" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Vertragplan ::</title>
    <style>
        table tr {
            border-bottom: 1px solid white;
        }

        html {
            overflow-y: hidden;
        }

        table a {
            color: #0000EE;
            text-decoration: underline;
        }
    </style>
    <script>
        function goback(){
            window.location= document.form2.sss.value;
        }
        function changecourses(){
            document.form2.action="changeCourseAfterPlan?cmd=cmd";
            document.form2.submit();
        }
    </script>
</head>
<body>
<%
    Vector image=new Vector();
    StudentDao studentDB= (StudentDao) request.getAttribute("studentDao");
    CourseDao courseDB= (CourseDao) request.getAttribute("courseDao");

    int userid=0;

    Course changedCourse=new Course();
    changedCourse.setCourseStartDate(MyDate.getCurrentSQLDate());
    changedCourse.setCourseEndDate(MyDate.getCurrentSQLDate());

    Vector coursePlan=new Vector();
    Vector oldCourses=new Vector();
    Vector finalCoursePlan=new Vector();

    Student u=(Student)session.getAttribute("pstudent");

    if(u==null){
        String err="Wählen Sie Schüler Zuerst aus";
        session.setAttribute("err",err);
        session.setAttribute("lin","seacrhStudent");
        response.sendRedirect("error");
    }else{
        session.setAttribute("pstudent",u);
        userid=u.getUserID();

        String cmd=request.getParameter("cmd");
        if(cmd!=null){
            //Actually Change Courses
            ArrayList allreg=studentDB.getRegistrationByStudentIDSubProcess(userid);

            String par[]=request.getParameterValues("checkbox");
            if(par!=null){
                Vector coursesToChange=new Vector();
                for(int i=0;i<par.length;i++){
                    Course planCourse=courseDB.getCourse(Integer.parseInt((String)par[i]));
                    Iterator allregIT=allreg.iterator();
                    while(allregIT.hasNext()){
                        CourseRegistration regis=(CourseRegistration)allregIT.next();
                        Course regisCourse=courseDB.getCourse(regis.getCourseID());
                        if(planCourse.getCourseType()==regisCourse.getCourseType() && regis.getRegistrationStatus()!=2){
                            studentDB.changeCourseRegistration(regis,planCourse.getCourseID());
                            (new TransactionDao()).updateTransactions(regis.getCourseID(),regis.getStudentID(),planCourse.getCourseID());
                        }
                    }
                }
                response.sendRedirect("showStudentPreciseD?userid="+userid);
            }else{
                response.sendRedirect("showStudentPreciseD?userid="+userid);
            }
            //End Actually Change Courses
        }else{
            String changedCourseIDS=request.getParameter("courseID");
            int chengedCourseID=Integer.parseInt(changedCourseIDS);
            changedCourse=courseDB.getCourse(chengedCourseID);

            ArrayList allreg=studentDB.getRegistrationByStudentIDSubProcess(userid);
            Iterator allregIT=allreg.iterator();
            while(allregIT.hasNext()){
                CourseRegistration regis=(CourseRegistration)allregIT.next();
                if(chengedCourseID!=regis.getCourseID()){
                    Course tempCourse=courseDB.getCourse(regis.getCourseID());
                    if(tempCourse.getCourseType()>changedCourse.getCourseType()){
                        oldCourses.addElement(tempCourse);
                    }
                }
            }

            Course trackCourse=changedCourse;
            coursePlan=courseDB.getVertragByPlace(changedCourse.getCoursePlace(),changedCourse.getCourseType());
            int courseTrack=changedCourse.getCourseType()+1;
            while(courseTrack<=5){
                for(int h=0;h<coursePlan.size();h++){
                    Course tempCourse=(Course)coursePlan.elementAt(h);

                    if(tempCourse.getCourseType()==courseTrack && tempCourse.getCourseStartDate().after(trackCourse.getCourseEndDate())){
                        finalCoursePlan.addElement(tempCourse);
                        trackCourse=tempCourse;
                        break;
                    }
                }
                courseTrack++;
            }
        }
    }
%>
<div id="wrapper" class="wrapper" style="height: 100%;">
    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">
        <jsp:include page="templates/navbar.jsp"/>

        <!-- Main Content -->
        <div id="content">
            <!-- Begin Page Content -->
            <div class="container-fluid">

                <div class="wrapper" style="padding-left: 17.5%; padding-right: 17.5%;">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="wrapper" style="margin-bottom: 5px; float:right;">
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form name="form2" method="post" action="vertragFinal">
                            <table width="100%" border="0" cellspacing="1" cellpadding="1">
                                <tr>
                                    <td colspan="2" bgcolor="657A9A">
                                        <div align="center"><b></b></div>
                                        <div align="center"><b><font size="2" color="#FFFFFF">Kurs
                                            Name</font></b></div></td>
                                    <td bgcolor="657A9A"><div align="center"><strong><font color="#FFFFFF" size="2">Stadt</font></strong></div></td>
                                    <td width="11%" bgcolor="657A9A">
                                        <div align="center"><font size="2" color="#FFFFFF"><b>Anfang
                                            Datum</b></font></div>
                                    </td>
                                    <td width="11%" bgcolor="657A9A">
                                        <div align="center"><font size="2" color="#FFFFFF"><b>Ende
                                            Datum</b></font></div>
                                    </td>
                                    <td width="24%" bgcolor="657A9A">
                                        <div align="center"><b><font size="2" color="#FFFFFF">Remains</font></b></div>
                                    </td>
                                </tr>

                                <tr bgcolor="#CCCCCC">
                                    <td height="9" colspan="2"><font size="2" color="#000033"><%=changedCourse.getCourseName()%></font></td>
                                    <td height="9"><font size="2" color="#000033"><%=(new PlaceDao()).getPlace(changedCourse.getCoursePlace()).getPlaceName()%></font></td>
                                    <td height="9"><font size="2" color="#000033"><%=MyDate.formateDate(changedCourse.getCourseStartDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                    <td height="9"><font size="2" color="#000033"><%=MyDate.formateDate(changedCourse.getCourseEndDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                    <td height="9"><font size="2" color="#000033"><%=(changedCourse.getCourseStrength()-(courseDB).countStudentsByCourse(changedCourse.getCourseID()))%></font></td>
                                </tr>
                                <tr>
                                    <td height="9" colspan="2" bgcolor="AEBACD">&nbsp;</td>
                                    <td height="9" bgcolor="AEBACD">&nbsp;</td>
                                    <td height="9" bgcolor="AEBACD">&nbsp;</td>
                                    <td height="9" bgcolor="AEBACD">&nbsp;</td>
                                    <td height="9" bgcolor="AEBACD">&nbsp;</td>
                                </tr>
                                <%
                                    for(int ii=0;ii<oldCourses.size();ii++){
                                        Course oldCourse=(Course)oldCourses.elementAt(ii);
                                %>

                                <tr>
                                    <td height="9" colspan="2" bgcolor="AEBACD"><font size="2" color="#000033"><%=oldCourse.getCourseName()%></font></td>
                                    <td height="9" bgcolor="AEBACD"><font size="2" color="#000033"><%=(new PlaceDao()).getPlace(oldCourse.getCoursePlace()).getPlaceName()%></font></td>
                                    <td width="11%" height="9" bgcolor="AEBACD"><font size="2" color="#000033"><%=MyDate.formateDate(oldCourse.getCourseStartDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                    <td width="11%" height="9" bgcolor="AEBACD"><font size="2" color="#000033"><%=MyDate.formateDate(oldCourse.getCourseEndDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                    <td height="9" bgcolor="AEBACD"><font size="2" color="#000033"><%=(oldCourse.getCourseStrength()-(courseDB).countStudentsByCourse(oldCourse.getCourseID()))%></font></td>
                                </tr>
                                <%
                                    }
                                %>
                                <tr>
                                    <td colspan="6" height="24">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td colspan="6" height="24" bgcolor="657A9A">
                                        <div align="center"><font size="2"><b><font color="#FFFFFF">M&ouml;chten
                                            Sie die folgenden Stufen auch tauschen?</font></b></font></div>
                                    </td>
                                </tr>
                                <%
                                    for(int iii=0;iii<finalCoursePlan.size();iii++){
                                        Course finalCourse=(Course)finalCoursePlan.elementAt(iii);
                                %>
                                <tr>
                                    <td width="4%" height="9" bgcolor="AEBACD">
                                        <input type="checkbox" name="checkbox" value="<%=finalCourse.getCourseID()%>">
                                    </td>
                                    <td width="38%" height="9" bgcolor="AEBACD"><font size="2" color="#000033"><%=finalCourse.getCourseName()%></font></td>
                                    <td width="12%" bgcolor="AEBACD"><font size="2" color="#000033"><%=(new PlaceDao()).getPlace(finalCourse.getCoursePlace()).getPlaceName()%></font></td>
                                    <td width="11%" height="9" bgcolor="AEBACD"><font size="2" color="#000033"><%=MyDate.formateDate(finalCourse.getCourseStartDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                    <td width="11%" height="9" bgcolor="AEBACD"><font size="2" color="#000033"><%=MyDate.formateDate(finalCourse.getCourseEndDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                    <td height="9" bgcolor="AEBACD"><font size="2" color="#000033"><%=(finalCourse.getCourseStrength()-(courseDB).countStudentsByCourse(finalCourse.getCourseID()))%></font></td>
                                </tr>
                                <%
                                    }
                                %>
                                <tr>
                                    <td colspan="6" height="2" bgcolor="AEBACD">
                                        <input class="btn btn-primary" type="button" name="Button" value="Tauschen" onClick="changecourses()">
                                        <input class="btn btn-primary"  type="button" name="Submit3" value="Zur&uuml;ck" onClick="goback()">
                                        <input class="btn btn-primary"  type="hidden" name="sss" value="showStudentPreciseD?userid=<%=userid%>">
                                    </td>
                                </tr>
                            </table>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="templates/footer.jsp"/>
<jsp:include page="templates/bodyimports.jsp"/>
</body>
</html>
