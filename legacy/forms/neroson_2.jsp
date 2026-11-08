<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>

<H3 class="p_title">Нейросонография</H3>
<table width="90%" border="1">
    <tr> 
        <td colspan="2">
            <%=r.getCheckbox("bespok")%>
            <SCRIPT LANGUAGE="JavaScript">
            document.protocol.bespok.focus();
            </script>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <%=r.getSelect("sredin")%>
        </td>
    </tr>
    <tr>
        <td>Межполушарная щель</td>
        <td><%=r.getSelect("megpol")%>
            <%=r.getSizeInput("megpol_how")%> мм
        </td>
    </tr>
    <tr>
        <td>Боковые желудочки:</td>
        <td>
            правый:<%=r.getSizeInput("prav_jeludok_how")%> мм
        </td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>
            левый:<%=r.getSizeInput("lev_jeludok_how")%> мм
        </td>
    </tr>
    <tr>
        <td>3-й желудочек</td>
        <td>
            <%=r.getSizeInput("jeludok_3_how")%> мм
        </td>
    </tr>
    <tr>
        <td>4-й желудочек</td>
        <td>
            <%=r.getSelect("jeludok")%>
            <%=r.getSizeInput("jeludok_how")%> мм
        </td>
    </tr>
    <tr>
        <td colspan="2"><%=r.getSelect("sosud")%></td>
    </tr>
    <tr>
        <td colspan="2"><%=r.getSelect("perv")%></td>
    </tr>
    <tr>
        <td colspan="2"><%=r.getSelect("kaudo")%></td>
    </tr>
    <tr>
        <td colspan="2"><%=r.getSelect("dopol")%></td>
    </tr>
    <tr>
        <td colspan="2">При ЦДК передней артерии: пульсация сосудов мозга <%=r.getSelect("cdk")%> на всех уровнях</td>
    </tr>
    <tr>
        <td colspan="2">Vs = <%=r.getSizeInput("vs")%> см/с; Vd = <%=r.getSizeInput("vd")%> см/с; RI = <%=r.getSizeInput("ri")%>; PI = <%=r.getSizeInput("pi")%></td>
    </tr>

</table>

<%@include file="footer.jsp"%>
