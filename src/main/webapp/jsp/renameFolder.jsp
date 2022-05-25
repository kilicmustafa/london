<%@ page import="com.rheinlandprivatschule.helper.FileManage" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Umbenennen  ::</title>
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
        function chk()
        {
            if(document.form1.hd.value!='null')
            {
                window.location=document.form1.hd.value;
            }
        }
        function myBack()
        {
            history.go(-1);
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
    FileManage fm= (FileManage) request.getAttribute("fileManage");

    String vb="";
    String link=null;
    try{
        String txt=(String)request.getParameter("textfield");
        if(txt!=null){

            txt=fm.properName(txt);

            String path=(String)request.getParameter("pa");
            String cpath=(String)request.getParameter("myPath");
            String cfolder=(String)request.getParameter("folder");
            String fk=cfolder;
            String pk=cpath;
            java.io.File f=new java.io.File(path);
            String tempName=txt;
            if(f.isDirectory()){
                f.renameTo(new java.io.File(cpath+"/"+cfolder+"/"+tempName));

            }else{
                f.renameTo(new java.io.File(cpath+"/"+cfolder+"/"+tempName));

            }
            link="driveControler?folder="+fk+"&myPath="+pk;
        }else{
            String path=(String)request.getParameter("pa");
            java.io.File f=new java.io.File(path);
            vb=f.getName();
        }
    }catch(Exception e){
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="myBack()">Zur&uuml;ck</a>

                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form style="width: 100%;" name="form1" method="post" action="" onSubmit="MM_validateForm('textfield','','R');return document.MM_returnValue">
                            <table width="100%" border="0" cellspacing="1" cellpadding="1" height="79">
                                <tr>
                                    <td valign="top" bgcolor="657A9A" colspan="2" height="16">
                                        <p><font size="2"><b><font color="#FFFFFF">Der Neue
                                            Name</font></b></font></p>
                                    </td>
                                </tr>

                                <tr bgcolor="AEBACD">
                                    <td valign="top" height="33">
                                        <input type="text" name="textfield" value="<%=vb%>">
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td valign="top" height="30">
                                        <input class="btn btn-primary" type="submit" name="Submit" value="Umbenennen">
                                        <input type="hidden" name="hd" value="<%=link%>">
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
