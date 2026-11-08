<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title" align="center">Эзофагогастродуоденоскопия</H3>
<b>Пищевод:</b><br>
<%=r.get("pish")%><br>
<b>Желудок:</b><br>
<%=r.get("jelud")%><br>
<b>Двенадцатиперстная кишка:</b><br>
<%=r.get("kish")%><br>
<b>Заключение:</b><br>
<%=r.get("zakl")%><br>


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