<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>

<H3 class="p_title" align="center">Анализ отделяемого</H3>
<table width="100%" border="1">
    <tr><td colspan="4">Дата забора <%=r.getTextInput("data")%></td></tr>
	<SCRIPT LANGUAGE="JavaScript">
            document.protocol.data.focus();
        </script>

    <tr><td colspan="4">&nbsp;</td></tr>
    <tr><td colspan="4" align="center">
	<b>Анализ отделяемого № <%=r.getSizeInput("nomer")%> гр-ки <%=r.getTextInput("gr_ki")%></b>
        </td>
    </tr>
    <tr><td width="40%">Реакция отделяемого</td> 
        <td width="20%"> Уретры</td> 
        <td width="20%"> Шейки матки</td> 
        <td>Вагины</td> 
    </tr>
    <tr><td>Гнойные клетки</td>
        <td> <%=r.getTextInput("gnoi_yr")%></td> 
        <td> <%=r.getTextInput("gnoi_sh")%></td> 
        <td> <%=r.getTextInput("gnoi_vg")%></td> 
    </tr>
    <tr><td>Лейкоциты</td>
        <td> <%=r.getTextInput("leik_yr")%></td> 
        <td> <%=r.getTextInput("leik_sh")%></td> 
        <td> <%=r.getTextInput("leik_vg")%></td> 
    </tr>

    <tr><td>Эритроциты</td>
        <td> <%=r.getTextInput("eret_yr")%></td> 
        <td> <%=r.getTextInput("eret_sh")%></td> 
        <td> <%=r.getTextInput("eret_vg")%></td> 
    </tr>

    <tr><td>Клетки пл. эпителий</td>
        <td> <%=r.getTextInput("klet_yr")%></td> 
        <td> <%=r.getTextInput("klet_sh")%></td> 
        <td> <%=r.getTextInput("klet_vg")%></td> 
    </tr>

    <tr><td>Слизь</td>
        <td> <%=r.getTextInput("sliz_yr")%></td> 
        <td> <%=r.getTextInput("sliz_sh")%></td> 
        <td> <%=r.getTextInput("sliz_vg")%></td> 
    </tr>

    <tr><td>Гонок. Нейсера</td>
        <td> <%=r.getTextInput("neis_yr")%></td> 
        <td> <%=r.getTextInput("neis_sh")%></td> 
        <td> <%=r.getTextInput("neis_vg")%></td> 
    </tr>

    <tr><td>Трихомонады</td>
        <td> <%=r.getTextInput("trih_yr")%></td> 
        <td> <%=r.getTextInput("trih_sh")%></td> 
        <td> <%=r.getTextInput("trih_vg")%></td> 
    </tr>

    <tr><td>Др. кокков и диплокок. форм</td>
        <td> <%=r.getTextInput("koki_yr")%></td> 
        <td> <%=r.getTextInput("koki_sh")%></td> 
        <td> <%=r.getTextInput("koki_vg")%></td> 
    </tr>
 
    <tr><td>Пл. Додерлейна</td>
        <td> <%=r.getTextInput("dodr_yr")%></td> 
        <td> <%=r.getTextInput("dodr_sh")%></td> 
        <td> <%=r.getTextInput("dodr_vg")%></td> 
    </tr>
	
</table>
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
