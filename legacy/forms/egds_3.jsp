<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title" align="center">Фиброэзофагогастродуоденоскопия</H3>
<b>Пищевод:</b><br>
<%=r.get("pish")%><br>
<SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.pish.value == "") document.protocol.pish.value = "Пищевод свободно проходим, просвет его обычный, стенки эластичны, складки продольные, слизистая на всем протяжении бледнорозовая, кардия периодически зияет, смыкается полностью.";
</script>

<b>Желудок:</b><br>
<%=r.get("jelud")%><br>
<SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.jelud.value == "") document.protocol.jelud.value = "Желудок обычных размеров, формы, натощак содержит небольшое количество пенистой слизи, стенки эластичны, хорошо расправляются при инсуффляции воздуха, складчатость сохранена, складки извиты, умеренной высоты, перистальтика прослеживается во всех отделах, умеренная, слизистая в теле, антральном отделе умеренно пятнисто гиперемирована, сосудистый рисунок прослеживается, привратник свободно проходим, смыкается полностью. Уреазный тест(Хелпил-тест) на Helicobactep pylori-";
</script>

<b>Двенадцатиперстная кишка:</b><br>
<%=r.get("kish")%><br>
<SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.kish.value == "") document.protocol.kish.value = "Луковица ДПК округлой формы, складки циркулярные, слизистая умеренно гиперемирована, в постбульбарном отделе умеренное количество пенистой слизи, просвет овальный, складки циркулярные, умеренной высоты, слизистая легко гиперемирована, дистальнее БДС полукруглой формы, на широком основании, слизистая над ним не изменена.";
</script>

<b>Заключение:</b><br>
<%=r.get("zakl")%><br>
<SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.zakl.value == "") document.protocol.zakl.value = "Рекомендовано: Консультация гастроэнтеролога. Эндоскопический контроль. Исследование выполнено на аппарате Olympus GIF - V70";
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