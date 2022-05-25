<%@ page import="com.rheinlandprivatschule.repository.CourseDao" %>
<%@ page import="com.rheinlandprivatschule.repository.InsuranceDao" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.model.Course" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
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

        function popUp(loc,eyeD,X,Y){
            window.open(loc,eyeD,"toolbar=no,location=0,directories=no,status=no,menubar=0,scrollbars=yes,resizable=0,width=" + X + ",height=" + Y + "'");
        }

        

    </script>
</head>
<body>
<%
    CourseDao cdb= (CourseDao) request.getAttribute("cdb");
    InsuranceDao insuranceDB= (InsuranceDao) request.getAttribute("insuranceDB");

    Vector v=new Vector();
    String hd1="";
    String hd2="";
    String course="";
    int count=1;

    hd1=(String)session.getAttribute("d1");
    hd2=(String)session.getAttribute("d2");
    v=(Vector)session.getAttribute("selstudent");
    if(v==null){
        v=new Vector();
    }
    String id=(String)session.getAttribute("idN");
    int courseid=0;
    if(id!=null){
        try{
            courseid=Integer.parseInt(id);
            Course c=cdb.getCourse(courseid);
            course=c.getCourseName();
        }catch(Exception e)
        {
        }
    }

    session.setAttribute("selstudent",null);
    session.setAttribute("d1",null);
    session.setAttribute("d2",null);
    session.setAttribute("idN",null);

%>
<table width="100%" height="8%" cellpadding="1" cellspacing="1" bgcolor="#000000" >
    <tr>
        <td colspan="16" height="18" bgcolor="657A9A">
            <div align="center"><font size="3" color="#FFFFFF"><b><%=course%></b></font></div>
        </td>
    </tr>
    <tr>
        <td colspan="16" height="18" bgcolor="657A9A">
            <div align="center"><b><font size="3" color="#FFFFFF">Anwesendheitsliste
                f&uuml;r die zeit von</font></b><font size="2" color="#FFFFFF"><%=hd1%>
                - <%=hd2%> </font></div>
        </td>
    </tr>
    <tr>
        <td height="18" bgcolor="657A9A" colspan="2"><b></b>
            <div align="center"><b><font size="2" color="#FFFFFF">Student</font></b></div>
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
        <td width="5%" height="18" bgcolor="657A9A">
            <div align="center"><b><font size="2" color="#FFFFFF">Freitag</font></b></div>
        </td>
        <td width="6%" height="18" bgcolor="657A9A">
            <div align="center"><b><font size="2" color="#FFFFFF"><b>Note</b></font></b></div>
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
        <td width="8%" height="18" bgcolor="657A9A">
            <div align="center"><b><font size="2" color="#FFFFFF">Donnerstag</font></b></div>
        </td>
        <td width="5%" height="18" bgcolor="657A9A">
            <div align="center"><b><font size="2" color="#FFFFFF">Freitag</font></b></div>
        </td>
        <td width="6%" height="18" bgcolor="657A9A">
            <div align="center"><font size="2" color="#FFFFFF"><b>Note</b></font></div>
        </td>
    </tr>
    <%
        String myFarbe="#000033";
        for(int d=0;d<v.size();d++){
            Student s=(Student)v.elementAt(d);

            String temp=s.getUserFirstName()+" "+ s.getUserLastName();
            if(temp.length()==20 || temp.length()>20){
                temp=s.getUserFirstName()+" "+ s.getUserLastName().substring(0,1);
            }
            if(!insuranceDB.isInsured(s.getUserID())){
                myFarbe="#FF0000";
            }

    %>
    <tr bordercolor="#000000" bgcolor="#CCCCCC">
        <td width="4%" height="9"><font size="2" color="#000033"><%=count%></font></td>
        <td width="17%" height="9"><font size="2" color="<%=myFarbe%>"><b><%=temp%></b></font></td>
        <td width="6%" height="9" bgcolor="#FFFFFF"><font size="2" color="#000033"></font></td>
        <td width="7%" height="9" bgcolor="#FFFFFF"><font size="2" color="#000033"></font></td>
        <td width="7%" height="9" bgcolor="#FFFFFF"><font size="2" color="#000033"></font></td>
        <td width="9%" height="9" bgcolor="#FFFFFF"><font size="2" color="#000033"></font></td>
        <td width="5%" height="9" bgcolor="#FFFFFF"><font size="2" color="#000033"></font></td>
        <td width="6%" height="9" bgcolor="#FFFFFF">
            <div align="center"><font color="#FFFFFF"></font></div>
        </td>
        <td width="6%" height="9" bgcolor="#FFFFFF"><font size="2" color="#000033"></font></td>
        <td width="7%" height="9" bgcolor="#FFFFFF"><font size="2" color="#000033"></font></td>
        <td width="7%" height="9" bgcolor="#FFFFFF"><font size="2" color="#000033"></font></td>
        <td width="8%" height="9" bgcolor="#FFFFFF"><font size="2" color="#000033"></font></td>
        <td width="5%" height="9" bgcolor="#FFFFFF"><font size="2" color="#000033"></font></td>
        <td width="6%" height="9" bgcolor="#FFFFFF">&nbsp;</td>
    </tr>
    <%
            count++;
        }
    %>
    <tr bordercolor="#000000" bgcolor="#FFFFFF">
        <td height="9" colspan="14"><p>&nbsp;</p>
            <p>A = Anwesend &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;V = Versp&auml;tung &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;E = Entschuldigt &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;O = Nicht Anwesend &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Z = Fr&uuml;her gegangen </p></td>
    </tr>

</table>
</body>
</html>
