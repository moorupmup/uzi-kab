<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title" align="center">РЕНТГЕНОЛОГИЧЕСКОЕ ИССЛЕДОВАНИЕ</H3>

Выполнен рентген:  <%=r.getTextInput("vipolll")%>

<br>
Лучевая нагрузка: <%=r.getSizeInput("nagruz")%>
<br>
Исследование выполнено на аппарате:
<br>


<b>ЖАЛОБЫ:</b><br>
<%=r.get("jalob")%>
<br>
<b>КОММЕНТАРИИ:</b><br>
<%=r.get("komment")%>
<br>
<b>ЗАКЛЮЧЕНИЕ:</b><br>
<%=r.get("zakl")%>
<br>
<b>РЕКОМЕНДАЦИИ:</b><br>
<%=r.get("rekomen")%>

<br>
Рентгенлаборант: <%=r.getSelect("labor")%>
<br>
Врач:<%=r.get("doctor_fio")%><br>
<input type="hidden" name="from_doctor_id" value="0">
<input type="hidden" name="decision" value="">
<input type="hidden" name="decision_id" value="2">
<input type="hidden" name="addition" value="">
<table width="100%" border="0">
    <tr>
        <td><input type="submit" value="Просмотр">
        <input type="button" value="Отмена" onClick="document.protocol.pacient_id.value = ''; setAction('choice_research'); submit();"></td></tr>
</table>
</form>
<%@include file="../footer.jsp"%>