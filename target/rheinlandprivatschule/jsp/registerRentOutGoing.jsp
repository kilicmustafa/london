<%@ page import="com.rheinlandprivatschule.repository.ResidenceDao" %>
<%@ page import="com.rheinlandprivatschule.model.Residence" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ page import="com.rheinlandprivatschule.model.Place" %>
<%@ page import="com.rheinlandprivatschule.model.SystemUser" %>
<html>
<head>
    <title>:: Register Admin ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%
    ResidenceDao residenceDB= (ResidenceDao) request.getAttribute("residenceDao");

    Residence residence=new Residence();
    MyDate num = new MyDate();

    int month =0;
    String paidday="1";
    String delete = new String();
    String loginname = new String();

    residence=(Residence)session.getAttribute("presidence");
    if(residence==null)	{
        residence=new Residence();
    }
    String residenceID=(String)request.getParameter("residenceid");
    String paidmonth=(String)request.getParameter("selMonth");
    String paidyear=(String)request.getParameter("selYear");
    String rent=(String)request.getParameter("txtRent");
    String deleteID=(String)request.getParameter("deleteid");
    String mode=(String)request.getParameter("selIden");
    String placename = ((Place) request.getAttribute("myPlace")).getPlaceName();
    String balance=(String)request.getParameter("txtBalance");
    double totalpaid = MyCurrency.getDoubleValue(rent) + MyCurrency.getDoubleValue(balance);

    loginname = loginname.concat(((SystemUser) request.getAttribute("loginUser")).getUserFirstName());
    loginname = loginname.concat(" ");
    loginname = loginname.concat(((SystemUser) request.getAttribute("loginUser")).getUserLastName());

    month = MyDate.getMonthNumber(paidmonth,MyDate.DEUTSCH);
    delete= delete.concat(residenceID);
    delete= delete.concat(Integer.toString(month));
    delete= delete.concat(paidyear);

    java.sql.Date rentdate=MyDate.getCurrentSQLDate();
    Residence res =new Residence();

    try{
        res.setRentMonth(MyDate.getMonthNumber(paidmonth,MyDate.DEUTSCH));
        res.setResidenceID(Integer.parseInt(residenceID));
        res.setRentYear(Integer.parseInt(paidyear));
        res.setRentDate(rentdate);
        res.setAmountPaid(MyCurrency.getDoubleValue(rent));
        res.setDeleteFunction(Integer.parseInt(delete));
        res.setPaymentModeID(Integer.parseInt(mode));
        res.setLoginName(loginname);
        res.setPlaceName(placename);
        res.setAmountBalance(totalpaid);


    }catch(Exception e){
    }
    // residenceDB.deleteRentIn(res);
    int tranno= residenceDB.addNewRentOut(res);

    session.setAttribute("myPrint","bill");
    session.setAttribute("tranno",""+tranno);
    response.sendRedirect("printRentOutProcessMain");

%>
</body>
</html>
