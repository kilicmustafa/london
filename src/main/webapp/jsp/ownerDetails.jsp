<%@ page import="com.rheinlandprivatschule.model.ResidenceOwner" %>
<%@ page import="com.rheinlandprivatschule.repository.ResidenceOwnerDao" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Allgemeine Benutzer Informationen ::</title>
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
        function composeMail(){
            document.form1.action="mailComposer";
            document.form1.submit();
        }

        function wohnungs(){
            window.location="residencesList?ownerid="+document.form1.ownerid.value;
        }

        function back(){
            window.location="ownersList";
        }

        function userdetail(){
            window.location="ownerUpdateForm?ownerid="+document.form1.ownerid.value;
        }
    </script>
</head>
<body>
<%
    String company="";
    String firstname="";
    String lastname="";
    int usergender=0;
    String usergenderS="";

    String address="";
    String postcode="";
    String city="";
    String country="";
    String homeno="";
    String officeno="";
    String mobileno="";
    String faxno="";
    String email="";

    String kontono="";
    String blz="";
    String bankname="";

    ResidenceOwnerDao rodb= (ResidenceOwnerDao) request.getAttribute("residenceOwnerDao");

    ResidenceOwner owner=new ResidenceOwner();
    int ownerid=0;

    String owneridS=(String)request.getParameter("ownerid");
    if(owneridS!=null){
        owner=(ResidenceOwner)rodb.getResidenceOwner(Integer.parseInt(owneridS));
        company=owner.getResidenceOwnerCompany();
        firstname=owner.getResidenceOwnerFirstName();
        lastname=owner.getResidenceOwnerLastName();
        usergender=owner.getResidenceOwnerGender();
        if(usergender==0){
            usergenderS="M&auml;nnlich";
        }else{
            usergenderS="Weiblich";
        }

        address=owner.getResidenceOwnerAddress();
        postcode=""+owner.getResidenceOwnerPostCode();
        city=owner.getResidenceOwnerCity();
        country=owner.getResidenceOwnerCountry();
        homeno=owner.getResidenceOwnerHomePhone();
        officeno=owner.getResidenceOwnerOfficePhone();
        mobileno=owner.getResidenceOwnerMobilePhone();
        faxno=owner.getResidenceOwnerFax();
        email=owner.getResidenceOwnerEmail();

        if(email!=null){
            session.setAttribute("singleemail",email);
        }

        kontono=owner.getResidenceOwnerAccountNo();
        blz=owner.getResidenceOwnerBLZ();
        bankname=owner.getResidenceOwnerBankName();

        ownerid=owner.getResidenceOwnerID();
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="composeMail">Email</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="wohnungs()">Wohnungen</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="userdetail()">Aktualisierung Vermieter</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="back()">Z&uuml;ruck</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width: 100%;" name="form1" method="post" action="ownerDetails">
                            <input name="ownerid" type="hidden" id="ownerid" value="<%=ownerid%>">
                            <table width="100%" height="456" border="0" cellpadding="1" cellspacing="1">
                                <tr bgcolor="657A9A">
                                    <td colspan="2"><div align="center"><font size="2"><b><font color="#FFFFFF">Vermieter Informationen</font></b></font></div></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="27" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Firma</font></b></td>
                                    <td><font color="#000033" size="2"><%=company%></font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td width="15%" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Vorname</font></b></td>
                                    <td width="85%"><font color="#000033" size="2"><%=firstname%></font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Nachname</font></b></td>
                                    <td><font color="#000033" size="2"><%=lastname%></font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="27" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">*Geschlecht</font></b></td>
                                    <td><font color="#000033" size="2"><%=usergenderS%></font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Adresse</font></b></td>
                                    <td><font color="#000033" size="2"><%=address%></font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*PLZ</font></b></td>
                                    <td><font color="#000033" size="2"><%=postcode%></font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="24" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Stadt</font></b></td>
                                    <td><font color="#000033" size="2"><%=city%></font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td bgcolor="657A9A"><b><font color="#FFFFFF" size="2">*Land</font></b></td>
                                    <td><font color="#000033" size="2"><%=country%></font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="30" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Telefon Nr</font></b></td>
                                    <td><font color="#000033" size="2"><%=homeno%></font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="25" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">B&uuml;ro Nr</font></b></td>
                                    <td><font color="#000033" size="2"><%=officeno%></font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="25" bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Handy Nr</font></b></td>
                                    <td><font color="#000033" size="2"><%=mobileno%></font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>Fax Nr.</b></font></td>
                                    <td><font color="#000033" size="2"><%=faxno%></font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td bgcolor="657A9A"><b><font color="#FFFFFF" size="2">Email</font></b></td>
                                    <td><font color="#000033" size="2"><%=email%></font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td colspan="2" bgcolor="657A9A"><div align="center"><b><font color="#FFFFFF">Bankverbindung</font></b></div></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="25" bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>Konto Nr.</b></font></td>
                                    <td><font color="#000033" size="2"><%=kontono%></font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="23" bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>BLZ</b></font></td>
                                    <td><font color="#000033" size="2"><%=blz%></font></td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>Bankname</b></font></td>
                                    <td><font color="#000033" size="2"><%=bankname%></font></td>
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
