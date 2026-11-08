<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>



<H3 class="p_title" align="center">ОСМОТР УРОЛОГА</H3>



Жалобы:<br>
<%=r.get("jalob")%><br>


Наружные половые органы:<br>
<%=r.get("nar_pol")%><br>
<SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.nar_pol.value == "") document.protocol.nar_pol.value = "без особенностей, придатки, яички нормотрофичны безболезненны";
</script>


Ректально:<br>
<%=r.get("rektal")%><br>
<SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.rektal.value == "") document.protocol.rektal.value = "предстательная железа не увеличена, безболезненна, эластична, ровная, междолевая борозда выражена";
</script>


Диагноз:<br>
<%=r.get("dsss")%><br>
<SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.dsss.value == "") document.protocol.dsss.value = "здоров";
</script>


<b>Заключение: в своей профессии: </b> <%=r.getSelect("zakl")%>
<br>

Рекомендовано:<br>
<%=r.get("rekom")%><br>


Лечение:<br>
<%=r.get("lech")%><br>




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
