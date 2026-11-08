<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title" align="center">Эзофагогастродуоденоскопия</H3>
<b>Пищевод:</b><br>
<%=r.get("pish")%><br>
<SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.pish.value == "") document.protocol.pish.value = "Пищевод свободно проходим, просвет его обычный, складки продольные. Стенки эластичны. Слизистая бледнорозовая. Кардия смыкается. Линия ZET дифференцируется.";
</script>

<b>Желудок:</b><br>
<%=r.get("jelud")%><br>
<SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.jelud.value == "") document.protocol.jelud.value = "Желудок в форме крючка средних размеров. Содержит немного прозрачной жидкости. Свободно расправляется воздухом. Стенки эластичные. Складки извиты, средние по высоте. Перистальтика умеренная, прослеживается во всех отделах. Слизистая бледнорозового цвета. Пилорус смыкается. Уреазный тест на Helicobacter pylori -";
</script>

<b>Двенадцатиперстная кишка:</b><br>
<%=r.get("kish")%><br>
<SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.kish.value == "") document.protocol.kish.value = "Луковица 12-перстной кишки полигональной формы, смыкается. Просвет кишки овальный, складки циркулярные. Слизистая бледнорозового цвета.";
</script>

<b>Заключение:</b><br>
<%=r.get("zakl")%><br>
<SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.zakl.value == "") document.protocol.zakl.value = "Рекомендовано: Консультация гастроэнтеролога. Эндоскопический контроль через 2 месяца.";
</script>


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