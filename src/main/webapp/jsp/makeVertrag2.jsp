<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.model.Course" %>
<%@ page import="com.rheinlandprivatschule.repository.CourseDao" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Mit welscher Stufe m&ouml;chten Sie Starten? ::</title>
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

        function first()
        {
            document.form2.Submit.disabled=false;
        }

    </script>
</head>
<body>
<%
    Vector vc=new Vector();
    int selectN=0;

    Student u=(Student)session.getAttribute("pstudent");

    if(u==null){
        String err="Wählen Sie Schüler Zuerst aus";
        session.setAttribute("err",err);
        session.setAttribute("lin","seacrhStudent");
        response.sendRedirect("error.jsp");
    }
    session.setAttribute("pstudent",u);
    String selectS=(String)request.getParameter("radiobutton");
    CourseDao cdb = (CourseDao) request.getAttribute("courseDao");
    RPS rps = (RPS) session.getAttribute("handler");
    try{
        if(selectS!=null){
            selectN=Integer.parseInt(selectS);
            vc=cdb.getVertragByPlaceActiveF(rps.getLoginPlace().getPlaceID(),selectN);
            for(int i=0;i<vc.size();i++){
                Course course = (Course)vc.elementAt(i);
            }
            session.setAttribute("planv",vc);
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
                        <form style="width: 100%;" name="form2" method="post" action="vertragPlan">
                            <table width="100%" border="0" cellspacing="1" cellpadding="1">
                                <tr bgcolor="657A9A">
                                    <td width="11%">
                                        <div align="center"><b><font size="2" color="#FFFFFF">w&auml;hlen</font></b></div>
                                    </td>
                                    <td width="36%">
                                        <div align="center"><b><font size="2" color="#FFFFFF">Kurs
                                            Name</font></b></div>
                                    </td>
                                    <td width="21%" bgcolor="657A9A">
                                        <div align="center"><font size="2" color="#FFFFFF"><b>Anfang
                                            Datum</b></font></div>
                                    </td>
                                    <td width="18%">
                                        <div align="center"><font size="2" color="#FFFFFF"><b>Ende
                                            Datum</b></font></div>
                                    </td>
                                    <td width="14%">
                                        <div align="center"><b><font size="2" color="#FFFFFF">Remains</font></b></div>
                                    </td>
                                </tr>
                                <%
                                    if(vc.size()==0 && selectN!=0)
                                    {
                                %>
                                <tr bgcolor="AEBACD">
                                    <td width="11%">&nbsp;</td>
                                    <td width="36%">&nbsp;</td>
                                    <td width="21%">&nbsp;</td>
                                    <td width="18%">&nbsp;</td>
                                    <td width="14%">&nbsp;</td>
                                </tr>
                                <%
                                    }
                                %>
                                <%
                                    for(int ii=0;ii<vc.size();ii++)	{
                                        Course f=(Course)vc.elementAt(ii);
                                        if(selectN==f.getCourseType()){

                                %>
                                <tr bgcolor="AEBACD">
                                    <td width="11%" height="9">
                                        <input type="radio" name="radiobutton" value="<%=f.getCourseID()%>" onClick="first()">
                                    </td>
                                    <td width="36%" height="9"><font size="2" color="#000033"><%=f.getCourseName()%></font></td>
                                    <td width="21%" height="9"><font size="2" color="#000033"><%=MyDate.formateDate(f.getCourseStartDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                    <td width="18%" height="9"><font size="2" color="#000033"><%=MyDate.formateDate(f.getCourseEndDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                    <td width="14%" height="9"><font size="2" color="#000033"><%=(f.getCourseStrength()-(cdb.countStudentsByCourse(f.getCourseID())))%></font></td>
                                </tr>
                                <%
                                        }
                                    }
                                %>
                                <tr bgcolor="AEBACD">
                                    <td colspan="5" height="9">
                                        <input class="btn btn-primary" type="submit" name="Submit" value="Weiter" disabled>
                                        <input class="btn btn-primary" type="button" name="Submit3" value="Zur&uuml;ck" onClick="goback()">
                                        <input type="hidden" name="sss" value="makeVertrag.jsp">
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
