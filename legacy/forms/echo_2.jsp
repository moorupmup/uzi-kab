<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title">Функциональная эхохолецистография</H3>

<table width="100%" border="1">
    <tr> 
        <td width="25%" class="simple_str">Объём желчного пузыря  
        </td>
        <td colspan="2">
            <%=r.getSizeInput("puzir_how")%>
            <span class="ed_izm"> мл</span>
        </td>
        <SCRIPT LANGUAGE="JavaScript">
            document.protocol.puzir_how.focus();
        </script>
    </tr>
    <tr> 
        <td colspan="3" class="simple_str">Через  
            <%=r.getSizeInput("cherez_how")%>
            <span class="ed_izm"> мин</span>
            после приема  желчегонного завтрака 
            <%=r.getSelect("zavtrak")%>
        </td>
    </tr>
    <tr> 
        <td width="25%" class="simple_str">Объем 
        </td>
        <td colspan="2">
            <%=r.getCheckbox("jelch")%>
            <%=r.getSizeInput("jelch_how")%>
            <span class="ed_izm"> мл</span><br>
            <%=r.getCheckbox("puzir")%>
            <%=r.getSelect("izm")%>
            <%=r.getSizeInput("izm_how")%>
            <span class="ed_izm"> мл</span><br>
            <%=r.getCheckbox("svid")%>
            <%=r.getSelect("gip")%> сфинктеров желчевыводящих путей<br>
            <%=r.getCheckbox("harak")%>
            <%=r.getSelect("disk")%> дискинезии<br>
            <%=r.getCheckbox("vozrost")%>
        </td>
    </tr>
</table>

<%@include file="footer.jsp"%>