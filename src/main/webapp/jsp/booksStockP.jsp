<%@ page import="com.rheinlandprivatschule.model.Buch" %>
<%@ page import="com.rheinlandprivatschule.model.Place" %>
<%@ page import="com.rheinlandprivatschule.repository.BuchDao" %>
<%@ page import="com.rheinlandprivatschule.repository.PlaceDao" %>
<%@ page import="com.rheinlandprivatschule.repository.RPS" %>
<%@ page import="java.util.Vector" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="templates/headimports.jsp"/>
    <title>:: B&uuml;cher im Stock ::</title>
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
<%

    Vector places=new Vector();
    Vector v=new Vector();
    BuchDao bdb= (BuchDao) request.getAttribute("buchDao");
    PlaceDao placeDB = (PlaceDao) request.getAttribute("placeDao");
    RPS rps=(RPS)session.getAttribute("handler");

    places= placeDB.getAllPlaces();
    Place np=new Place();
    np.setPlaceID(0);
    np.setPlaceName("Lager");
    places.insertElementAt(np,0);

    v=bdb.getAllBuch(0);
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
                            <table width="100%" border="0" height="120" cellpadding="1" cellspacing="1">
                                <tr>
                                    <td height="100" valign="top">
                                        <table width="100%" border="0" cellpadding="1" cellspacing="1">
                                            <tr bgcolor="657A9A">
                                                <td height="22" colspan="3">
                                                    <div align="center"><b><font color="#FFFFFF">B&uuml;cher
                                                        im Stock</font></b></div>
                                                </td>
                                            </tr>
                                            <tr bgcolor="657A9A">
                                                <td height="6" colspan="2" bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>Buchname</b></font></td>
                                                <td height="6" width="67%" bgcolor="657A9A"><font size="2" color="#FFFFFF"><b>Stock</b></font></td>
                                            </tr>
                                            <%
                                                for(int i=0;i<v.size();i++)
                                                {
                                                    Buch bu=(Buch)v.elementAt(i);


                                            %>
                                            <tr bgcolor="AEBACD">
                                                <td height="6" colspan="2" bgcolor="AEBACD"><font size="2" color="#000033"><%=bu.getBookName()%></font></td>
                                                <td height="6" width="67%">
                                                    <table width="100%" border="0" cellspacing="1" cellpadding="1">
                                                        <%
                                                            for(int ii=0;ii<places.size();ii++)
                                                            {
                                                                Place pl=(Place)places.elementAt(ii);
                                                                int tempp=bdb.countBooks(bu.getBookID(),pl.getPlaceID());
                                                        %>
                                                        <tr>
                                                            <td width="33%" bgcolor="657A9A"><font size="2" color="#FFFFFF"><b><%=pl.getPlaceName()%></b></font></td>
                                                            <td width="67%" bgcolor="#CCCCCC"><font size="2" color="#000033"><%=tempp%></font></td>
                                                        </tr>
                                                        <%
                                                            }
                                                        %>
                                                    </table>
                                                </td>
                                            </tr>
                                            <%
                                                }
                                            %>
                                        </table>
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
