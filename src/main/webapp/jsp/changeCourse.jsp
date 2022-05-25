<%@ page import="com.rheinlandprivatschule.repository.CourseDao" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.model.Course" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="com.rheinlandprivatschule.model.Place" %>
<%@ page import="com.rheinlandprivatschule.repository.PlaceDao" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Kurs Tauschen ::</title>
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

        function studentdetail(){
            window.location="showStudentPreciseD?userid="+document.form1.userids.value;
        }

        function sform(){
            if(document.form1.allflag.checked==true){
                document.form1.action="changeCourse?all=all";
                document.form1.submit();
            }else{
                document.form1.action="changeCourse";
                document.form1.submit();
            }

        }

        function chn(){
            document.form1.submit();
        }

        function can(){
            document.form1.action="changeCourseP";
            document.form1.submit();
        }

    </script>
</head>
<body>
<%
    CourseDao cdb= (CourseDao) request.getAttribute("courseDao");

    int userid=0;
    Vector clist=new Vector();
    Vector v=new Vector();
    String school="";
    int po=0;
    boolean allcourses=false;
    Place myPlace;

    Course c = new Course();


    Student u=(Student)session.getAttribute("pstudent");
    RPS rps=(RPS)session.getAttribute("handler");
    if(u==null){
        String err="Wählen Sie Schüler Zuerst aus";
        session.setAttribute("err",err);
        session.setAttribute("lin","seacrhStudent");
        response.sendRedirect("error");
    }else{
        userid=u.getUserID();
        myPlace=rps.getLoginPlace();
        c=(Course)session.getAttribute("course");
        session.setAttribute("course",c);
        v=(new PlaceDao()).getAllPlaces();

        String id=(String)request.getParameter("selCity");
        if(id!=null){
            po=Integer.parseInt(id);
            myPlace=(new PlaceDao()).getPlace(po);
            school=myPlace.getPlaceName();
        }else{
            school=(String)myPlace.getPlaceName();
            po=myPlace.getPlaceID();
        }

        String allflag=request.getParameter("all");
        if(allflag!=null){
            allcourses=true;
            clist=cdb.getAllCoursesByPlace(po);
        }else{
            allcourses=false;
            clist=cdb.getAllCoursesFAByPlace(po);
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="studentdetail()">Sch&uuml;ler-Information</a>

                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width: 100%;" name="form1" method="post" action="changeCourse">
                            <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                <tr bgcolor="657A9A">
                                    <td height="22" colspan="3">
                                        <div align="center"><b><font color="#FFFFFF">Kurs</font></b></div>
                                    </td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td bgcolor="657A9A" height="22" width="15%"><font size="2" color="#FFFFFF"><b>Kurs</b></font></td>
                                    <td height="22" colspan="2" bgcolor="AEBACD"><font size="2" color="#000033"><%=c.getCourseName()%></font></td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td bgcolor="657A9A" height="22" width="15%"><font size="2" color="#CCCCCC"><b><font color="#FFFFFF">Schule</font></b></font></td>
                                    <td height="22" colspan="2" bgcolor="AEBACD"><font size="2" color="#000033"><%=(new PlaceDao()).getPlace(c.getCoursePlace()).getPlaceName()%></font></td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td bgcolor="657A9A" height="22" colspan="3">
                                        <div align="center"><b><font color="#FFFFFF">Kurs
                                            Tauschen</font></b></div>
                                    </td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td bgcolor="657A9A" height="22" width="15%">
                                        <div align="left"><font color="#FFFFFF"><b><font size="2">Schule
                                        </font></b></font></div>
                                    </td>
                                    <td height="22" colspan="2" bgcolor="AEBACD"><font size="2" color="#000033">
                                        <select name="selCity" onChange="chn();">
                                            <%
                                                for(int i=0;i<v.size();i++)
                                                {
                                                    Place ppp=(Place)v.elementAt(i);
                                                    if(ppp.getPlaceName().equalsIgnoreCase(school))
                                                    {
                                            %>
                                            <option selected value="<%=ppp.getPlaceID()%>"><%=ppp.getPlaceName()%></option>
                                            <%
                                            }
                                            else
                                            {
                                            %>
                                            <option value="<%=ppp.getPlaceID()%>"><%=ppp.getPlaceName()%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                    </font></td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td bgcolor="657A9A" height="22" width="15%"><font size="2" color="#FFFFFF"><b>Kurs</b></font></td>
                                    <td bgcolor="AEBACD" height="22" width="54%">
                                        <select name="selCourse">
                                            <%
                                                for(int i=0;i<clist.size();i++)
                                                {
                                                    Course cc=(Course)clist.elementAt(i);
                                                    if(cc.getCourseID()==c.getCourseID())
                                                    {
                                            %>
                                            <option value="<%=cc.getCourseID()%>" selected><%=cc.getCourseName()%></option>
                                            <%
                                            }
                                            else
                                            {
                                            %>
                                            <option value="<%=cc.getCourseID()%>"><%=cc.getCourseName()%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                    </td>
                                    <td bgcolor="AEBACD" width="31%">
                                        <%
                                            if(allcourses){

                                        %>
                                        <input name="allflag" type="checkbox" id="allflag" value="checkbox" onClick="sform()" checked>
                                        <%
                                        }else{
                                        %>
                                        <input name="allflag" type="checkbox" id="allflag" value="checkbox" onClick="sform()">
                                        <%
                                            }
                                        %>
                                        <font color="#000033" size="2">Alle kurse</font>
                                    </td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td bgcolor="657A9A" height="22" width="15%">&nbsp;</td>
                                    <td height="22" colspan="2" bgcolor="AEBACD">
                                        <input class="btn btn-primary" type="button" name="Button" value="OK" onClick="can();">
                                        <input class="btn btn-primary" type="hidden" name="userids" value="<%=userid%>">
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
