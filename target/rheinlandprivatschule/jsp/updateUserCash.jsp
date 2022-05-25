<%@ page import="com.rheinlandprivatschule.model.Place" %>
<%@ page import="com.rheinlandprivatschule.model.SystemUser" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.repository.*" %>
<html>
<head>
    <title>:: Update Fee ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%
    Place myPlace=new Place();
    SystemUser loginuser=new SystemUser();
    TransactionDao transDB=new TransactionDao();
    StudentDao studentDB=new StudentDao();
    Place reqPlace=new Place();
    SystemUser reqAdmin=new SystemUser();

    String txtBal="";
    String selC="";
    String selAdmin="";
    String selPlace="";
    String paytype="";
    String tranNo="";

    String selSDay="";
    String selSMonth="";
    String selSYear="";
    String selEDay="";
    String selEMonth="";
    String selEYear="";

    RPS rps=(RPS)session.getAttribute("handler");
    if(rps==null){
        String err="Sitzung lief Ab";
        session.setAttribute("err",err);
        session.setAttribute("lin","../index");
        response.sendRedirect("error");
    }else{
        session.setAttribute("handler",rps);
        String chkbox=null;

        boolean adminprevilige=studentDB.payForTheCourse(rps.getLoginUser().getUserID());

        if(adminprevilige){
            myPlace=rps.getLoginPlace();
            loginuser=rps.getLoginUser();

            txtBal=(String)request.getParameter("txtBal");
            selC=(String)request.getParameter("selC");
            selAdmin=(String)request.getParameter("selAdmin");
            selPlace=(String)request.getParameter("selPlace");
            paytype=(String)request.getParameter("paytype");
            tranNo=(String)request.getParameter("tranno");
            selSDay=(String)request.getParameter("selSDay");
            selSMonth=(String)request.getParameter("selSMonth");
            selSYear=(String)request.getParameter("selSYear");
            selEDay=(String)request.getParameter("selEDay");
            selEMonth=(String)request.getParameter("selEMonth");
            selEYear=(String)request.getParameter("selEYear");

            try{
                if(!selAdmin.equalsIgnoreCase("wählen Administrator")){
                    int admin=Integer.parseInt(selAdmin);
                    reqAdmin=(new SystemUserDao()).getSystemUser(admin);
                }
            }catch(Exception e){
            }

            try{
                if(!selPlace.equalsIgnoreCase("wählen Schule")){
                    int place=Integer.parseInt(selPlace);
                    reqPlace=(new PlaceDao()).getPlace(place);
                }
            }catch(Exception e){
            }

            double paid= MyCurrency.getDoubleValue(txtBal);
            java.sql.Date d1= MyDate.getCurrentSQLDate();

            int tran=transDB.addKassea(paid,d1,rps.getLoginPlace().getPlaceID(),reqAdmin.getUserID());
            session.setAttribute("tranno",""+tran);
            session.setAttribute("ap",""+paid);

            response.sendRedirect("showUserCash?selC="+selC+"&selAdmin="+selAdmin+"&selPlace="+selPlace+"&paytype="+paytype+"&tranNo="+tranNo+"&selSDay="+selSDay+"&selSMonth="+selSMonth+"&selSYear="+selSYear+"&selEDay="+selEDay+"&selEMonth="+selEMonth+"&selEYear="+selEYear);


        }else{
            String err=studentDB.getError();
            session.setAttribute("err",err);
            session.setAttribute("lin","../map");
            response.sendRedirect("error");
        }

    }
%>

</body>
</html>
