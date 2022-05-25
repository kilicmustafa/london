<%@ page import="java.util.Vector" %>
<%@ page import="com.rheinlandprivatschule.model.ExpenseCategory" %>
<%@ page import="com.rheinlandprivatschule.helper.MyCurrency" %>
<%@ page import="com.rheinlandprivatschule.model.Place" %>
<%@ page import="java.sql.Date" %>
<%@ page import="com.rheinlandprivatschule.repository.ExpenseDao" %>
<%@ page import="com.rheinlandprivatschule.model.SystemUser" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: Stundenlohn ::</title>
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

    </script>
</head>
<body>
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
                        <form style="width: 100%;" name="form1" method="post" action="stlohnDetailEmployee">
                            <table width="100%" border="0" cellspacing="1" cellpadding="1">
                                <tr>
                                    <td bgcolor="657A9A" colspan="2">
                                        <div align="center"><font size="3" color="#FFFFFF"><b>Mittarbeiter Stundenlohn</b></font></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td bgcolor="657A9A" width="19%"><b><font size="2" color="#FFFFFF">Monat</font></b></td>
                                    <td bgcolor="AEBACD" width="81%">
                                        <%
                                            String monthO = (String) request.getAttribute("month0");
                                            int yearO = Integer.parseInt(String.valueOf(request.getAttribute("year0")));
                                            List<SystemUser> tea = (List<SystemUser>) request.getAttribute("tea");

                                        %>
                                        <select name="selSMonth">
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
                                                for(int iSM=0;iSM<vtemp.size();iSM++)
                                                {
                                                    String tempSM=(String)vtemp.elementAt(iSM);
                                                    if(tempSM.equalsIgnoreCase(monthO))
                                                    {
                                            %>
                                            <option selected><%=tempSM%></option>
                                            <%
                                            }
                                            else
                                            {
                                            %>
                                            <option ><%=tempSM%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                        .
                                        <select name="selSYear">
                                            <%
                                                for(int iSY=2004;iSY<2029;iSY++)
                                                {
                                                    if(iSY==yearO)
                                                    {
                                            %>
                                            <option selected><%=iSY%></option>
                                            <%
                                            }
                                            else
                                            {
                                            %>
                                            <option ><%=iSY%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="19%" bgcolor="657A9A"><b><font size="2" color="#FFFFFF">Lehrer/in</font></b></td>
                                    <td width="81%" bgcolor="AEBACD">
                                        <select name="tea">
                                            <option value="0" selected>w&auml;hlen</option>
                                            <%
                                                for(int h=0;h<tea.size();h++)
                                                {
                                                    SystemUser u=(SystemUser)tea.get(h);
                                            %>
                                            <option value="<%=u.getUserID()%>"><%=u.getUserFirstName()+" "+u.getUserLastName()%></option>
                                            <%
                                                }
                                            %>

                                        </select>
                                    </td>
                                </tr>
                                <tr bgcolor="AEBACD">
                                    <td>&nbsp;</td>
                                    <td>
                                        <input class="btn btn-primary" type="submit" name="Submit" value="OK">
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
