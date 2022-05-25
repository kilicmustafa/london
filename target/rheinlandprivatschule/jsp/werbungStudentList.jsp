<%@ page import="com.rheinlandprivatschule.repository.WerbungDao" %>
<%@ page import="com.rheinlandprivatschule.model.Werbung" %>
<%@ page import="com.rheinlandprivatschule.repository.StudentDao" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ page import="com.rheinlandprivatschule.model.StudentFinance" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Neur Werbung Klassifikation ::</title>
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
        function back()
        {
            window.location="werbungList"
        }

        function MM_findObj(n, d) { //v4.0
            var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
                d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
            if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
            for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
            if(!x && document.getElementById) x=document.getElementById(n); return x;
        }

        function notactive()
        {
            window.location="werbungStudentList?status="+document.form1.status.value;
        }
        function active()
        {
            window.location="werbungStudentList";
        }

    </script>
</head>
<body>
<%
    WerbungDao wdb = (WerbungDao) request.getAttribute("werbungDao");
    Werbung werbung = new Werbung();
    StudentDao sdb=(StudentDao) request.getAttribute("studentDao");
    Vector students=new Vector();
    double geb=0;
    double bez=0;
    double noc=0;
    Vector image=new Vector();
    int werbungid=0;
    int pageStatus=-1;


    String werS=(String)request.getParameter("wid");
    String flag=(String)request.getParameter("status");

    try{
        int wer =Integer.parseInt(werS);
        //students=sdb.getStudentRelatedToWerbung(wer);
        werbung = wdb.getWerbung(wer);

        werbungid = werbung.getWerbungID();

    }catch(Exception e){
    }

    if(flag==null){
        pageStatus=wdb.STUDENTACTIVE;
        students=wdb.getStudentRelatedToWerbung(werbungid,wdb.STUDENTACTIVE);
    }else{
        pageStatus=wdb.STUDENTNOTACTIVE;
        students=wdb.getStudentRelatedToWerbung(werbungid,wdb.STUDENTNOTACTIVE);
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="werbungStudentList?status=0&wid=<%=werbungid%>">Nicht Aktivliste</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="werbungStudentList?wid=<%=werbungid%>">Aktivliste</a>

                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="back()">Zur&uuml;ck</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td valign="top" height="434" bgcolor="D9E5F4" width="82%">
                                    <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                        <tr>
                                            <td bgcolor="657A9A" height="17">
                                                <div align="center"><font size="3" color="#FFFFFF"><b>Student
                                                    des Werbung
                                                    <input type="hidden" name="hiddenField">
                                                    <input name="status" type="hidden" id="status" value="notactive">
                                                </b></font></div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top">                      <form style="width: 100%;" name="form1" method="post" action="">
                                                <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                                    <tr>
                                                        <td height="20" bgcolor="657A9A" width="18%"><font color="#FFFFFF" size="2"><b>Summe </b></font></td>
                                                        <td height="20" bgcolor="657A9A" colspan="5"><div align="right"><font size="2" color="#FFFFFF"><b><%=students.size()%></b></font></div></td>
                                                    </tr>
                                                    <tr>
                                                        <td height="20" bgcolor="657A9A" width="18%"><b><font size="2" color="#FFFFFF">Vorname</font></b></td>
                                                        <td height="20" bgcolor="657A9A" width="20%"><b><font size="2" color="#FFFFFF">Nachname</font></b></td>
                                                        <td height="20" bgcolor="657A9A" width="18%"><b><font size="2" color="#FFFFFF">Geb&uuml;hr</font></b></td>
                                                        <td bgcolor="657A9A" width="17%"><b><font color="#FFFFFF" size="2">Bezahlt</font></b></td>
                                                        <td bgcolor="657A9A" width="16%"><font size="2" color="#FFFFFF"><b>Nochoffen</b></font></td>
                                                        <td height="20" bgcolor="657A9A" width="16%">&nbsp;</td>
                                                    </tr>
                                                    <%
                                                        for(int i=0;i<students.size();i++)
                                                        {
                                                            Student uu=(Student)students.elementAt(i);
                                                            StudentFinance sf=sdb.getStudentFinanceStatus(uu.getUserID());
                                                            geb=geb+sf.getTotalFee();
                                                            bez=bez+(sf.getTotalFee()-sf.getBalance());
                                                            noc=noc+sf.getBalance();
                                                            if(pageStatus==wdb.STUDENTNOTACTIVE){
                                                    %>
                                                    <tr bgcolor="AEBACD">
                                                        <td><font size="2" color="#000000"><a href="../schuler/showStudentPreciseD?userid=<%= uu.getUserID()%>"><%=uu.getUserFirstName()%></a></font></td>
                                                        <td bgcolor="AEBACD"><font size="2" color="#000000"><%=uu.getUserLastName()%></font></td>
                                                        <td bgcolor="AEBACD"><font size="2" color="#000000"><%=MyCurrency.getDisplayString(sf.getTotalFee())%></font></td>
                                                        <td><font size="2" color="#000000"><%=MyCurrency.getDisplayString((sf.getTotalFee()-sf.getBalance()))%></font></td>
                                                        <td><font size="2" color="#000000"><%=MyCurrency.getDisplayString(sf.getBalance())%></font></td>
                                                        <td width="11%"><font color="#000033" size="2"><a href="changeWerbungStatus?wid=<%=werbungid%>&status=<%=wdb.STUDENTACTIVE%>&userid=<%= uu.getUserID()%>">Aktiv</a></font></td>
                                                    </tr>
                                                    <%
                                                    }else if(pageStatus==wdb.STUDENTACTIVE){
                                                    %>
                                                    <tr bgcolor="AEBACD">
                                                        <td width="18%"><font size="2" color="#000000"><a href="../schuler/showStudentPreciseD?userid=<%= uu.getUserID()%>"><%=uu.getUserFirstName()%></a></font></td>
                                                        <td bgcolor="AEBACD" width="20%"><font size="2" color="#000000"><%=uu.getUserLastName()%></font></td>
                                                        <td bgcolor="AEBACD" width="18%"><font size="2" color="#000000"><%=MyCurrency.getDisplayString(sf.getTotalFee())%></font></td>
                                                        <td width="17%"><font size="2" color="#000000"><%=MyCurrency.getDisplayString((sf.getTotalFee()-sf.getBalance()))%></font></td>
                                                        <td width="16%"><font size="2" color="#000000"><%=MyCurrency.getDisplayString(sf.getBalance())%></font></td>
                                                        <td width="11%"><font color="#000033" size="2"><a href="changeWerbungStatus?wid=<%=werbungid%>&status=<%=wdb.STUDENTNOTACTIVE%>&userid=<%= uu.getUserID()%>">Nicht Aktiv</a></font></td>
                                                    </tr>
                                                    <%
                                                            }
                                                        }
                                                    %>
                                                    <tr bgcolor="657A9A">
                                                        <td width="18%">&nbsp;</td>
                                                        <td width="20%">&nbsp;</td>
                                                        <td width="18%"><b><font size="2" color="#FFFFFF"><%=MyCurrency.getDisplayString(geb)%></font></b></td>
                                                        <td width="17%"><b><font size="2" color="#FFFFFF"><%=MyCurrency.getDisplayString(bez)%></font></b></td>
                                                        <td width="16%"><b><font size="2" color="#FFFFFF"><%=MyCurrency.getDisplayString(noc)%></font></b></td>
                                                        <td width="16%">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </form></td>
                                        </tr>
                                    </table>
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
