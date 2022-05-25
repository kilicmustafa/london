<%@ page import="com.rheinlandprivatschule.model.ResidenceOwner" %>
<%@ page import="com.rheinlandprivatschule.repository.ResidenceOwnerDao" %>
<%@ page import="com.rheinlandprivatschule.model.Residence" %>
<%@ page import="com.rheinlandprivatschule.repository.ResidenceDao" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.GregorianCalendar" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Wohnung Informationen ::</title>
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
        function registerRentIncoming(){
            window.location="registerRentIncoming?residenceid="+document.form1.residenceid.value;
        }

        function leave(msg)
        {
            if(!confirm(msg)) return false
            else document.form1.submit()
        }

        function backto(){
            window.location="residenceDetails?residenceid="+document.form1.residenceid.value;
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
    ResidenceDao rdb= (ResidenceDao) request.getAttribute("residenceDao");
    ResidenceOwnerDao rodb= (ResidenceOwnerDao) request.getAttribute("residenceOwnerDao");
    ResidenceOwner owner=new ResidenceOwner();
    Residence residence=new Residence();
    Residence rentin=new Residence();
    MyDate Date = new MyDate();

    Vector owners = new Vector();
    Vector idy=new Vector();

    String mark ="";
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

    int residenceowner=0;
    double vwarmiete=0;
    double vkation=0;
    String paidday="1";
    String paidmonth="Januar";
    String paidyear="1980";

    String startday="1";
    String startmonth="Janaur";
    String startyear="1980";

    String endday="0";
    String endmonth="0";
    String endyear="0";
    int delete=0;
    int mode=1;
    double balance=0;

    String myMsg="Haben Sie ";

    String residenceidS=(String)request.getParameter("residenceid");
    String currentmonthS=(String)request.getParameter("currentmonth");
    String currentyearS=(String)request.getParameter("currentyear");
    Calendar gc = new GregorianCalendar();
    try{
        int residenceidN=Integer.parseInt(residenceidS);
        int currentmonthN= (currentmonthS != null && !currentmonthS.equals(""))
                ? Integer.parseInt(currentmonthS)
                : Integer.parseInt(MyDate.getMonth(new Date(gc.getTime().getTime())));
        int currentyearN= (currentyearS != null && !currentyearS.equals(""))
                ? Integer.parseInt(currentyearS)
                : Integer.parseInt(MyDate.getYear(new Date(gc.getTime().getTime())));
        residence=rdb.getResidence(residenceidN);
        rentin=rdb.getRentIn(residenceidN, currentmonthN, currentyearN);
        if(residence!=null){
            session.setAttribute("presidence",residence);
        }
        owners = rodb.getAllResidenceOwners();
        idy = rdb.getAllPayModes();
        mark=residence.getResidenceMark();
        address=residence.getResidenceAddress();
        postcode=""+residence.getResidencePostCode();
        city=residence.getResidenceCity();
        country=residence.getResidenceCountry();

        size=residence.getResidenceSize();
        description=residence.getResidenceDescription();
        rent=residence.getResidenceRent() - rentin.getAmountPaid();
        addcosts=residence.getResidenceSideCosts();
        kation=residence.getResidenceKation();
        meterno=residence.getResidenceMeterNumber();

        residenceowner=residence.getResidenceOwner();
        vwarmiete=residence.getVermieterWarmMiete();
        vkation=residence.getVermieterKation();
        paidday=MyDate.getDay(Date.getCurrentSQLDate());
        paidmonth=(currentmonthS != null && !currentmonthS.equals(""))
                ? currentmonthS
                : MyDate.getMonth(new Date(gc.getTime().getTime()));
        paidyear=(currentyearS != null && !currentyearS.equals(""))
                ? currentyearS
                : MyDate.getYear(new Date(gc.getTime().getTime()));

        startday=MyDate.getDay(residence.getVermieterMietStart());
        startmonth=MyDate.getMonth(residence.getVermieterMietStart());
        startyear=MyDate.getYear(residence.getVermieterMietStart());

        delete =rentin.getDeleteFunction();

        balance=rentin.getAmountPaid();
        //mode =rentin.getPaymentModeID();
        //mode=residence.getPaymentModeID();

        if(residence.getVermieterMietEnd()!=null){
            endday=MyDate.getDay(residence.getVermieterMietEnd());
            endmonth=MyDate.getMonth(residence.getVermieterMietEnd());
            endyear=MyDate.getYear(residence.getVermieterMietEnd());
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="backto()">Zur&uuml;ck</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width: 100%;" name="form1" method="post" action="registerRentIncoming" onSubmit="MM_validateForm('txtFirstName','','R','txtLastName','','R','txtBirthPlace','','R','txtNationality','','R','txtAddress','','R','txtPostCode','','RisNum','txtCity','','R','txtCountry','','R','txtHomeNo','','NisNum','txtEmail','','NisEmail','txtLoginName','','R','txtPassword','','R');return document.MM_returnValue">
                            <table width="100%" height="290" border="0" cellpadding="1" cellspacing="1">
                                <tr>
                                    <th colspan="2" height="17" bgcolor="657A9A"><b><font color="#FFFFFF">Wohnung
                                        Informationen</font></b></th>
                                </tr>
                                <tr>
                                    <td height="17" colspan="2" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Wohnungsinformationen</font></strong></td>
                                </tr>
                                <tr>
                                    <td height="17" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Bezeichnung</font></strong></td>
                                    <td height="17" bgcolor="AEBACD"><font color="#000033" size="2"><%=mark%></font></td>
                                </tr>
                                <tr>
                                    <td height="22" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Mietzahlung</font></strong></td>
                                    <td height="22" bgcolor="AEBACD"><font color="#000033">
                                        <option selected></option>
                                        <option></option>
                                        </select>
                                        <select name="selMonth" id="selMonth">
                                            <%
                                                Vector vtemp=new Vector();
                                                vtemp.addElement("Januar");
                                                vtemp.addElement("Februar");
                                                vtemp.addElement("M&auml;rz");
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
                                                    if((ii+1)==Integer.parseInt(paidmonth))
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
                                                for(int iii=2004;iii<2029;iii++)
                                                {
                                                    if(iii==Integer.parseInt(paidyear))
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
                                    <td height="14" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Art der Bezahlung</font></b></td>
                                    <td height="14" bgcolor="AEBACD"><font color="#000033">
                                        <select name="selIden" id="selIden">
                                            <%
                                                for(int g=0;g<idy.size();g++)
                                                {
                                                    Residence uc=(Residence)idy.elementAt(g);
                                                    if(uc.getPaymentModeID()== mode)
                                                    {
                                            %>
                                            <option value="<%=uc.getPaymentModeID()%>" selected><%=uc.getPaymentModeDesc()%></option>
                                            <%
                                            }
                                            else
                                            {
                                            %>
                                            <option value="<%=uc.getPaymentModeID()%>"><%=uc.getPaymentModeDesc()%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                    </font> </td>
                                </tr>
                                <tr>
                                    <td height="11" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Warmmiete (Mieter)</font></b></td>
                                    <td height="11" bgcolor="AEBACD">
                                        <input name="txtRent" type="text" id="txtRent" value="<%=rent%>">
                                        <input type="hidden" input name="txtBalance" id="txtBalance" value="<%=balance%>">
                                </tr>
                                <tr>
                                    <td width="26%" height="17" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Adresse</font></b></td>
                                    <td width="74%" height="17" bgcolor="AEBACD"><div align="left"><font color="#000033">
                                    </font><font color="#000033" size="2"> <%=address%></font><font color="#000033">                          </font></div></td>
                                </tr>
                                <tr >
                                    <td width="26%" height="16" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*PLZ</font></b></td>
                                    <td width="74%" height="16" bgcolor="AEBACD"> <div align="left"><font color="#000033">
                                    </font><font color="#000033" size="2"><%=postcode%></font><font color="#000033">                          </font></div></td>
                                </tr>
                                <tr>
                                    <td width="26%" height="19" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Stadt</font></b></td>
                                    <td width="74%" height="19" bgcolor="AEBACD"><div align="left"><font color="#000033">
                                    </font><font color="#000033" size="2"><%=city%></font><font color="#000033">                          </font></div></td>
                                </tr>
                                <tr>
                                    <td width="26%" height="14" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Land</font></b></td>
                                    <td width="74%" height="14" bgcolor="AEBACD"><div align="left"><font color="#000033" size="2"><%=country%></font><font color="#000033">
                                        <sinput type="text" name="txtCountry" value="<%=country%>">
                                    </font></div></td>
                                </tr>
                                <tr>
                                    <td width="26%" height="17" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Gr&ouml;&szlig;e</font></b></td>
                                    <td width="74%" height="17" bgcolor="AEBACD"><div align="left"><font color="#000033">
                                    </font><font color="#000033" size="2"><%=size%></font><font color="#000033">                          </font></div></td>
                                </tr>
                                <tr>
                                    <td height="23" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Kation (Mieter) </font></strong></td>
                                    <td height="23" bgcolor="AEBACD"><div align="left"><font color="#000033" size="2"><%=MyCurrency.getDisplayString(residence.getVermieterKation())%></font></div></td>
                                </tr>
                                <tr>
                                    <td width="26%" height="23" bgcolor="657A9A"><b><strong><font color="#FFFFFF" size="2">Z&auml;hlernummer</font></strong></b></td>
                                    <td width="74%" height="23" bgcolor="AEBACD"><div align="left"><font color="#000033">
                                        <%=meterno%> </font></div></td>
                                </tr>
                                <tr>
                                    <td width="26%" height="30" bgcolor="657A9A"><b><font color="#FFFFFF" size="2"></font></b></td>
                                    <td width="74%" height="30" bgcolor="AEBACD">
                                        <input class="btn btn-primary" type="submit" name="Submit" value="Aktualisieren" onClick="leave('<%=myMsg%>'+document.form1.txtRent.value+' Euro angenommen?');return false">
                                        <input type="hidden" input name="residenceid" id="residenceid" value="<%=residence.getResidenceID()%>" >
                                        <input type="hidden" input name="deleteid" id="deleteid" value="<%=delete%>" >

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
