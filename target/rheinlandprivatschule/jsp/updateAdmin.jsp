<html>
<head>
    <title>:: Update Administrator ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<%@ page import="java.util.*" %>
<%@ page import="com.rheinlandprivatschule.*" %>
<%@ page import="com.rheinlandprivatschule.helper.*" %>
<%@ page import="com.rheinlandprivatschule.model.SystemUser" %>
<%@ page import="com.rheinlandprivatschule.repository.SystemUserDao" %>
<%@ page import="com.rheinlandprivatschule.repository.PlaceDao" %>
<%@ page import="com.rheinlandprivatschule.repository.BookDao" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="com.rheinlandprivatschule.model.Place" %>
<%@ page session="true" %>

<body bgcolor="#FFFFFF" text="#000000">
<%
    SystemUser u=new SystemUser();
    SystemUserDao sdb=new SystemUserDao();
    PlaceDao pdb=new PlaceDao();
    BookDao bdb=new BookDao();

    RPS rps= (RPS) session.getAttribute("handler");
    SystemUser loginuser=new SystemUser();
    Place myPlace=new Place();
    if(rps==null){
        String err="Sitzung lief Ab";
        session.setAttribute("err",err);
        session.setAttribute("lin","../index.jsp");
        response.sendRedirect("error");
    }else{

        session.setAttribute("handler",rps);
        loginuser=rps.getLoginUser();
        myPlace=rps.getLoginPlace();

        if(sdb.canUpdateGeneralUser(loginuser.getUserID())){
            u=(SystemUser)session.getAttribute("padmin");
            if(u==null)	{
                u=new SystemUser();
            }

            String firstname=(String)request.getParameter("txtFirstName");
            String lastname=(String)request.getParameter("txtLastName");
            String birthday=(String)request.getParameter("selDay");
            String birthmonth=(String)request.getParameter("selMonth");
            String birthyear=(String)request.getParameter("selYear");
            String usergender=(String)request.getParameter("rdGender");
            String birthplace=(String)request.getParameter("txtBirthPlace");
            String nationality=(String)request.getParameter("txtNationality");
            String address=(String)request.getParameter("txtAddress");
            String postcode=(String)request.getParameter("txtPostCode");
            String city=(String)request.getParameter("txtCity");
            String country=(String)request.getParameter("txtCountry");
            String homeno=(String)request.getParameter("txtHomeNo");
            String mobileno=(String)request.getParameter("txtMobileNo");
            String faxno=(String)request.getParameter("txtFax");
            String email=(String)request.getParameter("txtEmail");
            String kontono=(String)request.getParameter("txtKonto");
            String blz=(String)request.getParameter("txtBLZ");
            String bankname=(String)request.getParameter("txtbankname");
            String loginname=(String)request.getParameter("txtLoginName");
            String password=(String)request.getParameter("txtPassword");
            String admintype=(String)request.getParameter("seltype");
            String usercat=(String)request.getParameter("selCate");
            int typevalue=Integer.parseInt(admintype);
            Vector placevec=new Vector();
            String adminplace[]=request.getParameterValues("checkbox");
            String company=(String)request.getParameter("txtCompany");
            String bamfnumber=(String)request.getParameter("txtBamfNumber");

            if(adminplace!=null){
                for(int a=0;a<adminplace.length;a++){
                    try	{
                        placevec.addElement(adminplace[a]);
                    }catch(Exception ee){
                    }
                }
            }

            java.sql.Date dd=MyDate.getSQLDateFromStrings(birthday,birthmonth,birthyear,MyDate.DEUTSCH);

            u.setUserFirstName(firstname);
            u.setUserLastName(lastname);
            u.setUserBirthDate(dd);
            u.setUserGender(Integer.parseInt(usergender));
            u.setUserBirthPlace(birthplace);
            u.setUserNationality(nationality);
            u.setUserAddress(address);
            u.setUserPostCode(postcode);
            u.setUserCity(city);
            u.setUserCountry(country);
            u.setUserHomePhone(homeno);
            u.setUserMobilePhone(mobileno);
            u.setUserFax(faxno);
            u.setUserEmail(email);
            u.setUserAccountNo(kontono);
            u.setUserBLZ(blz);
            u.setUserBankName(bankname);
            u.setUserType(Integer.parseInt(admintype));
            u.setUserLoginName(loginname);
            u.setUserPassword(password);
            //u.setUserRemarks("Not Given");
            //u.setUserStundenLohn(10);
            u.setUserPlaces(placevec);
            u.setUserCompany(company);
            u.setUserBamfNumber(bamfnumber);

            boolean respect=false;
            if(u.getUserID()==1){
                if(u.getUserID()==loginuser.getUserID()){
                    respect=true;
                }else{
                    respect=false;
                }
            }else{
                respect=true;
            }

            if(respect){
                int userCATID=Integer.parseInt(usercat);
                if(userCATID==5){
                    u.setUserPassword("inCorrect123");
                    if(sdb.updateSystemUser(u)){
                        bdb.updateUserToBook(u.getUserID(),userCATID);
                        response.sendRedirect("/user/adminUserList");
                    }else{
                        String err="Sitzung lief Ab. Noch einmal versuchen";
                        session.setAttribute("err",err);
                        session.setAttribute("lin","adminUserList.jsp");
                        response.sendRedirect("error.jsp");
                    }
                }else{
                    if(sdb.updateSystemUser(u)){
                        int abc=bdb.updateUserToBook(u.getUserID(),userCATID);
                        response.sendRedirect("/user/adminUserList");
                    }else{
                        String err="Sitzung lief Ab. Noch einmal versuchen";
                        session.setAttribute("err",err);
                        session.setAttribute("lin","adminUserList.jsp");
                        response.sendRedirect("error.jsp");
                    }
                }
            }else{
                String err="Sitzung lief Ab. Noch einmal versuchen";
                session.setAttribute("err",err);
                session.setAttribute("lin","adminUserList.jsp");
                response.sendRedirect("error.jsp");
            }

        }else{
            String err=sdb.getError();
            session.setAttribute("err",err);
            session.setAttribute("lin","../map.jsp");
            response.sendRedirect("error.jsp");
        }
    }
%>
</body>
</html>
