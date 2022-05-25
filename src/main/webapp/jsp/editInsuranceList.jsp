<%@ page import="com.rheinlandprivatschule.model.Insurance" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="com.rheinlandprivatschule.repository.InsuranceDao" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Krankenversicherung ::</title>
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
        function studentdetail()
        {
            window.location="showStudentPreciseD?userid="+document.form1.userid.value;
        }
    </script>
</head>
<body>
<%
    InsuranceDao insuranceDB=new InsuranceDao();
    ArrayList insuranceList=new ArrayList();

    int studentID=0;
    String descr="";
    String userid="=";

    Student u=(Student)session.getAttribute("pstudent");
    RPS rps=(RPS)session.getAttribute("handler");
    String cmd=(String)request.getParameter("cmd");

    if(cmd==null){
        insuranceList=insuranceDB.getAllInsurances();
        studentID=u.getUserID();
        userid=""+studentID;
        Insurance insurance=insuranceDB.getInsuranceRelatedToStudent(studentID);
        descr=insurance.getStudentInsuranceDescription();
        if(descr==null){
            descr="";
        }
    }else{
        studentID=u.getUserID();
        if(insuranceDB.deleteAllInsuranceRelatedToStudent(studentID)){
            String insu =request.getParameter("insurance");
            if(insu!=null){
                String desc =request.getParameter("desc");
                int tempInsuranceID=Integer.parseInt(insu);
                insuranceDB.addInsuranceRelatedToStudent(studentID,tempInsuranceID,desc);
                System.out.println(insuranceDB.getError());
            }
            response.sendRedirect("showStudentPreciseD?userid="+studentID);
        }else{
            String err=insuranceDB.getError();
            session.setAttribute("err",err);
            session.setAttribute("lin","../map");
            response.sendRedirect("error");
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="studentdetail()">Sch&uuml;ler Kurs Einzelheit</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <table width="100%" border="0" height="120">
                            <tr>
                                <td height="423" valign="top">
                                    <form style="width: 100%;" name="form1" method="post" action="editInsuranceList">
                                        <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                            <tr bgcolor="657A9A">
                                                <td height="22" colspan="2">
                                                    <div align="center"><b><font color="#FFFFFF">Krankenversicherung</font></b></div>
                                                </td>
                                            </tr>
                                            <tr bgcolor="657A9A">
                                                <td height="6" width="4%">
                                                    <input type="hidden" name="cmd" value="command">
                                                </td>
                                                <td width="96%" height="6" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Krankenversicherung</font></strong></td>
                                            </tr>
                                            <%
                                                Iterator insuranceListIT=insuranceList.iterator();
                                                while(insuranceListIT.hasNext())
                                                {
                                                    Insurance insurance=(Insurance)insuranceListIT.next();
                                                    if(insuranceDB.isRelatedToStudent(studentID,insurance.getInsuranceID())){

                                            %>
                                            <tr bgcolor="AEBACD">
                                                <td height="5" ><font size="2" color="#000033">
                                                    <input type="radio" name="insurance" value="<%=insurance.getInsuranceID()%>" checked>
                                                </font></td>
                                                <td height="5" ><font size="2" color="#000033"><%=insurance.getInsuranceName()%>
                                                </font></td>
                                            </tr>
                                            <%
                                            }
                                            else
                                            {
                                            %>
                                            <tr bgcolor="AEBACD">
                                                <td height="5" width="4%"><font size="2" color="#000033">
                                                    <input type="radio" name="insurance" value="<%=insurance.getInsuranceID()%>">
                                                </font></td>
                                                <td height="5" width="96%"><font size="2" color="#000033"><%=insurance.getInsuranceName()%>
                                                </font></td>
                                            </tr>
                                            <%
                                                    }
                                                }
                                            %>
                                            <tr bgcolor="657A9A">
                                                <td height="6" colspan="2"><strong><font color="#FFFFFF" size="2">Krankenversicherung Bemerkung</font></strong></td>
                                            </tr>
                                            <tr bgcolor="AEBACD">
                                                <td height="6" bgcolor="AEBACD" colspan="2"><input name="desc" type="text" id="desc" value="<%=descr%>">
                                                    <input name="userid" type="hidden" id="userid" value="<%=userid%>"></td>
                                            </tr>
                                            <tr bgcolor="AEBACD">
                                                <td height="6" bgcolor="AEBACD" colspan="2">
                                                    <input class="btn btn-primary" type="submit" name="Submit" value="OK">
                                                </td>
                                            </tr>
                                        </table>
                                    </form>
                                </td>
                            </tr>
                        </table>
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
