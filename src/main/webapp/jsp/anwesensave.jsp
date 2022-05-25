<HTML>
<HEAD>
    <TITLE>:: Anwesenheit Liste ::</TITLE>
    <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
    <!-- ImageReady Preload Script (Template.psd) -->
    <SCRIPT TYPE="text/javascript">


    </SCRIPT>
    <!-- End Preload Script -->
</HEAD>
<BODY BGCOLOR=#FFFFFF LEFTMARGIN=0 TOPMARGIN=0 MARGINWIDTH=0 MARGINHEIGHT=0>
<%@ page import="java.util.*" %>
<%@ page import="com.rheinlandprivatschule.repository.CourseDao" %>
<%@ page import="com.rheinlandprivatschule.repository.AnwesenDao" %>
<%
    AnwesenDao adb= (AnwesenDao) request.getAttribute("adb");
    CourseDao cdb= (CourseDao) request.getAttribute("cdb");

    int week=0;
    int trackP=-1;
    int trackN=1;
    int endPoint=0;
    Vector v=new Vector();
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

    String[] radio=request.getParameterValues("checkbox");

    if(radio!=null){

        Vector vec=new Vector();
        for(int r=0;r<radio.length;r++){
            vec.addElement((String)radio[r]);
        }
        v=adb.getProperVector(v,vec);
        session.setAttribute("selstudent",v);
        session.setAttribute("idN",""+idN);
    }else{
        Vector radiovec=(Vector)session.getAttribute("selstudent");
        v=radiovec;
        session.setAttribute("selstudent",v);
        session.setAttribute("idN",""+idN);
    }
    response.sendRedirect("anwesen?courseid="+idN);
%>
<table border="0" cellspacing="0" cellpadding="0" align="center" width="757">
    <tr>
        <td>&nbsp;</td>
        <td>
            <table width=780 border=0 cellpadding=0 cellspacing=0>

            </table>
        </td>
        <td>&nbsp;</td>
    </tr>
</table>
<!-- End ImageReady Slices -->
</BODY>
</HTML>