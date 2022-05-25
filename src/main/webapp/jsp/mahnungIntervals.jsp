<%@ page import="com.rheinlandprivatschule.repository.MahnungDao" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Zwischenraum f&uuml;r Mahnung und Inkasso ::</title>
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

        function am()
        {
            document.form1.action="mahnungIntervals?cmd=m";
            document.form1.submit();
        }
        function km()
        {
            document.form1.action="mahnungIntervals?cmd=k";
            document.form1.submit();
        }


        function MM_findObj(n, d) { //v4.0
            var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
                d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
            if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
            for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
            if(!x && document.getElementById) x=document.getElementById(n); return x;
        }

        function MM_validateForm() { //v4.0
            var i,p,q,nm,test,num,min,max,errors='',args=MM_validateForm.arguments;
            for (i=0; i<(args.length-2); i+=3) { test=args[i+2]; val=MM_findObj(args[i]);
                if (val) { nm=val.name; if ((val=val.value)!="") {
                    if (test.indexOf('isEmail')!=-1) { p=val.indexOf('@');
                        if (p<1 || p==(val.length-1)) errors+='- '+nm+' must contain an e-mail address.\n';
                    } else if (test!='R') {
                        if (isNaN(val)) errors+='- '+nm+' must contain a number.\n';
                        if (test.indexOf('inRange') != -1) { p=test.indexOf(':');
                            min=test.substring(8,p); max=test.substring(p+1);
                            if (val<min || max<val) errors+='- '+nm+' must contain a number between '+min+' and '+max+'.\n';
                        } } } else if (test.charAt(0) == 'R') errors += '- '+nm+' is required.\n'; }
            } if (errors) alert('The following error(s) occurred:\n'+errors);
            document.MM_returnValue = (errors == '');
        }
    </script>
</head>
<body>
<%

    MahnungDao mdb= new MahnungDao();
    String mvalue="";
    String kvalue="";

    RPS rps=(RPS)session.getAttribute("handler");
    session.setAttribute("handler",rps);

    String cmd=(String)request.getParameter("cmd");
    if(rps != null && cmd!=null)
    {
        if(cmd.equalsIgnoreCase("m"))
        {
            int days=0;
            String min=(String)request.getParameter("mahnung");
            try
            {
                days=Integer.parseInt(min);
            }
            catch(Exception e)
            {
            }
            if(!mdb.setMahnungInterval(days,rps.getLoginUser().getUserID())){
                String err=mdb.getError();
                session.setAttribute("err",err);
                session.setAttribute("lin","../map.jsp");
                response.sendRedirect("/error");
            }else{
                response.sendRedirect("mahnungIntervals");
            }
        }
        else if(cmd.equalsIgnoreCase("k"))
        {
            int days=0;
            String kin=(String)request.getParameter("inkasso");
            try
            {
                days=Integer.parseInt(kin);
            }
            catch(Exception e)
            {
            }
            if(!mdb.setInkassoInterval(days,rps.getLoginUser().getUserID())){
                String err=mdb.getError();
                session.setAttribute("err",err);
                session.setAttribute("lin","../map.jsp");
                response.sendRedirect("/error");
            }else{
                response.sendRedirect("mahnungIntervals");
            }
        }

    }
    else
    {
        int minterval=mdb.getMahnungInterval();
        if(minterval<0){
            String err=mdb.getError();
            session.setAttribute("err",err);
            session.setAttribute("lin","../map.jsp");
            response.sendRedirect("/error");
        }else{
            mvalue=""+minterval;
            kvalue=""+mdb.getInkassoInterval();
        }

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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width: 100%;" name="form1" method="post" action="mahnungIntervals" onSubmit="MM_validateForm('txtM','','RisNum','txtK','','RisNum');return document.MM_returnValue">
                            <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                <tr bgcolor="657A9A">
                                    <td height="22" colspan="2">
                                        <div align="center"><b><font color="#FFFFFF">Zwischenraum</font></b></div>
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="20" bgcolor="657A9A" width="15%"><b><font size="2" color="#FFFFFF">Mahnung</font></b></td>
                                    <td height="20" bgcolor="AEBACD" width="85%">
                                        <input type="text" name="mahnung" value="<%=mvalue%>">
                                        <input class="btn btn-primary" type="button" name="Button" value="Aktualisierung" onClick="am()">
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6" bgcolor="657A9A" width="15%"><b><font size="2" color="#FFFFFF">Inkasso</font></b></td>
                                    <td height="6" bgcolor="AEBACD" width="85%">
                                        <input type="text" name="inkasso" value="<%=kvalue%>">
                                        <input class="btn btn-primary" type="button" name="Submit2" value="Aktualisierung" onClick="km()">
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td height="6" bgcolor="657A9A" width="15%">&nbsp;</td>
                                    <td height="6" bgcolor="AEBACD" width="85%">&nbsp; </td>
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
