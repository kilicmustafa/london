<%@ page import="com.rheinlandprivatschule.repository.PlaceDao" %>
<%@ page import="com.rheinlandprivatschule.model.Place" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<html>
<head>
    <title>:: Add Course Process ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%
    PlaceDao PlaceDao=new PlaceDao();


    RPS rps=(RPS)session.getAttribute("handler");
    if(rps==null){
        String err="Sitzung lief Ab";
        session.setAttribute("err",err);
        session.setAttribute("lin","../index.jsp");
        response.sendRedirect("/error");
    }else{

        session.setAttribute("handler",rps);

        if(PlaceDao.canAddNewSchool(rps.getLoginUser().getUserID())){
            String firma=(String)request.getParameter("txtFirma");
            String name=(String)request.getParameter("txtName");
            String add=(String)request.getParameter("txtAddress");
            String telephone=(String)request.getParameter("txtTelephone");
            String postcode=(String)request.getParameter("txtPostCode");
            String city=(String)request.getParameter("txtCity");
            String country=(String)request.getParameter("txtCountry");
            String fax=(String)request.getParameter("txtFax");
            String email=(String)request.getParameter("txtEmail");
            String bamf=(String)request.getParameter("txtBamf");
            String business=(String)request.getParameter("txtBusiness");
            String tax=(String)request.getParameter("txtTax");
            String rechschool=(String)request.getParameter("txtRechSchool");
            String rechurl=(String)request.getParameter("txtRechURL");
            String rechaddress=(String)request.getParameter("txtRechAddress");
            String txtCom1=(String)request.getParameter("txtComment1");
            String txtCom2=(String)request.getParameter("txtComment2");
            String txtCom3=(String)request.getParameter("txtComment3");
            String txtCom4=(String)request.getParameter("txtComment4");
            String txtCom5=(String)request.getParameter("txtComment5");
            String txtCom6=(String)request.getParameter("txtComment6");
            String txtCom7=(String)request.getParameter("txtComment7");
            String txtCom8=(String)request.getParameter("txtComment8");


            Place pp=new Place();
            try{
                pp.setPlaceID(0);
                pp.setFirmaName(firma);
                pp.setPlaceName(name);
                pp.setPlaceAddress(add);
                pp.setPlaceTelephone(telephone);
                pp.setPlacePostCode(postcode);
                pp.setPlaceCity(city);
                pp.setPlaceCountry(country);
                pp.setPlaceFax(fax);
                pp.setPlaceEmail(email);
                pp.setBamfNumber(bamf);
                pp.setBusinessNumber(business);
                pp.setTaxNumber(tax);
                pp.setBillSchool(rechschool);
                pp.setBillURL(rechurl);
                pp.setBillAddress(rechaddress);
                pp.setComment1(txtCom1);
                pp.setComment2(txtCom2);
                pp.setComment3(txtCom3);
                pp.setComment4(txtCom4);
                pp.setComment5(txtCom5);
                pp.setComment6(txtCom6);
                pp.setComment7(txtCom7);
                pp.setComment8(txtCom8);

            }catch(Exception e){
            }

            if(PlaceDao.addNewPlace(pp)==1){
                response.sendRedirect("/school/schoolList");
            }else{
                String err="Sitzung lief Ab";
                session.setAttribute("err",err);
                session.setAttribute("lin","schoolList.jsp");
                response.sendRedirect("/error");
            }
        }else{
            String err=PlaceDao.getError();
            session.setAttribute("err",err);
            session.setAttribute("lin","../map.jsp");
            response.sendRedirect("/error");
        }


    }
%>
</body>
</html>
