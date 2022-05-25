<%@ page import="com.rheinlandprivatschule.model.SystemUser" %>
<%@ page import="com.rheinlandprivatschule.model.Certificate" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="com.rheinlandprivatschule.repository.CertificateDao" %>
<%@ page import="com.rheinlandprivatschule.repository.StudentDao" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
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
        function verify()
        {
            window.location="verifyCertAgain.jsp?useridS="+document.form1.userid.value
                +"&courseidS="+document.form1.courseid.value
                +"&hvTS="+document.form1.hvT.value
                +"&tpTS="+document.form1.tpT.value
                +"&lvTS="+document.form1.lvT.value
                +"&wsTS="+document.form1.wsT.value
                +"&mpTS="+document.form1.mpT.value
                +"&fsTS="+document.form1.fsT.value;
        }
    </script>
</head>
<body>
<%
    int userid=0;
    int userid1=0;
    double hvT=0;
    double tpT=0;
    double lvT=0;
    double wsT=0;
    double mpT=0;

    double fsT=0;

    double ndgT=0;
    int courseid=0;
    double testcount=0;
    Vector vec=new Vector();
    String Counter="1";
    int failCount = 0;
    double[] moduleMarks = new double[5];

    RPS rps=(RPS)session.getAttribute("handler");

    SystemUser loginuser= rps.getLoginUser();

    Student u=(Student)session.getAttribute("pstudent");
    Certificate c=(Certificate)session.getAttribute("certificate");

    loginuser=rps.getLoginUser();

    if(u==null){
        String err="W�hlen Sie Sch�ler Zuerst aus";
        session.setAttribute("err",err);
        session.setAttribute("lin","seacrhStudent.jsp");
        response.sendRedirect("error.jsp");
    }else{
        session.setAttribute("pstudent",u);
        loginuser=rps.getLoginUser();
        userid=u.getUserID();
        CertificateDao cdb=new CertificateDao();
        StudentDao studentDB= (StudentDao) request.getAttribute("studentDao");

        if(studentDB.canSeeCourseRegistration(rps.getLoginUser().getUserID())){
            String cmd=(String)request.getParameter("cmd");

            hvT=Double.parseDouble((String)request.getParameter("hvT"));
            tpT=Double.parseDouble((String)request.getParameter("tpT"));
            lvT=Double.parseDouble((String)request.getParameter("lvT"));
            wsT=Double.parseDouble((String)request.getParameter("wsT"));
            mpT=Double.parseDouble((String)request.getParameter("mpT"));
            fsT=Double.parseDouble((String)request.getParameter("fsT"));
            courseid=Integer.parseInt((String)request.getParameter("courseid"));
            userid=Integer.parseInt((String)request.getParameter("userid"));

            if (hvT>0){
                vec.addElement(Counter);
                moduleMarks[0] = hvT;
                //moduleMarks.add(hvT);
            }
            if (tpT>0){
                vec.addElement(Counter);
                moduleMarks[1] = tpT;
                //moduleMarks.add(tpT);
            }
            if (lvT>0){
                vec.addElement(Counter);
                moduleMarks[2] = lvT;
                //moduleMarks.add(lvT);
            }
            if (wsT>0){
                vec.addElement(Counter);
                moduleMarks[3] = wsT;
                //moduleMarks.add(wsT);
            }
            if (mpT>0){
                vec.addElement(Counter);
                moduleMarks[4] = mpT;
                //moduleMarks.add(mpT);
            }

            testcount = vec.size() * 100;
            //ndgT=((hvT+tpT+lvT+wsT+mpT)/testcount)*100;

            for(int i=0;i<=4;i++){
                if (moduleMarks[i] < 60){
                    failCount++;
                }
            }

            System.out.println(failCount);
            System.out.println(testcount);
            System.out.println(((hvT+tpT+lvT+wsT)/4)*100);

            if (failCount < 2){
                if ((((hvT*2)+(tpT*2)+(lvT*2)+wsT)/7) >60){
                    ndgT=(((hvT*2)+(tpT*2)+(lvT*2)+wsT+mpT)/8);
                }else {
                    ndgT=0.00;
                }
            }
            else {
                ndgT=0.00;
            }

        }else{
            String err=studentDB.getError();
            session.setAttribute("err",err);
            session.setAttribute("lin","../map.jsp");
            response.sendRedirect("error.jsp");
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
                        <form style="width: 100%;" name="form1" method="post" action="nocer">
                            <table width="100%" border="0" cellspacing="1" cellpadding="1">
                                <tr>
                                    <td colspan="2">
                                        <div align="right"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">
                                            <input name="cmd" type="hidden" id="cmd" value="cmd">
                                            <input type="hidden" name="userids" value="<%=userid%>">
                                            <input type="button" name="Submit32" value="Sch&uuml;ler-Information" onClick="studentdetail()">
                                            <input type="button" name="Submit22" value="Haupt" onClick="haupt()">
                                        </font></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A" colspan="2">
                                        <div align="center"><font size="3" color="#FFFFFF"><b>Zertifikat</b></font></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><font color="#FFFFFF" size="2"><strong>H&ouml;rverstehen</strong></font></td>
                                    <td bgcolor="AEBACD"><input name="hvT" type="text" id="hvT" value="<%=hvT%>"></td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><font color="#FFFFFF" size="2"><strong>Textproduktion</strong></font></td>
                                    <td bgcolor="AEBACD"><input name="tpT" type="text" id="tpT" value="<%=tpT%>"></td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><font color="#FFFFFF" size="2"><strong>Leseverstehen</strong></font></td>
                                    <td bgcolor="AEBACD"><input name="lvT" type="text" id="lvT" value="<%=lvT%>"></td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><font color="#FFFFFF" size="2"><strong>Wissenschaftssprachliche Strukturen</strong></font></td>
                                    <td bgcolor="AEBACD"><input name="wsT" type="text" id="wsT" value="<%=wsT%>"></td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><font color="#FFFFFF" size="2"><strong>M&uuml;ndliche Pr&uuml;fung</strong></font></td>
                                    <td bgcolor="AEBACD"><input name="mpT" type="text" id="mpT" value="<%=mpT%>"></td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><font color="#FFFFFF" size="2"><strong>Fehlstunden</strong></font></td>
                                    <td bgcolor="AEBACD"><input name="fsT" type="text" id="fsT" value="<%=fsT%>"></td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A"><font color="#FFFFFF" size="2"><strong>Note der Gesamtleistung</strong></font></td>
                                    <td bgcolor="AEBACD"><input name="ndgT" type="text" id="ndgT" value="<%=MyCurrency.getDisplayString(ndgT)%>" readonly="">
                                        <input name="courseid" type="hidden" id="courseid" value="<%=courseid%>">
                                        <input name="userid" type="hidden" id="userid" value="<%=userid%>">                        </td>
                                </tr>
                                <tr>
                                    <td width="29%" bgcolor="657A9A">&nbsp;</td>
                                    <td width="71%" bgcolor="AEBACD">
                                        <input class="btn btn-primary" type="button" name="prufen" value="pr�fen" onClick="verify()">
                                        <input class="btn btn-primary" type="submit" name="Submit" value="Zertifikat">
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
