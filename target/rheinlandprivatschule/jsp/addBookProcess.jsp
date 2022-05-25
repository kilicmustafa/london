<HTML>
<HEAD>
    <TITLE>:: Schulen ::</TITLE>
    <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
    <!-- ImageReady Preload Script (Template.psd) -->
    <SCRIPT TYPE="text/javascript">

        var myPopup = '';

        function popUp(loc,eyeD,X,Y){
            window.open(loc,eyeD,"toolbar=no,location=0,directories=no,status=no,menubar=0,scrollbars=yes,resizable=0,width=" + X + ",height=" + Y + "'");
        }




        function MM_findObj(n, d) { //v4.0
            var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
                d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
            if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
            for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
            if(!x && document.getElementById) x=document.getElementById(n); return x;
        }

        function MM_swapImgRestore() { //v3.0
            var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
        }

        function MM_preloadImages() { //v3.0
            var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
                var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
                    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
        }

        function MM_swapImage() { //v3.0
            var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
                if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
        }
    </SCRIPT>
    <!-- End Preload Script -->
</HEAD>
<BODY BGCOLOR=#FFFFFF LEFTMARGIN=0 TOPMARGIN=0 MARGINWIDTH=0 MARGINHEIGHT=0 ONLOAD="preloadImages();MM_preloadImages('../images/sidenav/such_bt_over.gif','../images/sidenav/aktivecourse_bt_over.gif','../images/sidenav/algemeinkat_bt_over.gif','../images/sidenav/ausgabe_bt_over.gif','../images/sidenav/stundenplan_bt_over.gif')">
<!-- ImageReady Slices (Template.psd) -->
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ page import="com.rheinlandprivatschule.model.Buch" %>
<%@ page import="com.rheinlandprivatschule.repository.BuchDao" %>

<%@ page session="true" %>
<%
    BuchDao bdb= (BuchDao) request.getAttribute("buchDao");

    String bookname= request.getParameter("bname");
    String isbn= request.getParameter("isbn");
    String price= request.getParameter("price");
    String stufe= request.getParameter("selStufe");
    double priceD=0;
    int stufeN=0;
    try	{
        priceD= MyCurrency.getDoubleValue(price);
        stufeN=Integer.parseInt(stufe);
        Buch b=new Buch();
        b.setBookName(bookname);
        b.setISBN(isbn);
        b.setPrice(priceD);
        b.setStufe(stufeN);
        boolean va=bdb.addBook(b);
        if(!va){
            String err="Das ist in diesem Augenblick nicht möglich. noch einmal versuchen";
            session.setAttribute("err",err);
            session.setAttribute("lin","addBook");
            response.sendRedirect("error");
        }
        response.sendRedirect("addBook");
    }catch(Exception e){

        String err="Geben Sie nur numer im Preis Feld, noch einmal versuchen";
        session.setAttribute("err",err);
        session.setAttribute("lin","addBook");
        response.sendRedirect("error");
    }
%>

<!-- End ImageReady Slices -->
</BODY>
</HTML>