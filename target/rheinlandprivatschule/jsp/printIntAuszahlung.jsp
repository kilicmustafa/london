<html>
<head>
    <title>Print Registration</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <style type="text/css">
        <!--
        .style29 {
            font-family: Arial, Helvetica, sans-serif;
            font-weight: bold;
            font-size: 16px;
        }
        body,td,th {
            font-family: Arial, Helvetica, sans-serif;
        }
        .style36 {font-size: 12}
        .style38 {font-size: 14px}
        .style40 {font-family: Arial, Helvetica, sans-serif; font-size: 12px; }
        .border { border-bottom-style:double}
        -->
    </style>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<body bgcolor="#FFFFFF" text="#000000">
<%@ page import="java.util.*" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.repository.*" %>
<%@ page import="com.rheinlandprivatschule.model.*" %>
<%
    AnwesenDao adb= (AnwesenDao) request.getAttribute("adb");
    int courseid= 0;
    String bamfnr="";
    Vector v=new Vector();
    int count=1;
    int classCount=0;
    int classCount1=0;
    double betrag=0;


    Course pcourse=(Course)session.getAttribute("pcourse");
    CourseDao courseDB= (CourseDao) request.getAttribute("courseDao");
    PlaceDao placeDB=new PlaceDao();

    courseid = pcourse.getCourseID();
    pcourse=courseDB.getCourse(courseid);
    Place myPlace =  placeDB.getPlace(pcourse.getCoursePlace());
    bamfnr = pcourse.getCourseBamfNr();
    if (bamfnr == null){
        bamfnr = "";}
    v=courseDB.getAllStudentsAuszahlung(courseid);
    Vector vec=new Vector();
    for(int pp=0;pp<v.size();pp++){
        Student st=(Student)v.elementAt(pp);
        if(st.getUserBamfNumber()!=null || st.getUserVerifiedNumber() !=null){
            if(st.getUserActive()==1 && st.getUserCostSharing()==2){
                vec.addElement(st);
            }
        }
    }
    v=vec;
%>
<table width="1066" height="500" align="left" cellpadding="0"  cellspacing="0" >
    <tr>
        <td width="1064" height="281">
            <table width="1080"  cellspacing="0" cellpadding="0">
                <tr>
                    <td colspan="7" valign="top"><p><img src="/resources/images/Template_47.gif" width=178 height=66 alt=""> </p>
                        <p align="center" class="style29">Auszahlungsbogen gem&auml;&szlig; Kooperationsmodell Fahrtkosten</p>
                    </td>
                </tr>
                <tr>
                    <td colspan="7" valign="top"><p>&nbsp;</p>
                        <p>&nbsp;</p></td>
                </tr>
                <tr>
                    <td width="4" height="25" valign="top">&nbsp;</td>
                    <td width="153" valign="bottom" class="style38" style="border-bottom:1px solid black;"> <span class="style36">&nbsp;Kurstr&auml;ger:</span></td>
                    <td width="171" valign="bottom" class="style38" style="border-bottom:1px solid black;"><%=myPlace.getFirmaName()%></td>
                    <td colspan="4" valign="bottom">&nbsp;</td>
                </tr>
                <tr>
                    <td height="30" valign="top">&nbsp;</td>
                    <td valign="bottom" class="style38" style="border-bottom:1px solid black;"><span class="style36"> &nbsp;Kurstr&auml;gernummer:</span></td>
                    <td width="171" valign="bottom" class="style38" style="border-bottom:1px solid black;"><%=myPlace.getBamfNumber()%></td>
                    <td colspan="4" valign="top">&nbsp;</td>
                </tr>
                <tr>
                    <td height="28" valign="top">&nbsp;</td>
                    <td valign="bottom" style="border-bottom:1px solid black;"><span class="style36">&nbsp;</span><span class="style38">Kursnummer:</span></td>
                    <td width="171" valign="bottom" class="style38" style="border-bottom:1px solid black;"><%=pcourse.getCourseBamfNr()%></td>
                    <td colspan="4" valign="top">&nbsp;</td>
                </tr>
                <tr>
                    <td height="27" valign="top">&nbsp;</td>
                    <td valign="bottom" style="border-bottom:1px solid black;"><span class="style38">&nbsp;Kursabschnitt:</span></td>
                    <td width="171" valign="bottom" class="style38" style="border-bottom:1px solid black;">&nbsp;</td>
                    <td colspan="4" valign="top">&nbsp;</td>
                </tr>
                <tr>
                    <td height="18" valign="top">&nbsp;</td>
                    <td valign="bottom" >&nbsp;</td>
                    <td valign="bottom" >&nbsp;</td>
                    <td colspan="4" valign="top">&nbsp;</td>
                </tr>
                <tr>
                    <td height="129" rowspan="2" valign="top">&nbsp;</td>
                    <td height="271" colspan="6" valign="bottom" >
                        <table width="1048" height="150" cellpadding="0" cellspacing="0" border="0" style="border-top:1px solid black;">
                            <tr class="style38">
                                <td width="58" height="38" style="border-bottom:1px solid black; border-right:1px solid black; border-left:1px solid black;"><div align="center" class="style38"><font color="#000000"> Lfd. Nr. </font></div></td>
                                <td width="273" style="border-bottom:1px solid black; border-right:1px solid black;"><div align="center" class="style40">
                                    <div align="left" class="style38"><font color="#000000">&nbsp; Name, Vorname </font></div>
                                </div></td>
                                <td width="100" style="border-bottom:1px solid black;border-right:1px solid black;"><p align="center" class="style38"><font color="#000000">Geburtsdatum</font></p></td>
                                <td width="180" style="border-bottom:1px solid black;border-right:1px solid black;"><p align="left" class="style38"> &nbsp;Personenkennziffer &nbsp;des &nbsp;Bundesamtes </p></td>
                                <td colspan="4" align="center" valign="middle" class="style38"style="border-bottom:1px solid black;border-right:1px solid black;">Auszahlung Fahrtkosten</td>
                            </tr>
                            <tr class="style38">
                                <td width="58" height="53" style="border-bottom:1px solid black; border-right:1px solid black; border-left:1px solid black;">&nbsp;</td>
                                <td width="273" style="border-bottom:1px solid black; border-right:1px solid black;">&nbsp;</td>
                                <td width="100" style="border-bottom:1px solid black;border-right:1px solid black;">&nbsp;</td>
                                <td width="180" style="border-bottom:1px solid black;border-right:1px solid black;">&nbsp;</td>
                                <td valign="top" class="style38" style="border-bottom:1px solid black;border-right:1px solid black;"><p align="left" class="style38">&nbsp;Datum</p></td>
                                <td valign="top" class="style38" style="border-bottom:1px solid black;border-right:1px solid black;">&nbsp;Betrag(Euro)</td>
                                <td valign="top" class="style38" style="border-bottom:1px solid black;border-right:1px solid black;">&nbsp;Handzeichen &nbsp;des Tr&auml;gers*</td>
                                <td class="style38" style="border-bottom:1px solid black;border-right:1px solid black;">&nbsp;Empfangsbest&auml;tigung &nbsp;des &nbsp;Teilnehmers &nbsp;(Unterschrift) </td>
                            </tr>
                            <%
                                for(int f=0;f<v.size();f++){
                                    Student s=(Student)v.elementAt(f);
                                    Anwesenheit a=adb.getAnwesenheit(courseid,s.getUserID(),adb.getFirstDate(),adb.getLastDate());
                                    classCount1=classCount1+classCount;
                                    betrag = betrag+s.getUserFahrtKosten();


                            %>
                            <tr>
                                <td height="26" class="style38" style="border-right:1px solid black;border-bottom:1px solid black; border-left:1px solid black;"><div align="center"><%=count%></div></td>
                                <td class="style38" style="border-right:1px solid black;border-bottom:1px solid black; "><div align="left">&nbsp; <%=s.getUserLastName()+" "+ s.getUserFirstName()%></div></td>
                                <td class="style38" style="border-right:1px solid black;border-bottom:1px solid black; "><div align="center"><%=MyDate.formateDate(s.getUserBirthDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></div></td>
                                <td class="style38" style="border-right:1px solid black;border-bottom:1px solid black; "><div align="center"><%=s.getUserBamfNumber()%>&nbsp;</div></td>
                                <td class="style38" width="81" style="border-right:1px solid black;border-bottom:1px solid black; "><div align="center">&nbsp;</div></td>
                                <td class="style38" width="96" style="border-right:1px solid black;border-bottom:1px solid black; "><div align="center"><%=s.getUserFahrtKosten()%></div></td>
                                <td class="style38" width="103" style="border-right:1px solid black;border-bottom:1px solid black; "><div align="center">&nbsp;</div></td>
                                <td class="style38" width="155" style="border-bottom:1px solid black; border-right:1px solid black;"><div align="center">&nbsp;</div></td>
                                    <%
count++;
}
%>
                            <tr>
                                <td height="32" class="style38" ></td>
                                <td class="style38" >&nbsp;</td>
                                <td class="style38" >&nbsp;</td>
                                <td class="style38" >&nbsp;</td>
                                <td class="style38" >&nbsp;</td>
                                <td width="92"><div align="center" class="border"><%=betrag%></div></td>
                                <td class="style38" >&nbsp;</td>
                                <td class="style38" ></td>
                        </table>
                        <p><span class="style38"> &nbsp;&nbsp;*Originalfahrkarte liegt vor und wurde mit einem Haken und Datum auf der R&uuml;ckseite gekennzeichnet </span></p>
                        <p>&nbsp;</p>
                    </td>
                </tr>
                <tr>
                    <td height="26" colspan="3" class="style38" style="border-bottom:1px solid black; "><div align="left">&nbsp;&nbsp;
                        <p>&nbsp;&nbsp;Ort, Datum, Unterschrift des Tr&auml;gers </p>
                    </div>            </td>
                    <td width="312" valign="bottom" style="border-bottom:1px solid black; " >&nbsp;</td>
                    <td width="365" valign="bottom" >&nbsp;</td>
                    <td width="46" valign="bottom" >&nbsp;</td>
                </tr>
                <tr>
                    <td height="94" valign="top">&nbsp;</td>
                    <td colspan="5" class="style38">&nbsp;&nbsp;KNr.630.057 BAMF 04/2009 </td>
                    <td valign="bottom" >&nbsp;</td>
                </tr>
            </table>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p></td>
    </tr>
</table>
</body>
</html>
