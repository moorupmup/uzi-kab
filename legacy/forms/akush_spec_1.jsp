<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title" align="center">Консультативный прием акушера-гинеколога. Специализированный прием по невынашиванию беременности и нарушениям в системе гемостаза</H3>

<b>Жалобы:</b><br>
<%=r.get("jalob")%><br>


<b>Акушерский анамнез:</b><br>
<%=r.get("an_akush")%><br>

<b>Гинекологические заболевания</b><br>
<%=r.get("zab_gin")%><br>


<b>Сопутствующие заболевания</b><br>
<%=r.get("soput")%><br>

<b>Anamnesis vitae</b><br>
<%=r.get("vitae")%><br>

<b>St.praesens:</b><br>
<%=r.get("status_o")%><br>

<b>St.genitalis:</b><br>
<%=r.get("status_l")%><br>

<b>Обследована:</b><br>
<%=r.get("pred_iss")%><br>

<b>Диагноз:</b><br>
<%=r.get("diag")%><br>

<b>Рекомендации:</b><br>
<%=r.get("rekomend")%><br>



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
