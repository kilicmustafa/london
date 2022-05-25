<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.repository.*" %>
<%@ page import="com.rheinlandprivatschule.model.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Schulen ::</title>
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
        function popUp(loc,eyeD,X,Y){
            window.open(loc,eyeD,"toolbar=no,location=0,directories=no,status=no,menubar=0,scrollbars=yes,resizable=0,width=" + X + ",height=" + Y + "'");
        }


        function MM_findObj(n, d) { //v4.0
            var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
                d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
            if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
            for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
            if(!x && document.getElementById) x=document.getElementById(n); return x;
        }

        function MM_validateForm() { //v4.0
            var i,p,q,nm,test,num,min,max,errors='',args=MM_validateForm.arguments;
            for (i=0; i<(args.length-2); i+=3) { test=args[i+2]; val=MM_findObj(args[i]);
                if (val) { nm=val.name; if ((val=val.value)!="") {
                    if (test.indexOf('isEmail')!=-1) { p=val.indexOf('@');
                        if (p<1 || p==(val.length-1)) errors+='- '+nm+' must contain an e-mail address.\n';
                    } else if (test!='R') {
                        if (isNaN(val)) errors+='- '+nm+' must contain a number.\n';
                        if (test.indexOf('inRange') != -1) { p=test.indexOf(':');
                            min=test.substring(8,p); max=test.substring(p+1);
                            if (val<min || max<val) errors+='- '+nm+' must contain a number between '+min+' and '+max+'.\n';
                        } } } else if (test.charAt(0) == 'R') errors += '- '+nm+' is required.\n'; }
            } if (errors) alert('The following error(s) occurred:\n'+errors);
            document.MM_returnValue = (errors == '');
        }
    </script>
</head>
<body>
<%

    String status="0";
    String groupid="0";
    String cri="";
    String adminS="";
    String placename="";
    String tranno="";
    String sDay="";
    String sMonth="";
    String sYear="";
    String eDay="";
    String eMonth="";
    String eYear="";
    String flag="";

    RPS rps=(RPS)session.getAttribute("handler");
    SystemUser u= rps.getLoginUser();

    try{

        cri=(String)request.getParameter("selC");
        adminS=(String)request.getParameter("selAdmin");
        placename=(String)request.getParameter("selPlace");
        tranno=(String)request.getParameter("tranNo");
        sDay=(String)request.getParameter("selSDay");
        sMonth=(String)request.getParameter("selSMonth");
        sYear=(String)request.getParameter("selSYear");
        eDay=(String)request.getParameter("selEDay");
        eMonth=(String)request.getParameter("selEMonth");
        eYear=(String)request.getParameter("selEYear");
        flag=(String)request.getParameter("status");
        status=(String)request.getParameter("status");
        groupid=(String)request.getParameter("wid");

        StudentComplaintDao sidb= (StudentComplaintDao) request.getAttribute("handler");

        if(sidb.setComplaintStatus(Integer.parseInt(groupid),Integer.parseInt(flag))){
            response.sendRedirect("showComplaint?tranNo="+tranno+"&selPlace="+placename+"&selC="+cri+"&selAdmin="+adminS+"&selSDay="+sDay+"&selSMonth="+sMonth+"&selSYear="+sYear+"&selEDay="+eDay+"&selEMonth="+eMonth+"&selEYear="+eYear);
        }else{
            String err=sidb.getError();
            session.setAttribute("err",err);
            session.setAttribute("lin","showComplaint?tranNo="+tranno+"&selPlace="+placename+"&selC="+cri+"&selAdmin="+adminS+"&selSDay="+sDay+"&selSMonth="+sMonth+"&selSYear="+sYear+"&selEDay="+eDay+"&selEMonth="+eMonth+"&selEYear="+eYear);
            response.sendRedirect("error");

            //response.sendRedirect("messeStudentTelephoneFormInt.jsp?messeid="+messeid+"&studentID="+studentIDm);
//				response.sendRedirect("showComplaint.jsp?status="null"&tranNo="+tranno+"&selPlace="+placename+"&selC="+cri+"&selAdmin="+adminS+"&selSDay="+sDay+"&selSMonth="+sMonth+"&selSYear="+sYear+"&selEDay="+eDay+"&selEMonth="+eMonth+"&selEYear="+eYear)
        }
    }
    catch(Exception e){
        String err="Problem, noch einmal versuchen"+e.toString();
        session.setAttribute("err",err);
        session.setAttribute("lin","showComplaint?tranNo="+tranno+"&selPlace="+placename+"&selC="+cri+"&selAdmin="+adminS+"&selSDay="+sDay+"&selSMonth="+sMonth+"&selSYear="+sYear+"&selEDay="+eDay+"&selEMonth="+eMonth+"&selEYear="+eYear);
        response.sendRedirect("error");
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
                        <form name="form1" method="post" action="addEUnterrichtProcess" onSubmit="MM_validateForm('txtFee','','RisNum','strength','','RisNum','hours','','R');return document.MM_returnValue">
                            <table width="100%" border="0" height="127">
                                <tr>
                                    <td colspan="2" height="38">
                                        <div align="right"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">
                                        </font></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" height="82">&nbsp; </td>
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
