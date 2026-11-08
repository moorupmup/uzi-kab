<%@page import = "java.util.Date" import="my_pack.beans.*" import="my_pack.tools.* java.text.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title" align="center"><%=r.get("research")%></H3>

<table width="100%" border="1">
    <tr><td colspan="3">Молочная железа <%=r.getSelect("moloch_del")%> удалена оперативно в <%=r.getSizeInput("moloch_god")%> году</td></tr>
    <tr><td colspan="3"><%=r.get("moloch_text")%></td></tr>
    <tr><td>Кожные покровы, ареолы </td>
        <td colspan="2"><%=r.getSelect("moloch_koja")%> <%=r.getTextInput("moloch_koja_text")%></td></tr>
        <SCRIPT LANGUAGE="JavaScript">
            document.protocol.moloch_koja.focus();
        </script>
    <tr><td>Сосок</td>
        <td colspan="2"><%=r.getSelect("moloch_sosok")%></td></tr>
    <tr><td width="30%">Молочные железы представлены </td>
        <td colspan="2"><%=r.getSelect("moloch_jel")%> </td></tr>
    <tr><td>Млечные протоки </td>
        <td><%=r.getSelect("moloch_protok")%></td>
        <td><%=r.getChangeHidden("moloch_protok", "1", "470")%>
                до <%=r.getSizeInput("m_protok_mm")%> мм
                <%=r.getSelect("m_protok_ravn")%>
                <%=r.getSelect("m_protok_gde")%>
            </div></td>
    </tr>
    <tr><td>Состояние протоков  </td>
        <td colspan="2"><%=r.getSelect("sost_protok")%></td></tr>
    <tr><td>Строма </td>
        <td colspan="2"><%=r.getSelect("moloch_stroma")%></td></tr>
    <tr><td>Очаговые образования: </td>
        <td colspan="2"><%=r.getSelect("moloch_ochag")%></td></tr>
    <tr><td colspan="3"><%=r.get("moloch_obraz")%> </td></tr>
    <tr><td>Региональные лимфатические узлы </td>
        <td><%=r.getSelect("moloch_limfou")%> до <%=r.getSizeInput("m_limf_mm")%> мм</td>
        <td><%=r.getSelect("m_limf_gde")%> <%=r.getTextInput("m_limf_text")%></td>
    </tr>
</table>
<%@include file="footer.jsp"%>
