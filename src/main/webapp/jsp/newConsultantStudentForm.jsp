<%@ page import="com.rheinlandprivatschule.repository.ConsultantStudentDao" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.model.Werbung" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
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
        function back()
        {
            window.location="consultantUpdateForm?consultantid="+document.form1.consultantid.value;
        }

        function setfocus(){
            document.forms[0].txtFirstName.focus();
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

    ConsultantStudentDao consultantDB= (ConsultantStudentDao) request.getAttribute("consultantStudentDao");


    int consultantid=0;
    String birthday="1";
    String birthmonth="Janaury";
    String birthyear="2008";
    String firstname ="";
    String lastname="";
    String email ="";
    String reason="";
    String language="";
    String telephone="";
    String fax="";
    String mobile="";
    String web="";
    String remarks="";
    String address="";
    Vector image=new Vector();


    String valueS=(String)request.getParameter("consultantid");


    Werbung werbung=(Werbung)session.getAttribute("newconsultant");
    if(werbung!=null){

        birthday= MyDate.getDay(MyDate.getCurrentSQLDate());
        birthmonth=MyDate.getMonth(MyDate.getCurrentSQLDate());
        birthyear=MyDate.getYear(MyDate.getCurrentSQLDate());
        firstname =werbung.getFirstName();
        lastname=werbung.getLastName();
        email =werbung.getEmail();
        reason=werbung.getStudyReason();
        language=werbung.getIntendedLanguage();
        telephone=werbung.getTelephoneNumber();
        remarks=werbung.getRemarks();
        fax=werbung.getConsultantUser();
        mobile=werbung.getMobile();
        web=werbung.getWeb();
        address=werbung.getConsultantAddress();
        consultantid=Integer.parseInt(valueS);

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
                        <form name="form1" style="width: 100%;" method="post" action="registerConsultantStudent" onSubmit="MM_validateForm('txtFirstName','','R',
				  																							   'txtLastName','','R',
																											   'txtTelephone','','R',
																											   'txtEmail','','NisEmail',
																											   'txtReason','','R',
																											   'txtLanguage','','R');return document.MM_returnValue">
                            <table width="100%" height="223" border="0" cellpadding="1" cellspacing="1">
                                <tr>
                                    <th colspan="2" height="17" bgcolor="657A9A"><b><font color="#FFFFFF">Agentur Informationen</font></b></th>
                                </tr>
                                <tr>
                                    <td height="24" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Firma</font></b></td>
                                    <td height="24" bgcolor="AEBACD"><font color="#000033">
                                        <input name="txtFirstName" type="text" value="<%=firstname%>" size="30">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td height="21" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Name</font></b></td>
                                    <td height="21" bgcolor="AEBACD"><font color="#000033">
                                        <input name="txtLastName" type="text" value="<%=lastname%>" size="30">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td width="26%" height="19" bgcolor="657A9A"><b><font color="#FFFFFF" size="2"><b><font color="#FFFFFF" size="2">*Anfang Datum </font></b></font></b></td>
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
                                    <td height="14" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Telefon</font></b></td>
                                    <td height="14" bgcolor="AEBACD"><font color="#000033">
                                        <input name="txtTelephone" type="text" id="txtTelephone" value="<%=telephone%>">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td height="14" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Fax</font></b></td>
                                    <td height="14" bgcolor="AEBACD"><font color="#000033">
                                        <input name="txtFax" type="text" id="txtFax" value="<%=fax%>">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td height="14" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Mobil Nummer </font></b></td>
                                    <td height="14" bgcolor="AEBACD"><font color="#000033">
                                        <input name="txtMobile" type="text" id="txtMobile" value="<%=mobile%>">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td height="14" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Email</font></b></td>
                                    <td height="14" bgcolor="AEBACD"><font color="#000033">
                                        <input name="txtEmail" type="text" id="txtEmail" value="<%=email%>" size="50">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td height="14" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Web Adresse</font></b></td>
                                    <td height="14" bgcolor="AEBACD"><font color="#000033">
                                        <input name="txtWeb" type="text" id="txtWeb" value="<%=web%>" size="50">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td height="14" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Adresse</font></b></td>
                                    <td height="14" bgcolor="AEBACD"><font color="#000033">
                                        <textarea name="txtAddress" cols="55" rows="3" id="txtAddress"><%=address%></textarea>
                                    </font></td>
                                </tr>
                                <tr>
                                    <td height="14" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Bemerkung</font></b></td>
                                    <td height="14" bgcolor="AEBACD"><font color="#000033">
                                        <textarea name="txtRemarks" cols="75" rows="4" id="txtRemarks"><%=remarks%></textarea>
                                    </font></td>
                                </tr>
                                <tr>
                                    <td width="26%" height="13" bgcolor="657A9A"><b><font color="#FFFFFF" size="2"></font></b></td>
                                    <td width="74%" height="13" bgcolor="AEBACD">
                                        <input class="btn btn-primary" type="submit" name="Submit" value="OK">
                                        <font color="#000033">
                                            <input name="consultantid" type="hidden" id="consultantid" value="<%=valueS%>">
                                        </font>                        </td>
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
