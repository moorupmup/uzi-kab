<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title" align="center">Колоноскопия</H3>

<b>Col.Rect:</b><br>
<%=r.get("col_rect")%><br>
<SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.col_rect.value == "") document.protocol.col_rect.value = "размеры обычные, складки продольные с выраженной сосудистой сетью. Слизистая светлорозового цвета. Хаустоновская заслонка острая.";
</script>

<b>S-roman:</b><br>
<%=r.get("s_roman")%><br>
<SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.s_roman.value == "") document.protocol.s_roman.value = "просвет овальной формы. Складки полулунные в нижней 13, в ср3 высокие, в н3 - циркулярные высокие. Слизистая сочная, бледнорозовая, сосуды размыты.";
</script>

<b>Col.desc:</b><br>
<%=r.get("col_desc")%><br>
<SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.col_desc.value == "") document.protocol.col_desc.value = "просвет треугольной формы с закругленными углами. Видна брыжеечная тения. Слизистая белесоватая, гладкая, блестящая. Видны подслизистые сосуды.";
</script>

<b>Col.transv:</b><br>
<%=r.get("col_transv")%><br>
<SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.col_transv.value == "") document.protocol.col_transv.value = "просвет треугольной формы. Слизистая жемчужно-белого цвета, блестящая, гладкая, видны сосуды.";
</script>

<b>Col.ascend:</b><br>
<%=r.get("col_ascend")%><br>
<SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.col_ascend.value == "") document.protocol.col_ascend.value = "просвет в виде приплюснутого треугольника, слизистая пятнисто гиперемирована, яркорозового цвета. Складки морщинистые, высокие.";
</script>

<b>Cecum:</b><br>
<%=r.get("cecum")%><br>
<SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.cecum.value == "") document.protocol.cecum.value = "в форме мешка с тремя сходящимися тениями. Слизистая оболочка белесоватая, с отчетливым рисунком сосудов.";
</script>

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