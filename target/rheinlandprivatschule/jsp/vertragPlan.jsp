<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.model.Course" %>
<%@ page import="com.rheinlandprivatschule.repository.CourseDao" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.model.CourseRegistration" %>
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

    </script>
</head>
<body>
<%
    int userid=0;
    Vector vc=new Vector();
    Course c=new Course();
    CourseRegistration cr=new CourseRegistration();

    Vector myv=new Vector();
    int selectN=0;
    int lasttrack=0;
    int finalchk=0;
    boolean bb=false;
    String selectS="";

    Student u=(Student)session.getAttribute("pstudent");

    if(u==null){
        String err="Wählen Sie Schüler Zuerst aus";
        session.setAttribute("err",err);
        session.setAttribute("lin","seacrhStudent");
        response.sendRedirect("error");
    }
    CourseDao cdb = (CourseDao) request.getAttribute("courseDao");

    session.setAttribute("pstudent",u);

    userid=u.getUserID();

    vc=(Vector)session.getAttribute("planv");
    session.setAttribute("planv",vc);
    selectS=(String)request.getParameter("radiobutton");

    Course myCourse=new Course();
    try{
        if(selectS!=null){

            selectN=Integer.parseInt(selectS);
            for(int k=0;k<vc.size();k++){
                Course cc=(Course)vc.elementAt(k);
                if(cc.getCourseID()==selectN){
                    myCourse=cc;
                }
            }
            myv.addElement(myCourse);
            int track=myCourse.getCourseType()+1;
            while(track<=5){
                for(int h=0;h<vc.size();h++){
                    Course co=(Course)vc.elementAt(h);
                    if(co.getCourseType()==track && co.getCourseStartDate().after(myCourse.getCourseEndDate())){
                        myv.addElement(co);
                        myCourse=co;
                        break;
                    }
                }
                track++;
            }
        }
    }catch(Exception e){
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
                        <form style="width: 100%;" name="form2" method="post" action="vertragFinal">
                            <table width="100%" border="0" cellspacing="1" cellpadding="1">
                                <tr>
                                    <td width="12%" bgcolor="657A9A">
                                        <div align="center"><b><font size="2" color="#FFFFFF">w&auml;hlen</font></b></div>
                                    </td>
                                    <td width="35%" bgcolor="657A9A">
                                        <div align="center"><b><font size="2" color="#FFFFFF">Kurs
                                            Name</font></b></div>
                                    </td>
                                    <td width="21%" bgcolor="657A9A">
                                        <div align="center"><font size="2" color="#FFFFFF"><b>Anfang
                                            Datum</b></font></div>
                                    </td>
                                    <td width="18%" bgcolor="657A9A">
                                        <div align="center"><font size="2" color="#FFFFFF"><b>Ende
                                            Datum</b></font></div>
                                    </td>
                                    <td width="14%" bgcolor="657A9A">
                                        <div align="center"><b><font size="2" color="#FFFFFF">Remains</font></b></div>
                                    </td>
                                </tr>
                                <%
                                    boolean mygh=true;
                                    for(int ii=0;ii<myv.size();ii++){
                                        Course f=(Course)myv.elementAt(ii);
                                        if(mygh){
                                %>
                                <tr>
                                    <td width="12%" height="9" bgcolor="AEBACD">
                                        <input type="checkbox" name="checkbox" value="<%=f.getCourseID()%>" checked>
                                    </td>
                                    <td width="35%" height="9" bgcolor="AEBACD"><font size="2" color="#000033"><%=f.getCourseName()%></font></td>
                                    <td width="21%" height="9" bgcolor="AEBACD"><font size="2" color="#000033"><%=MyDate.formateDate(f.getCourseStartDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                    <td width="18%" height="9" bgcolor="AEBACD"><font size="2" color="#000033"><%=MyDate.formateDate(f.getCourseEndDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                    <td width="14%" height="9" bgcolor="AEBACD"><font size="2" color="#000033"><%=(f.getCourseStrength()-(cdb).countStudentsByCourse(f.getCourseID()))%></font></td>
                                </tr>
                                <tr>
                                    <td colspan="5" height="24">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td colspan="5" height="24" bgcolor="657A9A">
                                        <div align="center"><font size="2"><b><font color="#FFFFFF">M&ouml;chten
                                            Sie die folgenden Stufen auch buchen?</font></b></font></div>
                                    </td>
                                </tr>
                                <%
                                    mygh=false;
                                }
                                else
                                {
                                %>
                                <tr>
                                    <td width="12%" height="9" bgcolor="AEBACD">
                                        <input type="checkbox" name="checkbox" value="<%=f.getCourseID()%>">
                                    </td>
                                    <td width="35%" height="9" bgcolor="AEBACD"><font size="2" color="#000033"><%=f.getCourseName()%></font></td>
                                    <td width="21%" height="9" bgcolor="AEBACD"><font size="2" color="#000033"><%=MyDate.formateDate(f.getCourseStartDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                    <td width="18%" height="9" bgcolor="AEBACD"><font size="2" color="#000033"><%=MyDate.formateDate(f.getCourseEndDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                    <td width="14%" height="9" bgcolor="AEBACD"><font size="2" color="#000033"><%=(f.getCourseStrength()-(cdb).countStudentsByCourse(f.getCourseID()))%></font></td>
                                </tr>
                                <%
                                        }
                                    }
                                %>
                                <tr>
                                    <td colspan="5" height="2" bgcolor="AEBACD">
                                        <input class="btn btn-primary" type="submit" name="Submit" value="Weiter">
                                        <input class="btn btn-primary" type="button" name="Submit3" value="Zur&uuml;ck" onClick="goback()">
                                        <input type="hidden" name="sss" value="makeVertrag">
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
