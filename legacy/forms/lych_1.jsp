<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title" align="center">Ультразвуковое исследование лучезапястных суставов</H3>

<table width="100%" border="1">
    <tr> 
        <td colspan="3" class="simple_str" align="center"><b>Правый лучезапястный сустав</b>
        </td>
    <tr> 
        <td colspan="2" class="simple_str">Форма сустава
        </td>
        <td width="50%"><%=r.getSelect("form_r")%></td>
        <SCRIPT LANGUAGE="JavaScript">
            document.protocol.form_r.focus();
        </script>
    </tr>
    <tr> 
        <td colspan="2" class="simple_str">Суставная щель</td>
        <td><%=r.getSelect("shel_r")%>
        </td>
    </tr>
    <tr> 
        <td colspan="2">Субхондральный склероз</td>
        <td><%=r.getSelect("subsk_r")%>
        </td>
    </tr>
    <tr> 
        <td colspan="2">Гиалиновый хрящ</td>
        <td><%=r.getSelect("geoh_r")%>
        </td>
    </tr>
    <tr> 
        <td colspan="2" class="simple_str">Суставные поверхности</td>
        <td>
            <%=r.getSelect("syst_pov_r")%>
        </td>
    </tr>
    <tr>
        <td colspan="2" class="simple_str">Избыточное количество свободной жидкости в полости сустава</td>
        <td><%=r.getSelect("svobj_r")%> </td>
    </tr>
    <tr>
        <td colspan="2" class="simple_str">Выпот во влагалище сухожилий сгибателей пальцев</td>
        <td>
            <%=r.getSelect("vip_syh_r")%>
        </td>
    </tr>
    <tr>
        <td colspan="2" class="simple_str">Сужение суставных щелей пястнофаланговых, межфаланговых суставов</td>
        <td>
            <%=r.getSelect("syj_sys_r")%>
        </td>
    </tr>
    <tr>
        <td colspan="2" class="simple_str">Избыточное количество свободной жидкости в полости суставов</td>
        <td>
            <%=r.getSelect("svobjsys_r")%> <%=r.getTextInput("svobj_text_r")%>
        </td>
    </tr>
    <tr>
        <td colspan="2" class="simple_str">Выпот во влагалище сухожилий межфаланговых суставов</td>
        <td>
            <%=r.getSelect("vip_mej_r")%>
        </td>
    </tr>
	<tr><td colspan="3"><%=r.get("dop_r")%> </td></tr>
</table>

<table width="100%" border="1">
    <tr> 
        <td colspan="3" class="simple_str" align="center"><b>Левый лучезапястный сустав</b>
        </td>
    <tr> 
        <td colspan="2" class="simple_str">Форма сустава
        </td>
        <td width="50%"><%=r.getSelect("form_l")%></td>
    </tr>
    <tr> 
        <td colspan="2" class="simple_str">Суставная щель</td>
        <td><%=r.getSelect("shel_l")%>
        </td>
    </tr>
    <tr> 
        <td colspan="2">Субхондральный склероз</td>
        <td><%=r.getSelect("subsk_l")%>
        </td>
    </tr>
    <tr> 
        <td colspan="2">Гиалиновый хрящ</td>
        <td><%=r.getSelect("geoh_l")%>
        </td>
    </tr>
    <tr> 
        <td colspan="2" class="simple_str">Суставные поверхности</td>
        <td>
            <%=r.getSelect("syst_pov_l")%>
        </td>
    </tr>
    <tr>
        <td colspan="2" class="simple_str">Избыточное количество свободной жидкости в полости сустава</td>
        <td><%=r.getSelect("svobj_l")%> </td>
    </tr>
    <tr>
        <td colspan="2" class="simple_str">Выпот во влагалище сухожилий сгибателей пальцев</td>
        <td>
            <%=r.getSelect("vip_syh_l")%>
        </td>
    </tr>
    <tr>
        <td colspan="2" class="simple_str">Сужение суставных щелей пястнофаланговых, межфаланговых суставов</td>
        <td>
            <%=r.getSelect("syj_sys_l")%>
        </td>
    </tr>
    <tr>
        <td colspan="2" class="simple_str">Избыточное количество свободной жидкости в полости суставов</td>
        <td>
            <%=r.getSelect("svobjsys_l")%> <%=r.getTextInput("svobj_text_l")%>
        </td>
    </tr>
    <tr>
        <td colspan="2" class="simple_str">Выпот во влагалище сухожилий межфаланговых суставов</td>
        <td>
            <%=r.getSelect("vip_mej_l")%>
        </td>
    </tr>
	<tr><td colspan="3"> <%=r.get("dop_l")%> </td></tr>
</table>

<%@include file="footer.jsp"%>
