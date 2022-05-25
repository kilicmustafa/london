<html>
<head>
    <title>:: Register Admin ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<%@ page import="com.rheinlandprivatschule.repository.ResidenceDao" %>
<%@ page import="com.rheinlandprivatschule.model.Residence" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ page session="true" %>

<body bgcolor="#FFFFFF" text="#000000">
<%
    ResidenceDao rdb= (ResidenceDao) request.getAttribute("residenceDao");

    String mark=(String)request.getParameter("txtMark");
    String address=(String)request.getParameter("txtAddress");
    String postcode=(String)request.getParameter("txtPostCode");
    String city=(String)request.getParameter("txtCity");
    String country=(String)request.getParameter("txtCountry");

    String size=(String)request.getParameter("txtSize");
    String description =(String)request.getParameter("txtDescription");
    String rent=(String)request.getParameter("txtRent");
    String addcost=(String)request.getParameter("txtAddCost");
    String kation=(String)request.getParameter("txtKation");
    String meterno=(String)request.getParameter("txtMeterNo");

    String ownerid=(String)request.getParameter("selOwner");
    String vwarmmiete=(String)request.getParameter("txtVWMiete");
    String vkation=(String)request.getParameter("txtVKation");

    String paidday=(String)request.getParameter("selDay");
    String paidmonth=(String)request.getParameter("selMonth");
    String paidyear=(String)request.getParameter("selYear");

    String startday=(String)request.getParameter("selSDay");
    String startmonth=(String)request.getParameter("selSMonth");
    String startyear=(String)request.getParameter("selSYear");

    String endday=(String)request.getParameter("selEDay");
    String endmonth=(String)request.getParameter("selEMonth");
    String endyear=(String)request.getParameter("selEYear");

    java.sql.Date paiddate=MyDate.getSQLDateFromStrings(paidday,paidmonth,paidyear,MyDate.DEUTSCH);
    java.sql.Date startdate=MyDate.getSQLDateFromStrings(startday,startmonth,startyear,MyDate.DEUTSCH);
    java.sql.Date enddate = null;

    String residenceType = request.getParameter("residenceType");

    try{
        Integer.parseInt(endday);
        Integer.parseInt(endyear);
        if(!endmonth.equalsIgnoreCase("--")){
            enddate=MyDate.getSQLDateFromStrings(endday,endmonth,endyear, MyDate.DEUTSCH);
        }
    }catch(Exception eee){
    }

    Residence residence=new Residence();
    residence.setResidenceMark(mark);
    residence.setResidenceAddress(address);
    residence.setResidencePostCode(postcode);
    residence.setResidenceCity(city);
    residence.setResidenceCountry(country);

    residence.setResidenceSize(size);
    residence.setResidenceDescription(description);
    residence.setResidenceRent(MyCurrency.getDoubleValue(rent));
    residence.setResidenceSideCosts(MyCurrency.getDoubleValue(addcost));
    residence.setResidenceKation(MyCurrency.getDoubleValue(kation));
    residence.setResidenceMeterNumber(meterno);

    residence.setResidenceOwner(Integer.parseInt(ownerid));
    residence.setVermieterWarmMiete(MyCurrency.getDoubleValue(vwarmmiete));
    residence.setVermieterKation(MyCurrency.getDoubleValue(vkation));
    residence.setVermieterKationPaidDate(paiddate);
    residence.setVermieterMietStart(startdate);
    residence.setVermieterMietEnd(enddate);
    residence.setResidenceType(residenceType);
    rdb.addNewResidence(residence);
    response.sendRedirect("residencesList");
%>
</body>
</html>
