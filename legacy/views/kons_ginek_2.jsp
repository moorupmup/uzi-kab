<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>


<br>
<%if(!r.empty("jalob_"+count)){%><br>
    <input id="remove" type="checkbox" name="hidden_jalob_<%=count%>" onClick="hiddenField('div_jalob_<%=count%>.style', 'menu.hidden_jalob_<%=count%>');" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать Жалобы" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_jalob_<%=count%>" style="display:;position:relative; left:0;">
        <b>Жалобы:</b> <%=r.get("jalob_"+count)%>
     </div>
<%}%>


<%if(!r.empty("morbi_"+count)){%><br>
    <input id="remove" type="checkbox" name="hidden_morbi_<%=count%>" onClick="hiddenField('div_morbi_<%=count%>.style', 'menu.hidden_morbi_<%=count%>');" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать Anamnesis morbi" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_morbi_<%=count%>" style="display:;position:relative; left:0;">
        <b>Anamnesis morbi:</b> <%=r.get("morbi_"+count)%>
     </div>
<%}%>

<%if(!r.empty("vitae_"+count)){%><br>
    <input id="remove" type="checkbox" name="hidden_vitae_<%=count%>" onClick="hiddenField('div_vitae_<%=count%>.style', 'menu.hidden_vitae_<%=count%>');" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать Anamnesis vitae" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_vitae_<%=count%>" style="display:;position:relative; left:0;">
        <b>Anamnesis vitae:</b> <%=r.get("vitae_"+count)%>
     </div>
<%}%>

<%if(!r.empty("status_o_"+count)){%><br>
    <input id="remove" type="checkbox" name="hidden_status_o_<%=count%>" onClick="hiddenField('div_status_o_<%=count%>.style', 'menu.hidden_status_o_<%=count%>');" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать Общий статус" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_status_o_<%=count%>" style="display:;position:relative; left:0;">
        <b>Общий статус:</b> <%=r.get("status_o_"+count)%>
     </div>
<%}%>

<%if(!r.empty("status_l_"+count)){%><br>
    <input id="remove" type="checkbox" name="hidden_status_l_<%=count%>" onClick="hiddenField('div_status_l_<%=count%>.style', 'menu.hidden_status_l_<%=count%>');" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать Локальный статус" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_status_l_<%=count%>" style="display:;position:relative; left:0;">
        <b>Status genitalis:</b> <%=r.get("status_l_"+count)%>
     </div>
<%}%>

<%if(!r.empty("pred_iss_"+count)){%><br>
    <input id="remove" type="checkbox" name="hidden_pred_iss_<%=count%>" onClick="hiddenField('div_pred_iss_<%=count%>.style', 'menu.hidden_pred_iss_<%=count%>');" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать Данные предварительного исследования" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_pred_iss_<%=count%>" style="display:;position:relative; left:0;">
        <b>Данные предварительного исследования:</b> <%=r.get("pred_iss_"+count)%>
     </div>
<%}%>

<%if(!r.empty("diag_"+count)){%><br>
    <input id="remove" type="checkbox" name="hidden_diag_<%=count%>" onClick="hiddenField('div_diag_<%=count%>.style', 'menu.hidden_diag_<%=count%>');" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать Диагноз основной" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_diag_<%=count%>" style="display:;position:relative; left:0;">
        <b>Диагноз основной:</b> <%=r.get("diag_"+count)%>
     </div>
<%}%>

<%if(!r.empty("soput_"+count)){%><br>
    <input id="remove" type="checkbox" name="hidden_soput_<%=count%>" onClick="hiddenField('div_soput_<%=count%>.style', 'menu.hidden_soput_<%=count%>');" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать Сопутствующие зоболевания" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_soput_<%=count%>" style="display:;position:relative; left:0;">
        <b>Сопутствующие зоболевания:</b> <%=r.get("soput_"+count)%>
     </div>
<%}%>

<%if(!r.empty("obsled_"+count)){%><br>
    <input id="remove" type="checkbox" name="hidden_obsled_<%=count%>" onClick="hiddenField('div_obsled_<%=count%>.style', 'menu.hidden_obsled_<%=count%>');" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать Направлен на обследование" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_obsled_<%=count%>" style="display:;position:relative; left:0;">
        <b>Направлен на обследование:</b> <%=r.get("obsled_"+count)%>
     </div>
<%}%>

<%if(!r.empty("rekomend_"+count)){%><br>
    <input id="remove" type="checkbox" name="hidden_rekomend_<%=count%>" onClick="hiddenField('div_rekomend_<%=count%>.style', 'menu.hidden_rekomend_<%=count%>');" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать Рекомендации" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_rekomend_<%=count%>" style="display:;position:relative; left:0;">
        <b>Рекомендации:</b> <%=r.get("rekomend_"+count)%>
     </div>
<%}%>

<br>


