<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.repository.*" %>
<%@ page import="com.rheinlandprivatschule.model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Katagorie Liste ::</title>
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
        function newComplaint()
        {
            window.location="newComplaint";
        }
        function studentdetail()
        {
            window.location="../schuler/showStudentPreciseD?userid="+document.form1.userids.value;
        }
        function notactive()
        {
            window.location="complaintList?status="+document.form1.status.value;
        }
        function active()
        {
            window.location="complaintList";
        }

        function back()
        {
            window.location="complaintList";
        }
        function searchstudentall()
        {
            window.location="searchStudentAll";
        }
    </script>
</head>
<body>
<%
    StudentComplaintDao exp= (StudentComplaintDao) request.getAttribute("studentComplaintDao");
    ComplaintDao complaintDB= (ComplaintDao) request.getAttribute("complaintDao");
    Complaint complaint=new Complaint();
    Student student=new Student();
    StudentDao studentDB= (StudentDao) request.getAttribute("studentDao");
    SystemUser sys=new SystemUser();
    SystemUserDao sysDB= (SystemUserDao) request.getAttribute("systemUserDao");
    PlaceDao placeDao = (PlaceDao) request.getAttribute("placeDao");
    Place myPlace = new Place();

    Vector v=new Vector();
    Vector com=new Vector();

    int userid=0;
    int pageStatus=-1;
    String firstname="";
    String lastname="";
    String desc="";
    int complaint1=0;
    String remarks="";

    RPS rps=(RPS)session.getAttribute("handler");
    SystemUser loginuser= rps.getLoginUser();

    String valueS=(String)request.getParameter("userid");
    String a=(String)request.getParameter("wid");

    userid=Integer.parseInt(valueS);
    student=studentDB.getStudentInformation(userid,rps.getLoginUser().getUserID());
    session.setAttribute("pstudent",student);

    firstname=student.getUserFirstName();
    lastname=student.getUserLastName();
    //xtra = exp.getAllStudentComplaints(userid);
    v=complaintDB.getAllComplaints(0);

    String flag=(String)request.getParameter("status");
    if(flag==null){
        com=exp.getAllStudentComplaints(userid, 0);
    }else{
        com=exp.getAllStudentComplaints(userid, Integer.parseInt(flag));
    }
    if(flag==null){
        pageStatus=exp.COMPLAINTACTIVE;
    }else{
        pageStatus=exp.COMPLAINTNOTACTIVE;
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="complaintList">Katagorie</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="studentComplaintList?status=1&userid=<%=userid%>">Nicht erledigt</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="studentComplaintList?userid=<%=userid%>">erledigt</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="studentdetail()">Sch&uuml;ler Kurs Einzelheit</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width: 100%;" name="form1" method="post" action="registerStudentComp" onSubmit="MM_validateForm('txtRemarks','','R');return document.MM_returnValue">
                            <table width="100%" height="206" border="0" cellpadding="1" cellspacing="1">
                                <tr>
                                    <th height="17">
                                        <div align="left">
                                            <input name="status" type="hidden" id="status" value="notactive">
                                            <input type="hidden" name="userids" value="<%=userid%>">
                                        </div>
                                    </th>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <th height="17" colspan="6"><b><font color="#FFFFFF">Beschwerden</font></b></th>
                                </tr>
                                <tr>
                                    <td width="13%" height="21" bgcolor="657A9A"><font color="#FFFFFF" size="2"><b>Schuler Name </b></font></td>
                                    <td height="21" colspan="5" bgcolor="AEBACD"><font size="2" color="#000033"><%=firstname%></font><font color="#000033">&nbsp;
                                    </font></td>
                                </tr>
                                <tr>
                                    <td height="2" bgcolor="657A9A"><font color="#FFFFFF" size="2"><b>Katagorie</b></font></td>
                                    <td height="2" colspan="5" bgcolor="AEBACD"><font color="#000033">
                                        <select name="selCate">
                                            <option value="0" selected>w&auml;hlen</option>
                                            <%
                                                for(int g=0;g<v.size();g++)
                                                {
                                                    Complaint uc=(Complaint)v.elementAt(g);
                                                    {
                                            %>
                                            <option value="<%=uc.getComplaintID()%>" selected><%=uc.getComplaintName()%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                    </font></td>
                                </tr>
                                <tr>
                                    <td height="2" bgcolor="657A9A"><font color="#FFFFFF" size="2"><b>Bemerkung</b></font></td>
                                    <td height="2" colspan="5" bgcolor="AEBACD"><font color="#000033">
                                        <textarea name="txtRemarks" cols="80" rows="6"><%=remarks%></textarea>
                                    </font></td>
                                </tr>
                                <tr>
                                    <td width="13%" height="30" bgcolor="657A9A">&nbsp;</td>
                                    <td height="30" colspan="5" bgcolor="AEBACD">
                                        <input type="submit" name="Submit" value="OK">
                                        <font color="#000033">
                                            <input type="hidden" name="txtuserid" value="<%=userid%>">
                                            <input type="hidden" name="txtadminid" value="<%=loginuser.getUserID()%>">
                                            <input type="hidden" name="txtplaceid" value="<%=myPlace.getPlaceID()%>">
                                        </font>                        </td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td height="10" colspan="5"><font color="#FFFFFF" size="2"><b>Summe </b></font></td>
                                    <td width="15%" height="10" colspan="-2"><div align="right"><font size="2" color="#FFFFFF"><b><%=com.size()%></b></font></div></td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td height="10"><b><font size="2" color="#FFFFFF">Katagorie Name </font></b></td>
                                    <td width="36%" height="10"><b><font size="2" color="#FFFFFF">Beschwerde Bemerkung </font></b></td>
                                    <td width="9%"><b><font color="#FFFFFF" size="2">Datum</font></b></td>
                                    <td width="13%"><b><font color="#FFFFFF" size="2">Admin</font></b></td>
                                    <td width="14%"><b><font color="#FFFFFF" size="2">Schule</font></b></td>
                                    <td height="10" colspan="-2"><b><font color="#FFFFFF" size="2">Status</font></b></td>
                                </tr>

                                <%
                                    for(int i=0;i<com.size();i++){
                                        StudentComplaint ec=(StudentComplaint)com.elementAt(i);
                                        Complaint comp= complaintDB.getComplaints(ec.getComplaintID());
                                        sys = sysDB.getSystemUser(ec.getAdminID());
                                        myPlace = placeDao.getPlace(ec.getPlaceID());
                                        if(pageStatus==exp.COMPLAINTNOTACTIVE){
                                %>
                                <tr bgcolor="AEBACD">
                                    <td><font size="2" color="#000033"><a href="complaintView?id=<%=ec.getComplaintID()%>"><%=comp.getComplaintName()%></a></font><font size="2" color="#000000">&nbsp;</font></td>
                                    <td><font size="2" color="#000033"><a href="studentComplaintView?id=<%=ec.getComStudentID()%>&userid=<%=userid%>"><%=ec.getRemarks()%></a></font></td>
                                    <td><font size="2" color="#000033"><%=ec.getComplaintDate()%></font></td>
                                    <td><font size="2" color="#000033"><%=sys.getUserFirstName()+ ' ' + sys.getUserLastName()%></font></td>
                                    <td><font size="2" color="#000033"><%=myPlace.getPlaceName()%></font></td>
                                    <td height="10"><div align="left"><font color="#000033" size="2"><a href="changeStudentCompStatus?wid=<%=ec.getComStudentID()%>&status=<%=exp.COMPLAINTACTIVE%>&userid=<%=userid%>">erledigt</a></font></div></td>
                                </tr>
                                <%
                                }else if(pageStatus==exp.COMPLAINTACTIVE){
                                %>
                                <tr bgcolor="AEBACD">
                                    <td><font size="2" color="#000033"><a href="complaintView?id=<%=ec.getComplaintID()%>"><%=comp.getComplaintName()%></a></font><font size="2" color="#000000">&nbsp;</font></td>
                                    <td><font size="2" color="#000033"><a href="studentComplaintView?id=<%=ec.getComStudentID()%>&userid=<%=userid%>"><%=ec.getRemarks()%></a></font></td>
                                    <td><font size="2" color="#000033"><%=ec.getComplaintDate()%></font></td>
                                    <td><font size="2" color="#000033"><%=sys.getUserFirstName()+ ' ' + sys.getUserLastName()%></font></td>
                                    <td><font size="2" color="#000033"><%=myPlace.getPlaceName()%></font></td>
                                    <td height="10"><div align="left"><font color="#000033" size="2"><a href="changeStudentCompStatus?wid=<%=ec.getComStudentID()%>&status=<%=exp.COMPLAINTNOTACTIVE%>&userid=<%=userid%>">Nicht erledigt</a></font></div></td>
                                </tr>
                                <%
                                        }
                                    }
                                %>

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
