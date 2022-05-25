<%@ page import="com.rheinlandprivatschule.repository.ResidentEntryDao" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.model.Resident" %>
<%@ page import="java.util.Vector" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Neuer Mieter ::</title>
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
        function searchStudent(){
            window.location="studentSearch?cmd=a&studentid="+document.form1.txtUserID.value;
        }
        function back()
        {
            window.location="residentsList";
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

    ResidentEntryDao residentDB= (ResidentEntryDao) request.getAttribute("residentEntryDao");
    MyDate Date = new MyDate();

    String firstname="";
    String lastname="";
    String birthday="1";
    String birthmonth="Janaury";
    String birthyear="1980";
    String usergender="1";
    String birthplace="";
    String nationality="";
    String co="";
    String address="";
    String postcode="";
    String city="";
    String country="";
    String homeno="";
    String mobileno="";
    String faxno="";
    String email="";
    String residenceID="0";

    String startday="1";
    String startmonth="Janaury";
    String startyear="1980";

    String endday="0";
    String endmonth="--";
    String endyear="0";

    String countStart ="";
    String countEnd ="";


    String residenceIDS=(String)request.getParameter("residenceid");
    residenceID=residenceIDS;

    int residenceidN=Integer.parseInt(residenceID);

    Resident resident=(Resident)session.getAttribute("newresident");
    if(resident!=null){
        firstname=resident.getUserFirstName();
        lastname=resident.getUserLastName();
        birthday=MyDate.getDay(resident.getUserBirthDate());
        birthmonth=MyDate.getMonth(resident.getUserBirthDate());
        birthyear=MyDate.getYear(resident.getUserBirthDate());
        usergender=resident.getUserGender()+"";
        birthplace=resident.getUserBirthPlace();
        nationality=resident.getUserNationality();
        co=resident.getUserCO();
        address=resident.getUserAddress();
        postcode=resident.getUserPostCode();
        city=resident.getUserCity();
        country=resident.getUserCountry();
        homeno=resident.getUserHomePhone();
        mobileno=resident.getUserMobilePhone();
        faxno=resident.getUserFax();
        email=resident.getUserEmail();
        countStart=resident.getMieterCountStart();
        countEnd=resident.getMieterCountEnd();
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
                        <form name="form1" method="post" action="registerResidentEntry" onSubmit="MM_validateForm('txtFirstName','','R','txtLastName','','R','txtBirthPlace','','R','txtNationality','','R','txtAddress','','R','txtPostCode','','NisNum','txtCity','','R','txtCountry','','R','txtHomeNo','','NisNum','txtMobileNo','','NisNum','txtFax','','NisNum','txtEmail','','NisEmail');return document.MM_returnValue">
                            <table width="100%" height="284" border="0" cellpadding="1" cellspacing="1">

                                <tr>
                                    <th colspan="2" height="17" bgcolor="657A9A"><font color="#FFFFFF">Sch&uuml;ler Suchen </font></th>
                                </tr>
                                <tr>
                                    <th height="17" bgcolor="657A9A"><div align="left"><b><font color="#FFFFFF" size="2">Sch&uuml;ler Nr.: </font></b></div></th>
                                    <th height="17" bgcolor="AEBACD"><div align="left">
                                        <input name="txtUserID" disabled type="text" id="txtUserID">
                                        <input type="button" disabled name="Button" value="Suchen" onClick="searchStudent()">
                                    </div></th>
                                </tr>
                                <tr>
                                    <th colspan="2" height="17" bgcolor="657A9A"><b><font color="#FFFFFF">P</font><font color="#FFFFFF">ers&ouml;nliche
                                        Informationen</font></b></th>
                                </tr>
                                <tr>
                                    <td width="26%" height="24" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Vorname</font></b></td>
                                    <td width="74%" height="24" bgcolor="AEBACD"><font color="#000033">
                                        <input type="text" name="txtFirstName" value=<%=firstname%>>
                                    </font></td>
                                </tr>
                                <tr>
                                    <td width="26%" height="21" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Nachname</font></b></td>
                                    <td width="74%" height="21" bgcolor="AEBACD"><font color="#000033">
                                        <input type="text" name="txtLastName" value="<%=lastname%>">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td width="26%" height="19" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*<b><font color="#FFFFFF" size="2">Geburtsdatum</font></b></font></b></td>
                                    <td width="74%" height="19" bgcolor="AEBACD"><font color="#000033">
                                        <select name="selDay">
                                            <%
                                                for(int i=1;i<32;i++)
                                                {
                                                if(i==Integer.parseInt(birthday))
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
                                        <select name="selMonth">
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
                                                if(temps.equalsIgnoreCase(birthmonth))
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
                                        <select name="selYear">
                                            <%
                                                for(int iii=1950;iii<2011;iii++)
                                                {
                                                if(iii==Integer.parseInt(birthyear))
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
                                    <td width="26%" height="14" bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>*Geburtsort</b></font></td>
                                    <td width="74%" height="14" bgcolor="AEBACD">
                                        <input type="text" name="txtBirthPlace" value="<%=birthplace%>">
                                    </td>
                                </tr>
                                <tr>
                                    <td width="26%" height="14" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">*Geschlecht</font></b></td>
                                    <td width="74%" height="14" bgcolor="AEBACD"> m&auml;nnlich
                                        <%
                                            if(usergender.equalsIgnoreCase("1"))
                                            {
                                        %>
                                        <input type="radio" name="rdGender" value="1" checked>
                                        weiblich
                                        <input type="radio" name="rdGender" value="0">
                                        <%
                                            }
                                            else
                                            {
                                        %>
                                        <input type="radio" name="rdGender" value="1">
                                        weiblich
                                        <input type="radio" name="rdGender" value="0" checked>
                                        <%
                                            }
                                        %>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="11" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Handy Nr.</font></b></td>
                                    <td height="11" bgcolor="AEBACD"><font color="#000033">
                                        <input type="text" name="txtMobileNo" value="<%=mobileno%>">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td width="26%" height="17" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Fest
                                        Nr.</font></b></td>
                                    <td width="74%" height="17" bgcolor="AEBACD"><font color="#000033">
                                        <input type="text" name="txtHomeNo" value="<%=homeno%>">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td height="23" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Email</font></b></td>
                                    <td height="23" bgcolor="AEBACD"><font color="#000033">
                                        <input type="text" name="txtEmail" value="<%=email%>">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td height="17" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Z&auml;hlerstand Anfang </font></b></td>
                                    <td height="17" bgcolor="AEBACD"><font color="#000033">                          <input name="txtCountStart" type="text" id="txtCountStart" value="<%=countStart%>">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td width="26%" height="11" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Z&auml;hlerstand Ende </font></b></td>
                                    <td width="74%" height="11" bgcolor="AEBACD"><font color="#000033">
                                        <input name="txtCountEnd" type="text" id="txtCountEnd" value="<%=countEnd%>">
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
                                                Vector utemp=new Vector();
                                                utemp.addElement("Januar");
                                                utemp.addElement("Februar");
                                                utemp.addElement("M&auml;rz");
                                                utemp.addElement("April");
                                                utemp.addElement("Mai");
                                                utemp.addElement("Juni");
                                                utemp.addElement("Juli");
                                                utemp.addElement("August");
                                                utemp.addElement("September");
                                                utemp.addElement("Oktober");
                                                utemp.addElement("November");
                                                utemp.addElement("Dezember");
                                                for(int ii=0;ii<utemp.size();ii++)
                                                {
                                                String temps=(String)utemp.elementAt(ii);
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
                                                for(int iii=2005;iii<2029;iii++)
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
                                                for(int iii=2005;iii<2029;iii++)
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
                                    <td width="26%" height="13" bgcolor="657A9A"><b><font color="#FFFFFF" size="2"></font></b></td>
                                    <td width="74%" height="13" bgcolor="AEBACD">
                                        <input type="hidden" input name="residenceid" type="text" id="residenceid" value="<%=residenceID%>" >
                                        <input class="btn btn-primary" type="submit" name="Submit" value="OK">
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
