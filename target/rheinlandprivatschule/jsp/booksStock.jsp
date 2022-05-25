<%@ page import="com.rheinlandprivatschule.repository.BuchDao" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.model.Buch" %>
<%@ page import="com.rheinlandprivatschule.model.Place" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="com.rheinlandprivatschule.repository.PlaceDao" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Buch Status ::</title>
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
        function setfocus(){
            document.forms[0].id.focus();
        }
        function searchbook(){
            document.form1.action="booksStock?cmd=s";
            document.form1.submit();
        }

        function deletebook(){
            if(!confirm("wollen Sie dieses Buch löschen?")) {
                return false;
            }else{
                if(document.form1.can.value=='1'){
                    document.form1.action="booksStock?cmd=r";
                    document.form1.submit();
                }else{
                    alert('Buch kann nicht gelöscht werden.');
                }
            }
        }

        function MM_findObj(n, d) { //v4.01
            var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
                d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
            if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
            for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
            if(!x && d.getElementById) x=d.getElementById(n); return x;
        }

        function MM_validateForm() { //v4.0
            var i,p,q,nm,test,num,min,max,errors='',args=MM_validateForm.arguments;
            for (i=0; i<(args.length-2); i+=3) { test=args[i+2]; val=MM_findObj(args[i]);
                if (val) { nm=val.name; if ((val=val.value)!="") {
                    if (test.indexOf('isEmail')!=-1) { p=val.indexOf('@');
                        if (p<1 || p==(val.length-1)) errors+='- '+nm+' must contain an e-mail address.\n';
                    } else if (test!='R') { num = parseFloat(val);
                        if (isNaN(val)) errors+='- '+nm+' must contain a number.\n';
                        if (test.indexOf('inRange') != -1) { p=test.indexOf(':');
                            min=test.substring(8,p); max=test.substring(p+1);
                            if (num<min || max<num) errors+='- '+nm+' must contain a number between '+min+' and '+max+'.\n';
                        } } } else if (test.charAt(0) == 'R') errors += '- '+nm+' is required.\n'; }
            } if (errors) alert('The following error(s) occurred:\n'+errors);
            document.MM_returnValue = (errors == '');
        }
    </script>
</head>
<body>
<%
    BuchDao bdb= (BuchDao) request.getAttribute("buchDao");
    PlaceDao placeDao = (PlaceDao) request.getAttribute("placeDao");

    String bookname="";
    String bookplace="";
    String bookstatus="";
    String buyername="";

    String booktodelete="0";
    String can="0";

    String cmd=(String)request.getParameter("cmd");

    RPS rps = (RPS) session.getAttribute("handler");
    if(cmd!=null){
        if(cmd.equalsIgnoreCase("r")){
            String cann=(String)request.getParameter("can");
            String booktrackid=(String)request.getParameter("bookid");
            if(cann.equalsIgnoreCase("1")){
                if(bdb.canDeleteBook(rps.getLoginUser().getUserID())){
                    bdb.deleteBookRecord(Integer.parseInt(booktrackid));
                }else{
                    String err=bdb.getError();
                    session.setAttribute("err",err);
                    session.setAttribute("lin","../map");
                    response.sendRedirect("error");
                }
            }
        }else if(cmd.equalsIgnoreCase("s")){

            String ids=(String)request.getParameter("id");
            int booktrack=0;
            try{
                booktrack=Integer.parseInt(ids);
                Buch book=bdb.getBookForSale(booktrack);
                Buch buyer=bdb.getBookBuyer(booktrack);
                if(book.getBookTrack()>0){
                    booktodelete=""+book.getBookTrack();
                    bookname=book.getBookName();
                    int result=bdb.whereIsBook(booktrack);
                    if(result==0){
                        bookplace="Lager";
                        bookstatus="Nein";
                        can="1";
                    }else{
                        Vector places=placeDao.getAllPlaces();
                        for(int i=0;i<places.size();i++){
                            Place temp=(Place)places.elementAt(i);
                            if(result==temp.getPlaceID()){
                                bookplace=temp.getPlaceName();
                                if(bdb.isBookForSale(booktrack,temp.getPlaceID())){
                                    bookstatus="Nein";
                                    can="1";
                                }else{
                                    bookstatus="Ja";
                                    buyername=buyer.getStudentName();
                                }
                            }
                        }
                    }
                }
            }catch(Exception e){
            }
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
                        <form style="width:100%;" action="booksStock?cmd=s" method="post" name="form1">
                            <table width="100%" border="0" height="120">
                                <tr>
                                    <td height="100" valign="top">
                                        <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                            <tr bgcolor="657A9A">
                                                <td height="22" colspan="2">
                                                    <div align="center"><b><font color="#FFFFFF">Buch
                                                        Status</font></b></div>
                                                </td>
                                            </tr>
                                            <tr bgcolor="657A9A">
                                                <td bgcolor="657A9A" height="22" width="15%">
                                                    <div align="left"><font color="#FFFFFF" size="2"><b>Buch ID </b></font></div>
                                                </td>
                                                <td bgcolor="AEBACD" height="22"><input name="id" type="text" id="id" >
                                                </td>
                                            </tr>
                                            <tr bgcolor="657A9A">
                                                <td height="6" colspan="2">&nbsp;</td>
                                            </tr>
                                            <tr bgcolor="657A9A">
                                                <td height="6" bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>Buchname</b></font><font size="2" color="#FFFFFF">&nbsp;</font></td>
                                                <td height="6" bgcolor="AEBACD"><font size="2" color="#000033"><%=bookname%></font></td>
                                            </tr>
                                            <tr bgcolor="AEBACD">
                                                <td height="6" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Ort</font></strong></td>
                                                <td height="6" bgcolor="AEBACD"><font size="2" color="#000033"><%=bookplace%></font></td>
                                            </tr>
                                            <tr bgcolor="AEBACD">
                                                <td height="6" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Verkauft</font></strong></td>
                                                <td height="6" bgcolor="AEBACD"><font size="2" color="#000033"><%=bookstatus%></font></td>
                                            </tr>
                                            <tr bgcolor="AEBACD">
                                                <td height="6" bgcolor="657A9A"><strong><font color="#FFFFFF" size="2">Schuler Name </font></strong></td>
                                                <td height="6" bgcolor="AEBACD"><font size="2" color="#000033"><%=buyername%></font></td>
                                            </tr>
                                            <tr bgcolor="AEBACD">
                                                <td height="6" colspan="2" bgcolor="AEBACD"><input class="btn btn-primary" type="button" name="Button" value="Suchen" onClick="searchbook()">
                                                    <input class="btn btn-primary" type="button" name="Button" value="L&ouml;schen" onClick="deletebook()">
                                                    <input name="can" type="hidden" id="can" value="<%=can%>">
                                                    <input name="bookid" type="hidden" id="bookid" value="<%=booktodelete%>"></td>
                                            </tr>
                                        </table>
                                    </td>
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
