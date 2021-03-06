<%@ page import="com.rheinlandprivatschule.repository.ResidentEntryDao" %>
<%@ page import="com.rheinlandprivatschule.model.Resident" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="java.util.Vector" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Mieter Pers&ouml;nliche Information ::</title>
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

        function makestudent(){
            window.location=window.location="makeStudent?residentid="+document.form1.residentids.value;
        }
        function back()
        {
            window.location="mieterEntryDetails?residentid="+document.form1.residentids.value;
        }

        function studentdetail()
        {
            window.location="showStudentPreciseD?userid="+document.form1.userids.value;
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
    ResidentEntryDao residentDB = (ResidentEntryDao) request.getAttribute("residentEntryDao");

    String firstname="";
    String lastname="";
    String birthday="1";
    String birthmonth="Janaury";
    String birthyear="1975";
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
    int usergender=0;
    String userloginname="";
    String userpassword="";
    String remarks="";
    String birthplace="";
    int residentid=0;

    String startday="1";
    String startmonth="Janaury";
    String startyear="1980";
    String endday="0";
    String endmonth="--";
    String endyear="0";

    String countStart ="";
    String countEnd ="";

    Resident resident = new Resident();

    String valueS=(String)request.getParameter("residentid");
    try{
        residentid=Integer.parseInt(valueS);
        resident=residentDB.getResident(residentid);
        session.setAttribute("president",resident);
    }
    catch(Exception e){
    }

    if(resident!=null){
        firstname=resident.getUserFirstName();
        lastname=resident.getUserLastName();
        birthday= MyDate.getDay(resident.getUserBirthDate());
        birthmonth=MyDate.getMonth(resident.getUserBirthDate());
        birthyear=MyDate.getYear(resident.getUserBirthDate());
        usergender=resident.getUserGender();
        birthplace=resident.getUserBirthPlace();
        nationality=resident.getUserNationality();

        if(resident.getUserCO()==null){
            co="";
        }else{
            co=resident.getUserCO();
        }
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

        startday = MyDate.getDay(resident.getMietStart());
        startmonth=MyDate.getMonth(resident.getMietStart());
        startyear=MyDate.getYear(resident.getMietStart());
        if (resident.getMietEnd() == null){
            endday="0";
            endmonth="--";
            endyear="0";
        }else{
            endday = MyDate.getDay(resident.getMietEnd());
            endmonth=MyDate.getMonth(resident.getMietEnd());
            endyear=MyDate.getYear(resident.getMietEnd());
        }

    }else{
        String err=residentDB.getError();
        session.setAttribute("err",err);
        session.setAttribute("lin","../map");
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="back()">Zur&uuml;ck</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width: 100%;" name="form1" method="post" action="updateResident" onSubmit="MM_validateForm('txtFirstName','','R','txtLastName','','R','txtBirthPlace','','R','txtNationality','','R','txtAddress','','R','txtPostCode','','RisNum','txtCity','','R','txtCountry','','R','txtHomeNo','','RisNum','txtMobileNo','','RisNum','txtEmail','','RisEmail','txtLoginName','','R','txtPassword','','R');return document.MM_returnValue">
                            <input name="residentids" type="hidden" id="residentids" value="<%=residentid%>">
                            <table width="100%" height="265" border="0" cellpadding="1" cellspacing="1">

                                <tr bgcolor="657A9A">
                                    <th colspan="2" height="17"><b><font color="#FFFFFF">P</font><font color="#FFFFFF">ers&ouml;nliche
                                        Informationen</font></b></th>
                                </tr>
                                <tr>
                                    <td width="19%" height="24" bgcolor="657A9A"><font color="#000033" size="2"><b><font color="#FFFFFF">*Vorname</font></b></font></td>
                                    <td width="81%" height="24" bgcolor="AEBACD"><font color="#000033">
                                        <input type="text" name="txtFirstName" value="<%=firstname%>">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td width="19%" height="21" bgcolor="657A9A"><font color="#FFFFFF" size="2"><b>*Nachname</b></font></td>
                                    <td width="81%" height="21" bgcolor="AEBACD"><font color="#000033">
                                        <input type="text" name="txtLastName" value="<%=lastname%>">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td width="19%" height="19" bgcolor="657A9A"><font color="#FFFFFF" size="2"><b>*Geburtsdatum</b></font></td>
                                    <td width="81%" height="19" bgcolor="AEBACD"><font color="#000033">
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
                                                vtemp.addElement("M??rz");
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
                                                    if(birthmonth.equalsIgnoreCase((ii+1)+""))
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
                                    <td width="19%" height="14" bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>*Geburtsort</b></font></td>
                                    <td width="81%" height="14" bgcolor="AEBACD">
                                        <input type="text" name="txtBirthPlace" value="<%=birthplace%>">
                                    </td>
                                </tr>
                                <tr>
                                    <td width="19%" height="14" bgcolor="657A9A"><font size="2" color="#000033"><b><font color="#FFFFFF">*Geschlecht</font></b></font></td>
                                    <td width="81%" height="14" bgcolor="AEBACD"> <font size="2" color="#000033">M&auml;nnlich</font>
                                        <%
                                            if(usergender==0){

                                        %>
                                        <input type="radio" name="rdGender" value="0" checked>
                                        <font size="2" color="#000033">Weiblich</font>
                                        <input type="radio" name="rdGender" value="1">
                                        <%
                                        }else{
                                        %>
                                        <input type="radio" name="rdGender" value="0">
                                        <font size="2" color="#000033">Weiblich</font>
                                        <input type="radio" name="rdGender" value="1" checked>
                                        <%
                                            }
                                        %>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="19%" height="17" bgcolor="657A9A"><font color="#FFFFFF" size="2"><b>Fest
                                        Nr.</b></font></td>
                                    <td width="81%" height="17" bgcolor="AEBACD"><font color="#000033">
                                        <input type="text" name="txtHomeNo" value="<%=homeno%>">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td width="19%" height="11" bgcolor="657A9A"><font color="#FFFFFF" size="2"><b>Handy
                                        Nr.</b></font></td>
                                    <td width="81%" height="11" bgcolor="AEBACD"><font color="#000033">
                                        <input type="text" name="txtMobileNo" value="<%=mobileno%>">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td width="19%" height="23" bgcolor="657A9A"><font color="#FFFFFF" size="2"><b>Email
                                    </b></font></td>
                                    <td width="81%" height="23" bgcolor="AEBACD"><font color="#000033">
                                        <input type="text" name="txtEmail" value="<%=email%>">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td height="17" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Z&auml;hlerstand Anfang </font></b></td>
                                    <td height="17" bgcolor="AEBACD"><font color="#000033">
                                        <input name="txtCountStart" type="text" id="txtCountStart" value="<%=countStart%>">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td height="11" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Z&auml;hlerstand Ende </font></b></td>
                                    <td height="11" bgcolor="AEBACD"><font color="#000033">
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
                                        <select name="selSMonth">
                                            <%
                                                Vector stemp=new Vector();
                                                stemp.addElement("Januar");
                                                stemp.addElement("Februar");
                                                stemp.addElement("M??rz");
                                                stemp.addElement("April");
                                                stemp.addElement("Mai");
                                                stemp.addElement("Juni");
                                                stemp.addElement("Juli");
                                                stemp.addElement("August");
                                                stemp.addElement("September");
                                                stemp.addElement("Oktober");
                                                stemp.addElement("November");
                                                stemp.addElement("Dezember");
                                                for(int ii=0;ii<stemp.size();ii++)
                                                {
                                                    String temps=(String)stemp.elementAt(ii);
                                                    if(startmonth.equalsIgnoreCase((ii+1)+""))
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
                                        <select name="selEMonth">
                                            <%
                                                Vector etemp=new Vector();
                                                etemp.addElement("Januar");
                                                etemp.addElement("Februar");
                                                etemp.addElement("M??rz");
                                                etemp.addElement("April");
                                                etemp.addElement("Mai");
                                                etemp.addElement("Juni");
                                                etemp.addElement("Juli");
                                                etemp.addElement("August");
                                                etemp.addElement("September");
                                                etemp.addElement("Oktober");
                                                etemp.addElement("November");
                                                etemp.addElement("Dezember");
                                                for(int ii=0;ii<etemp.size();ii++)
                                                {
                                                    String temps=(String)etemp.elementAt(ii);
                                                    if(endmonth.equalsIgnoreCase((ii+1)+""))
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
                                    <td width="19%" height="30" bgcolor="657A9A">&nbsp;</td>
                                    <td width="81%" height="30" bgcolor="AEBACD">
                                        <input type="hidden" input name="residentid" type="text" id="residentid" value="<%=residentid%>" >
                                        <input class="btn btn-primary" type="submit" name="Submit" value="OK">
                                        <font color="#000033">
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
