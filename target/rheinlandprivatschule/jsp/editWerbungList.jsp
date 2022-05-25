<%@ page import="com.rheinlandprivatschule.repository.StudentDao" %>
<%@ page import="com.rheinlandprivatschule.repository.WerbungDao" %>
<%@ page import="com.rheinlandprivatschule.repository.AgentDao" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.rheinlandprivatschule.model.Werbung" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="java.util.Iterator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Werbung Klassifikation ::</title>
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
        function back()
        {
            window.location="editWerbungList?userid="+document.form1.userid.value;
        }
    </script>
</head>
<body>
<%
    StudentDao studentDB= (StudentDao) request.getAttribute("studentDao");
    WerbungDao wdb=new WerbungDao();
    AgentDao adb=new AgentDao();
    ArrayList werbungList=new ArrayList();

    Werbung studentWerbung=new Werbung();
    String userid="0";

    Student student=(Student)session.getAttribute("pstudent");

    int studentID=student.getUserID();
    userid=""+studentID;
    studentWerbung=wdb.getWerbungRelatedToStudent(studentID);

    int parent=0;
    String cmd=request.getParameter("cmd");
    RPS rps = (RPS) session.getAttribute("handler");
    if(cmd==null){
        String parentS=request.getParameter("parent");
        if(parentS!=null){
            parent=Integer.parseInt(parentS);
        }
        werbungList=wdb.getAllWerbungs(parent);
    }else{
        String wid=(String)request.getParameter("werbung");
        int tempWerbungID=Integer.parseInt(wid);
        wdb.deleteWerbungRelatedToClient(studentID);
        boolean isok=studentDB.addWerbungsToNewStudent(studentID,tempWerbungID,rps.getLoginUser().getUserID());
        if(!isok){
            String err=studentDB.getError();
            session.setAttribute("err",err);
            session.setAttribute("lin","../map");
            response.sendRedirect("error");
        }else{
            adb.deleteAgentStudent(studentID);
            int agentID=wdb.getWerbungAgent(tempWerbungID);
            adb.addAgentStudent(agentID,tempWerbungID,studentID,0,0,null,null, MyDate.getCurrentSQLDate());
        }
        response.sendRedirect("showStudentPreciseD?userid="+studentID);
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="back()">Zur&uuml;ck</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <table width="100%" border="0" height="120">
                            <tr>
                                <td height="423" valign="top">
                                    <form style="width: 100%;" name="form1" method="post" action="">
                                        <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                            <tr bgcolor="657A9A">
                                                <td height="21" colspan="3"><div align="center"><b><font color="#FFFFFF">Werbung </font></b></div></td>
                                            </tr>
                                            <tr bgcolor="657A9A">
                                                <td width="20%" height="5"><strong><font color="#FFFFFF" size="2">Sch&uuml;ler/in Werbung</font></strong> </td>
                                                <td height="5" colspan="2" bgcolor="AEBACD"><font color="#000033" size="2"><%=studentWerbung.getWerbungName()%></font></td>
                                            </tr>
                                            <tr bgcolor="657A9A">
                                                <td height="5" colspan="2"><b><font size="2" color="#FFFFFF">Werbung Klassifikation </font></b></td>
                                                <td width="14%" height="5"><input name="userid" type="hidden" id="userid" value="<%=userid%>"></td>
                                            </tr>
                                            <%
                                                Iterator werbungListIT=werbungList.iterator();
                                                while(werbungListIT.hasNext()){
                                                    Werbung werbung=(Werbung)werbungListIT.next();
                                                    String name = "Zuordnen";
                                                    int id = werbung.getStatus();
                                                    if(id==1){
                                                        name = "";
                                                    }
                                                    if (werbung.getWerbungActive()==0 && name==""){
                                            %>

                                            <tr bgcolor="AEBACD">
                                                <td height="5" colspan="2"><font size="2" color="#000033"><a href="/schuler/editWerbungList?parent=<%=werbung.getWerbungID()%>" ><%=werbung.getWerbungName()%></a></font></td>
                                                <td height="5"><font color="#000033" size="2"><a href="/schuler/editWerbungList?werbung=<%=werbung.getWerbungID()%>&cmd=cmd"><%=name%></a></font></td>
                                            </tr>
                                            <%}
                                            else if (werbung.getWerbungActive()==0 && name!=""){
                                            %>

                                            <tr bgcolor="AEBACD">
                                                <td height="5" colspan="2"><font size="2" color="#000033"><a href="/schuler/editWerbungList?parent=<%=werbung.getWerbungID()%>" onclick="return false"><%=werbung.getWerbungName()%></a></font></td>
                                                <td height="5"><font color="#000033" size="2"><a href="/schuler/editWerbungList?werbung=<%=werbung.getWerbungID()%>&cmd=cmd"><%=name%></a></font></td>
                                            </tr>
                                            <%}

                                            }
                                            %>
                                            <tr bgcolor="AEBACD">
                                                <td height="6" colspan="3">&nbsp;</td>
                                            </tr>
                                        </table>
                                    </form></td>
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
