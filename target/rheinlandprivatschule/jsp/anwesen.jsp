<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.repository.AnwesenDao" %>
<%@ page import="com.rheinlandprivatschule.repository.CourseDao" %>
<%@ page import="com.rheinlandprivatschule.repository.InsuranceDao" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="com.rheinlandprivatschule.model.Anwesenheit" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Anwesenheit Liste ::</title>
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
        myPopup = '';

        function druck()
        {
            window.open("anwesenD");
        }
        function activecourses()
        {
            window.location="courseList";
        }
        function popUp(loc,eyeD,X,Y){
            window.open(loc,eyeD,"toolbar=no,location=0,directories=no,status=no,menubar=0,scrollbars=yes,resizable=0,width=" + X + ",height=" + Y + "'");
        }

    </script>
</head>
<body>
<%
    AnwesenDao adb= (AnwesenDao) request.getAttribute("adb");
    CourseDao cdb= (CourseDao) request.getAttribute("cdb");
    InsuranceDao insuranceDB= (InsuranceDao) request.getAttribute("insuranceDB");

    int totalcount=0;
    int week=0;
    int trackP=-1;
    int trackN=1;
    int endPoint=0;
    Vector v=new Vector();
    Vector image=new Vector();
    String hd1="";
    String hd2="";
    int idN=0;



    String courseid=(String)request.getParameter("courseid");
    if(courseid!=null){
        idN=Integer.parseInt(courseid);
        session.setAttribute("courseid",courseid);
    }else{
        String tempcoid=(String)session.getAttribute("courseid");
        if(tempcoid!=null){
            idN=Integer.parseInt(tempcoid);
        }
    }

    v=cdb.getAllStudentsByCourse(idN);

    String weekS=(String)request.getParameter("week");
    try{
        if(weekS==null){
            week=adb.getWeek(idN);
            int wee1=week;
            int wee2=week;
            wee1++;
            wee2--;
            trackN=wee1;
            trackP=wee2;
        }else{
            week=Integer.parseInt(weekS);
            int wee1=week;
            int wee2=week;
            wee1++;
            wee2--;
            trackN=wee1;
            trackP=wee2;
        }
    }catch(Exception e){

    }
    endPoint=adb.getLastWeek(idN);
    adb.setWeek(week,idN);
    hd1= MyDate.formateDate(adb.getFirstDate(),MyDate.ALPHANUMERIC,MyDate.DEUTSCH);
    hd2=MyDate.formateDate(adb.getLastDate(),MyDate.ALPHANUMERIC,MyDate.DEUTSCH);
    session.setAttribute("d1",hd1);
    session.setAttribute("d2",hd2);

    adb.synchronizedAnwesenheit(v,idN,adb.getFirstDate(),adb.getLastDate());

    Vector vec=new Vector();
    for(int pp=0;pp<v.size();pp++){
        Student st=(Student)v.elementAt(pp);
        if(st.getUserActive()==1){
            vec.addElement(st);
        }
    }
    v=vec;
    session.setAttribute("selstudent",v);
    session.setAttribute("idN",""+idN);
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
                                <a style="margin-right: 5px;" class="btn btn-primary" href="#" onclick="activecourses()">Aktiv Kurse</a>
                                <a style="margin-right: 5px;" class="btn btn-primary" href="../index">Haupt</a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <table width="100%" border="0" cellpadding="1" cellspacing="1">
                            <tr>
                                <%
                                    if(trackP<1)
                                    {
                                %>
                                <td height="33" width="15%"><font size="2" color="#000033">Letzte
                                    Wochen </font> </td>
                                <%
                                }
                                else
                                {
                                %>
                                <td height="33" width="7%"><font size="2" color="#000033"><a href="anwesen?week=<%=trackP%>">Letzte
                                    Wochen </a></font> </td>
                                <%
                                    }
                                %>

                                <%
                                    if(trackN>endPoint)
                                    {
                                %>
                                <td colspan="13" height="33">
                                    <div align="right"><font size="2" color="#000033">Nächste
                                        Wochen</font></div>
                                </td>
                                <%
                                }
                                else
                                {
                                %>
                                <td width="6%" height="33" colspan="13">
                                    <div align="right"><font size="2" color="#000033"><a href="anwesen?week=<%=trackN%>">Nächste
                                        Wochen</a></font></div>
                                </td>
                                <%
                                    }
                                %>
                            </tr>
                            <tr>
                                <td colspan="14" height="18" bgcolor="657A9A"><div align="center"><font size="3" color="#FFFFFF"><b><font size="3" color="#FFFFFF">Anwesendheitsliste f&uuml;r die zeit von</font></b></font><font size="2" color="#FFFFFF"> <%=hd1%> - <%=hd2%> </font></div></td>
                            </tr>
                            <tr>
                                <td height="18" bgcolor="657A9A">
                                    <div align="left"><font color="#FFFFFF" size="2"><strong>Summe</strong></font></div></td>
                                <td height="18" colspan="10" bgcolor="657A9A">&nbsp;</td>
                                <td height="18" colspan="3" bgcolor="657A9A"><div align="right"><strong><font color="#FFFFFF" size="2"><%=v.size()%></font></strong></div></td>
                            </tr>
                            <tr>
                                <td width="15%" height="18" bgcolor="657A9A"><b></b>
                                    <div align="center"><b><font size="2" color="#FFFFFF">Student</font></b></div>
                                </td>
                                <td width="7%" height="18" bgcolor="657A9A">
                                    <div align="center"><b><font size="2" color="#FFFFFF">Montag</font></b></div>
                                </td>
                                <td width="7%" height="18" bgcolor="657A9A">
                                    <div align="center"><b><font size="2" color="#FFFFFF">Dienstag</font></b></div>
                                </td>
                                <td width="7%" height="18" bgcolor="657A9A">
                                    <div align="center"><b><font size="2" color="#FFFFFF">Mittwoch</font></b></div>
                                </td>
                                <td width="9%" height="18" bgcolor="657A9A">
                                    <div align="center"><b><font size="2" color="#FFFFFF">Donnerstag</font></b></div>
                                </td>
                                <td width="6%" height="18" bgcolor="657A9A">
                                    <div align="center"><b><font size="2" color="#FFFFFF">Freitag</font></b></div>
                                </td>
                                <td width="2%" height="18" bgcolor="657A9A">
                                    <div align="center"><b><font color="#FFFFFF">-</font></b></div>
                                </td>
                                <td width="6%" height="18" bgcolor="657A9A">
                                    <div align="center"><b><font size="2" color="#FFFFFF">Montag</font></b></div>
                                </td>
                                <td width="7%" height="18" bgcolor="657A9A">
                                    <div align="center"><b><font size="2" color="#FFFFFF">Dienstag</font></b></div>
                                </td>
                                <td width="7%" height="18" bgcolor="657A9A">
                                    <div align="center"><b><font size="2" color="#FFFFFF">Mittwoch</font></b></div>
                                </td>
                                <td width="9%" height="18" bgcolor="657A9A">
                                    <div align="center"><b><font size="2" color="#FFFFFF">Donnerstag</font></b></div>
                                </td>
                                <td width="7%" height="18" bgcolor="657A9A">
                                    <div align="center"><b><font size="2" color="#FFFFFF">Freitag</font></b></div>
                                </td>
                            </tr>
                            <%
                                String myFarbe="#000033";
                                for(int d=0;d<v.size();d++){
                                    Student s=(Student)v.elementAt(d);
                                    Anwesenheit a=adb.getAnwesenheit(idN,s.getUserID(),adb.getFirstDate(),adb.getLastDate());
                                    if(!insuranceDB.isInsured(s.getUserID())){
                                        myFarbe="#FF0000";
                                    }

                            %>
                            <tr>
                                <td width="15%" bgcolor="AEBACD" height="18"><font size="2" color="<%=myFarbe%>"><%=s.getUserFirstName()+" "+ s.getUserLastName()%></font></td>
                                <td width="7%" bgcolor="AEBACD" height="18"><font size="2" color="#000033"><a href="javascript:popUp('anwesenSelection?d=<%=a.getDate1()%>&cid=<%=idN%>&sid=<%=s.getUserID()%>','Selection','300','300')"><%=a.getStunden1()%></a></font></td>
                                <td width="7%" bgcolor="AEBACD" height="18"><font size="2" color="#000033"><a href="javascript:popUp('anwesenSelection?d=<%=a.getDate2()%>&cid=<%=idN%>&sid=<%=s.getUserID()%>','Selection','300','300')"><%=a.getStunden2()%></a></font></td>
                                <td width="7%" bgcolor="AEBACD" height="18"><font size="2" color="#000033"><a href="javascript:popUp('anwesenSelection?d=<%=a.getDate3()%>&cid=<%=idN%>&sid=<%=s.getUserID()%>','Selection','300','300')"><%=a.getStunden3()%></a></font></td>
                                <td width="9%" bgcolor="AEBACD" height="18"><font size="2" color="#000033"><a href="javascript:popUp('anwesenSelection?d=<%=a.getDate4()%>&cid=<%=idN%>&sid=<%=s.getUserID()%>','Selection','300','300')"><%=a.getStunden4()%></a></font></td>
                                <td width="6%" bgcolor="AEBACD" height="18"><font size="2" color="#000033"><a href="javascript:popUp('anwesenSelection?d=<%=a.getDate5()%>&cid=<%=idN%>&sid=<%=s.getUserID()%>','Selection','300','300')"><%=a.getStunden5()%></a>-<%=a.getPercentage5()%></font></td>
                                <td bgcolor="AEBACD" width="2%" height="18">
                                    <div align="center"><font color="#FFFFFF"><b>-</b></font></div>
                                </td>
                                <td bgcolor="AEBACD" width="6%" height="18"><font size="2" color="#000033"><a href="javascript:popUp('anwesenSelection?d=<%=a.getDate8()%>&cid=<%=idN%>&sid=<%=s.getUserID()%>','Selection','300','300')"><%=a.getStunden8()%></a></font></td>
                                <td bgcolor="AEBACD" width="7%" height="18"><font size="2" color="#000033"><a href="javascript:popUp('anwesenSelection?d=<%=a.getDate9()%>&cid=<%=idN%>&sid=<%=s.getUserID()%>','Selection','300','300')"><%=a.getStunden9()%></a></font></td>
                                <td bgcolor="AEBACD" width="7%" height="18"><font size="2" color="#000033"><a href="javascript:popUp('anwesenSelection?d=<%=a.getDate10()%>&cid=<%=idN%>&sid=<%=s.getUserID()%>','Selection','300','300')"><%=a.getStunden10()%></a></font></td>
                                <td bgcolor="AEBACD" width="9%" height="18"><font size="2" color="#000033"><a href="javascript:popUp('anwesenSelection?d=<%=a.getDate11()%>&cid=<%=idN%>&sid=<%=s.getUserID()%>','Selection','300','300')"><%=a.getStunden11()%></a></font></td>
                                <td bgcolor="AEBACD" width="7%" height="18"><font size="2" color="#000033"><a href="javascript:popUp('anwesenSelection?d=<%=a.getDate12()%>&cid=<%=idN%>&sid=<%=s.getUserID()%>','Selection','300','300')"><%=a.getStunden12()%></a>-<%=a.getPercentage12()%></font></td>
                            </tr>
                            <%
                                }
                            %>
                        </table>
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
