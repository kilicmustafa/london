<%@ page import="com.rheinlandprivatschule.repository.ResidentDao" %>
<%@ page import="com.rheinlandprivatschule.repository.MietenDB" %>
<%@ page import="com.rheinlandprivatschule.repository.ResidenceDao" %>
<%@ page import="com.rheinlandprivatschule.model.Resident" %>
<%@ page import="com.rheinlandprivatschule.model.Residence" %>
<%@ page import="java.util.Vector" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Neue Wohnung ::</title>
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
            window.location="residencesList"
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

        function MM_findObj(n, d) { //v4.01
            var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
                d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
            if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
            for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
            if(!x && d.getElementById) x=d.getElementById(n); return x;
        }
    </script>
</head>
<body>
<%
    ResidenceDao rdb= (ResidenceDao) request.getAttribute("residenceDao");
    MietenDB mdb= (MietenDB) request.getAttribute("mietenDB");

    ResidentDao rtdb= (ResidentDao) request.getAttribute("residentDao");
    Residence residence=new Residence();
    Resident resident=new Resident();

    String name ="";

    String mark="";
    String address="";
    String postcode="";
    String city="";
    String country="";

    String size="";
    String description="";
    double rent=0;
    double addcosts=0;
    double kation=0;
    String meterno="";

    String startday="1";
    String startmonth="Janaury";
    String startyear="1980";

    String endday="0";
    String endmonth="--";
    String endyear="0";

    String residentidS = (String)session.getAttribute("pmieter");
    String residenceidS = (String)request.getParameter("sel");
    int residentID = Integer.parseInt(residentidS);
    int residenceID = Integer.parseInt(residenceidS);

    session.setAttribute("pmieter",residentidS);
    session.setAttribute("presidence",residenceidS);

    try{
        resident=rtdb.getResident(residentID);
        if(resident.isStudent()==1){
            name=resident.getStudentReference().getUserFirstName()+" "+resident.getStudentReference().getUserLastName();
        }else{
            name=resident.getUserFirstName()+" "+resident.getUserLastName();
        }
        residence=rdb.getResidence(residenceID);
        if(residence!=null){
            mark=residence.getResidenceMark();
            address=residence.getResidenceAddress();
            postcode=""+residence.getResidencePostCode();
            city=residence.getResidenceCity();
            country=residence.getResidenceCountry();

            size=residence.getResidenceSize();
            description=residence.getResidenceDescription();
            rent=residence.getResidenceRent();
            addcosts=residence.getResidenceSideCosts();
            kation=residence.getResidenceKation();
            meterno=residence.getResidenceMeterNumber();
        }
    }catch(Exception e){
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="back()">Zur&uuml;ck</a>

                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form name="form1" method="post" action="registerResidenceMieten" onSubmit="MM_validateForm('txtAddress','','R','txtPostCode','','RisNum','txtCity','','R','txtCountry','','R','txtHomeNo','','NisNum','txtMobileNo','','NisNum','txtEmail','','NisEmail');return document.MM_returnValue">
                            <table width="100%" height="435" border="0" cellpadding="1" cellspacing="1">
                                <tr>
                                    <th colspan="2" height="17" bgcolor="657A9A"><b><font color="#FFFFFF">Neuer Mietvertrag </font></b></th>
                                </tr>
                                <tr>
                                    <td height="24" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Mieter</font></strong></td>
                                    <td height="24" bgcolor="AEBACD"><font color="#000033" size="2"><%=name%></font></td>
                                </tr>
                                <tr>
                                    <td height="24" colspan="2" bgcolor="657A9A">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td height="24" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Bezeichnung</font></strong></td>
                                    <td height="24" bgcolor="AEBACD"><font color="#000033" size="2"><%=mark%></font></td>
                                </tr>
                                <tr>
                                    <td width="26%" height="24" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Adresse</font></b></td>
                                    <td width="74%" height="24" bgcolor="AEBACD"> <font color="#000033" size="2"><%=address%></font></td>
                                </tr>
                                <tr>
                                    <td width="26%" height="24" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*PLZ</font></b></td>
                                    <td width="74%" height="24" bgcolor="AEBACD"><font color="#000033" size="2">
                                        <%=postcode%>
                                    </font></td>
                                </tr>
                                <tr>
                                    <td width="26%" height="24" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Stadt</font></b></td>
                                    <td width="74%" height="24" bgcolor="AEBACD"><font color="#000033" size="2">
                                        <%=city%>
                                    </font></td>
                                </tr>
                                <tr>
                                    <td width="26%" height="24" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Land</font></b></td>
                                    <td width="74%" height="24" bgcolor="AEBACD"><font color="#000033" size="2">
                                        <%=country%>
                                    </font></td>
                                </tr>
                                <tr>
                                    <td width="26%" height="24" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Gro&szlig;</font></b></td>
                                    <td width="74%" height="24" bgcolor="AEBACD"><font color="#000033" size="2">
                                        <%=size%>
                                    </font></td>
                                </tr>
                                <tr>
                                    <td width="26%" height="24" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Kaltmiete</font></b></td>
                                    <td width="74%" height="24" bgcolor="AEBACD"><font color="#000033" size="2">
                                        <%=rent%>
                                    </font></td>
                                </tr>
                                <tr>
                                    <td width="26%" height="24" bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>Nebenkosten</b></font></td>
                                    <td width="74%" height="24" bgcolor="AEBACD"><font color="#000033" size="2"><%=addcosts%></font>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="24" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Kation</font></strong></td>
                                    <td height="24" bgcolor="AEBACD"> <font color="#000033" size="2"><%=kation%></font></td>

                                </tr>
                                <tr>
                                    <td width="26%" height="24" bgcolor="657A9A"><b><strong><font color="#FFFFFF" size="2">Z&auml;hlernummer</font></strong></b></td>
                                    <td width="74%" height="24" bgcolor="AEBACD"><font color="#000033" size="2">
                                        <%=meterno%>
                                    </font></td>
                                </tr>
                                <tr>
                                    <td height="24" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Bemerkung</font></b></td>
                                    <td height="24" bgcolor="AEBACD"><font color="#000033" size="2">
                                        <%=description%>
                                    </font></td>
                                </tr>
                                <tr>
                                    <td height="7" bgcolor="657A9A"><DIV id=result_box dir=ltr><strong><font color="#FFFFFF" size="2">Mieteanfang</font></strong></DIV></td>
                                    <td height="7" bgcolor="AEBACD"><font color="#000033">
                                        <select name="selSDay" id="selSDay">
                                            <%
                                                for(int i=1;i<32;i++)
                                                {
                                                    if(i==Integer.parseInt(startday))
                                                    {
                                            %>
                                            <option selected><%=i%></option>
                                            <%
                                            }
                                            else
                                            {
                                            %>
                                            <option><%=i%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                        <select name="selSMonth" id="selSMonth">
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
                                                for(int ii=0;ii<vtemp.size();ii++)
                                                {
                                                    String temps=(String)vtemp.elementAt(ii);
                                                    if(temps.equalsIgnoreCase(startmonth))
                                                    {
                                            %>
                                            <option selected><%=temps%></option>
                                            <%
                                            }
                                            else
                                            {
                                            %>
                                            <option><%=temps%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                        <select name="selSYear" id="selSYear">
                                            <%
                                                for(int iii=1950;iii<2011;iii++)
                                                {
                                                    if(iii==Integer.parseInt(startyear))
                                                    {
                                            %>
                                            <option selected><%=iii%></option>
                                            <%
                                            }
                                            else
                                            {
                                            %>
                                            <option><%=iii%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                    </font></td>
                                </tr>
                                <tr>
                                    <td height="7" bgcolor="657A9A"><DIV id=result_box dir=ltr><font size="2"><strong><font color="#FFFFFF">Mieteende</font></strong></font></DIV></td>
                                    <td height="7" bgcolor="AEBACD"><font color="#000033">
                                        <select name="selEDay" id="selEDay">
                                            <option selected>--</option>
                                            <%
                                                for(int i=1;i<32;i++){
                                                    if(i==Integer.parseInt(endday))
                                                    {
                                            %>
                                            <option selected><%=i%></option>
                                            <%
                                            }
                                            else
                                            {
                                            %>
                                            <option><%=i%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                        <select name="selEMonth" id="selEMonth">
                                            <%
                                                Vector vtemp1=new Vector();
                                                vtemp1.addElement("--");
                                                vtemp1.addElement("Januar");
                                                vtemp1.addElement("Februar");
                                                vtemp1.addElement("M&auml;rz");
                                                vtemp1.addElement("April");
                                                vtemp1.addElement("Mai");
                                                vtemp1.addElement("Juni");
                                                vtemp1.addElement("Juli");
                                                vtemp1.addElement("August");
                                                vtemp1.addElement("September");
                                                vtemp1.addElement("Oktober");
                                                vtemp1.addElement("November");
                                                vtemp1.addElement("Dezember");
                                                for(int ii=0;ii<vtemp1.size();ii++)
                                                {
                                                    String temps=(String)vtemp1.elementAt(ii);
                                                    if(temps.equalsIgnoreCase(endmonth))
                                                    {
                                            %>
                                            <option selected><%=temps%></option>
                                            <%
                                            }
                                            else
                                            {
                                            %>
                                            <option><%=temps%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                        <select name="selEYear" id="selEYear">
                                            <option selected>--</option>
                                            <%
                                                for(int iii=1950;iii<2011;iii++)
                                                {
                                                    if(iii==Integer.parseInt(endyear))
                                                    {
                                            %>
                                            <option selected><%=iii%></option>
                                            <%
                                            }
                                            else
                                            {
                                            %>
                                            <option><%=iii%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                    </font></td>
                                </tr>
                                <tr>
                                    <td width="26%" height="7" bgcolor="657A9A"><b><font size="2" color="#FFFFFF"></font></b></td>
                                    <td width="74%" height="7" bgcolor="AEBACD"><input class="btn btn-primary" type="submit" name="Submit" value="Add">
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
