<html>
<head>
    <title>:: Print Bericht ::</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <SCRIPT TYPE="text/javascript">
            function myOpen(){

                history.go(-1);
                window.open("printBillMul"); // params and stuff

            }
    </SCRIPT>
</head>
<%@ page import="java.util.*" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="com.rheinlandprivatschule.model.Transaction" %>
<%@ page import="com.rheinlandprivatschule.repository.TransactionDao" %>
<%@ page session="true" %>
<body bgcolor="#FFFFFF" text="#000000" onLoad="myOpen()">
<%
    Vector v=new Vector();

    RPS rps=(RPS)session.getAttribute("handler");
    if(rps==null){
        String err="Sitzung lief Ab";
        session.setAttribute("err",err);
        session.setAttribute("lin","../index.jsp");
        response.sendRedirect("error");
    }else{
        session.setAttribute("handler",rps);

        String list[] =request.getParameterValues("dr");
        if(list!=null){
            for(int i=0;i<list.length;i++){
                try{
                    Transaction t=(new TransactionDao()).getTransaction(Integer.parseInt(list[i]));
                    v.addElement(t);
                }catch(Exception e){
                }
            }
            session.setAttribute("tr",v);
        }else{
            String err="Zuerst Ausgesuchte Rechnungen";
            session.setAttribute("err",err);
            session.setAttribute("lin","searchTransactions");
            response.sendRedirect("error");
        }
    }

%>
</body>
</html>
