<%@ page import="com.rheinlandprivatschule.repository.CourseDao" %>
<%@ page import="com.rheinlandprivatschule.repository.AnwesenDao" %>
<%@ page import="com.rheinlandprivatschule.model.Anwesenheit" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.model.Course" %>
<html>
<head>
    <title>:: Anwesenheit ::</title>
    <SCRIPT LANGUAGE="JavaScript">

// function that takes names string and inserts it into the parant windows textbox
            function backAtYa(form)
            {
                document.form1.submit();
                window.close();

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




    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000" onunload="window.opener.location.reload();">
<%
    AnwesenDao adb= (AnwesenDao) request.getAttribute("adb");
    CourseDao cdb= (CourseDao) request.getAttribute("cdb");

    int atten=0;
    double percent=0;
    double stunden=0;
    int full=0;

    String da=(String)request.getParameter("d");
    String cid=(String)request.getParameter("cid");
    String mtid=(String)request.getParameter("sid");
    if(cid!=null){
        session.setAttribute("coid",cid);
        session.setAttribute("coda",da);
        session.setAttribute("cotid",mtid);

        Anwesenheit a=adb.getAnwesenheitOnly(MyDate.getSQLDateFromDashFormatString(da,MyDate.DEUTSCH),Integer.parseInt(mtid),Integer.parseInt(cid));
        atten=a.getAttendance1();
        percent=a.getPercentage1();
        stunden=a.getStunden1();

    }else{
        String tempCo=(String)session.getAttribute("coid");
        String tempDa=(String)session.getAttribute("coda");
        String tempTI=(String)session.getAttribute("cotid");

        String tid=(String)request.getParameter("select");
        String percentage=(String)request.getParameter("txtPer");
        String std=(String)request.getParameter("std");

        Course c=cdb.getCourse(Integer.parseInt(tempCo));
        String timing=c.getCourseTiming();
        if(timing.equalsIgnoreCase("8:30-12:00")){
            full=4;
        }else if(timing.equalsIgnoreCase("12:00-18:00")){
            full=6;
        }else if(timing.equalsIgnoreCase("18:00-21:00")){
            full=3;
        }
        int tidN=Integer.parseInt(tid);
        double stdN=0;
        if(tidN==0){
            stdN=0;
        }else if(tidN==1){
            stdN=(double)full;
        }else if(tidN==2){
            stdN=Double.parseDouble(std);
        }else if(tidN==3){
            stdN=Double.parseDouble(std);
        }
        adb.updateAnwesenheit(MyDate.getSQLDateFromDashFormatString(tempDa,MyDate.DEUTSCH),Integer.parseInt(tempCo),Integer.parseInt(tempTI),tidN,Double.parseDouble(percentage),stdN);
    }
%>
<form style="width: 100%;" name="form1" onSubmit="MM_validateForm('txtStd','','RisNum');return document.MM_returnValue" action="anwesenSelection" method="post">
    <table width="100%" border="0">
        <tr bgcolor="657A9A">
            <td colspan="2">
                <div align="center"><b><font size="3" color="#FFFFFF">Anwesenheit</font></b></div>
            </td>
        </tr>
        <tr bgcolor="AEBACD">
            <td width="15%" bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>Anwesenheit</b></font></td>
            <td width="85%">
                <select name="select" onChange="if(selectedIndex==0)std.disabled=true;document.form1.std.value='0'; if(selectedIndex==1)std.disabled=true;document.form1.std.value=document.form1.hd.value; if(selectedIndex==2 || selectedIndex==3)std.disabled=false;std.value=''">
                    <%

                        if(atten==0)
                        {

                    %>
                    <option value="0" selected>Anwesend</option>
                    <option value="1">Abwesend</option>
                    <option value="2">Spät gekommen</option>
                    <option value="3">Früh gegangen</option>
                    <%
                    }
                    else if(atten==1)
                    {
                    %>
                    <option value="0">Anwesend</option>
                    <option value="1" selected>Abwesend</option>
                    <option value="2">Spät gekommen</option>
                    <option value="3">Früh gegangen</option>
                    <%
                    }
                    else if(atten==2)
                    {
                    %>
                    <option value="0">Anwesend</option>
                    <option value="1">Abwesend</option>
                    <option value="2" selected>Spät gekommen</option>
                    <option value="3">Früh gegangen</option>
                    <%
                    }
                    else if(atten==3)
                    {
                    %>
                    <option value="0" >Anwesend</option>
                    <option value="1">Abwesend</option>
                    <option value="2">Spät gekommen</option>
                    <option value="3" selected>Früh gegangen</option>
                    <%
                        }
                    %>
                </select>
            </td>
        </tr>
        <tr bgcolor="AEBACD">
            <td width="15%" bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>Stunden</b></font></td>
            <td width="85%">
                <input type="text" name="std" value="<%=stunden%>" disabled>
            </td>
        </tr>
        <tr bgcolor="AEBACD">
            <td width="15%" bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>Procent</b></font></td>
            <td width="85%">
                <input type="text" name="txtPer" value="<%=percent%>">
            </td>
        </tr>
        <tr bgcolor="AEBACD">
            <td width="15%">&nbsp; </td>
            <td width="85%">
                <input type="button" onClick="backAtYa(this.form)" value="OK" name="button">
                <input type="hidden" name="hd" value="<%=full%>">
            </td>
        </tr>
    </table>
    <br>
</form>


</body>
</html>
