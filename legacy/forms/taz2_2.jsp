<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title">Ультразвуковое исследование тазобедренных суставов</H3>

<table width="100%" border="1">
    <tr> 
        <td width="25%" class="simple_str">Ядра окостенения
        </td>
        <td width="25%"><%=r.getSelect("yadro")%>
        </td>
        <td width="50%">
            <%=r.getCheckbox("oba_yadro")%><br>
            <%=r.getCheckbox("right_yadro")%><br>
            <%=r.getCheckbox("left_yadro")%>
        </td>
        <SCRIPT LANGUAGE="JavaScript">
            document.protocol.yadro.focus();
        </script>
    </tr>
    <tr> 
        <td width="25%" class="simple_str">Интенсивность 
        </td>
        <td width="25%"><%=r.getSelect("intens")%>
        </td>
        <td width="50%">
            <%=r.getCheckbox("right_intens")%><br>
            <%=r.getCheckbox("left_intens")%>
        </td>
    </tr>
    <tr> 
        <td colspan="3" class="simple_str">
            <%=r.getCheckbox("sootn")%><br>
            <%=r.getCheckbox("preobl")%>
        </td>
    </tr>
    <tr> 
        <td width="25%" class="simple_str">Головки ТБС
        </td>
        <td colspan="2">
            <%=r.getSelect("tbs")%>
        </td>
    </tr>
    <tr> 
        <td width="25%" class="simple_str">Угловые параметры 
        </td>
        <td colspan="2">
            <%=r.getSelect("param")%> нормативам
        </td>
    </tr>
    <tr> 
        <td width="25%" class="simple_str">Справа: a-
            <%=r.getSizeInput("right_alfa")%> (N <font face="Symbol" class="font-family: Symbol;" >&#179</font> 60)
        </td>
        <td width="25%" class="simple_str">b-
            <%=r.getSizeInput("right_betta")%> (N <font face="Symbol" class="font-family: Symbol;" >&#163</font> 55)
        </td>
        <td width="50%" class="simple_str">g-
            <%=r.getSizeInput("right_gamma")%> (N <font face="Symbol" class="font-family: Symbol;" >&#179</font> 78)
        </td>
    </tr>
    <tr> 
        <td width="25%" class="simple_str">Слева: a-
            <%=r.getSizeInput("left_alfa")%>
        </td>
        <td width="25%" class="simple_str">b-
            <%=r.getSizeInput("left_betta")%>
        </td>
        <td width="50%" class="simple_str">g-
            <%=r.getSizeInput("left_gamma")%>
        </td>
    </tr>
</table>

<%@include file="footer.jsp"%>