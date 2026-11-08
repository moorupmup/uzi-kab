<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>



<H3 class="p_title" align="center">Операция: Диагностическая гистероскопия. Выскабливание цервикального канала и полости матки</H3>



Показания:<br>
<%=r.get("pokaz")%><br>


Обезболивание:<br>
<%=r.get("obezb")%><br>


Описание:<br>
<%=r.get("opis")%><br>
<SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.opis.value == "") document.protocol.opis.value = "В асептических условиях после соответствубщей обработки шейка фиксирована пулевыми щипцами. Выполнено зондирование полости матки. L=    см. Расширителями Гегара выполнено расширение цервикального канала до №5,0. Введен гистероскоп, эндоцервикс не изменён. Полость матки правильной формы. Эндометрий выражен равномерно, обычного цвета. Кюреткой №2,1 выполнено диагностическое выскабливание цервикального канала и полости матки. - на гистологию. В удовлетворительном состоянии пациентка переведена в палату.";
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
