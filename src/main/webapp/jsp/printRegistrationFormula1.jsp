<html>
<head>
    <title>Print Registration</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body bgcolor="#FFFFFF" text="#000000">
<%@ page import="com.rheinlandprivatschule.helper.MyDate" %>
<%@ page import="com.rheinlandprivatschule.model.Country" %>
<%@ page import="com.rheinlandprivatschule.model.Place" %>
<%@ page import="com.rheinlandprivatschule.model.Student" %>
<%@ page import="com.rheinlandprivatschule.repository.CountryDao" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="com.rheinlandprivatschule.repository.StudentDao" %>
<%
    RPS rps=(RPS)session.getAttribute("handler");
    int userid= 0;
    String bamfnumber ="";
    int bamfchoice =0;
    int countryid=0;
    String inttest="";


    Student pstudent=(Student)session.getAttribute("pstudent");
    StudentDao studentDB= (StudentDao) request.getAttribute("studentDao");
    Country country=new Country();
    CountryDao countryDB=new CountryDao();
    Place myPlace=rps.getLoginPlace();

    userid = pstudent.getUserID();

    pstudent=studentDB.getStudentInformation(userid,rps.getLoginUser().getUserID());
    bamfnumber = pstudent.getUserBamfNumber();
    bamfchoice = pstudent.getUserBamfChoice();
    countryid=pstudent.getUserCountryID();
    country = countryDB.getCountry(countryid);

    if(pstudent.getUserIntTest()>0){
        inttest=Integer.toString(pstudent.getUserIntTest());
    }
    else{
        inttest="";
    }

%>
<table border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
        <td colspan="4"><img src="/resources/images/Template_49.gif" width="1" height="1">
            <table width="10%" height="825"  border="0" cellpadding="0">
                <tr>
                    <td height="821">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
            <img src="/resources/images/Template_48.gif" width="29" height="335"></td>
        <td width="842">
            <table width="800" border="0" align="right" >
                <tr>
                    <td colspan="4"><img src="/resources/images/Template_47.gif" width=224 height=138 alt=""></td>
                </tr>
                <tr>
                    <td colspan="4"><table width="795" border="0" cellpadding="0">
                        <tr>
                            <td width="13">&nbsp;</td>
                            <td width="775"><font size="3" face="Times New Roman, Times, serif"><font color="#000033" size="5">Anmeldeformular f&uuml;r den Integrationkurs gem&auml;&szlig; &sect; 7 Abs. 1 IntV</font></font></td>
                        </tr>
                    </table>
                        <table width="200" border="0" cellpadding="0">
                            <tr>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                        </table></td>
                </tr>
                <tr>
                    <td height="116" colspan="3"><table width="814"  table style="border:1px solid black;"  cellspacing="1" cellpadding="0">
                        <tr>
                            <td width="57%" height="28"><font color="#000000" size="3" face="Times New Roman, Times, serif">&nbsp;Personenkennziffer des Bundesamtes: </font></td>
                            <td width="37%"><font color="#000033" size="3" face="Times New Roman, Times, serif">
                                <%
                                    if(bamfchoice ==0){
                                %>
                                <%=bamfnumber%>
                                <%
                                    }
                                %>
                            </font></td>
                            <td width="6%" ><div align="left"><font size="3"><u>oder</u></font></div></td>
                        </tr>
                    </table>
                        <table width="814"  table style="border-left:1px solid black; border-right:1px solid black; border-bottom:1px solid black;"  cellspacing="1" cellpadding="0">
                            <tr>
                                <td width="57%" height="53"><font size="3"><font color="#000000" face="Times New Roman, Times, serif">&nbsp;(Beh&ouml;rden-Aktenzeichen (ABH oder BVA oder Tr&auml;ger der </font><font size="3"><font color="#000000" face="Times New Roman, Times, serif">&nbsp;</font></font><font color="#000000" face="Times New Roman, Times, serif">Grundsicherung)</font></font> </td>
                                <td width="37%"><font color="#000033" size="3" face="Times New Roman, Times, serif">
                                    <%
                                        if(pstudent.getUserBamfChoice()==1){
                                    %>
                                    <%=bamfnumber%>
                                    <%
                                        }
                                    %>
                                    <%
                                        if(pstudent.getUserBamfChoice()==2){
                                    %>
                                    <%=bamfnumber%>
                                    <%
                                        }
                                    %>
                                </font></td>
                                <td width="6%" ><div align="left"><font size="3"></font></div></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td height="42" >
                        <table width="620" height="30" border="0" cellspacing="0">
                            <tr>
                                <td width="149" height="30"><font color="#000033" size="3" face="Times New Roman, Times, serif">
                                    <br>
                                    <%
                                        if(pstudent.getUserGender()==0){
                                    %>
                                    <input type="checkbox" readonly name="rdChoice" value="0" checked>
                                    <%
                                    }else {
                                    %>
                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                    <%
                                        }

                                    %>
                                </font><font size="3" face="Times New Roman, Times, serif">&nbsp;Herr</font></td>
                                <td width="467"><font size="3"><br>
                                    <font color="#000033" face="Times New Roman, Times, serif">
                                        <%
                                            if(pstudent.getUserGender()==1){
                                        %>
                                        <input type="checkbox" readonly name="rdChoice" value="1" checked>
                                        <%
                                        }else {
                                        %>
                                        <input type="checkbox"  readonly name="rdChoice" value="1">
                                        <%
                                            }

                                        %>
                                    </font></font><font size="3" face="Times New Roman, Times, serif">&nbsp;Frau </font></td>
                            </tr>
                        </table></td>
                </tr>
                <tr>
                    <td height="26" colspan="3"><table width="815" table style="border:1px solid black;"  cellspacing="0" cellpadding="0">
                        <tr>
                            <td height="27"  style="border-right:1px solid black;"><font size="3" face="Times New Roman, Times, serif">&nbsp;Name<font color="#FFFFFF">.</font>: <%=pstudent.getUserLastName()%></font> <font size="3"></font><font size="3" face="Times New Roman, Times, serif">&nbsp;</font></td>
                            <td><font size="3" face="Times New Roman, Times, serif"> &nbsp;Vorname<font color="#FFFFFF">.</font>: <%=pstudent.getUserFirstName()%></font></td>
                        </tr>
                    </table></td>
                </tr>
                <tr>
                    <td height="99" colspan="3">        <table width="620" border="0" cellpadding="0">
                        <tr>
                            <td><font size="3" face="Times New Roman, Times, serif">&nbsp;Anschrift</font></td>
                        </tr>
                    </table>
                        <table width="816" style="border:1px solid black;" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="318" height="49"><p><font size="3" face="Times New Roman, Times, serif">Stra&szlig;e/ Hausnummer<br>
                                </font><font color="#000033" size="3" face="Times New Roman, Times, serif">&nbsp;</font><font size="3" face="Times New Roman, Times, serif"><%=pstudent.getUserAddress()%>	</font></p>
                                </td>
                                <td width="258" style="border-left:1px solid black;"><p><font size="3" face="Times New Roman, Times, serif">&nbsp;Postleitzahl<br>
                                </font><font color="#000033" size="3" face="Times New Roman, Times, serif">&nbsp;</font><font size="3" face="Times New Roman, Times, serif"><%=pstudent.getUserPostCode()%></font></p></td>
                                <td width="238" style="border-left:1px solid black;"><font size="3" face="Times New Roman, Times, serif">&nbsp;Ort<br>
                                </font><font color="#000033" size="3" face="Times New Roman, Times, serif">&nbsp;</font><font size="3" face="Times New Roman, Times, serif"><%=pstudent.getUserCity()%> </font></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="3"><table width="816" style="border:1px solid black;"  cellspacing="1" cellpadding="0">
                        <tr>
                            <td width="318" height="28" style="border-right:1px solid black;"><font size="3" face="Times New Roman, Times, serif">&nbsp;Geburtsort : <%=pstudent.getUserBirthPlace()%></font></td>
                            <td width="234"><p><font size="3" face="Times New Roman, Times, serif">&nbsp;Geburtsdatum<font color="#FFFFFF">.</font>: <%=MyDate.formateDate(pstudent.getUserBirthDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></p></td>
                            <td width="258" style="border-left:1px solid black;"><font size="3" face="Times New Roman, Times, serif">&nbsp;Staatsangeh&ouml;rigkeit<font color="#FFFFFF">.</font>: <%=country.getUserCountryName()%></font></td>
                        </tr>
                    </table></td>
                </tr>
                <tr>
                    <td colspan="3"><div align="left">


                        <table width="620" border="0" cellpadding="0">
                            <tr>
                                <td><table width="200" border="0" cellpadding="0">
                                    <tr>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td><font size="3" face="Times New Roman, Times, serif">&nbsp;Bildungsstand(ISCED-Level)</font></td>
                                    </tr>
                                </table></td>
                            </tr>
                        </table>
                        <table width="816" table style="border:1px solid black;"  cellspacing="1" cellpadding="0">
                            <tr>
                                <td width="85" height="42" ><font size="3" face="Times New Roman, Times, serif"> &nbsp;1</font><font color="#000033" size="3" face="Times New Roman, Times, serif">
                                    <%
                                        if(pstudent.getUserAcademicPoints()==1){
                                    %>
                                    <input type="checkbox" readonly name="rdChoice" value="1" checked>
                                    <%
                                    }else {
                                    %>
                                    <input type="checkbox" readonly name="rdChoice" value="1">
                                    <%
                                        }

                                    %>
                                </font></td>
                                <td width="1" bgcolor="#000000"><font size="3"></font></td>
                                <td width="89"><font size="3" face="Times New Roman, Times, serif">&nbsp;2<font color="#000033"><font color="#000033">
                                    <%
                                        if(pstudent.getUserAcademicPoints()==2){
                                    %>
                                    <input type="checkbox" readonly name="rdChoice" value="2" checked>
                                    <%
                                    }else {
                                    %>
                                    <input type="checkbox" readonly name="rdChoice" value="2">
                                    <%
                                        }

                                    %>
                                </font></font></font><font size="3"></font><font size="3" face="Times New Roman, Times, serif">&nbsp;</font></td>
                                <td width="84" style="border-left:1px solid black;"><font size="3" face="Times New Roman, Times, serif">&nbsp;3A<font color="#000033"><font color="#000033">
                                    <%
                                        if(pstudent.getUserAcademicPoints()==3){
                                    %>
                                    <input type="checkbox" readonly name="rdChoice" value="3" checked>
                                    <%
                                    }else {
                                    %>
                                    <input type="checkbox" readonly name="rdChoice" value="3">
                                    <%
                                        }

                                    %>
                                </font></font></font></td>
                                <td width="1" bgcolor="#000000"><font size="3"></font></td>
                                <td width="85"><font size="3" face="Times New Roman, Times, serif">&nbsp;3B<font color="#000033"><font color="#000033">
                                    <%
                                        if(pstudent.getUserAcademicPoints()==4){
                                    %>
                                    <input type="checkbox" readonly name="rdChoice" value="4" checked>
                                    <%
                                    }else {
                                    %>
                                    <input type="checkbox" readonly name="rdChoice" value="4">
                                    <%
                                        }

                                    %>
                                </font></font></font></td>
                                <td width="1" bgcolor="#000000"><font size="3"></font></td>
                                <td width="85"><font size="3" face="Times New Roman, Times, serif">&nbsp;4A<font color="#000033"><font color="#000033">
                                    <%
                                        if(pstudent.getUserAcademicPoints()==5){
                                    %>
                                    <input type="checkbox" readonly name="rdChoice" value="5" checked>
                                    <%
                                    }else {
                                    %>
                                    <input type="checkbox" readonly name="rdChoice" value="5">
                                    <%
                                        }

                                    %>
                                </font></font></font></td>
                                <td width="1" bgcolor="#000000"><font size="3"></font></td>
                                <td width="85"><font size="3" face="Times New Roman, Times, serif">&nbsp;5A<font color="#000033"><font color="#000033">
                                    <%
                                        if(pstudent.getUserAcademicPoints()==6){
                                    %>
                                    <input type="checkbox" readonly name="rdChoice" value="6" checked>
                                    <%
                                    }else {
                                    %>
                                    <input type="checkbox" readonly name="rdChoice" value="6">
                                    <%
                                        }

                                    %>
                                </font></font></font></td>
                                <td width="1" bgcolor="#000000"><font size="3"></font></td>
                                <td width="85"><font size="3" face="Times New Roman, Times, serif">&nbsp;5B<font color="#000033"><font color="#000033">
                                    <%
                                        if(pstudent.getUserAcademicPoints()==7){
                                    %>
                                    <input type="checkbox" readonly name="rdChoice" value="7" checked>
                                    <%
                                    }else {
                                    %>
                                    <input type="checkbox" readonly name="rdChoice" value="7">
                                    <%
                                        }

                                    %>
                                </font></font></font></td>
                                <td width="1" bgcolor="#000000"><font size="3"></font></td>
                                <td width="85"><font size="3" face="Times New Roman, Times, serif">&nbsp;6<font color="#000033"><font color="#000033">
                                    <%
                                        if(pstudent.getUserAcademicPoints()==8){
                                    %>
                                    <input type="checkbox" readonly name="rdChoice" value="8" checked>
                                    <%
                                    }else {
                                    %>
                                    <input type="checkbox" readonly name="rdChoice" value="8">
                                    <%
                                        }

                                    %>
                                </font></font></font></td>
                                <td width="1" bgcolor="#000000"><font size="3"></font></td>
                                <td width="107"><font size="3" face="Times New Roman, Times, serif">&nbsp;9<font color="#000033"><font color="#000033">
                                    <%
                                        if(pstudent.getUserAcademicPoints()==9){
                                    %>
                                    <input type="checkbox" readonly name="rdChoice" value="9" checked>
                                    <%
                                    }else {
                                    %>
                                    <input type="checkbox" readonly name="rdChoice" value="9">
                                    <%
                                        }

                                    %>
                                </font></font></font> </td>
                            </tr>
                            <tr>
                                <td height="19" colspan="16" style="border-top:1px solid black;"><p><font color="#000033" size="3" face="Times New Roman, Times, serif">&nbsp;</font><font size="3" face="Times New Roman, Times, serif">Anzahl der Schuljahre, falls kein Abschluss (= ISCED-Level 1) <%=pstudent.getUserSchoolingYears()%></font></p></td>
                            </tr>
                        </table>
                        <font size="3">      </font></div></td>
                </tr>
                <tr>
                    <td height="20" colspan="3">&nbsp;</td>
                </tr>

                <tr>
                    <td colspan="3"><table width="330" border="0" cellpadding="0">
                        <tr>
                            <td width="1"></td>
                            <td width="316"><font color="#000033" size="3" face="Times New Roman, Times, serif">&nbsp;Angaben zur Schreibkundigkeit</font> </td>
                        </tr>
                    </table>
                        <table width="817" table style="border:1px solid black;"  cellspacing="1" cellpadding="0">
                            <tr>
                                <td width="231" height="23"><font color="#000000" size="3" face="Times New Roman, Times, serif">
                                    <%
                                        if(pstudent.getUserProficency()==0){
                                    %>
                                    <input type="checkbox" readonly name="rdChoice" value="0" checked>
                                    <%
                                    }else {
                                    %>
                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                    <%
                                        }

                                    %>
                                    nicht alphabetisiert </font> </td>
                                <td width="284"><font color="#000000" size="3" face="Times New Roman, Times, serif">
                                    <%
                                        if(pstudent.getUserProficency()==1){
                                    %>
                                    <input type="checkbox" readonly name="rdChoice" value="1" checked>
                                    <%
                                    }else {
                                    %>
                                    <input type="checkbox" readonly name="rdChoice" value="1">
                                    <%
                                        }

                                    %>
                                    nicht lateinisch alphabetisiert</font></td>
                                <td width="296"><font color="#000000" size="3" face="Times New Roman, Times, serif">
                                    <%
                                        if(pstudent.getUserProficency()==2){
                                    %>
                                    <input type="checkbox" readonly name="rdChoice" value="2" checked>
                                    <%
                                    }else {
                                    %>
                                    <input type="checkbox" readonly name="rdChoice" value="2">
                                    <%
                                        }

                                    %>
                                    lateinisch alphabetisiert</font></td>
                            </tr>
                        </table>      </td>
                </tr>
                <tr>
                    <td colspan="3"><font size="3" face="Times New Roman, Times, serif">&nbsp;</font></td>
                </tr>
                <tr>
                    <td colspan="3"><font size="3" face="Times New Roman, Times, serif">&nbsp;Ergebnis des Einstufungstests</font> <font size="3" face="Times New Roman, Times, serif"><%=inttest%></font>  </tr>
                <tr>
                    <td height="133" colspan="2" align="left"><table width="817" cellspacing="0" cellpadding="0">
                        <tr>
                            <td height="25" colspan="2" style="border-left:1px solid black; border-bottom:1px solid black; border-top:1px solid black;">            <font size="3" face="Times New Roman, Times, serif"> &nbsp;Datum :
                                <%=MyDate.formateDate(pstudent.getUserGradingDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%>          </font></td>
                            <td colspan="4" style="border:1px solid black;"><div align="center">
                                <font color="#000033" size="3" face="Times New Roman, Times, serif">Empfohlene Kursart: </font></div></td>
                        </tr>
                        <tr>
                            <td width="213" height="23" style="border-left:1px solid black; border-bottom:1px solid black; "> &nbsp;Empfohlenes Kursmodul: <font size="3" face="Times New Roman, Times, serif">
                                <%=pstudent.getUserModuleNr()%></font></td>
                            <td width="41" style="border-bottom:1px solid black; ">(1-9)</td>
                            <td width="240" style="border-left:1px solid black; border-bottom:1px solid black; ">&nbsp;Allgemeiner Integrationskurs</td>
                            <td width="35" style="border-left:1px solid black; border-bottom:1px solid black; "><div align="center"><font color="#000033" size="3" face="Times New Roman, Times, serif">
                                <input type="checkbox" readonly name="rdChoice" value="1">
                            </font></div></td>
                            <td width="235" style="border-left:1px solid black; border-bottom:1px solid black; ">&nbsp;Alphabetisierungkurs</td>
                            <td width="51" style="border-left:1px solid black; border-bottom:1px solid black; border-right:1px solid black; "><div align="center"><font color="#000033" size="3" face="Times New Roman, Times, serif">
                                <input type="checkbox" readonly name="rdChoice" value="1">
                            </font></div></td>
                        </tr>
                        <tr>
                            <td height="23" colspan="2">&nbsp;</td>
                            <td style="border-left:1px solid black; border-bottom:1px solid black; ">&nbsp;Frauenkurs</td>
                            <td style="border-left:1px solid black; border-bottom:1px solid black; "><div align="center"><font color="#000033" size="3" face="Times New Roman, Times, serif">
                                <input type="checkbox" readonly name="rdChoice" value="1">
                            </font></div></td>
                            <td style="border-left:1px solid black; border-bottom:1px solid black; ">&nbsp;F&ouml;rderkurs</td>
                            <td style="border-left:1px solid black; border-bottom:1px solid black; border-right:1px solid black;"><div align="center"><font color="#000033" size="3" face="Times New Roman, Times, serif">
                                <input type="checkbox" readonly name="rdChoice" value="1">
                            </font></div></td>
                        </tr>
                        <tr>
                            <td height="25" colspan="2">&nbsp;</td>
                            <td style="border-left:1px solid black; border-bottom:1px solid black; ">&nbsp;Elternkurs</td>
                            <td style="border-left:1px solid black; border-bottom:1px solid black; "><div align="center"><font color="#000033" size="3" face="Times New Roman, Times, serif">
                                <input type="checkbox" readonly name="rdChoice" value="1">
                            </font></div></td>
                            <td style="border-left:1px solid black; border-bottom:1px solid black; ">&nbsp;Intensivkurs</td>
                            <td style="border-left:1px solid black; border-bottom:1px solid black; border-right:1px solid black; "><div align="center"><font color="#000033" size="3" face="Times New Roman, Times, serif">
                                <input type="checkbox" readonly name="rdChoice" value="1">
                            </font></div></td>
                        </tr>
                        <tr>
                            <td colspan="2">&nbsp;</td>
                            <td style="border-left:1px solid black; border-bottom:1px solid black; ">&nbsp;Jugendkurs</td>
                            <td style="border-left:1px solid black; border-bottom:1px solid black; "><div align="center"><font color="#000033" size="3" face="Times New Roman, Times, serif">
                                <input type="checkbox" readonly name="rdChoice" value="1">
                            </font></div></td>
                            <td style="border-left:1px solid black; border-bottom:1px solid black; ">&nbsp;Sonst.spez. Integrationskurs</td>
                            <td style="border-left:1px solid black; border-bottom:1px solid black; border-right:1px solid black;"><div align="center"><font color="#000033" size="3" face="Times New Roman, Times, serif">
                                <input type="checkbox" readonly name="rdChoice" value="1">
                            </font></div></td>
                        </tr>
                    </table>        </td>
                </tr>
                <tr>
                    <td colspan="3" align="left"><font size="3" face="Times New Roman, Times, serif">&nbsp;</font></td>
                </tr>
                <tr>
                    <td height="16" colspan="3" align="left"><table width="818" table style="border:1px solid black;"  cellspacing="1" cellpadding="0">
                        <tr>
                            <td width="814" height="23">
                                <font color="#000033" face="Times New Roman, Times, serif">
                                    <input type="checkbox" readonly name="rdChoice" value="0">
                                    <font color="#000000">Einstufungstest entbehrlich, da unmittelbare Teilnahme am Sprachtest oder am Orientierungskurs bzw. Test zum Orientierungskurs</font></font> </td>
                        </tr>
                    </table></td>
                </tr>
                <tr>
                    <td colspan="2" align="left">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="2" align="left"><table width="818" table style="border:1px solid black;"  cellspacing="1" cellpadding="0">
                        <tr>
                            <td width="239" height="23"><font size="3" face="Times New Roman, Times, serif">&nbsp;</font><font color="#000033" size="3" face="Times New Roman, Times, serif">&nbsp;</font><font color="#000033" face="Times New Roman, Times, serif"> <font color="#000000"></font></font><font color="#000033" face="Times New Roman, Times, serif"> <font color="#000000"></font></font><font size="3" face="Times New Roman, Times, serif">&nbsp;</font><font color="#000033" face="Times New Roman, Times, serif"> <font color="#000000"></font></font><font color="#000033" face="Times New Roman, Times, serif"> <font color="#000000"></font></font>&nbsp;Falls der Einstufungstest durch einen <u>&nbsp;anderen</u> Tr&auml;ger durchgef&uuml;hrt wurde </td>
                            <td width="210" style="border-left:1px solid black;"><font size="3" face="Times New Roman, Times, serif">&nbsp;</font><font color="#000033" size="3" face="Times New Roman, Times, serif">&nbsp;</font><font size="3" face="Times New Roman, Times, serif">&nbsp;</font>&nbsp;Name des Tr&auml;gers </td>
                            <td width="195" style="border-left:1px solid black;"><font size="3" face="Times New Roman, Times, serif">&nbsp;</font><font color="#000033" size="3" face="Times New Roman, Times, serif">&nbsp;</font><font size="3" face="Times New Roman, Times, serif">&nbsp;</font>&nbsp;Ort</td>
                            <td width="167" style="border-left:1px solid black;"><font size="3" face="Times New Roman, Times, serif">&nbsp;</font><font color="#000033" size="3" face="Times New Roman, Times, serif">&nbsp;</font><font size="3" face="Times New Roman, Times, serif">&nbsp;</font>&nbsp;Kenziffer (falls bekannt) </td>
                        </tr>
                    </table></td>
                </tr>
                <tr>
                    <td colspan="3" align="left"><font size="3" face="Times New Roman, Times, serif">&nbsp;</font></td>
                </tr>
                <tr>
                    <td colspan="3" align="left"><table width="818" table style="border:1px solid black;"  cellspacing="1" cellpadding="0">
                        <tr>
                            <td width="814" height="24"><font size="3" face="Times New Roman, Times, serif">&nbsp;Datum der Anmeldung beim Kurstr&auml;ger <%=MyDate.formateDate(pstudent.getUserGradingDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                        </tr>
                    </table></td>
                </tr>
                <tr>
                    <td colspan="3" align="left"><font size="3" face="Times New Roman, Times, serif">&nbsp;</font></td>
                </tr>
                <tr>
                    <td colspan="3" align="left"><table width="819" table style="border:1px solid black;"  cellspacing="1" cellpadding="0">
                        <tr>
                            <td width="815" height="25"><font color="#000033" size="3" face="Times New Roman, Times, serif">
                                <%
                                    if(pstudent.getUserSponsorShip()==1){
                                %>
                                <input type="checkbox" readonly name="rdChoice" value="1" checked>
                                <%
                                }else {
                                %>
                                <input type="checkbox" readonly name="rdChoice" value="1">
                                <%
                                    }
//<td width="1" bgcolor="#000000"><img src="/images/clearpixel.gif" width="1" height="1" /></td>
                                %>
                            </font><font size="3" face="Times New Roman, Times, serif">&nbsp;Ein separater Antrag auf Kostenbefreiung wurde mit der Anmeldung gestellt. </font></td>
                        </tr>
                    </table></td>
                </tr>
                <tr>
                    <td colspan="3" align="left"><font size="3">&nbsp;</font></td>
                </tr>
                <tr>
                    <td colspan="3" align="left"><table width="820" table style="border:1px solid black;"  cellspacing="1" cellpadding="0">
                        <tr>
                            <td width="353" height="25"><div align="left"><font size="3" face="Times New Roman, Times, serif">&nbsp;Name des Kurstr&auml;gers<font color="#FFFFFF">.</font>: <%=myPlace.getFirmaName()%></font></div></td>
                            <td width="1" bgcolor="#000000"><font size="3"></font></td>
                            <td width="460"><font size="3" face="Times New Roman, Times, serif">&nbsp;Kennziffer des Kurstr&auml;gers<font color="#FFFFFF">.</font>: <%=myPlace.getBamfNumber()%></font></td>

                        </tr>
                    </table>      <table width="820" table style="border-left:1px solid black; border-right:1px solid black;"  cellspacing="1" cellpadding="0">
                        <tr>
                            <td width="267"><font size="3" face="Times New Roman, Times, serif">&nbsp;Ort, Datum<font color="#FFFFFF">.</font>:          </font></td>
                            <td width="548"><font size="3" face="Times New Roman, Times, serif"><%=MyDate.formateDate(pstudent.getUserGradingDate(),MyDate.NUMERIC,MyDate.DEUTSCH)%></font></td>
                        </tr>
                    </table>
                        <table width="820" table style="border:1px solid black;"  cellspacing="1" cellpadding="0">
                            <tr>
                                <td width="355"><p><font size="3" face="Times New Roman, Times, serif">&nbsp;Unterschrift Kurstr&auml;ger </font></p>
                                    <p>&nbsp;</p></td>
                                <td width="1" bgcolor="#000000"><font size="3"></font></td>

                                <td width="458"><p><font size="3" face="Times New Roman, Times, serif">&nbsp;Unterschrift Teilnahmeberechtigter </font></p>
                                    <p>&nbsp;</p></td>
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
