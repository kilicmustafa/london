<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.model.Place" %>
<%@ page import="com.rheinlandprivatschule.model.SystemUser" %>
<%@ page import="com.rheinlandprivatschule.repository.PlaceDao" %>
<%@ page import="com.rheinlandprivatschule.repository.SystemUserDao" %>
<%@ page import="java.util.Vector" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Ansicht Bericht ::</title>
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
    PlaceDao placeDao = (PlaceDao) request.getAttribute("placeDao");
    SystemUserDao systemUserDao = (SystemUserDao) request.getAttribute("systemUserDao");

    Vector vec=new Vector();
    Vector cityV=new Vector();
    Vector image=new Vector();
    int dayO=0;
    int yearO=0;
    String monthO="01";
    int day =0;
    int year=0;
    String month="01";
    String xtraCost=null;
    String bucher=null;
    String rent =null;


    vec= systemUserDao.getAllSystemUserWOTeacher();
    cityV=placeDao.getAllPlaces();

    month=MyDate.getMonth(MyDate.getCurrentSQLDate());
    String dayS=MyDate.getDay(MyDate.getCurrentSQLDate());
    String yearS=MyDate.getYear(MyDate.getCurrentSQLDate());
    day =Integer.parseInt(dayS);
    year=Integer.parseInt(yearS);

    java.util.Calendar gc=new java.util.GregorianCalendar();
    gc.setTime(MyDate.getCurrentSQLDate());
    gc.add(gc.DATE, -9);
    java.sql.Date tempdate=new java.sql.Date(gc.getTime().getTime());
    monthO=MyDate.getMonth(tempdate);
    String dayOS=MyDate.getDay(tempdate);
    String yearOS= MyDate.getYear(tempdate);
    dayO=Integer.parseInt(dayOS);
    yearO=Integer.parseInt(yearOS);
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
                        <form style="width: 100%;" name="form1" method="post" action="showEmployeeTimeSheet" onSubmit="MM_validateForm('tranNo','','NisNum');return document.MM_returnValue">
                            <table width="100%" border="0" height="112" cellpadding="1" cellspacing="1">
                                <tr bgcolor="657A9A">
                                    <td height="23" colspan="2">
                                        <div align="center"><font size="3" color="#FFFFFF"><b>Ansicht
                                            Mitarbeiter </b></font></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="29" width="24%" bgcolor="657A9A"><font color="#FFFFFF"><b>Gesichtspunkt</b></font></td>
                                    <td height="29" width="76%" bgcolor="AEBACD">
                                        <select name="selC" onChange="if(selectedIndex==2)tranNo.disabled=false;if(selectedIndex==0)tranNo.disabled=true;if(selectedIndex==1)tranNo.disabled=true;if(!tranNo.disabled)tranNo.focus()">
                                            <option value="2" selected>Date Limit</option>
                                            <option value="1">Given Date</option>
                                            <option value="3">Transaction No</option>
                                        </select>                          </td>
                                </tr>
                                <tr>
                                    <td height="29" width="24%" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Administrator</font></b></td>
                                    <td height="29" width="76%" bgcolor="AEBACD">
                                        <select name="selAdmin">
                                            <option selected>w&auml;hlen Administrator</option>
                                            <%
                                                for(int i=0;i<vec.size();i++)
                                                {
                                                    SystemUser uu=(SystemUser)vec.elementAt(i);
                                                    String aname=uu.getUserFirstName();
                                            %>
                                            <option value="<%=uu.getUserID()%>"><%=aname%></option>
                                            <%
                                                }
                                            %>
                                        </select>
                                        <font size="1" face="Verdana, Arial, Helvetica, sans-serif">
                                            <input type="button" name="All" value="Alle" onClick="Alle()">
                                        </font>                        </td>
                                </tr>
                                <tr>
                                    <td width="24%" height="25" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Schule
                                        Name</font></b></td>
                                    <td width="76%" height="25" bgcolor="AEBACD">
                                        <select name="selPlace">
                                            <option selected>w&auml;hlen Schule</option>
                                            <%
                                                for(int h=0;h<cityV.size();h++)
                                                {
                                                    Place plk=(Place)cityV.elementAt(h);
                                            %>
                                            <option value="<%=plk.getPlaceID()%>"><%=plk.getPlaceName()%></option>
                                            <%
                                                }
                                            %>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="24%" height="26" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Anfang
                                        Datum</font></b></td>
                                    <td width="76%" height="26" bgcolor="AEBACD">
                                        <select name="selSDay">
                                            <%
                                                for(int iSD=1;iSD<32;iSD++)
                                                {
                                                    if(dayO==iSD)
                                                    {
                                            %>
                                            <option selected><%=iSD%></option>
                                            <%
                                            }
                                            else
                                            {
                                            %>
                                            <option ><%=iSD%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                        <select name="selSMonth">
                                            <%
                                                Vector vtemp=new Vector();
                                                vtemp.addElement("Januar");
                                                vtemp.addElement("Februar");
                                                vtemp.addElement("März");
                                                vtemp.addElement("April");
                                                vtemp.addElement("Mai");
                                                vtemp.addElement("Juni");
                                                vtemp.addElement("Juli");
                                                vtemp.addElement("August");
                                                vtemp.addElement("September");
                                                vtemp.addElement("Oktober");
                                                vtemp.addElement("November");
                                                vtemp.addElement("Dezember");
                                                for(int iSM=0;iSM<vtemp.size();iSM++)
                                                {
                                                    String tempSM=(String)vtemp.elementAt(iSM);
                                                    if(Integer.parseInt(monthO)==(iSM+1))
                                                    {
                                            %>
                                            <option selected><%=tempSM%></option>
                                            <%
                                            }
                                            else
                                            {
                                            %>
                                            <option ><%=tempSM%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                        <select name="selSYear">
                                            <%
                                                for(int iSY=2004;iSY<2029;iSY++)
                                                {
                                                    if(iSY==yearO)
                                                    {
                                            %>
                                            <option selected><%=iSY%></option>
                                            <%
                                            }
                                            else
                                            {
                                            %>
                                            <option ><%=iSY%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="24%" height="26" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Ende
                                        Datum</font></b></td>
                                    <td width="76%" height="26" bgcolor="AEBACD">
                                        <select name="selEDay">
                                            <%
                                                for(int iED=1;iED<32;iED++)
                                                {
                                                    if(iED==day)
                                                    {
                                            %>
                                            <option selected><%=iED%></option>
                                            <%
                                            }
                                            else
                                            {
                                            %>
                                            <option><%=iED%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                        <select name="selEMonth">
                                            <%
                                                Vector vtempE=new Vector();
                                                vtempE.addElement("Januar");
                                                vtempE.addElement("Februar");
                                                vtempE.addElement("März");
                                                vtempE.addElement("April");
                                                vtempE.addElement("Mai");
                                                vtempE.addElement("Juni");
                                                vtempE.addElement("Juli");
                                                vtempE.addElement("August");
                                                vtempE.addElement("September");
                                                vtempE.addElement("Oktober");
                                                vtempE.addElement("November");
                                                vtempE.addElement("Dezember");
                                                for(int iEM=0;iEM<vtempE.size();iEM++)
                                                {
                                                    String tempEM=(String)vtempE.elementAt(iEM);
                                                    if(Integer.parseInt(month)==(iEM+1)){
                                            %>
                                            <option selected><%=tempEM%></option>
                                            <%
                                            }else{
                                            %>
                                            <option ><%=tempEM%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                        <select name="selEYear">
                                            <%
                                                for(int iEY=2004;iEY<2029;iEY++)
                                                {
                                                    if(iEY==year)
                                                    {
                                            %>
                                            <option selected><%=iEY%></option>
                                            <%
                                            }
                                            else
                                            {
                                            %>
                                            <option ><%=iEY%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="24%" height="24" bgcolor="657A9A">&nbsp;</td>
                                    <td width="76%" height="24" bgcolor="AEBACD">
                                        <input class="btn btn-primary" type="submit" name="Submit" value="Schauen">
                                        <font size="1" face="Verdana, Arial, Helvetica, sans-serif">&nbsp;                        </font>                        <font size="1" face="Verdana, Arial, Helvetica, sans-serif">&nbsp;                        </font>                        </td>
                                </tr>
                            </table>
                            <p>&nbsp;</p>
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
