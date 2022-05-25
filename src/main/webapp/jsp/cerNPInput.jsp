<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.model.Certificate" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="com.rheinlandprivatschule.repository.CertificateDao" %>
<%@ page import="com.rheinlandprivatschule.model.SystemUser" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Zertifikat ::</title>
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
            window.location="showStudentPreciseD?userid="+document.form1.userids.value;
        }
        function changeCity()
        {
            document.form2.submit()
        }
    </script>
</head>
<body>
<%
    RPS rps=(RPS)session.getAttribute("handler");

    SystemUser loginuser= rps.getLoginUser();


    double hv=0;
    double tp=0;
    double lv=0;
    double ws=0;
    double mp=0;

    double fs=0;

    double ndg=0;
    int courseid=0;


    Student u=(Student)session.getAttribute("pstudent");
    int userid= u.getUserID();
    if(u==null){
        String err="Wï¿½hlen Sie Schï¿½ler Zuerst aus";
        session.setAttribute("err",err);
        session.setAttribute("lin","seacrhStudent");
        response.sendRedirect("error");
    }else{
        CertificateDao cdb=new CertificateDao();
        String cmd=(String)request.getParameter("cmd");

        String hvS=(String)request.getParameter("hvT");
        String tpS=(String)request.getParameter("tpT");
        String lvS=(String)request.getParameter("lvT");
        String wsS=(String)request.getParameter("wsT");
        String mpS=(String)request.getParameter("mpT");

        String fsS=(String)request.getParameter("fsT");

        String ndgS=(String)request.getParameter("ndgT");

        if(cmd!=null){
            hv=Double.parseDouble(hvS);
            tp=Double.parseDouble(tpS);
            lv=Double.parseDouble(lvS);
            ws=Double.parseDouble(wsS);
            mp=Double.parseDouble(mpS);

            fs=Double.parseDouble(fsS);

            ndg=Double.parseDouble(ndgS);

            if(ndg<60){
                String err="Es ist nicht mï¿½glich, Note ist nicht Gut";
                session.setAttribute("err",err);
                session.setAttribute("lin","showStudentPreciseD?userid="+u.getUserID());
                response.sendRedirect("error");
            }else{
                String id=(String)session.getAttribute("myco");
                if(id!=null){
                    int va=Integer.parseInt(id);
                    courseid =va;
                    int chk=cdb.addCertificateNP(u.getUserID(),va,hv,tp,lv,ws,mp,fs,ndg,MyDate.getCurrentSQLDate(),loginuser.getUserID());
                    Certificate c=cdb.getCertificateNP(chk);
                    session.setAttribute("certificate",c);
                    session.setAttribute("pstudent",u);
                    response.sendRedirect("verifyCert");
                }else{
                    String err="Es ist nicht mï¿½glich.";
                    session.setAttribute("err",err);
                    session.setAttribute("lin","showStudentPreciseD?userid="+u.getUserID());
                    response.sendRedirect("error");
                }
            }
        }else{
            String id=(String)request.getParameter("courseid");
            courseid = Integer.parseInt(id);
            session.setAttribute("myco",id);
            //cdb.makeCertificate(Integer.parseInt(id),u.getUserID());
            hv=0;
            tp=0;
            lv=0;
            ws=0;
            mp=0;
            fs=0;//cdb.getPresentStunden();
            ndg=0;//cdb.getEndPercentage();
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
                        <form style="width: 100%;" name="form1" method="post" action="verifyCertNP">
                            <table width="100%" border="0" cellspacing="1" cellpadding="1">
                                <input name="cmd" type="hidden" id="cmd" value="cmd">
                                <input type="hidden" name="userids" value="<%=userid%>">
                                <tr>
                                    <td bgcolor="657A9A" colspan="2">
                                        <div align="center"><font size="3" color="#FFFFFF"><b>Zertifikat</b></font></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><font color="#FFFFFF" size="2"><strong>H&ouml;rverstehen</strong></font></td>
                                    <td bgcolor="AEBACD"><input name="hvT" type="text" id="hvT" value="<%=hv%>"></td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><font color="#FFFFFF" size="2"><strong>Textproduktion</strong></font></td>
                                    <td bgcolor="AEBACD"><input name="tpT" type="text" id="tpT" value="<%=tp%>"></td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><font color="#FFFFFF" size="2"><strong>Leseverstehen</strong></font></td>
                                    <td bgcolor="AEBACD"><input name="lvT" type="text" id="lvT" value="<%=lv%>"></td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><font color="#FFFFFF" size="2"><strong>Wissenschaftssprachliche Strukturen</strong></font></td>
                                    <td bgcolor="AEBACD"><input name="wsT" type="text" id="wsT" value="<%=ws%>"></td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><font color="#FFFFFF" size="2"><strong>M&uuml;ndliche Pr&uuml;fung</strong></font></td>
                                    <td bgcolor="AEBACD"><input name="mpT" type="text" id="mpT" value="<%=mp%>"></td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><font color="#FFFFFF" size="2"><strong>Fehlstunden</strong></font></td>
                                    <td bgcolor="AEBACD"><input name="fsT" type="text" id="fsT" value="<%=fs%>"></td>
                                </tr>
                                <tr>
                                    <td width="29%" bgcolor="657A9A">&nbsp;</td>
                                    <td width="71%" bgcolor="AEBACD">
                                        <input class="btn btn-primary" name="courseid" type="hidden" id="courseid" value="<%=courseid%>">
                                        <input class="btn btn-primary" name="userid" type="hidden" id="userid" value="<%=userid%>">
                                        <input class="btn btn-primary" type="submit" name="Submit" value="Pr&uuml;fen">
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
