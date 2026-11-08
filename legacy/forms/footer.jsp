<b>Комментарии:</b><br>
<%=r.get("addition")%>
<br>
<b>Заключительный диагноз:</b><br>
<%=r.get("decision")%><br>
<%=r.get("decision2")%>
<br>
Врач:<%=r.get("doctor_fio")%><br>
<input type="hidden" name="from_doctor_id" value="0">
<br>
<table width="100%" border="0">
    <tr>
        <td><input type="button" value="Просмотр" onFocus="if (check_decision()) submit();">
        <input type="button" value="Отмена" onClick="document.protocol.pacient_id.value = ''; setAction('main_menu'); submit();"></td>
        
    </tr>
</table>
<Script>
  function check_decision()
  {
    if (document.all.decision_id_bookfield.value == "" || document.all.decision_id.value == "") { 
       window.alert("Не задано заключение, либо заключение взято не из справочника. В поле заключительный диагноз, в узком поле, нажмите клавишу Enter.");
       return (false);
       }
    else return (true);
  }
</Script>
<form>
<%@include file="../footer.jsp"%>
