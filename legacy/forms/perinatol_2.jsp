<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title" align="center">Перинатология</H3>
<b>Жалобы</b><br>
<%=r.get("jaloby")%>
<br><b>AN. VITAE(норма)</b><br>
<%=r.get("vitae")%>
<br><b>AN. VITAE(патология)</b><br>
<%=r.get("vitaepat")%>
<br><b>Родословная</b><br>
<%=r.get("rod")%>
<br><b>Акушерский анамнез</b><br>
<%=r.get("anamnez")%>
<br><b>Паритет</b><br>
<%=r.get("paritet")%>
<br><b>Настоящая беременность</b><br>
<%=r.get("berem")%>
<br><b>ST. PRAESENS</b><br>
<%=r.get("praesens")%>
<br><b>Дополнительные исследования</b><br>
<%=r.get("dop")%>
<br><b>Диагноз</b><br>
<%=r.get("diag")%>
<br><b>Предварительный диагноз</b><br>
<%=r.get("preddiag")%>
<br><b>Заключительный диагноз</b><br>
<%=r.get("decision2")%><br>
<br><b>Рекомендации</b><br>
<%=r.get("rekomend")%>
<br><b>Направление на обследования</b><br>
<%=r.get("napravl")%><br>
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

