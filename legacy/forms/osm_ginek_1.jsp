<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>



<H3 class="p_title" align="center">ОСМОТР ГИНЕКОЛОГА</H3>



Жалобы:<br>
<%=r.get("jalob")%><br>

Месячные с  <%=r.getSizeInput("ssss")%> по <%=r.getSizeInput("pooo")%> дн., через <%=r.getSizeInput("cher")%> дн.
<br>Беременностей <%=r.getSizeInput("berem")%> роды <%=r.getSizeInput("rodi")%> аборты <%=r.getSizeInput("abort")%>   <%=r.getTextInput("disp_text")%>

<br>


Гинекологические заболевания<br>
<%=r.get("ginek")%><br>

Контрацепция<br>
<%=r.get("kontr")%><br>

Гин.осмотр:шейка матки:<br>
<%=r.get("gin_text")%><br>

Матка<br>  <%=r.get("mat_text")%>
<br>
Придатки <br> <%=r.get("pri_text")%>
<br>
Выделения <br>  <%=r.get("vid_text")%>
<br>
Молочные железы <br>  <%=r.get("mol_text")%>
<br>
Взят мазок на: <br><%=r.getSelect("mazo")%>
<br>



Диагноз:<br>
<%=r.get("dsss")%><br>
<SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.dsss.value == "") document.protocol.dsss.value = "здорова";
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
