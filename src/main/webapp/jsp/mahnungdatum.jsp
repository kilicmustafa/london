<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.rheinlandprivatschule.repository.*" %>
<%@ page import="com.rheinlandprivatschule.model.*" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Mahnung Datum ::</title>
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
        function update()
        {
            document.form1.action="mahnungdatum?cmd=u";
            document.form1.submit();
        }
        function lochen()
        {
            document.form1.action="mahnungdatum?cmd=ö";
            document.form1.submit();
        }
    </script>
</head>
<body>
<%
    int cid=0;
    int uid=0;
    String day=MyDate.getDay(MyDate.getCurrentSQLDate());
    String month=MyDate.getMonth(MyDate.getCurrentSQLDate());
    String year=MyDate.getYear(MyDate.getCurrentSQLDate());
    String desc="";
    MahnungDao mdb= (MahnungDao) request.getAttribute("mahnungDao");

    String u=(String)request.getParameter("u");
    String c=(String)request.getParameter("c");

    if(u!=null && c!=null){
        int useridN=Integer.parseInt(u);
        int courseidN=Integer.parseInt(c);
        MahnungDatum m=mdb.getMahnungDatum(courseidN,useridN);
        if(m.getCourseID()>0){
            day=MyDate.getDay(m.getMahnungDate());
            month=MyDate.getMonth(m.getMahnungDate());;
            year=MyDate.getYear(m.getMahnungDate());

            desc=m.getDesc();
            cid=courseidN;
            uid=useridN;
        }else{
            cid=courseidN;
            uid=useridN;
        }
    }else{
        String temp=request.getParameter("cmd");
        String userid=(String)request.getParameter("userid");
        String courseid=(String)request.getParameter("courseid");
        if(temp!=null && userid!=null && courseid!=null){
            int useridN=Integer.parseInt(userid);
            int courseidN=Integer.parseInt(courseid);
            if(temp.equalsIgnoreCase("u")){
                String tDay=(String)request.getParameter("selDay");
                String tMonth=(String)request.getParameter("selMonth");
                String tYear=(String)request.getParameter("selYear");
                String desT=(String)request.getParameter("textfield");
                if(mdb.isMahnungDatumExist(courseidN,useridN)){
                    mdb.updateMahnungDatum(courseidN,useridN,MyDate.getSQLDateFromStrings(tDay,tMonth,tYear,MyDate.DEUTSCH),desT);
                }else{
                    mdb.addMahnungDatum(courseidN,useridN,MyDate.getSQLDateFromStrings(tDay,tMonth,tYear,MyDate.DEUTSCH),desT);
                }
                response.sendRedirect("showStudentPreciseD?userid="+useridN);
            }else if(temp.equalsIgnoreCase("ö")){
                mdb.removeMahnungDatum(courseidN,useridN);
                response.sendRedirect("showStudentPreciseD?userid="+useridN);
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
                        <form style="width: 100%;" name="form1" method="post" action="">
                            <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                <tr bgcolor="657A9A">
                                    <td height="22" colspan="2">
                                        <div align="center"><b><font color="#FFFFFF">Mahnung
                                            Datum </font></b></div>
                                    </td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td bgcolor="657A9A" height="22" width="23%">
                                        <div align="left"><font color="#FFFFFF"><b><font size="2">Datum</font></b></font></div>
                                    </td>
                                    <td bgcolor="AEBACD" height="22" width="77%"><font color="#000033">
                                        <select name="selDay">
                                            <%
                                                for(int i=1;i<32;i++)
                                                {
                                                    if(i==Integer.parseInt(day))
                                                    {
                                            %>
                                            <option selected><%=i%></option>
                                            <%
                                            }
                                            else
                                            {
                                            %>
                                            <option><%=i%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                        <select name="selMonth">
                                            <%
                                                Vector vtemp=new Vector();
                                                vtemp.addElement("Januar");
                                                vtemp.addElement("Februar");
                                                vtemp.addElement("März");
                                                vtemp.addElement("April");
                                                vtemp.addElement("Mai");
                                                vtemp.addElement("Juni");
                                                vtemp.addElement("Juli");
                                                vtemp.addElement("August");
                                                vtemp.addElement("September");
                                                vtemp.addElement("Oktober");
                                                vtemp.addElement("November");
                                                vtemp.addElement("Dezember");
                                                for(int ii=0;ii<vtemp.size();ii++)
                                                {
                                                    String temps=(String)vtemp.elementAt(ii);
                                                    if(month.equalsIgnoreCase((ii+1)+""))
                                                    {
                                            %>
                                            <option selected><%=temps%></option>
                                            <%
                                            }
                                            else
                                            {
                                            %>
                                            <option><%=temps%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                        <select name="selYear">
                                            <%
                                                for(int iii=2000;iii<2030;iii++)
                                                {
                                                    if(iii==Integer.parseInt(year))
                                                    {
                                            %>
                                            <option selected><%=iii%></option>
                                            <%
                                            }
                                            else
                                            {
                                            %>
                                            <option><%=iii%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                    </font></td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td bgcolor="657A9A" height="22" width="23%"><font size="2" color="#FFFFFF"><b>Anmerkung</b></font></td>
                                    <td bgcolor="AEBACD" height="22" width="77%">
                                        <textarea rows="5" cols="40" name="textfield"><%=desc%></textarea>
                                        <input type="hidden" name="courseid" value="<%=cid%>">
                                        <input type="hidden" name="userid" value="<%=uid%>">
                                    </td>
                                </tr>
                                <tr bgcolor="657A9A">
                                    <td bgcolor="657A9A" height="22" width="23%">&nbsp;</td>
                                    <td bgcolor="AEBACD" height="22" width="77%">
                                        <input class="btn btn-primary" type="submit" name="Submit" value="OK" onClick="update()">
                                        <input class="btn btn-primary" type="submit" name="Submit2" value="L&ouml;schen" onClick="lochen()">
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
