<SCRIPT TYPE="text/javascript">
    function myOpen(){

        history.go(-1);
        window.open("printRentIn"); // params and stuff

    }
</SCRIPT>
</head>
<%@ page import="java.util.*" %>
<%@ page import="com.rheinlandprivatschule.model.Residence" %>
<%@ page import="com.rheinlandprivatschule.repository.ResidenceDao" %>
<body bgcolor="#FFFFFF" text="#000000" onLoad="myOpen()">
<%
    Vector v=new Vector();

    String list[] =request.getParameterValues("dr");
    ResidenceDao residenceDao = (ResidenceDao) request.getAttribute("residenceDao");
    if(list!=null){
        for(int i=0;i<list.length;i++){
            try{
                Residence t=residenceDao.getRentInPrint(Integer.parseInt(list[i]));
                v.addElement(t);
            }catch(Exception e){
            }
        }
        session.setAttribute("tr",v);
    }else{
        String err="Zuerst Ausgesuchte Rechnungen";
        session.setAttribute("err",err);
        session.setAttribute("lin","showRentInTrans");


%>
<form name="form1" method="post" action="">

</form>
</body>
</html>