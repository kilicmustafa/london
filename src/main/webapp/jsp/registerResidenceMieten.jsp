<html>
<head>
    <title>:: Register Admin ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<%@ page import="com.rheinlandprivatschule.model.ResidenceMieten" %>
<%@ page import="com.rheinlandprivatschule.model.Residence" %>
<%@ page import="com.rheinlandprivatschule.model.Resident" %>
<%@ page import="com.rheinlandprivatschule.repository.MietenDB" %>
<%@ page import="com.rheinlandprivatschule.repository.ResidentDao" %>
<%@ page import="com.rheinlandprivatschule.repository.ResidenceDao" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>

<body bgcolor="#FFFFFF" text="#000000">
<%
    ResidenceDao rdb= (ResidenceDao) request.getAttribute("residenceDao");
    MietenDB mdb= (MietenDB) request.getAttribute("mietenDB");

    ResidentDao rtdb= (ResidentDao) request.getAttribute("residentDao");
    Residence residence=new Residence();
    Resident resident=new Resident();

    String residentidS = (String)session.getAttribute("pmieter");
    String residenceidS = (String)session.getAttribute("presidence");
    try{
        int residentID = Integer.parseInt(residentidS);
        int residenceID = Integer.parseInt(residenceidS);
        session.setAttribute("pmieter",null);
        session.setAttribute("presidence",null);
        String startday=(String)request.getParameter("selSDay");
        String startmonth=(String)request.getParameter("selSMonth");
        String startyear=(String)request.getParameter("selSYear");

        String endday=(String)request.getParameter("selEDay");
        String endmonth=(String)request.getParameter("selEMonth");
        String endyear=(String)request.getParameter("selEYear");

        java.sql.Date startdate= MyDate.getSQLDateFromStrings(startday,startmonth,startyear,MyDate.DEUTSCH);
        java.sql.Date enddate = null;

        try{
            Integer.parseInt(endday);
            Integer.parseInt(endyear);
            if(!endmonth.equalsIgnoreCase("--")){
                enddate=MyDate.getSQLDateFromStrings(endday,endmonth,endyear,MyDate.DEUTSCH);
            }
        }catch(Exception eee){
        }

        ResidenceMieten residenceMieten=new ResidenceMieten();
        residenceMieten.setResidenceID(residenceID);
        residenceMieten.setResidentID(residentID);
        residenceMieten.setMietStart(startdate);
        residenceMieten.setMietEnd(enddate);
        mdb.addNewMieten(residenceMieten);
        response.sendRedirect("mieterDetails?residentid="+residentID);

    }catch(Exception eee){
        String err=mdb.getError();
        session.setAttribute("err",err);
        session.setAttribute("lin","../map.jsp");
        response.sendRedirect("error");
    }
%>
</body>
</html>
