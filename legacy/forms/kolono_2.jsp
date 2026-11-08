<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title" align="center">Фиброколоноскопия</H3>

<b>Прямая кишка:</b><br>
<%=r.get("col_rect")%><br>
<SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.col_rect.value == "") document.protocol.col_rect.value = "тонус сфинктера сохранен, ампула свободна, стенки эластичны, хорошо расправляются при инсуффляции воздухом, слизистая умеренно гиперемирована, сосудистый рисунок умеренно выражен";
</script>

<b>Сигмовидная кишка:</b><br>
<%=r.get("s_roman")%><br>
<SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.s_roman.value == "") document.protocol.s_roman.value = "просвет овальный, стенки эластичны, складки полулулнной формы умеренной высоты, слизистая умеренно гиперемирована, сосудистый рисунок размыт, в просвете небольшое количество мутной жидкости, перистальтика прослеживается. Далее уплощение складки(сфинктер Балли)";
</script>

<b>Нисходящая кишка:</b><br>
<%=r.get("col_desc")%><br>
<SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.col_desc.value == "") document.protocol.col_desc.value = "просвет треугольный, стенки эластичны, складчатость сохранена, складки умеренной высоты, слизистая умеренно гиперемирована, сосудистый рисунок смазан, перистальтика прослеживается, в просвете небольшое количество мутной жидкости, дистальнее изгиб образует карман(сфинктер Пайра), пройден вслепую";
</script>

<b>Поперечно-ободочная кишка:</b><br>
<%=r.get("col_transv")%><br>
<SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.col_transv.value == "") document.protocol.col_transv.value = "просвет в форме равностороннего треугольника, в просвете небольшое количество мутной жидкости, слизистая легко гиперемирована, гладкая, блестящая, сосудистый рисунок умеренно выражен, складки умеренной высоты, перистальтика прослеживается, в области печеночного угла видна печеночная синева стенки кишки, в этом месте складки циркулярно отчетливо выражены, просвет кишки в этой области сужен (сфинктер Кеннона)";
</script>

<b>Восходящая кишка:</b><br>
<%=r.get("col_ascend")%><br>
<SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.col_ascend.value == "") document.protocol.col_ascend.value = "просвет её треугольный, видны брыжеечная и сальниковая тении, складки высокие, морщинистые, слизистая умеренно гиперемирована, сосудистый рисунок хорошо выражен, в просвете небольшое количество мутной жидкости, просвет постепенно расширяется к слепой кишке";
</script>

<b>Слепая кишка:</b><br>
<%=r.get("cecum")%><br>
<SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.cecum.value == "") document.protocol.cecum.value = "в форме мешка со сходящимися тениями, слизистая умеренно пятнисто гиперемирована, сосудистый рисунок хорошо выражен, баугиниевая заслонка губовидной формы, признаков её недостаточности нет";
</script>

<b>Заключение:</b><br>
<%=r.get("zakl")%><br>

<SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.zakl.value == "") document.protocol.zakl.value = "Рекомендовано: консультация гастроэнтеролога. Исследование выполнено на аппарате Оlympus CF type EL";
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