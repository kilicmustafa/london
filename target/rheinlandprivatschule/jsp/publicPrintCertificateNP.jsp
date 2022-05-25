<html>
<head>
    <title>:: Zertifikat :: </title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.model.*" %>
<%@ page import="com.rheinlandprivatschule.repository.CertificateDao" %>
<%@ page import="com.rheinlandprivatschule.repository.CourseDao" %>
<%@ page import="com.rheinlandprivatschule.repository.StudentDao" %>
<%@ page import="java.util.ArrayList" %>
<%
    int userid =0;
    String personType="";
    String courseName="";
    String displayFehlStunden="0";
    String currentDate=MyDate.formateDate(MyDate.getCurrentSQLDate(),MyDate.NUMERIC, MyDate.DEUTSCH);

    CertificateDao cerDB=new CertificateDao();

    CourseDao courseDao = (CourseDao) request.getAttribute("courseDao");
    StudentDao studentDB = (StudentDao) request.getAttribute("studentDao");

    QRCodeInformation qrCodeInformation = (QRCodeInformation) request.getAttribute("qrCodeInformation");
    SystemUser loginUser = qrCodeInformation.getSystemUser();
    int studentId = qrCodeInformation.getStudentId();
    int certificateId = qrCodeInformation.getCertificateId();
    Student pstudent=studentDB.getStudent(studentId, loginUser.getUserID());
    request.getSession().setAttribute("pstudent", pstudent);

    if(pstudent.getUserGender()==0){
        personType="Herr";
    }else{
        personType="Frau";
    }

    Certificate cer= cerDB.getCertificateNP(certificateId);
    Course course=(courseDao).getCourse(cer.getCourseID());
    int courseTyp=course.getCourseType();
    if(courseTyp==1){
        courseName="Grundstufe I - Niveau A1";
        //courseName=course.getCourseName()+" - Niveau A1";
    }else if(courseTyp==2){
        courseName="Grundstufe II - Niveau A2";
        //courseName=course.getCourseName()+" - Niveau A2";
    }else if(courseTyp==3){
        courseName="Mittelstufe I - Niveau B1";
        //courseName=course.getCourseName()+" - Niveau B1";
    }else if(courseTyp==4){
        courseName="Mittelstufe II - Niveau B2";
        //courseName=course.getCourseName()+" - Niveau B2";
    }else if(courseTyp==5){
        courseName="Oberstufe - Niveau C1";
        //courseName=course.getCourseName()+" - Niveau C1";
    }

    if(cer.getStunden()==0){
        displayFehlStunden="0";
    }else{
        String str= MyCurrency.getDisplayString(cer.getStunden());
        displayFehlStunden=str.substring(0,str.indexOf(","));
    }

    userid=pstudent.getUserID();
    ArrayList<Student> vertrags=studentDB.downloadBilder(userid,loginUser.getUserID());
    if(vertrags==null){
        vertrags=new ArrayList<Student>();
        String err=studentDB.getError();
        session.setAttribute("err",err);
        session.setAttribute("lin","../unitutor/rps/admin/map");
        response.sendRedirect("error");
    }
%>
<table border="0" cellspacing="0" cellpadding="0" width="90%" height="800">
    <tr>
        <td height="819" align="left" valign="top">
            <div align="left"></div>
            <div align="right">
                <table width="636" height="800" border="0">
                    <tr>
                        <td height="845">&nbsp;</td>
                        <td valign="top"><table width="100%" height="800" border="0" background="/resources/images/rpspictures/rheinland.jpg">
                            <tr>
                                <td width="22%" height="84" rowspan="2"><img src="/resources/images/rpspictures/logo.jpg" width="107" height="75"></td>
                                <td height="84" colspan="2" rowspan="2" valign="top"><div align="left"><b> <font size="5"><strong> Rheinland Privatschule</strong> </font></b><font size="5"></font><font size="5"><br>
                                    <font face="Times New Roman, Times, serif" size="3">Seminare &diams; Schulungen &diams; Deutschkurse </font></font> </div>
                                    <p></p>
                                    <div align="right"></div>
                                    <div align="right"></div>
                                    <div align="right"></div>
                                    <div align="right"></div>
                                    <div align="right"></div>
                                    <div align="right"></div></td>
                            </tr>
                            <tr>
                                <%

                                    for(int i=0;i<vertrags.size();i++){
                                        Student pp=(Student)vertrags.get(i);

//Iterator vertragsIT=vertrags.iterator();
//while(vertragsIT.hasNext()){
                                        String ver=pp.getBildName();
//
                                %>
                                <td width="24%" rowspan="2" valign="top"><div align="right"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><img src="/studentBilder/image?ver=<%=ver%>"<%=ver%> width="150" height="160"></font></div></td>
                                <%
                                    }
                                %>
                            </tr>
                            <tr>
                                <td height="54" colspan="3"><div align="center">
                                    <p align="right"><font size="6"><strong> &nbsp;&nbsp;&nbsp;</strong></font></p>
                                </div></td>
                            </tr>
                            <tr>
                                <td height="54" colspan="3"><div align="center">
                                    <p align="right"><font size="6"><strong> Z E R T I F I K A T</strong></font></p>
                                </div></td>
                            </tr>
                            <tr>
                                <td height="1" colspan="4">&nbsp;</td>
                            </tr>
                            <tr>
                                <td height="2" colspan="4"><div align="center"> <font size="2">Intensivdeutschkurs f&uuml;r Studienbewerber aus dem Ausland <br>
                                    zur Vorbereitung zu den Pr&uuml;fungen DSH, &bdquo;TestDaF&ldquo; und Studienkolleg. </font> </div></td>
                            </tr>
                            <tr>
                                <td height="9" colspan="4">&nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="4" height="8">&nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="4" height="21"><p align="center"><strong> <%=personType%>&nbsp;<%=pstudent.getUserFirstName()%>,&nbsp;<%=pstudent.getUserLastName()%></strong>&nbsp;(Vorname, Name)</p></td>
                            </tr>
                            <tr>
                                <td colspan="4" height="2"><p align="center">Geboren am <strong> <%=MyDate.formateDate(pstudent.getUserBirthDate(),MyDate.ALPHANUMERIC,MyDate.DEUTSCH)%></strong>&nbsp;(Tag, Monat, Jahr) in <strong><%=pstudent.getUserBirthPlace()%></strong>&nbsp;(Stadt / Land)<strong></strong></p></td>
                            </tr>
                            <tr>
                                <td colspan="4" height="2">&nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="4" height="40"><p align="center"> hat in der Rheinland Privatschule an der <em><%=courseName%></em>, &bdquo;Deutsch als Fremdsprache&ldquo; Pr&uuml;fung teilgenommen und mit Erfolg abgeschlossen.</p></td>
                            </tr>
                            <tr>
                                <td height="21" colspan="4" valign="top"><div align="right">&nbsp;&nbsp;&nbsp;&nbsp; </div></td>
                            </tr>
                            <tr>
                                <td colspan="4" align="left" height="11"><strong> Schriftliche Pr&uuml;fungen </strong></td>
                            </tr>
                            <tr>
                                <td colspan="4" align="left" height="48"><table width="616" height="46" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td width="291">H&ouml;rverstehen:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                        <td width="45"><%=MyCurrency.getDisplayString(cer.getListenPercentage())%></td>
                                        <td width="280">%&nbsp;&nbsp;(<%=cerDB.getRemarks(cer.getListenPercentage())%>)</td>
                                    </tr>
                                    <tr>
                                        <td height="21">Textproduktion:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                        <td><%=MyCurrency.getDisplayString(cer.getWrittingPercentage())%></td>
                                        <td>%&nbsp;&nbsp;(<%=cerDB.getRemarks(cer.getWrittingPercentage())%>)</td>
                                    </tr>
                                    <tr>
                                        <td height="21">Leseverstehen:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                        <td><%=MyCurrency.getDisplayString(cer.getReadPercentage())%></td>
                                        <td>%&nbsp;&nbsp;(<%=cerDB.getRemarks(cer.getReadPercentage())%>)</td>
                                    </tr>
                                    <tr>
                                        <td height="21">Wissenschaftssprachliche Strukturen:&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                        <td><%=MyCurrency.getDisplayString(cer.getContentPercentage())%></td>
                                        <td>%&nbsp;&nbsp;(<%=cerDB.getRemarks(cer.getContentPercentage())%>)</td>
                                    </tr>
                                    <tr>
                                        <td height="21">&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td height="21"><strong>M&uuml;ndliche Pr&uuml;fung: </strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                        <td><%=MyCurrency.getDisplayString(cer.getOralPercentage())%></td>
                                        <td>%&nbsp;&nbsp;(<%=cerDB.getRemarks(cer.getOralPercentage())%>)</td>
                                    </tr>
                                    <tr>
                                        <td height="21">&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td height="21">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td height="21">&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td height="21"><strong><u>Note der Gesamtleistung:</u>&nbsp;&nbsp;&nbsp;</strong></td>
                                        <td><strong><%=MyCurrency.getDisplayString(cer.getTotalPercentage())%></strong></td>
                                        <td><strong>%&nbsp;(<%=cerDB.getRemarks(cer.getTotalPercentage())%>)</strong> </td>
                                    </tr>
                                </table>
                                    <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="33%">&nbsp;</td>
                                            <td width="67%">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td height="94" valign="top">&nbsp;</td>
                                            <td><div align="right"><font size="2"><strong><u>Notensystem:</u></strong></font> <br>
                                                <font size="2">sehr gut &ge; 90 %<br>
                                                    gut &ge; 80 % <br>
                                                    befriedigend &ge; 70 %<br>
                                                    ausreichend &ge; 60 % <br>
                                                    nicht bestanden&le; 59 %</font></div></td>
                                        </tr>
                                        <tr>
                                            <td height="94" valign="bottom">- Rheinland Privatschule -<br>
                                                <%=loginUser.getUserFirstName()+" "+loginUser.getUserLastName()%><br>
                                                <%=currentDate%> </td>
                                            <td><div align="right"><font size="2"><u><strong>Niveaustufen des &bdquo;Gemeinsamen <br>
                                                europ&auml;ischen Referenzrahmens&ldquo; GER:</strong> </u><br>
                                                Grundstufe I = 200 Std. <strong>A1</strong><br>
                                                Grundstufe II = 200 Std. <strong>A2</strong><br>
                                                Mittelstufe I = 200 Std. <strong>B1</strong><br>
                                                Mittelstufe II = 200 Std. <strong>B2</strong><br>
                                                Oberstufe = 200 Std. <strong>C1</strong><br>
                                                Summe Stunden 1.000 Std.</font></div></td>
                                        </tr>
                                    </table></td>
                            </tr>
                            <tr>
                            </tr>
                            <tr align="center">
                                <td height="21" colspan="4" valign="bottom"><div align="center">-------------------------------------------------------------------------------------------------------------------</div></td>
                            </tr>
                        </table></td>
                        <td valign="top">&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
            </div></td>
    </tr>
    <tr>
        <td valign="top" height="0"><table border="0" cellspacing="1" cellpadding="1" height="1%" width="100%">
            <tr>
                <td width="17" height="8">&nbsp;</td>
                <td width="123"><font size="-2">Gesch&auml;ftsf&uuml;hrung</font></td>
                <td width="130" height="8"><font size="-2">45127 Essen</font></td>
                <td width="130" height="8"><font size="-2">40210</font><font size="-2"> D&uuml;sseldorf</font></td>
                <td width="131"><font size="-2">50667 K&ouml;ln:</font></td>
                <td width="126" height="8"><font size="-2">Bankverbindung</font></td>
            </tr>
            <tr>
                <td width="17" height="50" valign="top">&nbsp;</td>
                <td width="123" valign="top"><font face="Times New Roman, Times, serif" size="-2" color="#666666">Aydin &Ouml;zt&uuml;rk<br>
                    www.unitutor.de <br>
                    info@unitutor.de</font></td>
                <td valign="top" width="130"><font size="-2" face="Times New Roman, Times, serif" color="#666666">Viehofer Stra&szlig;e 14<br>
                    Tel:+49/201/102 67 31<br>
                    Fax:+49/201/102 67 33 </font></td>
                <td width="130" valign="top"><font face="Times New Roman, Times, serif" size="-2" color="#666666">Friedrich-Ebert-Stra&szlig;e 55<br>
                    Tel:+49/211 / 179 54 54 <br>
                    <font size="-2" face="Times New Roman, Times, serif" color="#666666">Fax:+49/211 / 179 52 58 </font> </font></td>
                <td width="131" valign="top"><font face="Times New Roman, Times, serif" size="-2" color="#666666">Schildergasse 24-30 <br>
                    Tel:+49/221/258 99 92 9 <br>
                    <font face="Times New Roman, Times, serif" size="-2" color="#666666"><font size="-2" face="Times New Roman, Times, serif" color="#666666">Fax:+49/221/258 99 95 9 </font></font></font></td>
                <td valign="top" width="126"><font face="Times New Roman, Times, serif" size="-2" color="#666666">Sparkasse Essen<br>
                    <font face="Times New Roman, Times, serif" size="-2" color="#666666">Konto Nr.: 570 53 71</font><br>
                    BLZ: 360 501 05
                </font></td>
            </tr>
            <tr>
                <td valign="top" colspan="6" height="2">&nbsp;</td>
            </tr>
        </table></td>
    </tr>
</table>
</body>
</html>
