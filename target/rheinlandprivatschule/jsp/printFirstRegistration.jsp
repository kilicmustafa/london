<html>
<head>
    <title>Print Registration</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <style type="text/css">
        <!--
        .style14 {font-size: 28px}
        .style15 {font-size: 26px}
        .style16 {font-size: 24px}
        .style17 {
            font-size: 16px;
            font-weight: bold;
        }
        .style18 {font-size: 14px}
        .style20 {font-size: 22px}
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
    RPS rps=(RPS)session.getAttribute("handler");
    AnwesenDao adb= (AnwesenDao) request.getAttribute("adb");
    int courseid= 0;
    String bamfnumber ="";
    int countryid=0;
    String bamfnr="";
    int module = 0;
    int nochHours=0;
    int completedHours=0;
    String totalHours="0";
    String modulename = "";
    int modulenameN = 0;
    Vector v=new Vector(25);
    Vector tran= new Vector();
    Vector places=new Vector();
    int count=1;
    int classCount=0;
    int classCount1=0;

    Vector teacher=new Vector();


    Course pcourse=(Course)session.getAttribute("pcourse");
    CourseDao courseDB= (CourseDao) request.getAttribute("courseDao");
    TransactionDao transDB= (TransactionDao) request.getAttribute("transactionDao");
    Transaction trans=new Transaction();
    StundDao stdb= (StundDao) request.getAttribute("stundDao");
    PlaceDao placeDB=new PlaceDao();
    Place myPlace=new Place();
    HoursDao hoursDB=new HoursDao();
    Hours hours=new Hours();
    //CourseRegistration cr=(CourseRegistration)session.getAttribute("cr");
    //Course course=(Course)session.getAttribute("course");
    //String topay=(String)session.getAttribute("ap");
    courseid = pcourse.getCourseID();


    pcourse=courseDB.getCourse(courseid);

    module = pcourse.getCourseType();
    myPlace =  placeDB.getPlace(pcourse.getCoursePlace());
    bamfnr = myPlace.getBamfNumber();

    teacher=stdb.getIntegrationDetail(courseid);

    totalHours=""+pcourse.getCourseTotalHours();
    completedHours=stdb.getTotalStundenTillDate(courseid, MyDate.getCurrentSQLDate());
    if (bamfnr == null){
        bamfnr = "";}
    nochHours=Integer.parseInt(totalHours)-completedHours;
    if(module ==1 & nochHours > 99){
        modulename  = "1";
        modulenameN  = 1;
    }
    if(module ==1 & nochHours < 99){
        modulename  = "2";
        modulenameN  = 2;
    }
    if(module ==2 & nochHours > 99){
        modulename  = "3";
        modulenameN  = 3;
    }
    if(module ==2 & nochHours < 99){
        modulename  = "4";
        modulenameN  = 4;
    }
    if(module ==3 & nochHours > 99){
        modulename  = "5";
        modulenameN  = 5;
    }
    if(module ==3 & nochHours < 99){
        modulename  = "6";
        modulenameN  = 6;
    }
    if(module ==4 & nochHours > 99){
        modulename  = "7";
        modulenameN  = 7;
    }
    if(module ==4 & nochHours < 99){
        modulename  = "8";
        modulenameN  = 8;
    }
    if(module ==5 & nochHours > 99){
        modulename  = "9";
        modulenameN  = 9;
    }
    if(module ==5 & nochHours < 99){
        modulename  = "10";
        modulenameN  = 10;
    }
    v=courseDB.getAllStudentsByCourse(courseid);
    Vector vec=new Vector();
    for(int pp=0;pp<v.size();pp++){
        Student st=(Student)v.elementAt(pp);
        if(st.getUserBamfNumber()!=null && st.getUserActive()>0){
            vec.addElement(st);
        }
    }
    v=vec;
    hours = hoursDB.getHours();
    String classFrom="";
    String classTo="";
    String classBreakFrom1="";
    String classBreakFrom2="";
    String classBreakTo1="";
    String classBreakTo2="";
    if(pcourse.getCourseTiming().equalsIgnoreCase("8:30-12:00")){
        classFrom=hours.getMorFrom();
        classTo =hours.getMorTo();
        classBreakFrom1= hours.getMorFirstBreakFrom();
        classBreakFrom2=hours.getMoreSecBreakFrom();
        classBreakTo1= hours.getMorFirstBreakTo();
        classBreakTo2=hours.getMorSecBreakTo();
    }
    else if(pcourse.getCourseTiming().equalsIgnoreCase("12:00-18:00"))
    {
        classFrom=hours.getEveFrom();
        classTo =hours.getEveTo();
        classBreakFrom1= hours.getEveFirstBreakFrom();
        classBreakFrom2=hours.getEveSecBreakFrom();
        classBreakTo1= hours.getEveFirstBreakTo();
        classBreakTo2=hours.getEveSecBreakTo();
    }
    //bamfnumber = pstudent.getUserBamfNumber();
    //bamfchoice = pstudent.getUserBamfChoice();
    //countryid=pstudent.getUserCountryID();
    //country = countryDB.getCountry(countryid);
%>
<table width="766" border="0" cellspacing="0" cellpadding="0" align="center" >
    <tr>

        <td><img src="../images/Template_49.gif" width="1" height="1"></td>
        <td width="754">
            <table width="740" cellspacing="0" cellpadding="0" align="right" >
                <tr>
                    <td width="740">
                        <table width="740"  cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="203"><img src="../images/Template_47.gif" width=191 height=118 alt=""></td>
                                <td width="595"><font face="Times New Roman, Times, serif"><font face="Times New Roman, Times, serif" size="2"></font></font></td>
                            </tr>
                        </table></td>
                </tr>
                <tr>
                    <td height="887"><table width="740" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td colspan="8" ><p class="style14"><span class="style15"><span class="style16">&nbsp;<span class="style18"><span class="style20">&nbsp;Meldung &uuml;ber den Beginn eines Integrationskurses gem&auml;s <font face="Times New Roman, Times, serif"><font face="Times New Roman, Times, serif"><font color="#000033">&sect; 8 Abs. 2 Satz 1 IntV</font></font></font><font face="Times New Roman, Times, serif"><font face="Times New Roman, Times, serif"><font color="#000033"></font></font></font></span></span></span></span></p>
                                <p><strong>&nbsp;&nbsp;Angaben zum Kurstr&auml;ger / Kursort </strong></p></td>
                        </tr>
                        <tr>
                            <td colspan="8"><div align="center"><strong></strong></div></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="border:1px solid black; "><div align="left"><font size="2" face="Times New Roman, Times, serif">&nbsp;Name des Kurstr&auml;gers Rheinland Priavtschule</font></div></td>
                            <td colspan="4" style="border:1px solid black; "><font size="2" face="Times New Roman, Times, serif"> &nbsp;Kennziffer des Kurstr&auml;gers </font><font size="1" color="#000033"><%=bamfnr%></font></td>
                        </tr>
                        <tr>
                            <td colspan="7" >&nbsp;</td>
                        </tr>
                        <tr>
                            <td colspan="7" >&nbsp;</td>
                        </tr>
                        <tr>
                            <td colspan="7" ><font size="2" face="Times New Roman, Times, serif">&nbsp;Anshrift des K u r s o r t e s</font></td>
                        </tr>
                        <tr >
                            <td height="22" colspan="2" style="border:1px solid black; "><font size="2" face="Times New Roman, Times, serif">&nbsp;Stra&szlig;e / Hausnummer </font><font size="2" color="#000033"><%=myPlace.getPlaceAddress()%></font></td>
                            <td colspan="3" style="border:1px solid black; "><font size="2" face="Times New Roman, Times, serif">&nbsp;Postleitzahl</font><font size="2" color="#000033"> <%=myPlace.getPlacePostCode()%></font></td>
                            <td width="285" colspan="2" style="border:1px solid black; "><font size="2" face="Times New Roman, Times, serif">&nbsp;Ort </font><font size="2" color="#000033"><%=myPlace.getPlaceName()%></font></td>
                        </tr>
                        <tr>
                            <td colspan="2" >&nbsp;</td>
                            <td colspan="2" >&nbsp;</td>
                            <td width="200" >&nbsp;</td>
                            <td colspan="2" >&nbsp;</td>
                        </tr>
                        <tr>
                            <td colspan="7" ><p><strong>&nbsp;&nbsp;Angaben zum Kurs </strong></p>
                                <p>&nbsp;</p></td>
                        </tr>
                        <tr>
                            <td colspan="7" ><table width="100%"  border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td height="24" colspan="3" style=""><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;Kursart</font></strong></td>
                                    <td colspan="4" style="  "><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;Kursbeginn mit</font></strong><font size="2" face="Times New Roman, Times, serif"> (nicht auszuf&uuml;llen bei Widerholerkursen) </font></td>
                                </tr>
                                <tr>
                                    <td width="29%" height="24" style="border-left:1px solid black; border-top:1px solid black; border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif"><u>&nbsp;Integrationskurs allgemein</u></font></td>
                                    <td width="4%" style="border-right:1px solid black; border-top:1px solid black; border-right:1px solid black; "><div align="center"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                        <input type="checkbox" readonly name="rdChoice" value="0">
                                    </font></div></td>
                                    <td width="6%" style="border-right:1px solid black; border-right:1px solid black; ">&nbsp;</td>
                                    <td width="26%" style="border-top:1px solid black; border-right:1px solid black; "><strong><font size="2" face="Times New Roman, Times, serif">&nbsp; kurstyp</font></strong></td>
                                    <td width="5%" style="border-top:1px solid black; ">&nbsp;</td>
                                    <td width="23%" style="border-left:1px solid black; border-top:1px solid black; border-right:1px solid black; "><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;kursabschnitt (Modul) </font></strong></td>
                                    <td width="7%" style="border-right:1px solid black; border-top:1px solid black; border-right:1px solid black; ">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td height="30" style="border-left:1px solid black; border-top:1px solid black; border-right:1px solid black; ">&nbsp;</td>
                                    <td style="border-right:1px solid black; border-top:1px solid black; border-right:1px solid black; ">&nbsp;</td>
                                    <td style="border-right:1px solid black; ">&nbsp;</td>
                                    <td style="border-right:1px solid black; border-top:1px solid black;  ">&nbsp;</td>
                                    <td style="border-top:1px solid black;  ">&nbsp;</td>
                                    <td style="border-left:1px solid black; border-top:1px solid black; border-right:1px solid black; ">&nbsp;</td>
                                    <td style="border-right:1px solid black; border-top:1px solid black; border-right:1px solid black; ">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td height="24" style="border-left:1px solid black; border-top:1px solid black; border-right:1px solid black; "><font size="2" face="Times New Roman, Times, serif"><u>&nbsp;Integrationskurs f&uuml;r spez. zielgruppen</u></font></td>
                                    <td style="border-right:1px solid black; border-top:1px solid black; border-right:1px solid black; ">&nbsp;</td>
                                    <td style="border-right:1px solid black; border-right:1px solid black; ">&nbsp;</td>
                                    <td width="26%" style="border-right:1px solid black; border-top:1px solid black; border-right:1px solid black; "><font size="2" face="Times New Roman, Times, serif">&nbsp;Basiskurs</font></td>
                                    <td width="5%" style="border-top:1px solid black; "><div align="center"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                        <input type="checkbox" readonly name="rdChoice" value="0">
                                    </font></div></td>
                                    <td width="23%" style="border-left:1px solid black; border-top:1px solid black; border-right:1px solid black; "><font size="2" face="Times New Roman, Times, serif">&nbsp;Abschnitt 1</font></td>
                                    <td width="7%" style="border-right:1px solid black; border-top:1px solid black; border-right:1px solid black; "><div align="center"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                        <input type="checkbox" readonly name="rdChoice" value="0">
                                    </font></div></td>
                                </tr>
                                <tr>
                                    <td height="25" style="border-left:1px solid black; border-top:1px solid black; border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Jugend</font></td>
                                    <td style="border-right:1px solid black; border-top:1px solid black; border-right:1px solid black; "><div align="center"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                        <input type="checkbox" readonly name="rdChoice" value="0">
                                    </font></div></td>
                                    <td style="border-right:1px solid black; border-right:1px solid black; ">&nbsp;</td>
                                    <td style="border-right:1px solid black; border-top:1px solid black; border-right:1px solid black; "><font size="2" face="Times New Roman, Times, serif">&nbsp;Aufbaukurs</font></td>
                                    <td style="border-top:1px solid black; "><div align="center"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                        <input type="checkbox" readonly name="rdChoice" value="0">
                                    </font></div></td>
                                    <td style="border-left:1px solid black; border-top:1px solid black; border-right:1px solid black; "><font size="2" face="Times New Roman, Times, serif">&nbsp;Abschnitt 2 </font></td>
                                    <td style="border-right:1px solid black; border-top:1px solid black; border-right:1px solid black; "><div align="center"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                        <input type="checkbox" readonly name="rdChoice" value="0">
                                    </font></div></td>
                                </tr>
                                <tr>
                                    <td height="23" style="border-left:1px solid black; border-top:1px solid black;border-right:1px solid black; "><font size="2" face="Times New Roman, Times, serif">&nbsp;Eltern</font></td>
                                    <td style="border-right:1px solid black; border-top:1px solid black; border-right:1px solid black; "><div align="center"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                        <input type="checkbox" readonly name="rdChoice" value="0">
                                    </font></div></td>
                                    <td style="border-right:1px solid black; border-right:1px solid black; ">&nbsp;</td>
                                    <td style="border-right:1px solid black; border-top:1px solid black; border-right:1px solid black; "><font size="2" face="Times New Roman, Times, serif">&nbsp;Orientierungkurs</font></td>
                                    <td style="border-top:1px solid black;"><div align="center"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                        <input type="checkbox" readonly name="rdChoice" value="0">
                                    </font></div></td>
                                    <td style="border-left:1px solid black; border-top:1px solid black; border-right:1px solid black; "><font size="2" face="Times New Roman, Times, serif">&nbsp;Abschnitt 3 </font></td>
                                    <td style="border-right:1px solid black; border-top:1px solid black; border-right:1px solid black; "><div align="center"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                        <input type="checkbox" readonly name="rdChoice" value="0">
                                    </font></div></td>
                                </tr>
                                <tr>
                                    <td height="24" style="border-left:1px solid black; border-top:1px solid black; border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Alpha</font></td>
                                    <td style="border-right:1px solid black; border-top:1px solid black; border-right:1px solid black; "><div align="center"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                        <input type="checkbox" readonly name="rdChoice" value="0">
                                    </font></div></td>
                                    <td style=" ">&nbsp;</td>
                                    <td colspan="4" style="border-top:1px solid black; ">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td height="24" style="border-left:1px solid black; border-top:1px solid black; border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;F&ouml;rderkurs</font></td>
                                    <td style="border-right:1px solid black; border-top:1px solid black; border-right:1px solid black; "><div align="center"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                        <input type="checkbox" readonly name="rdChoice" value="0">
                                    </font></div></td>
                                    <td style="">&nbsp;</td>
                                    <td colspan="4" style=""><strong><font size="2" face="Times New Roman, Times, serif">&nbsp; Wochenstundent</font></strong>              <div align="center"></div>              <div align="center"></div></td>
                                </tr>
                                <tr>
                                    <td height="24" style="border-left:1px solid black; border-top:1px solid black; border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;sonst. spez. Integrationskurs</font></td>
                                    <td style="border-right:1px solid black; border-top:1px solid black; border-right:1px solid black; "><div align="center"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                        <input type="checkbox" readonly name="rdChoice" value="0">
                                    </font></div></td>
                                    <td style="border-right:1px solid black; border-right:1px solid black; ">&nbsp;</td>
                                    <td style="border-right:1px solid black; border-top:1px solid black; border-right:1px solid black; "><font size="2" face="Times New Roman, Times, serif">&nbsp;Volzeit kurs </font></td>
                                    <td style="border-right:1px solid black; border-top:1px solid black; border-right:1px solid black; "><div align="center"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                        <input type="checkbox" readonly name="rdChoice" value="0">
                                    </font></div></td>
                                    <td colspan="2" style=""><div align="center"></div></td>
                                </tr>
                                <tr>
                                    <td height="24" style="border-left:1px solid black; border-top:1px solid black; border-right:1px solid black; ">&nbsp;</td>
                                    <td style="border-right:1px solid black; border-top:1px solid black; border-right:1px solid black; "><div align="center"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                        <input type="checkbox" readonly name="rdChoice" value="0">
                                    </font></div></td>
                                    <td style="border-right:1px solid black;border-right:1px solid black; ">&nbsp;</td>
                                    <td style="border-right:1px solid black; border-top:1px solid black; border-right:1px solid black; "><font size="2" face="Times New Roman, Times, serif">&nbsp;Teilzeit kurs </font></td>
                                    <td style="border-right:1px solid black; border-top:1px solid black; border-right:1px solid black; "><div align="center"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                        <input type="checkbox" readonly name="rdChoice" value="0">
                                    </font></div></td>
                                    <td colspan="2" style=""><div align="center"></div></td>
                                </tr>
                                <tr>
                                    <td height="24" style="border-left:1px solid black; border-top:1px solid black; border-right:1px solid black; "><font size="2" face="Times New Roman, Times, serif">&nbsp;<u>Intensivkurs</u></font></td>
                                    <td style="border-right:1px solid black; border-top:1px solid black; border-right:1px solid black; "><div align="center"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                        <input type="checkbox" readonly name="rdChoice" value="0">
                                    </font></div></td>
                                    <td style="border-right:1px solid black; border-right:1px solid black; ">&nbsp;</td>
                                    <td style="border-right:1px solid black; border-top:1px solid black; border-right:1px solid black; "><font size="2" face="Times New Roman, Times, serif">&nbsp;Anzahl der Wochen </font></td>
                                    <td style="border-right:1px solid black; border-top:1px solid black; border-right:1px solid black; "><div align="center"><font size="3" face="Times New Roman, Times, serif">
                                        <input name="txtKeyWord" type="text" style=" border-color:#FFFFFF" maxlength="10" size="3">
                                    </font></div></td>
                                    <td colspan="2" style=" "><div align="center"></div></td>
                                </tr>
                                <tr>
                                    <td height="26" style="border-left:1px solid black; border-top:1px solid black; border-bottom:1px solid black; border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;<u>Widerholerkurs</u></font></td>
                                    <td style="border-right:1px solid black; border-top:1px solid black; border-right:1px solid black; border-bottom:1px solid black; "><div align="center"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                        <input type="checkbox" readonly name="rdChoice" value="0">
                                    </font></div></td>
                                    <td style="border-right:1px solid black; ">&nbsp;</td>
                                    <td style="border-right:1px solid black; border-top:1px solid black; border-bottom:1px solid black; ">&nbsp;</td>
                                    <td style="border-right:1px solid black; border-top:1px solid black; border-bottom:1px solid black; ">&nbsp;</td>
                                    <td colspan="2" style=""><div align="center"></div></td>
                                </tr>
                                <tr>
                                    <td height="24" colspan="7" style=""><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></strong></td>
                                </tr>
                            </table></td>
                        </tr>
                        <tr>
                            <td colspan="7" >&nbsp;</td>
                        </tr>
                        <tr>
                            <td width = "205" height="70" style="border:1px solid black; "><font size="2" face="Times New Roman, Times, serif"><strong>&nbsp;Kursbeginn am</strong> (Datum) </font><font size="3" face="Times New Roman, Times, serif">
                                <input name="txtKeyWord" type="text" style=" border-color:#FFFFFF" maxlength="10" size="8">
                            </font>
                                <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td><div align="center"><font size="3" face="Times New Roman, Times, serif">
                                        </font></div></td>
                                    </tr>
                                </table></td>
                            <td height="70" colspan="4" style="border-top:1px solid black; border-bottom:1px solid black; border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif"><strong>&nbsp;Voraussichtl. Kursende</strong> (Datum) </font><font size="3" face="Times New Roman, Times, serif">
                                <input name="txtKeyWord" type="text" style=" border-color:#FFFFFF" maxlength="10" size="8">
                            </font>
                                <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td><div align="center"><font size="3" face="Times New Roman, Times, serif">
                                        </font></div></td>
                                    </tr>
                                </table></td>
                            <td height="70" colspan="2" style="border-top:1px solid black; border-bottom:1px solid black; border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif"><strong>&nbsp;Abschlusstest Sprachkurs</strong> (Datum) </font><font size="3" face="Times New Roman, Times, serif">
                                <input name="txtKeyWord" type="text" style=" border-color:#FFFFFF" maxlength="10" size="8">
                            </font>
                                <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">&nbsp;(soweit bereits bekannt)</font></div></td>
                                    </tr>
                                </table></td>
                        </tr>
                        <tr>
                            <td height="20" >&nbsp;</td>
                            <td height="20" colspan="4" >&nbsp;</td>
                            <td height="20" colspan="2" >&nbsp;</td>
                        </tr>
                        <tr>
                            <td height="20" ><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;Unterrichtszeiten&nbsp;</font></strong></td>
                            <td height="20" colspan="4" >&nbsp;</td>
                            <td height="20" colspan="2" >&nbsp;</td>
                        </tr>
                        <tr>
                            <td height="20" >&nbsp;</td>
                            <td height="20" colspan="4" >&nbsp;</td>
                            <td height="20" colspan="2" >&nbsp;</td>
                        </tr>
                    </table>
                        <table width="740" table cellspacing="0" cellpadding="0">
                            <tr>
                                <td height="20" colspan="2" style="border:1px solid black;">&nbsp;</td>
                                <td width="70" style="border-top:1px solid black; border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;&nbsp;Montag</font></td>
                                <td width="82" style="border-top:1px solid black; border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;&nbsp;Dienstag</font></td>
                                <td width="82" style="border-top:1px solid black; border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;&nbsp;Mittwoch</font></td>
                                <td width="82" style="border-top:1px solid black; border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;&nbsp;Donnerstag</font></td>
                                <td width="82" style="border-top:1px solid black; border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;&nbsp;Freitag</font></td>
                                <td width="82" style="border-top:1px solid black; border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;&nbsp;Samstag</font></td>
                                <td width="147" style="border-top:1px solid black; border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;&nbsp;Sonntag</font></td>
                            </tr>
                            <tr>
                                <td width="63" rowspan="2" style="border-bottom:1px solid black; border-left:1px solid black; "><font size="2" face="Times New Roman, Times, serif">&nbsp;Unterricht</font></td>
                                <td width="50" height="20" style="border-bottom:1px solid black; border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">von:</font></td>
                                <td style="border-top:1px solid black; border-right:1px solid black;"><div align="center"><font size="2" color="#000033"><%=classFrom%></font></div></td>
                                <td style="border-top:1px solid black; border-right:1px solid black;"><div align="center"><font size="2" color="#000033"><%=classFrom%></font></div></td>
                                <td style="border-top:1px solid black; border-right:1px solid black;"><div align="center"><font size="2" color="#000033"><%=classFrom%></font></div></td>
                                <td style="border-top:1px solid black; border-right:1px solid black;"><div align="center"><font size="2" color="#000033"><%=classFrom%></font></div></td>
                                <td style="border-top:1px solid black; border-right:1px solid black;"><div align="center"><font size="2" color="#000033"><%=classFrom%></font></div></td>
                                <td style="border-top:1px solid black; border-right:1px solid black;">&nbsp;</td>
                                <td style="border-top:1px solid black; border-right:1px solid black;">&nbsp;</td>
                            </tr>
                            <tr>
                                <td height="20" style="border-bottom:1px solid black; border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">bis:</font></td>
                                <td style="border-bottom:1px solid black;border-top:1px solid black; border-right:1px solid black;"><div align="center"><font size="2" color="#000033"><%=classTo%></font></div></td>
                                <td style="border-bottom:1px solid black;border-top:1px solid black; border-right:1px solid black;"><div align="center"><font size="2" color="#000033"><%=classTo%></font></div></td>
                                <td style="border-bottom:1px solid black;border-top:1px solid black; border-right:1px solid black;"><div align="center"><font size="2" color="#000033"><%=classTo%></font></div></td>
                                <td style="border-bottom:1px solid black;border-top:1px solid black; border-right:1px solid black;"><div align="center"><font size="2" color="#000033"><%=classTo%></font></div></td>
                                <td style="border-bottom:1px solid black;border-top:1px solid black; border-right:1px solid black;"><div align="center"><font size="2" color="#000033"><%=classTo%></font></div></td>
                                <td style="border-bottom:1px solid black;border-top:1px solid black; border-right:1px solid black;">&nbsp;</td>
                                <td style="border-bottom:1px solid black;border-top:1px solid black; border-right:1px solid black;">&nbsp;</td>
                            </tr>
                            <tr>
                                <td rowspan="2" style="border-top:1px solid black;border-bottom:1px solid black; border-left:1px solid black; "><font size="2" face="Times New Roman, Times, serif">&nbsp;Pause</font></td>
                                <td height="20" style="border-top:1px solid black;border-bottom:1px solid black; border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">von:</font></td>
                                <td style="border-top:1px solid black;border-top:1px solid black; border-right:1px solid black;"><div align="center"><font size="2" color="#000033"><%=classBreakFrom1%></font></div></td>
                                <td style="border-top:1px solid black;border-top:1px solid black; border-right:1px solid black;"><div align="center"><font size="2" color="#000033"><%=classBreakFrom1%></font></div></td>
                                <td style="border-top:1px solid black;border-top:1px solid black; border-right:1px solid black;"><div align="center"><font size="2" color="#000033"><%=classBreakFrom1%></font></div></td>
                                <td style="border-top:1px solid black;border-top:1px solid black; border-right:1px solid black;"><div align="center"><font size="2" color="#000033"><%=classBreakFrom1%></font></div></td>
                                <td style="border-top:1px solid black;border-top:1px solid black; border-right:1px solid black;"><div align="center"><font size="2" color="#000033"><%=classBreakFrom1%></font></div></td>
                                <td style="border-top:1px solid black;border-top:1px solid black; border-right:1px solid black;">&nbsp;</td>
                                <td style="border-top:1px solid black;border-top:1px solid black; border-right:1px solid black;">&nbsp;</td>
                            </tr>
                            <tr>
                                <td height="20" style="border-bottom:1px solid black; border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">bis:</font></td>
                                <td style="border-bottom:1px solid black;border-top:1px solid black; border-right:1px solid black;"><div align="center"><font size="2" color="#000033"><%=classBreakTo1%></font></div></td>
                                <td style="border-bottom:1px solid black;border-top:1px solid black; border-right:1px solid black;"><div align="center"><font size="2" color="#000033"><%=classBreakTo1%></font></div></td>
                                <td style="border-bottom:1px solid black;border-top:1px solid black; border-right:1px solid black;"><div align="center"><font size="2" color="#000033"><%=classBreakTo1%></font></div></td>
                                <td style="border-bottom:1px solid black;border-top:1px solid black; border-right:1px solid black;"><div align="center"><font size="2" color="#000033"><%=classBreakTo1%></font></div></td>
                                <td style="border-bottom:1px solid black;border-top:1px solid black; border-right:1px solid black;"><div align="center"><font size="2" color="#000033"><%=classBreakTo1%></font></div></td>
                                <td style="border-bottom:1px solid black;border-top:1px solid black; border-right:1px solid black;">&nbsp;</td>
                                <td style="border-bottom:1px solid black;border-top:1px solid black; border-right:1px solid black;">&nbsp;</td>
                            </tr>
                            <tr>
                                <td height="20" colspan="2" style="border-top:1px solid black;border-bottom:1px solid black; border-left:1px solid black; border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Zahl d. Unterrichtst. </font></td>
                                <td style="border-bottom:1px solid black;border-top:1px solid black; border-right:1px solid black;"><div align="center"><font size="2" face="Times New Roman, Times, serif">5</font></div></td>
                                <td style="border-bottom:1px solid black;border-top:1px solid black; border-right:1px solid black;"><div align="center"><font size="2" face="Times New Roman, Times, serif">5</font></div></td>
                                <td style="border-bottom:1px solid black;border-top:1px solid black; border-right:1px solid black;"><div align="center"><font size="2" face="Times New Roman, Times, serif">5</font></div></td>
                                <td style="border-bottom:1px solid black;border-top:1px solid black; border-right:1px solid black;"><div align="center"><font size="2" face="Times New Roman, Times, serif">5</font></div></td>
                                <td style="border-bottom:1px solid black;border-top:1px solid black; border-right:1px solid black;"><div align="center"><font size="2" face="Times New Roman, Times, serif">5</font></div></td>
                                <td style="border-bottom:1px solid black;border-top:1px solid black; border-right:1px solid black;">&nbsp;</td>
                                <td style="border-bottom:1px solid black;border-top:1px solid black; border-right:1px solid black;">&nbsp;</td>
                            </tr>
                            <tr>
                                <td height="20" colspan="9" >&nbsp;</td>
                            </tr>
                            <tr>
                                <td height="49" colspan="9" style="border:1px solid black;"><font size="2" face="Times New Roman, Times, serif">Ferien / Kursunterbrechungen (Von/Bis/Grund) </font><font size="3" face="Times New Roman, Times, serif">
                                    <input name="txtKeyWord" type="text" style=" border-color:#FFFFFF" maxlength="50" size="50">
                                </font></td>
                            </tr>
                            <tr>
                                <td height="49" colspan="9" ><p>&nbsp;</p>
                                    <p align="center"><span class="style17"><font face="Times New Roman, Times, serif">Seite 1 </font></span></p>
                                    <p align="center">&nbsp;</p>
                                    <p align="center">&nbsp;</p>
                                    <p>&nbsp;</p>
                                    <p>&nbsp;</p></td>
                            </tr>
                            <tr>
                                <td height="23" colspan="9" ><font size="2" face="Times New Roman, Times, serif">&nbsp;Angaben zum Kursleiter / zur Kursleiterin (Zulassung vom Bundesamt muss vorliegen) </font></td>
                            </tr>
                            <tr>
                                <td height="305" colspan="9" ><table width="740"  border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td height="10"style="border-left:1px solid black;border-right:1px solid black;border-top:1px solid black;">&nbsp;</td>
                                    </tr>
                                    <%

                                        for(int i=0;i<teacher.size();i++)
                                        {
                                            StundenLohn sl=(StundenLohn)teacher.elementAt(i);
                                            String courseN="";
                                            String city="";
                                            String bamfN="";
                                            String travelDate="";

                                            if(sl.getCourseName()==null){courseN="";}else{courseN=sl.getCourseName();}
                                            if(sl.getCourseCity()==null){city="";}else{city=sl.getCourseCity();}
                                            if(sl.getDay()==null){bamfN="";}else{bamfN=sl.getDay();}
                                            if(sl.getStundenDate()==null){travelDate="";}
                                            else{
                                                travelDate=MyDate.formateDate(sl.getStundenDate(),MyDate.NUMERIC,MyDate.DEUTSCH);
                                            }
                                    %>
                                    <tr>
                                        <td height="26" style="border-left:1px solid black;border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Name :</font><font size="2" color="#000033"><%=courseN%></font></td>
                                    </tr>

                                    <tr>
                                        <td height="27" style="border-left:1px solid black;border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Vorame :</font><font size="2" color="#000033"><%=city%></font></td>
                                    </tr>
                                    <tr>
                                        <td height="29" style="border-left:1px solid black;border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Zulassungsnummer (falls verf&uuml;gbar) : </font><font size="2" color="#000033"><%=bamfN%></font></td>
                                    </tr>
                                    <tr>
                                        <td height="32" style="border-left:1px solid black;border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Geburtsdatum : </font><font size="2" color="#000033"><%=travelDate%></font></td>
                                    </tr>
                                    <tr>
                                        <td height="63" style="border-left:1px solid black;border-right:1px solid black;">&nbsp;</td>
                                    </tr>
                                    <%
                                        }

                                        for(int c=teacher.size()+1;c<3;c++) {
                                    %>
                                    <tr>
                                        <td height="25" style="border-left:1px solid black;border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Name : .............................. </font></td>
                                    </tr>
                                    <tr>
                                        <td height="26" style="border-left:1px solid black;border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Vorame :</font></td>
                                    </tr>
                                    <tr>
                                        <td height="31" style="border-left:1px solid black;border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Zulassungsnummer (falls verf&uuml;gbar) : </font></td>
                                    </tr>
                                    <tr>
                                        <td height="47" style="border-left:1px solid black;border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Geburtsdatum : </font></td>
                                    </tr>
                                    <%

                                        }
                                    %>
                                    <tr>
                                        <td height="27" style="border-top:1px solid black;"><div align="left"><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;Eingesetztes Lehrwerk</font></strong></div></td>
                                    </tr>
                                    <tr>
                                        <td height="27"><div align="center"><strong><font size="2" face="Times New Roman, Times, serif">S p r a c h k u r s </font></strong></div></td>
                                    </tr>
                                    <tr>
                                        <td height="27"><table width="740"  border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td width="310" height="32" style="border-left:1px solid black;border-right:1px solid black;border-top:1px solid black;"><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;Berliner Platz </font></strong></td>
                                                <td width="52" style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                                <td width="322" style="border-right:1px solid black;border-top:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Passwort Deutsch</font></strong></td>
                                                <td width="56" style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td height="20" style="border-left:1px solid black;border-right:1px solid black;"> <font size="2" face="Times New Roman, Times, serif">&nbsp;Band 1-3(A1/A2/B1) , Lagnescheidt Verlag</font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp;
                                                </font></td>
                                                <td style="border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Band 1-4 (A1/A2) , Ernst Klett Sprachen </font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp;
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td width="310" height="32" style="border-left:1px solid black;border-right:1px solid black;border-top:1px solid black;"><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;Delfin</font></strong></td>
                                                <td width="52" style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                                <td width="322" style="border-right:1px solid black;border-top:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Pluspunkt Deutsch </font></strong></td>
                                                <td width="56" style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td height="20" style="border-left:1px solid black;border-right:1px solid black;"> <font size="2" face="Times New Roman, Times, serif">&nbsp;Band 1-3 (A1/A2/B1) , Max Hueber Verlag </font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp;
                                                </font></td>
                                                <td style="border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Band 1-3  (A1/A2/B1) , Cornelsen Verlag </font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp;
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td width="310" height="32" style="border-left:1px solid black;border-right:1px solid black;border-top:1px solid black;"><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;Deutsch 1 und 2, Einleben in Deutschland leicht &nbsp;gemacht </font></strong></td>
                                                <td width="52" style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                                <td width="322" style="border-right:1px solid black;border-top:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Schritte</font></strong></td>
                                                <td width="56" style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td height="20" style="border-left:1px solid black;border-right:1px solid black;"> <font size="2" face="Times New Roman, Times, serif">&nbsp;Band 1,2 und Anhangband (A1-B1)<br>
                                                    &nbsp;Internationale Inligua Sprachschulen </font></td>
                                                <td style="border-bottom:1px solid black;border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp;
                                                </font></td>
                                                <td style="border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Band 1 - 6 (A1/A2/B1)<br>
                                                    &nbsp;Max Hueber Verlag</font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp;
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td width="310" height="32" style="border-left:1px solid black;border-right:1px solid black;border-top:1px solid black;"><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;Deutsch aktiv Neu</font></strong></td>
                                                <td width="52" style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                                <td width="322" style="border-right:1px solid black;border-top:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Studio d A1, A2 und B1 </font></strong></td>
                                                <td width="56" style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td height="20" style="border-left:1px solid black;border-right:1px solid black;"> <font size="2" face="Times New Roman, Times, serif">&nbsp;Band 1A-1C (A1,A2,B1) , Cornelsen Verlag </font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp;
                                                </font></td>
                                                <td style="border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Cornelsen Verlag </font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp;
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td width="310" height="32" style="border-left:1px solid black;border-right:1px solid black;border-top:1px solid black;"><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;EuroLingua</font></strong></td>
                                                <td width="52" style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                                <td width="322" style="border-right:1px solid black;border-top:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Stufen International</font></strong></td>
                                                <td width="56" style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td height="20" style="border-left:1px solid black;border-right:1px solid black;"> <font size="2" face="Times New Roman, Times, serif">&nbsp;Band 1-3 (A1/A2,B1) , Cornelsen Verlag</font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp;
                                                </font></td>
                                                <td style="border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Band 1-3 , Ernst Klett Sprachen</font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp;
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td width="310" height="32" style="border-left:1px solid black;border-right:1px solid black;border-top:1px solid black;"><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;EuroLingua Deutsch 1 bis 3 - Neue Ausgabe </font></strong></td>
                                                <td width="52" style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                                <td width="322" style="border-right:1px solid black;border-top:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Tangram</font></strong></td>
                                                <td width="56" style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td height="20" style="border-left:1px solid black;border-right:1px solid black;"> <font size="2" face="Times New Roman, Times, serif">&nbsp;Band 1 - 3 (A1/A2/B1) <br>
                                                    <font size="2" face="Times New Roman, Times, serif"> &nbsp;(Cornelsen Verlag</font>) </font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp;
                                                </font></td>
                                                <td style="border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;&nbsp;Band 1, 2 und Z (A1/A2/B1) <br>
                                                    &nbsp; Max Hueber Verlag</font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp;
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td width="310" height="32" style="border-left:1px solid black;border-right:1px solid black;border-top:1px solid black;"><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;Mit uns Leben </font></strong></td>
                                                <td width="52" style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                                <td width="322" style="border-right:1px solid black;border-top:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Tangram aktuell </font></strong></td>
                                                <td width="56" style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td height="20" style="border-left:1px solid black;border-right:1px solid black;"> <font size="2" face="Times New Roman, Times, serif">&nbsp;Band 1 und 2 (A1/A2) , Ernst Klett Sprachen</font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp;
                                                </font></td>
                                                <td style="border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Band 1-3 (A1/A2/B1), Max Hueber Verlag</font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp;
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td width="310" height="32" style="border-left:1px solid black;border-right:1px solid black;border-top:1px solid black;"><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;Moment Mal! </font></strong></td>
                                                <td width="52" style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                                <td width="322" style="border-right:1px solid black;border-top:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Themen neu</font></strong></td>
                                                <td width="56" style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td height="20" style="border-left:1px solid black;border-right:1px solid black;"> <font size="2" face="Times New Roman, Times, serif">&nbsp;Band 1-3(A1/A2/B1)<br>
                                                    &nbsp;Lagnescheidt Verlag</font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp;
                                                </font></td>
                                                <td style="border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Band 1-3 und Zertifikatsband(A1/A2/B1) ,<br> &nbsp;Max Hueber Verlag</font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp;
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td width="310" height="32" style="border-left:1px solid black;border-right:1px solid black;border-top:1px solid black;"><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;Optimal A1, A2 und B1 </font></strong></td>
                                                <td width="52" style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                                <td width="322" style="border-right:1px solid black;border-top:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Themen aktuell </font></strong></td>
                                                <td width="56" style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td height="20" style="border-bottom:1px solid black;border-left:1px solid black;border-right:1px solid black;"> <font size="2" face="Times New Roman, Times, serif">&nbsp;Lagnescheidt Verlag</font></td>
                                                <td style="border-bottom:1px solid black;border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp;
                                                </font></td>
                                                <td style="border-bottom:1px solid black;border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Band 1-3 (A1/A2/B1), Max Hueber Verlag</font></td>
                                                <td style="border-bottom:1px solid black;border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp;
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td height="29" colspan="4" ><div align="center"><strong><span class="style17"></span></strong>
                                                    <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td><div align="center"><strong><span class="style17"><font face="Times New Roman, Times, serif">Seite 2 </font></span></strong></div></td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td><div align="center"><strong><font size="2" face="Times New Roman, Times, serif">Orientierungskurs</font></strong> <strong><span class="style17"><font face="Times New Roman, Times, serif"></font></span></strong></div></td>
                                                        </tr>
                                                    </table>
                                                </div></td>
                                            </tr>
                                            <tr>
                                                <td height="32" style="border-left:1px solid black;border-right:1px solid black;border-top:1px solid black;"><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;30 Student Deutschland</font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Pluspunkt Deutsch-Der Orientierungskurs</font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td height="20" style="border-left:1px solid black;border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Enst Klett Sprachen/2.aktualisierte Auflage 2006 </font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                                <td style="border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Cornelsen Verlag </font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                            </tr>
                                            <tr>
                                                <td height="32" style="border-left:1px solid black;border-right:1px solid black;border-top:1px solid black;"><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;miteinander leben</font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Zur Orientierung </font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td height="20" style="border-left:1px solid black;border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Landeszentrale f&uuml;r politische Bildung Baden- &nbsp;W&uuml;rttemberg /IUDICIUM Verlag </font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                                <td style="border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Max Hueber Verlag / 2.Auflage 2006 </font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                            </tr>
                                            <tr>
                                                <td height="32" style="border-left:1px solid black;border-right:1px solid black;border-top:1px solid black;"><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;Orientierungskurs</font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><strong>&nbsp;</strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp;                  </font></td>
                                            </tr>
                                            <tr>
                                                <td height="20" style="border-bottom:1px solid black;border-left:1px solid black;border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Lagnescheidt Verlag</font></td>
                                                <td style="border-bottom:1px solid black;border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                                <td style="border-bottom:1px solid black;border-right:1px solid black;">&nbsp;</td>
                                                <td style="border-bottom:1px solid black;border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                            </tr>
                                            <tr>
                                                <td height="19" colspan="4" >&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td height="19" colspan="4" ><div align="center"><strong><span class="style17"></span></strong></div></td>
                                            </tr>
                                            <tr>
                                                <td height="19" colspan="4" >&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td height="19" colspan="4" >&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td height="19" colspan="4" >&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td height="19" colspan="4" ><div align="center"><strong><font size="2" face="Times New Roman, Times, serif">Alphabetisierungskurs</font></strong></div></td>
                                            </tr>
                                            <tr>
                                                <td height="32" style="border-left:1px solid black;border-right:1px solid black;border-top:1px solid black;"><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;Alpha-Basis-Projekt <br>
                                                    &nbsp;Erwachsene Neulinge erobern die Schrift 1 </font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Hamburger ABC </font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td height="20" style="border-left:1px solid black;border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Books on Demand </font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                                <td style="border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Arbeitsgemeinschaft Karolinenviertel e.V. </font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                            </tr>
                                            <tr>
                                                <td height="32" style="border-left:1px solid black;border-right:1px solid black;border-top:1px solid black;"><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;Alphabetisierung &amp; Deutsche Sprache </font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Lesen und Schreiben</font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td height="20" style="border-left:1px solid black;border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Proson GmbH</font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                                <td style="border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Max Hueber Verlag</font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                            </tr>
                                            <tr>
                                                <td height="32" style="border-left:1px solid black;border-right:1px solid black;border-top:1px solid black;"><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;Berliner Platz</font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Mosaik</font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td height="20" style="border-left:1px solid black;border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Einstiegkurs, Langenscheidt Verlag </font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                                <td style="border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Cornelsen Verlag </font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                            </tr>
                                            <tr>
                                                <td height="32" style="border-left:1px solid black;border-right:1px solid black;border-top:1px solid black;"><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;Der Vorkurs </font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Projekt Alphabet Neu</font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td height="20" style="border-left:1px solid black;border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Ernst Klett Sprachen </font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                                <td style="border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Lagnescheidt Verlag</font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                            </tr>
                                            <tr>
                                                <td height="32" style="border-left:1px solid black;border-right:1px solid black;border-top:1px solid black;"><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;Das Alpha-Buch</font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                                <td height="32" style="border-right:1px solid black;border-top:1px solid black;"><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp;
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td height="20" style="border-left:1px solid black;border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Max Hueber Verlag</font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                                <td height="20" style="border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                            </tr>
                                            <tr>
                                                <td height="32" style="border-left:1px solid black;border-right:1px solid black;border-top:1px solid black;"><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;Erste Schritte </font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><strong>&nbsp;Zusatzmaterial<font size="2" face="Times New Roman, Times, serif"></font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                            </tr>
                                            <tr>
                                                <td height="54" style="border-bottom:1px solid black;border-left:1px solid black;border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Max Hueber Verlag 2002 <br>
                                                    &nbsp;Ein Vorkurs f&uuml;r lernungewohnte&nbsp;Teilnehmende <br>
                                                    &nbsp;f&uuml;r etwa 30 EU </font></td>
                                                <td style="border-bottom:1px solid black;border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                                <td style="border-bottom:1px solid black;border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif"><strong>&nbsp;Leselotto/Silbenschieber/1200 wichtige W&ouml;rter/ <br>
                                                    &nbsp;Wortkarten und Bildkarten/wendekarten</strong> <br>
                                                    <strong>&nbsp;</strong>(Bundesverband Alphabetisierung u. Grundbildung e.V)
                                                </font></td>
                                                <td style="border-bottom:1px solid black;border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                            </tr>
                                            <tr>
                                                <td height="25" colspan="4" ><div align="center">
                                                    <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td><div align="center"><strong><span class="style17"><font face="Times New Roman, Times, serif">Seite 3 </font></span></strong></div></td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td><div align="center"><strong><font size="2" face="Times New Roman, Times, serif">Zusatzmaterialien</font></strong> </div></td>
                                                        </tr>
                                                    </table>
                                                </div></td>
                                            </tr>
                                            <tr>
                                                <td height="32" style="border-left:1px solid black;border-right:1px solid black;border-top:1px solid black;"><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;Alltag in Deutschland-Materialien mit &uuml;bungen </font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Grammatik Intesivetrainer </font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td height="20" style="border-left:1px solid black;border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Klett Edition Deutschland</font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                                <td style="border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;A1/A2, Langenscheidt Verlag </font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                            </tr>
                                            <tr>
                                                <td height="32" style="border-left:1px solid black;border-right:1px solid black;border-top:1px solid black;"><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;Berliner Platz</font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Grammatik sehen </font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td height="20" style="border-left:1px solid black;border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Einstiegkurs, Lagnescheidt Verlag</font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                                <td style="border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Max Hueber Verlag </font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                            </tr>
                                            <tr>
                                                <td height="32" style="border-left:1px solid black;border-right:1px solid black;border-top:1px solid black;"><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;DaF Grammatik</font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Kinderleicht</font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td height="20" style="border-left:1px solid black;border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;AOL Verlag Frohmut Menze GmbH</font></td>
                                                <td style="border-bottom:1px solid black;border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                                <td style="border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Max Hueber Verlag 2002, Ein &Uuml;bungsbuch speziell f&uuml;r &nbsp;Elternkurse (Anf&auml;nger) </font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                            </tr>
                                            <tr>
                                                <td height="32" style="border-left:1px solid black;border-right:1px solid black;border-top:1px solid black;"><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;DaF Wortschatz</font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Komm, wir lernen einfach Deutsch !</font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td height="20" style="border-left:1px solid black;border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;AOL Verlag Frohmut Menze GmbH</font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                                <td style="border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Band 1und 2, Deutsches Rotes Kreuz Landesverband &nbsp;Nordrhein-Westfallen e.V.</font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                            </tr>
                                            <tr>
                                                <td height="32" style="border-left:1px solid black;border-right:1px solid black;border-top:1px solid black;"><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;Detuch Klasse </font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Langune</font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td height="20" style="border-left:1px solid black;border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Band 1 und 2, Ernst Klett Sprachen </font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                                <td style="border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Band 1 und 2 (A1/A2), Max Hueber Verlag</font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                            </tr>
                                            <tr>
                                                <td height="32" style="border-left:1px solid black;border-right:1px solid black;border-top:1px solid black;"><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;Deutsche Sprache in Alltag &amp; Beruf A1 und A2 </font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Mit Erfolg zu Start Deutsch (Test- und &Uuml;bungs-<br>
                                                </font>&nbsp;<font size="2" face="Times New Roman, Times, serif">-buch)</font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td height="20" style="border-left:1px solid black;border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Proson GmbH</font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                                <td style="border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Ernst Klett Sprachen </font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                            </tr>
                                            <tr>
                                                <td height="32" style="border-left:1px solid black;border-right:1px solid black;border-top:1px solid black;"><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;Der Vorkurs </font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Mit Erfolg zum Zertifikat Deutsch(Test- und <br>
                                                </font>&nbsp;<font size="2" face="Times New Roman, Times, serif"></font><font size="2" face="Times New Roman, Times, serif">&Uuml;bungsbuch)</font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td height="20" style="border-left:1px solid black;border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Ernst Klett Sprachen </font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                                <td style="border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Ernst Klett Sprachen</font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                            </tr>
                                            <tr>
                                                <td height="32" style="border-left:1px solid black;border-right:1px solid black;border-top:1px solid black;"><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;Dialog Beruf</font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Schule mal anderes</font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td height="20" style="border-left:1px solid black;border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Band 1-3 <br>
                                                    &nbsp;Max Hueber Verlag </font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                                <td style="border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Staatsinstitut f&uuml;r Schulp&auml;dagogik und Bildungsforschung/ &nbsp;Ernst Klett Sprachen</font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                            </tr>
                                            <tr>
                                                <td height="32" style="border-left:1px solid black;border-right:1px solid black;border-top:1px solid black;"><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;Einfach Grammatik</font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Sequenzen -&Uuml;bungsgrammatik</font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td height="20" style="border-left:1px solid black;border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;&Uuml;bungsgrammatik Deutsch A1 bis B1 <br>
                                                    &nbsp;Langenscheidt Verlag</font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                                <td style="border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Deutsch als Fremdsprache <br>
                                                    &nbsp;Cornelsen Verlag </font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                            </tr>
                                            <tr>
                                                <td height="32" style="border-left:1px solid black;border-right:1px solid black;border-top:1px solid black;"><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;em- Br&uuml;ckenkurs B1 </font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">so geht's </font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td height="20" style="border-left:1px solid black;border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Max Hueber Verlag</font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                                <td style="border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Ernst Klett Sprachen </font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                            </tr>
                                            <tr>
                                                <td height="32" style="border-left:1px solid black;border-right:1px solid black;border-top:1px solid black;"><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;Erste Schritte </font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><strong></strong><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp;                  </font><font color="#000033" size="2" face="Times New Roman, Times, serif"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">So geht's zum ZD</font></strong> </font></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td height="20" style="border-left:1px solid black;border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Max Hueber Verlag 2002, Ein Vorkurs f&uuml;r lernungewohnte &nbsp;Teilnehmende f&uuml;r etwa 30 UE</font></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                                <td style="border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;Ernst Klett Sprachen</font></td>
                                                <td style="border-right:1px solid black;">&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td height="32" style="border-left:1px solid black;border-right:1px solid black;border-top:1px solid black;"><strong><font size="2" face="Times New Roman, Times, serif">&nbsp;genial </font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp;                  </font></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Sonstige Lehrwerk: </font></strong></td>
                                                <td style="border-right:1px solid black;border-top:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                            </tr>
                                            <tr>
                                                <td height="28" rowspan="3" style="border-bottom:1px solid black;border-left:1px solid black;border-right:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;(A1/A2/B1)<br><br>
                                                    &nbsp;Langensheidt Verlag</font></td>
                                                <td rowspan="3" style="border-bottom:1px solid black;border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                                <td height="28" style="border-right:1px solid black;">&nbsp;</td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">&nbsp; </font></td>
                                            </tr>
                                            <tr>
                                                <td height="20" style="border-right:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Durch das Bundesamt genehmigt </font></strong></td>
                                                <td style="border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td height="26" style="border-bottom:1px solid black;border-right:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Nicht genehmigt</font></strong></td>
                                                <td style="border-bottom:1px solid black;border-right:1px solid black;"><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                                </font></td>
                                            </tr>
                                            <tr>
                                                <td height="25" colspan="4" >&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td height="25" colspan="4" >&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td height="25" colspan="4" >&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td height="25" colspan="4" >&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td height="25" colspan="4" ><div align="center"><strong><span class="style17"><font face="Times New Roman, Times, serif">Seite 4</font></span></strong></div></td>
                                            </tr>
                                            <tr>
                                                <td height="25" colspan="4" >&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td height="25" colspan="4" >&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td height="25" colspan="4" >&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td height="25" colspan="4" >&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td height="25" colspan="4" ><font size="2" face="Times New Roman, Times, serif">&nbsp;Kursteilnehmer/innen soweit nach dem Zuwanderungsgesetz zur Teilnahme berechtigt/verpflichtet</font></td>
                                            </tr>
                                            <tr>
                                                <td height="19" colspan="4" >&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td height="25" colspan="4" ><table width="740"  border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td width="29" rowspan="2" style="border-left:1px solid black;border-right:1px solid black;border-top:1px solid black;"><strong></strong><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif"></font></strong></td>
                                                        <td width="235" style="border-right:1px solid black;border-top:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif"></font></strong></td>
                                                        <td width="138" style="border-right:1px solid black;border-top:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Personenkennziffer des </font></strong></td>
                                                        <td width="120" style="border-right:1px solid black;border-top:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">ABH-Kennziffer</font></strong></td>
                                                        <td width="111" style="border-right:1px solid black;border-top:1px solid black;"><strong> &nbsp;<font size="2" face="Times New Roman, Times, serif">BVA-Kennziffer</font></strong></td>
                                                        <td width="120" style="border-right:1px solid black;border-top:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Aktenzeichen</font></strong></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="border-right:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif"></font></strong></td>
                                                        <td style="border-right:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Bundesamtes</font></strong></td>
                                                        <td style="border-right:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif"></font></strong></td>
                                                        <td rowspan="3" style="border-bottom:1px solid black;border-right:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif"></font></strong><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif"></font>&nbsp;</strong><strong></strong></td>
                                                        <td style="border-right:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Tr&auml;ger d. Grunds. f.</font></strong></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="border-left:1px solid black;border-right:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Nr.</font></strong></td>
                                                        <td style="border-right:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Name, Vorname </font></strong></td>
                                                        <td style="border-right:1px solid black;"><strong>&nbsp;</strong></td>
                                                        <td style="border-right:1px solid black;"><strong>&nbsp;</strong></td>
                                                        <td style="border-right:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Arbeitsuchende</font>&nbsp;</strong></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="border-bottom:1px solid black;border-left:1px solid black;border-right:1px solid black;"><strong>&nbsp;</strong></td>
                                                        <td style="border-bottom:1px solid black;border-right:1px solid black;"><strong>&nbsp;</strong></td>
                                                        <td style="border-bottom:1px solid black;border-right:1px solid black;"><div align="right"><strong>&nbsp;&nbsp;<font size="2" face="Times New Roman, Times, serif">oder</font>&nbsp;<font size="2" face="Times New Roman, Times, serif"></font></strong></div></td>
                                                        <td style="border-bottom:1px solid black;border-right:1px solid black;"><div align="right"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif"></font>&nbsp;&nbsp;&nbsp;<font size="2" face="Times New Roman, Times, serif">oder</font>&nbsp;<font size="2" face="Times New Roman, Times, serif"></font></strong></div></td>
                                                        <td style="border-bottom:1px solid black;border-right:1px solid black;"><div align="right"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif"></font>&nbsp;&nbsp;&nbsp;<font size="2" face="Times New Roman, Times, serif">oder</font>&nbsp;<font size="2" face="Times New Roman, Times, serif"></font></strong></div></td>
                                                    </tr>
                                                    <%
                                                        int check=5;
                                                        String classification="";
                                                        String BamfPkz="";
                                                        String BamfAbh="";
                                                        String BamfBva="";
                                                        for(int f=0;f<v.size();f++){
                                                            Student s=(Student)v.elementAt(f);
                                                            Anwesenheit a=adb.getAnwesenheit(courseid,s.getUserID(),adb.getFirstDate(),adb.getLastDate());
                                                            trans = transDB.getTransaction(s.getUserID(),courseid);

                                                            //Student student=new Student();
                                                            StudentDao studentDB=new StudentDao();
                                                            s=studentDB.getStudentInformation(s.getUserID(),rps.getLoginUser().getUserID());

                                                            int status = s.getUserCostSharing();
                                                            String statusS="";
                                                            if (status == 0){
                                                                statusS = "";}
                                                            else if (status == 1){
                                                                statusS = "mit Kostenbeitrag";}
                                                            else if (status == 2){
                                                                statusS = "ohne Kostenbeitrag";}
                                                            int classificationN= trans.getInitialTest();
                                                            if(classificationN==modulenameN){
                                                                classification = "Ja";
                                                                classCount =1;
                                                            }
                                                            else {
                                                                classification = "Nein";
                                                                classCount=0;}
                                                            classCount1=classCount1+classCount;

                                                            int bamfchoice = s.getUserBamfChoice();
                                                            if(bamfchoice==0)
                                                            {
                                                                BamfPkz = s.getUserBamfNumber();
                                                            }
                                                            else {
                                                                BamfPkz ="";
                                                            }
                                                            if(bamfchoice==1)
                                                            {
                                                                BamfAbh = s.getUserBamfNumber();
                                                            }
                                                            else {
                                                                BamfAbh ="";
                                                            }
                                                            if(bamfchoice==2)
                                                            {
                                                                BamfBva = s.getUserBamfNumber();
                                                            }
                                                            else {
                                                                BamfBva ="";
                                                            }

                                                    %>
                                                    <tr>
                                                        <td style="border-bottom:1px solid black;border-left:1px solid black;border-right:1px solid black;"><div align="center"><strong><font size="1" color="#000033"><%=count%></font></strong></div></td>
                                                        <td style="border-bottom:1px solid black;border-right:1px solid black;"><font size="1" color="#000033"><%=s.getUserLastName()+" "+ s.getUserFirstName()%></font></td>
                                                        <td style="border-bottom:1px solid black;border-right:1px solid black;"><strong><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                        </font>&nbsp;<font size="1" color="#000033"><%=BamfPkz%></font></strong></td>
                                                        <td style="border-bottom:1px solid black;border-right:1px solid black;"><strong><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                        </font>&nbsp;<font color="#000033" size="1" face="Times New Roman, Times, serif">
                                                        </font><font size="1" color="#000033"><%=BamfAbh%></font><font color="#000033" size="1" face="Times New Roman, Times, serif">                        </font></strong></td>
                                                        <td style="border-bottom:1px solid black;border-right:1px solid black;"><strong><font color="#000033" size="2" face="Times New Roman, Times, serif">
                                                        </font>&nbsp;<font color="#000033" size="1" face="Times New Roman, Times, serif">
                                                        </font><font size="1" color="#000033"><%=BamfBva%></font><font color="#000033" size="1" face="Times New Roman, Times, serif">                        </font></strong></td>
                                                        <td style="border-bottom:1px solid black;border-right:1px solid black;">&nbsp;</td>
                                                    </tr>
                                                    <%
                                                            count++;
                                                        }

                                                        for(count=v.size()+1;count<26;count++) {
                                                    %>
                                                    <tr>
                                                        <td style="border-bottom:1px solid black;border-left:1px solid black;border-right:1px solid black;"><div align="center"><strong><font size="1" color="#000033"><%=count%></font></strong></div></td>
                                                        <td style="border-bottom:1px solid black;border-right:1px solid black;">&nbsp;</td>
                                                        <td style="border-bottom:1px solid black;border-right:1px solid black;">&nbsp;</td>
                                                        <td style="border-bottom:1px solid black;border-right:1px solid black;">&nbsp;</td>
                                                        <td style="border-bottom:1px solid black;border-right:1px solid black;">&nbsp;</td>
                                                        <td style="border-bottom:1px solid black;border-right:1px solid black;">&nbsp;</td>
                                                    </tr>
                                                    <%

                                                        }
                                                    %>

                                                    <tr>
                                                        <td >&nbsp;</td>
                                                        <td >&nbsp;</td>
                                                        <td >&nbsp;</td>
                                                        <td >&nbsp;</td>
                                                        <td colspan="2" >&nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" style="border-bottom:1px solid black;border-left:1px solid black;border-right:1px solid black;border-top:1px solid black;"><strong></strong><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Zahl der Kursteilnehmer/innen insgesamt </font><font color="#000000" size="2"><%=v.size()%></font></strong></td>
                                                        <td colspan="4" style="border-bottom:1px solid black;border-right:1px solid black;border-top:1px solid black;"><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Personen</font><font size="3" face="Times New Roman, Times, serif">
                                                        </font></strong></td>
                                                    </tr>
                                                    <tr>
                                                        <td >&nbsp;</td>
                                                        <td >&nbsp;</td>
                                                        <td >&nbsp;</td>
                                                        <td >&nbsp;</td>
                                                        <td colspan="2" >&nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td height="25" colspan="6" style="border-bottom:1px solid black;border-left:1px solid black;border-right:1px solid black;border-top:1px solid black;"><p><strong></strong><strong>&nbsp;<font size="2" face="Times New Roman, Times, serif">Ort, Datum, Unterschrift des Kurstr&auml;gers</font></strong></p>
                                                            <p>&nbsp;</p></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" >&nbsp;</td>
                                                        <td >&nbsp;</td>
                                                        <td >&nbsp;</td>
                                                        <td colspan="2" >&nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" >&nbsp;</td>
                                                        <td >&nbsp;</td>
                                                        <td >&nbsp;</td>
                                                        <td colspan="2" >&nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" >&nbsp;</td>
                                                        <td >&nbsp;</td>
                                                        <td >&nbsp;</td>
                                                        <td colspan="2" >&nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" >&nbsp;</td>
                                                        <td >&nbsp;</td>
                                                        <td >&nbsp;</td>
                                                        <td colspan="2" >&nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" >&nbsp;</td>
                                                        <td >&nbsp;</td>
                                                        <td >&nbsp;</td>
                                                        <td colspan="2" >&nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" >&nbsp;</td>
                                                        <td >&nbsp;</td>
                                                        <td >&nbsp;</td>
                                                        <td colspan="2" >&nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" >&nbsp;</td>
                                                        <td >&nbsp;</td>
                                                        <td >&nbsp;</td>
                                                        <td colspan="2" >&nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" >&nbsp;</td>
                                                        <td >&nbsp;</td>
                                                        <td >&nbsp;</td>
                                                        <td colspan="2" >&nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" >&nbsp;</td>
                                                        <td >&nbsp;</td>
                                                        <td >&nbsp;</td>
                                                        <td colspan="2" >&nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" >&nbsp;</td>
                                                        <td >&nbsp;</td>
                                                        <td >&nbsp;</td>
                                                        <td colspan="2" >&nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" >&nbsp;</td>
                                                        <td >&nbsp;</td>
                                                        <td >&nbsp;</td>
                                                        <td colspan="2" >&nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="6" ><div align="center"><strong><span class="style17"><font face="Times New Roman, Times, serif">Seite 5 </font></span></strong></div></td>
                                                    </tr>
                                                </table></td>
                                            </tr>

                                        </table></td>
                                    </tr>
                                </table></td>
                            </tr>
                        </table></td>
                </tr>
            </table>
        </td>
        <td width="8">&nbsp;
            <p>&nbsp;</p></td>
    </tr>
    <tr>
        <td height="19" colspan="6" >&nbsp;</td>
    </tr>
</table>
</td>
</tr>
</table>
</td>
<td width="4">&nbsp;</td>
</tr>
</table>

</body>
</html>
