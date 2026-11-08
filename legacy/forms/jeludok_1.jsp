<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title">Ультразвуковое исследование желудка</H3>

<table width="100%" border="1">
    <tr> 
        <td width="30%" class="simple_str">Акт глотания
        </td>
        <td colspan="2"><%=r.getSelect("akt")%>
        </td>
        <SCRIPT LANGUAGE="JavaScript">
            document.protocol.akt.focus();
        </script>
    </tr>
    <tr> 
        <td width="30%" class="simple_str">Пищевод
        </td>
        <td colspan="2"><%=r.getSelect("pisha")%>
        </td>
    </tr>
    <tr> 
        <td colspan="3" class="simple_str">Перорально желудок заполнен жидкостью в объеме
            <%=r.getSizeInput("pero_how")%>
            <span class="ed_izm"> мл</span>
            <%=r.getSelect("pero")%><br>
            <%=r.getCheckbox("posl")%><br>
            <%=r.getCheckbox("otch")%>
        </td>
    </tr>
    <tr> 
        <td width="30%" class="simple_str">Перистальтика</td>
        <td colspan="2"><%=r.getSelect("peri")%>
        </td>
    </tr>
    <tr> 
        <td width="30%" class="simple_str">Эвакуация</td>
        <td colspan="2"><%=r.getSelect("eval")%>
        </td>
    </tr>
    <tr> 
        <td width="30%" class="simple_str">Рефлюксы:
            <%=r.getSelect("refl")%></td>
        <td colspan="2">
            <%=r.getChangeHidden("refl", "1", "2282")%>
                <%=r.getCheckbox("duod")%><br>
                <%=r.getCheckbox("bulba")%><br>
                <%=r.getCheckbox("gastro")%><br>
                <%=r.getCheckbox("regur")%>
            </div>
        </td>
    </tr>
</table>

<%@include file="footer.jsp"%>
