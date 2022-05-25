<%@ page import="com.rheinlandprivatschule.repository.ComplaintDao" %>
<%@ page import="com.rheinlandprivatschule.repository.StudentComplaintDao" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.repository.StudentDao" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="com.rheinlandprivatschule.model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Beschwerden ::</title>
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
            window.location="../schuler/showStudentPreciseD?userid="+document.form1.userids.value;
        }
    </script>
</head>
<body>
<%
    StudentComplaintDao expDB= (StudentComplaintDao) request.getAttribute("studentComplaintDao");
    StudentComplaint exp=new  StudentComplaint();
    ComplaintDao complaintDB= (ComplaintDao) request.getAttribute("complaintDao");
    Complaint complaint=new Complaint();
    Student student=new Student();
    StudentDao studentDB= (StudentDao) request.getAttribute("studentDao");

    Vector v=new Vector();
    Vector com=new Vector();

    int userid=0;
    int id =0;
    int pageStatus=-1;
    String firstname="";
    String lastname="";
    String desc="";
    int studentComplaint=0;
    String remarks="";

    String valueS=(String)request.getParameter("userid");
    String idS=(String)request.getParameter("id");

    RPS rps = (RPS) session.getAttribute("handler");
    SystemUser loginuser=rps.getLoginUser();
    Place myPlace = rps.getLoginPlace();


    id=Integer.parseInt(idS);
    userid=Integer.parseInt(valueS);
    student=studentDB.getStudentInformation(userid,rps.getLoginUser().getUserID());
    session.setAttribute("pstudent",student);

    firstname=student.getUserFirstName();
    lastname=student.getUserLastName();
    //xtra = exp.getAllStudentComplaints(userid);
    v=complaintDB.getAllComplaints(0);
    exp=expDB.getComplaint(Integer.parseInt(idS));

    studentComplaint=exp.getComplaintID();
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="studentComplaintList?status=1&userid=<%=userid%>">Nicht erledigt</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="studentComplaintList?userid=<%=userid%>">erledigt</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="studentdetail()">Sch&uuml;ler Kurs Einzelheit</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width: 100%;" name="form1" method="post" action="updateStudentCompView" onSubmit="MM_validateForm('txtRemarks','','R');return document.MM_returnValue">
                            <input name="status" type="hidden" id="status" value="notactive">
                            <input type="hidden" name="userids" value="<%=userid%>">
                            <table width="100%" height="96" border="0" cellpadding="1" cellspacing="1">
                                <tr bgcolor="657A9A">
                                    <th height="17" colspan="2"><b><font color="#FFFFFF">Beschwerden</font></b></th>
                                </tr>
                                <tr>
                                    <td width="19%" height="21" bgcolor="657A9A"><font color="#FFFFFF" size="2"><b>Schuler Name </b></font></td>
                                    <td height="21" bgcolor="AEBACD"><font size="2" color="#000033"><%=firstname%></font><font color="#000033">&nbsp;
                                    </font></td>
                                </tr>
                                <tr>
                                    <td height="2" bgcolor="657A9A"><font color="#FFFFFF" size="2"><b>Katagorie</b></font></td>
                                    <td height="2" bgcolor="AEBACD"><font color="#000033">                          <select name="selCate">
                                        <option value="0" selected>w&auml;hlen</option>
                                        <%
                                            for(int g=0;g<v.size();g++)
                                            {
                                                Complaint uc=(Complaint)v.elementAt(g);
                                                if(uc.getComplaintID()== studentComplaint)
                                                {
                                        %>
                                        <option value="<%=uc.getComplaintID()%>" selected><%=uc.getComplaintName()%></option>
                                        <%
                                        }
                                        else
                                        {
                                        %>
                                        <option value="<%=uc.getComplaintID()%>"><%=uc.getComplaintName()%></option>
                                        <%
                                                }
                                            }
                                        %>
                                    </select>
                                    </font></td>
                                </tr>
                                <tr>
                                    <td height="2" bgcolor="657A9A"><font color="#FFFFFF" size="2"><b>Bemerkung</b></font></td>
                                    <td height="2" bgcolor="AEBACD"><font color="#000033">
                                        <textarea name="txtRemarks" cols="80" rows="6"><%=exp.getRemarks()%></textarea>
                                    </font></td>
                                </tr>
                                <tr>
                                    <td width="19%" height="30" bgcolor="657A9A">&nbsp;</td>
                                    <td height="30" bgcolor="AEBACD">
                                        <input type="submit" name="Submit" value="OK">
                                        <font color="#000033">
                                            <input type="hidden" name="txtuserid" value="<%=userid%>">
                                            <input type="hidden" name="txtadminid" value="<%=loginuser.getUserID()%>">
                                            <input type="hidden" name="txtplaceid" value="<%=myPlace.getPlaceID()%>">
                                        </font>                        <font color="#000033">
                                        <input type="hidden" name="txtID" value="<%=id%>">
                                    </font></td>
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
