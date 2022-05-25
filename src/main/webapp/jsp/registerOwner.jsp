<html>
<head>
    <title>:: Register Admin ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.model.ResidenceOwner" %>
<%@ page import="com.rheinlandprivatschule.repository.ResidenceOwnerDao" %>

<body bgcolor="#FFFFFF" text="#000000">
<%
    ResidenceOwnerDao rodb= (ResidenceOwnerDao) request.getAttribute("residenceOwnerDao");

    String company=(String)request.getParameter("txtCompany");
    String firstname=(String)request.getParameter("txtFirstName");
    String lastname=(String)request.getParameter("txtLastName");
    String birthday=(String)request.getParameter("selDay");
    String birthmonth=(String)request.getParameter("selMonth");
    String birthyear=(String)request.getParameter("selYear");
    String usergender=(String)request.getParameter("rdGender");

    String address=(String)request.getParameter("txtAddress");
    String postcode=(String)request.getParameter("txtPostCode");
    String city=(String)request.getParameter("txtCity");
    String country=(String)request.getParameter("txtCountry");
    String homeno=(String)request.getParameter("txtHomeNo");
    String officeno=(String)request.getParameter("txtOfficeNo");
    String mobileno=(String)request.getParameter("txtMobileNo");
    String faxno=(String)request.getParameter("txtFax");
    String email=(String)request.getParameter("txtEmail");

    String kontono=(String)request.getParameter("txtKonto");
    String blz=(String)request.getParameter("txtBLZ");
    String bankname=(String)request.getParameter("txtbankname");

    String loginname=(String)request.getParameter("txtLoginName");
    String password=(String)request.getParameter("txtPassword");


    java.sql.Date dd= MyDate.getSQLDateFromStrings(birthday,birthmonth,birthyear,MyDate.DEUTSCH);

    ResidenceOwner owner=new ResidenceOwner();
    owner.setResidenceOwnerCompany(company);
    owner.setResidenceOwnerFirstName(firstname);
    owner.setResidenceOwnerLastName(lastname);
    owner.setResidenceOwnerBirthDate(dd);
    owner.setResidenceOwnerGender(Integer.parseInt(usergender));

    owner.setResidenceOwnerAddress(address);
    owner.setResidenceOwnerPostCode(postcode);
    owner.setResidenceOwnerCity(city);
    owner.setResidenceOwnerCountry(country);
    owner.setResidenceOwnerHomePhone(homeno);
    owner.setResidenceOwnerOfficePhone(officeno);
    owner.setResidenceOwnerMobilePhone(mobileno);
    owner.setResidenceOwnerFax(faxno);
    owner.setResidenceOwnerEmail(email);

    owner.setResidenceOwnerAccountNo(kontono);
    owner.setResidenceOwnerBLZ(blz);
    owner.setResidenceOwnerBankName(bankname);

    owner.setResidenceOwnerLoginName(loginname);
    owner.setResidenceOwnerPassword(password);

    rodb.addNewResidenceOwner(owner);
    response.sendRedirect("ownersList");

%>
</body>
</html>
