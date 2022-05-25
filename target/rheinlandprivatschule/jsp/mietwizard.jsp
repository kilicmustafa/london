<%@ page import="com.rheinlandprivatschule.repository.ResidenceDao" %>
<%@ page import="com.rheinlandprivatschule.repository.MietenDB" %>
<%@ page import="java.util.Vector" %>
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
    ResidenceDao rdb= (ResidenceDao) request.getAttribute("residenceDao");
    MietenDB mdb= (MietenDB) request.getAttribute("mietenDB");


    String residentidS= request.getParameter("residentid");
    session.setAttribute("pmieter",residentidS);
    Vector v=rdb.getAllResidences();
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
                        <form style="width: 100%;" name="form1" method="post" action="newResidenceMieten" onSubmit="MM_validateForm('too','','R','subject','','R');return document.MM_returnValue">
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
                                                <td width="5%" bgcolor="657A9A"><div align="left"><font color="#FFFFFF" size="2"></font></div></td>
                                                <td width="14%" bgcolor="657A9A"><font color="#FFFFFF" size="2"><b>Bezeichnung</b></font></td>
                                                <td width="13%" height="14" bgcolor="657A9A"><font color="#FFFFFF"><b><font size="2">Stadt</font></b></font></td>
                                                <td width="20%" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Addresse</font></strong></td>
                                                <td width="10%" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">PLZ</font></strong></td>
                                                <td width="13%" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Land</font></strong></td>
                                                <td width="7%" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Gro&szlig;</font></strong></td>
                                                <td width="8%" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Miete</font></strong></td>
                                                <td width="10%" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Nebenkosten</font></strong><strong></strong><strong></strong><strong></strong><strong></strong></td>
                                            </tr>
                                            <%
                                                for(int i=0;i<v.size();i++)
                                                {
                                                    Residence residence=(Residence)v.elementAt(i);

                                            %>
                                            <tr bgcolor="AEBACD">
                                                <td height="6"><font size="2" color="#000033"><font size="2" color="#000033">
                                                    <input name="sel" type="radio" value="<%=residence.getResidenceID()%>">
                                                </font></font></td>
                                                <td height="6"><font size="2" color="#000033"><font size="2" color="#000033"><a href="residenceDetails?residenceid=<%=residence.getResidenceID()%>"><%=residence.getResidenceMark()%></a></font></font></td>
                                                <td width="13%" height="6"><font size="2" color="#000033"><%=residence.getResidenceCity()%></font></td>
                                                <td width="20%" height="6"><font size="2" color="#000033"><%=residence.getResidenceAddress()%></font></td>
                                                <td width="10%" height="6"><font size="2" color="#000033"><%=residence.getResidencePostCode()%></font></td>
                                                <td width="13%" height="6"><font size="2" color="#000033"><%=residence.getResidenceCountry()%></font></td>
                                                <td height="6" bgcolor="AEBACD"><font size="2" color="#000033"><%=residence.getResidenceSize()%></font></td>
                                                <td height="6" bgcolor="AEBACD"><font size="2" color="#000033"><%=residence.getResidenceRent()%></font></td>
                                                <td height="6" bgcolor="AEBACD"><font size="2" color="#000033"><%=residence.getResidenceSideCosts()%></font></td>
                                            </tr>
                                            <%
                                                }
                                            %>
                                            <tr bgcolor="AEBACD">
                                                <td height="6" colspan="9"><input type="submit" name="Submit" value="Mietvertrag"></td>
                                            </tr>


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
