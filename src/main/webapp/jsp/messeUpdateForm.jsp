<%@ page import="com.rheinlandprivatschule.repository.MesseDao" %>
<%@ page import="com.rheinlandprivatschule.repository.MesseStudentDao" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.model.Werbung" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
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
        function back()
        {
            window.location="messeList";
        }
        function newstudent(){
            window.location="newMesseStudentForm?messeid="+document.form1.txtMesseid.value;
        }

        function telephone(){
            window.location="messeTelephoneListe?messeid="+document.form1.txtMesseid.value;
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
    MesseDao messeDB = (MesseDao) request.getAttribute("messeDao");
    MesseStudentDao studentDB = (MesseStudentDao) request.getAttribute("messeStudentDao");

    String birthday="1";
    String birthmonth="Janaury";
    String birthyear="1975";
    String city="";
    String country="";
    String organisation="";
    String user="";
    int messeid=0;
    Vector v=new Vector();

    Werbung werbung = new Werbung();

    String valueS= request.getParameter("messeid");
    try{
        messeid=Integer.parseInt(valueS);
        werbung=messeDB.getMesse(messeid);
        session.setAttribute("werbung",werbung);
    }
    catch(Exception e){
    }

    if(werbung!=null){
        birthday=MyDate.getDay(werbung.getMesseDate());
        birthmonth=MyDate.getMonth(werbung.getMesseDate());
        birthyear= MyDate.getYear(werbung.getMesseDate());
        city=werbung.getMessePlace();
        country=werbung.getMesseCountry();
        organisation=werbung.getMesseOrg();
        user=werbung.getMesseUser();

        v=studentDB.getAllStudentMesse(messeid);

    }else{
        String err=messeDB.getError();
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="composeMail()">Email</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="telephone()">Telefon Liste</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="newstudent()">Neue Student</a>

                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="back()">Zur&uuml;ck</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width: 100%;" name="form1" method="post" action="updateMesse" onSubmit="MM_validateForm('txtFirstName','','R','txtLastName','','R','txtBirthPlace','','R','txtNationality','','R','txtAddress','','R','txtPostCode','','RisNum','txtCity','','R','txtCountry','','R','txtHomeNo','','RisNum','txtMobileNo','','RisNum','txtEmail','','RisEmail','txtLoginName','','R','txtPassword','','R');return document.MM_returnValue">
                            <table width="100%" height="189" border="0" cellpadding="1" cellspacing="1">
                                <input name="messeidS" type="hidden" id="messeidS" value="<%=messeid%>">
                                <input type="hidden" name="hiddenField" value="<%=messeid%>">
                                <tr bgcolor="657A9A">
                                    <th colspan="2" height="17"><b><font color="#FFFFFF">P</font><font color="#FFFFFF">ers&ouml;nliche
                                        Informationen</font></b></th>
                                </tr>
                                <tr>
                                    <td height="19" bgcolor="657A9A"><font color="#FFFFFF" size="2"><b>*Ort</b></font></td>
                                    <td height="19" bgcolor="AEBACD"><font color="#000033">
                                        <input type="text" name="txtCity" value="<%=city%>">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td height="19" bgcolor="657A9A"><font color="#FFFFFF" size="2"><b>*Land</b></font></td>
                                    <td height="19" bgcolor="AEBACD"><font color="#000033">
                                        <input name="txtCountry" type="text" id="txtCountry" value="<%=country%>">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td width="19%" height="19" bgcolor="657A9A"><font color="#FFFFFF" size="2"><b>*Datum</b></font></td>
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
                                    <td height="14" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Mitarbeiter</font></b></td>
                                    <td height="14" bgcolor="AEBACD"><font color="#000033">
                                        <input type="text" name="txtUser" value="<%=user%>">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td height="14" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Veranstalter</font></b></td>
                                    <td height="14" bgcolor="AEBACD"><font color="#000033">
                                        <input type="text" name="txtOrg" value="<%=organisation%>">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td width="19%" height="30" bgcolor="657A9A">&nbsp;</td>
                                    <td width="81%" height="30" bgcolor="AEBACD">
                                        <input class="btn btn-primary" type="submit" name="Submit" value="OK">
                                        <font color="#000033">
                                            <input type="hidden" name="txtMesseid" value="<%=messeid%>">
                                        </font>                        </td>
                                </tr>
                                <tr>
                                    <td height="30" colspan="2" bgcolor="#FFFFFF"><table width="100%"  border="0" cellspacing="1" cellpadding="1">
                                        <tr>
                                            <td height="29" colspan="7" bgcolor="657A9A"><div align="center">
                                                <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td colspan="2"><div align="center"><b></b></div>                                    <div align="center"><b><font color="#FFFFFF" >Messestudent Liste</font></b></div></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2"><div align="right"><font size="2" color="#FFFFFF"><b><%=v.size()%></b></font></div></td>
                                                    </tr>
                                                </table>
                                                <b></b></div></td>
                                        </tr>
                                        <tr bgcolor="#405579">
                                            <td width="3%" bgcolor="657A9A"><div align="left"><font color="#FFFFFF"><b>
                                                <input type="checkbox" name="selectm" onClick="checkAll(this)">
                                            </b></font><font color="#ffffff" size="2"></font></div></td>
                                            <td width="14%" bgcolor="657A9A"><font color="#ffffff" size="2"><B>Name</B></font></td>
                                            <td width="15%" height="14" bgcolor="657A9A"><font color="#FFFFFF"><b><FONT size=2>Email</FONT></b></font></td>
                                            <td width="16%" bgcolor="657A9A"><strong><b><font color="#ffffff" size="2">Telephone</font></b></strong></td>
                                            <td width="15%" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Anfang Datum </font></strong></td>
                                            <td width="17%" bgcolor="657A9A"><strong><B><font color="#ffffff" size="2">Grund</font></B></strong></td>
                                            <td width="20%" bgcolor="657A9A"><strong><B><font color="#ffffff" size="2">Sprache</font></B></strong></td>
                                        </tr>
                                        <tr bgcolor="AEBACD">
                                            <%
                                                for(int i=0;i<v.size();i++)
                                                {
                                                    Werbung werbungStudent=(Werbung)v.elementAt(i);

                                            %>
                                            <td height="6" bgcolor="AEBACD"><font size="2" color="#000033"><font size="2" color="#000033"><font size="2" color="#000033">
                                                <input type="checkbox" name="checkbox" value="<%=werbungStudent.getEmail()%>" onClick="addSel(this)">
                                            </font></font></td>
                                            <td height="6" bgcolor="AEBACD"><font size="2" color="#000033"><font size="2" color="#000033"><a href="messeStudentUpdateForm?messeid=<%=werbungStudent.getMesseID()%>&studentID=<%=werbungStudent.getStudentID()%>"><%=werbungStudent.getFirstName()%></a><font size="2" color="#000033"><a href="messeStudentUpdateForm?messeid=<%=werbungStudent.getMesseID()%>&studentID=<%=werbungStudent.getStudentID()%>"> <%=werbungStudent.getLastName()%></a></font></font></font></td>
                                            <td height="6" bgcolor="AEBACD"><font size="2" color="#000033"><%=werbungStudent.getEmail()%></font></td>
                                            <td height="6" bgcolor="AEBACD"><font size="2" color="#000033"><%=werbungStudent.getTelephoneNumber()%></font></td>
                                            <td height="6" bgcolor="AEBACD"><font size="2" color="#000033"><%=MyDate.formateDate(werbungStudent.getBeginDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                                            <td height="6" bgcolor="AEBACD"><font size="2" color="#000033"><%=werbungStudent.getStudyReason()%></font></td>
                                            <td height="6" bgcolor="AEBACD"><font size="2" color="#000033"><%=werbungStudent.getIntendedLanguage()%></font></td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                        <tr bgcolor="AEBACD">
                                            <td height="6" colspan="2">&nbsp;</td>
                                            <td height="6">&nbsp;</td>
                                            <td height="6" bgcolor="AEBACD">&nbsp;</td>
                                            <td height="6" bgcolor="AEBACD">&nbsp;</td>
                                            <td height="6" colspan="2" bgcolor="AEBACD">&nbsp;</td>
                                        </tr>
                                    </table></td>
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
