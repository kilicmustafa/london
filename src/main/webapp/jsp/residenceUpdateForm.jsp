<%@ page import="com.rheinlandprivatschule.repository.ResidenceOwnerDao" %>
<%@ page import="com.rheinlandprivatschule.repository.ResidenceDao" %>
<%@ page import="com.rheinlandprivatschule.model.ResidenceOwner" %>
<%@ page import="com.rheinlandprivatschule.model.Residence" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
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
    ResidenceOwnerDao rodb= (ResidenceOwnerDao) request.getAttribute("residenceOwnerDao");
    ResidenceDao rdb= (ResidenceDao) request.getAttribute("residenceDao");
    ResidenceOwner owner=new ResidenceOwner();
    Residence residence=new Residence();

    Vector owners = new Vector();

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

    String residenceidS=(String)request.getParameter("residenceid");
    try{
        int residenceidN=Integer.parseInt(residenceidS);
        residence=rdb.getResidence(residenceidN);
        if(residence!=null){
            session.setAttribute("presidence",residence);
        }
        owners = rodb.getAllResidenceOwners();
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

        residenceowner=residence.getResidenceOwner();
        vwarmiete=residence.getVermieterWarmMiete();
        vkation=residence.getVermieterKation();
        paidday= MyDate.getDay(residence.getVermieterKationPaidDate());
        paidmonth=MyDate.getMonth(residence.getVermieterKationPaidDate());
        paidyear=MyDate.getYear(residence.getVermieterKationPaidDate());

        startday=MyDate.getDay(residence.getVermieterMietStart());
        startmonth=MyDate.getMonth(residence.getVermieterMietStart());
        startyear=MyDate.getYear(residence.getVermieterMietStart());
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
                        <form name="form1" style="width: 100%;" method="post" action="updateResidence" onSubmit="MM_validateForm('txtFirstName','','R','txtLastName','','R','txtBirthPlace','','R','txtNationality','','R','txtAddress','','R','txtPostCode','','RisNum','txtCity','','R','txtCountry','','R','txtHomeNo','','NisNum','txtEmail','','NisEmail','txtLoginName','','R','txtPassword','','R');return document.MM_returnValue">
                            <table width="100%" height="544" border="0" cellpadding="1" cellspacing="1">
                                <tr>
                                    <th colspan="2" height="17" bgcolor="657A9A"><b><font color="#FFFFFF">Wohnung
                                        Informationen</font></b></th>
                                </tr>
                                <tr>
                                    <td height="17" colspan="2" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Wohnungsinformationen</font></strong></td>
                                </tr>
                                <tr>
                                    <td height="17" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Bezeichnung</font></strong></td>
                                    <td height="17" bgcolor="AEBACD"><input name="txtMark" type="text" id="txtMark" value="<%=mark%>"></td>
                                </tr>
                                <tr>
                                    <td width="26%" height="17" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Adresse</font></b></td>
                                    <td width="74%" height="17" bgcolor="AEBACD"><font color="#000033">
                                        <input type="text" name="txtAddress" value="<%=address%>" maxlength="50">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td width="26%" height="16" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*PLZ</font></b></td>
                                    <td width="74%" height="16" bgcolor="AEBACD"><font color="#000033">
                                        <input type="text" name="txtPostCode" value="<%=postcode%>">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td width="26%" height="19" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Stadt</font></b></td>
                                    <td width="74%" height="19" bgcolor="AEBACD"><font color="#000033">
                                        <input type="text" name="txtCity" value="<%=city%>">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td width="26%" height="14" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Land</font></b></td>
                                    <td width="74%" height="14" bgcolor="AEBACD"><font color="#000033">
                                        <input type="text" name="txtCountry" value="<%=country%>">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td width="26%" height="17" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Gr&ouml;&szlig;e</font></b></td>
                                    <td width="74%" height="17" bgcolor="AEBACD"><font color="#000033">
                                        <input name="txtSize" type="text" id="txtSize" value="<%=size%>">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td width="26%" height="11" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Warmmiete (Mieter)</font></b></td>
                                    <td width="74%" height="11" bgcolor="AEBACD"><font color="#000033">
                                        <input name="txtRent" type="text" id="txtRent" value="<%=rent%>">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td height="23" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Kation (Mieter) </font></strong></td>
                                    <td height="23" bgcolor="AEBACD"><input name="txtKation" type="text" id="txtKation" value="<%=kation%>"></td>
                                </tr>
                                <tr>
                                    <td width="26%" height="23" bgcolor="657A9A"><b><strong><font color="#FFFFFF" size="2">Z&auml;hlernummer</font></strong></b></td>
                                    <td width="74%" height="23" bgcolor="AEBACD"><font color="#000033">
                                        <input name="txtMeterNo" type="text" id="txtMeterNo" value="<%=meterno%>">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td height="24" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Bemerkung</font></b></td>
                                    <td height="24" bgcolor="AEBACD"><font color="#000033">
                                        <input name="txtDescription" type="text" id="txtDescription" value="<%=description%>">
                                    </font></td>
                                </tr>
                                <tr>
                                    <td height="21" colspan="2" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Vermietersinformationen</font></strong></td>
                                </tr>
                                <tr>
                                    <td width="26%" height="24" bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>Vermieter</b></font></td>
                                    <td width="74%" height="24" bgcolor="AEBACD">
                                        <select name="selOwner" id="selOwner">
                                            <%
                                                for(int i=0;i<owners.size();i++){
                                                    ResidenceOwner ownerT = (ResidenceOwner)owners.elementAt(i);
                                                    if(residenceowner==ownerT.getResidenceOwnerID()){
                                            %>
                                            <option selected value="<%=ownerT.getResidenceOwnerID()%>"><%=ownerT.getResidenceOwnerCompany()%></option>
                                            <%
                                            }else{
                                            %>
                                            <option value="<%=ownerT.getResidenceOwnerID()%>"><%=ownerT.getResidenceOwnerCompany()%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="21" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Warmmiete (Vermieter) </font></strong></td>
                                    <td height="21" bgcolor="AEBACD"><input name="txtVWMiete" type="text" id="txtVWMiete" value="<%=vwarmiete%>"></td>
                                </tr>
                                <tr>
                                    <td height="24" bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>Nebenkosten (Mieter &amp; Vermieter)</b></font></td>
                                    <td height="24" bgcolor="AEBACD"><input name="txtAddCost" type="text" id="txtAddCost" value="<%=addcosts%>"></td>
                                </tr>
                                <tr>
                                    <td height="24" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Kation (Vermieter) </font></strong></td>
                                    <td height="24" bgcolor="AEBACD"><input name="txtVKation" type="text" id="txtVKation" value="<%=vkation%>"></td>
                                </tr>
                                <tr>
                                    <td height="22" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Kation Bezahlt </font></strong></td>
                                    <td height="22" bgcolor="AEBACD"><font color="#000033">
                                        <select name="selDay">
                                            <%
                                                for(int i=1;i<32;i++)
                                                {
                                                    if(i==Integer.parseInt(paidday))
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
                                                for(int iii=2000;iii<2050;iii++)
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
                                    <td height="21" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Mieteanfang</font></strong></td>
                                    <td height="21" bgcolor="AEBACD"><font color="#000033">
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

                                                for(int ii=0;ii<vtemp.size();ii++)
                                                {
                                                    String temps=(String)vtemp.elementAt(ii);
                                                    if(Integer.parseInt(startmonth)==(ii+1))
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
                                                for(int iii=2000;iii<2050;iii++)
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
                                    <td height="21" bgcolor="657A9A"><font size="2"><strong><font color="#FFFFFF">Mieteende</font></strong></font></td>
                                    <td height="21" bgcolor="AEBACD"><font color="#000033">
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
                                                    if(Integer.parseInt(endmonth)==(ii))
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
                                                for(int iii=2000;iii<2050;iii++)
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
                                    <td height="24" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Wohnunhg Type</font></strong></td>
                                    <td height="24" bgcolor="AEBACD">
                                        <%
                                            if(residence.getResidenceType().equalsIgnoreCase("A")) {
                                        %>
                                        <input name="residenceType" type="radio" id="residenceTypeA" value="A" checked>
                                        <label for="residenceTypeA">Gemietete Objekte</label>
                                        <input name="residenceType" type="radio" id="residenceTypeB" value="B">
                                        <label for="residenceTypeB">Eigene Objekte</label>
                                        <%
                                            } else if(residence.getResidenceType().equalsIgnoreCase("B")) {
                                        %>
                                        <input name="residenceType" type="radio" id="residenceTypeA" value="A">
                                        <label for="residenceTypeA">Gemietete Objekte</label>
                                        <input name="residenceType" type="radio" id="residenceTypeB" value="B" checked>
                                        <label for="residenceTypeB">Eigene Objekte</label>
                                        <%
                                            } else {
                                        %>
                                        <input name="residenceType" type="radio" id="residenceTypeA" value="A">
                                        <label for="residenceTypeA">Gemietete Objekte</label>
                                        <input name="residenceType" type="radio" id="residenceTypeB" value="B">
                                        <label for="residenceTypeB">Eigene Objekte</label>
                                        <%
                                            }
                                        %>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="26%" height="30" bgcolor="657A9A"><b><font color="#FFFFFF" size="2"></font></b></td>
                                    <td width="74%" height="30" bgcolor="AEBACD">
                                        <input class="btn btn-primary" type="submit" name="Submit" value="Aktualisieren">
                                        <input name="residenceid" type="hidden" id="residenceid" value="<%=residence.getResidenceID()%>" >
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
