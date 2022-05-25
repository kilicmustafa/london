<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.repository.ResidenceDao" %>
<%@ page import="com.rheinlandprivatschule.repository.ResidenceOwnerDao" %>
<%@ page import="com.rheinlandprivatschule.model.ResidenceOwner" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ page import="com.rheinlandprivatschule.model.Residence" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Wohnungliste ::</title>
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

        function notactive()
        {
            window.location="mieterListNotActive";
        }
        function active()
        {
            window.location="mieterList";
        }


        function newresidence(){
            window.location="newResidenceForm";
        }

        function sc(){
            document.form1.action="adminUserList?cmd=set";
            document.form1.submit();
        }
        function composeMail(){
            document.form1.action="mailComposer";
            document.form1.submit();
        }

        function checkAll(chk){
            if(chk.checked==true){

                for (i = 0; i < form1.checkbox.length; i++)	{
                    form1.checkbox[i].checked = true ;
                }
            }else{
                for (ii = 0; ii < form1.checkbox.length; ii++){
                    form1.checkbox[ii].checked = false ;
                }
            }
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
    String currentmonth1 = MyDate.getMonthNameSmall(Integer.parseInt(MyDate.getMonth(MyDate.getCurrentSQLDate())), MyDate.DEUTSCH);
    String currentmonth2 = MyDate.getMonthNameSmall(Integer.parseInt(MyDate.getMonth(MyDate.getLastMonth1st())), MyDate.DEUTSCH);
    String currentmonth3 = MyDate.getMonthNameSmall(Integer.parseInt(MyDate.getMonth(MyDate.getLastMonth2nd())), MyDate.DEUTSCH);
    String currentmonth4 = MyDate.getMonthNameSmall(Integer.parseInt(MyDate.getMonth(MyDate.getLastMonth3rd())), MyDate.DEUTSCH);
    String currentmonth5 = MyDate.getMonthNameSmall(Integer.parseInt(MyDate.getMonth(MyDate.getLastMonth4th())), MyDate.DEUTSCH);
    String currentmonth6 = MyDate.getMonthNameSmall(Integer.parseInt(MyDate.getMonth(MyDate.getLastMonth5th())), MyDate.DEUTSCH);

    ResidenceDao rdb= (ResidenceDao) request.getAttribute("residenceDao");
    ResidenceOwnerDao rodb= (ResidenceOwnerDao) request.getAttribute("residenceOwnerDao");

    ResidenceOwner residenceOwner = new ResidenceOwner();
    Vector v=new Vector();
    Vector u=new Vector();

    String owneridS=(String)request.getParameter("ownerid");
    if(owneridS!=null){
        v=rdb.getAllResidencesByOwner(Integer.parseInt(owneridS));
    }else{
        //v=rdb.getAllResidences();
        v=rdb.getRentInNotActive();
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="active()">Aktivliste</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="notactive()">Nicht Aktivliste</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form name="form1" style="width: 100%;" method="post" action="mieterList1" onSubmit="MM_validateForm('too','','R','subject','','R');return document.MM_returnValue">
                            <table width="100%" border="0" cellspacing="1" cellpadding="1">
                                <tr>
                                    <td width="100%" colspan="5">
                                        <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                            <tr bgcolor="657A9A">
                                                <td colspan="9" height="16">
                                                    <div align="center"><b><font color="#FFFFFF">Wohnungliste </font></b></div>
                                                </td>
                                            </tr>
                                            <tr bgcolor="#405579">
                                                <td width="15%" bgcolor="657A9A"><div align="left"><font color="#FFFFFF" size="2"><b>Bezeichnung</b></font></div></td>
                                                <td width="7%" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Miete (Mieter) </font></strong></td>
                                                <td width="5%" height="18" bgcolor="657A9A"><div align="center"><font size="3"><font color="#FFFFFF"><%=currentmonth1%></font></font></div></td>
                                                <td width="5%" height="18" bgcolor="657A9A"><div align="center"><font size="3"><font color="#FFFFFF"><%=currentmonth2%></font></font></div></td>
                                                <td width="5%" height="18" bgcolor="657A9A"><div align="center"><font size="3"><font color="#FFFFFF"><%=currentmonth3%></font></font></div></td>
                                                <td width="5%" height="18" bgcolor="657A9A"><div align="center"><font size="3"><font color="#FFFFFF"><%=currentmonth4%></font></font></div></td>
                                                <td width="5%" height="18" bgcolor="657A9A"><div align="center"><font size="3"><font color="#FFFFFF"><%=currentmonth5%></font></font></div></td>
                                                <td width="5%" height="18" bgcolor="657A9A"><div align="center"><font size="3"><font color="#FFFFFF"><%=currentmonth6%></font></font></div></td>
                                            </tr>
                                            <%
                                                for(int i=0;i<v.size();i++)
//for(int j=0;j<u.size();j++)
                                                {
                                                    Residence residence=(Residence)v.elementAt(i);
                                                    //int owner=residence.getResidenceOwner();
                                                    //residenceOwner = rodb.getResidenceOwner(owner);

                                                    //{
                                                    //rps.wohnung.Residence res=(rps.wohnung.Residence)u.elementAt(j);
                                            %>
                                            <tr bgcolor="AEBACD">
                                                <td height="6"><font size="2" color="#000033"><font size="2" color="#000033"><a href="residenceDetails?residenceid=<%=residence.getResidenceID()%>"><%=residence.getResidenceMark()%></a></font></font></td>
                                                <td height="6" bgcolor="AEBACD"><font size="2" color="#000033"><%=MyCurrency.getDisplayString(residence.getResidenceRent())%></font></td>
                                                <td height="6"><font size="2" color="#000033"><font size="2" color="#000033"><a href="rentIncoming?residenceid=<%=residence.getResidenceID()%>"><%=MyCurrency.getDisplayString(residence.getResidenceRent() - residence.getAmountPaid())%></a></font></font></td>
                                            </tr>

                                            <%
                                                    //}
                                                }
                                            %>
                                        </table>
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
