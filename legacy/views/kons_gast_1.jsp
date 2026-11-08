<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>

<%if(!r.empty("jalob_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_jalob_<%=count%>" onClick="hiddenField('div_jalob_<%=count%>.style', 'menu.hidden_jalob_<%=count%>');" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать Жалобы" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_jalob_<%=count%>" style="display:;position:relative; left:0;">
        <b>Жалобы:</b> <%=r.get("jalob_"+count)%>
    </div>
<%}%>
<%if(!r.empty("morbi_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_morbi_<%=count%>" onClick="hiddenField('div_morbi_<%=count%>.style', 'menu.hidden_morbi_<%=count%>');" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать Anamnesis morbi" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_morbi_<%=count%>" style="display:;position:relative; left:0;">
        <b>Anamnesis morbi:</b> <%=r.get("morbi_"+count)%>
    </div>
<%}%>
<%if(!r.empty("vitae_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_vitae_<%=count%>" onClick="hiddenField('div_vitae_<%=count%>.style', 'menu.hidden_vitae_<%=count%>');" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать Anamnesis vitae" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_vitae_<%=count%>" style="display:;position:relative; left:0;">
        <b>Anamnesis vitae:</b> <%=r.get("vitae_"+count)%>
    </div>
<%}%>
<%if(!r.empty("praesens_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_praesens_<%=count%>" onClick="hiddenField('div_praesens_<%=count%>.style', 'menu.hidden_praesens_<%=count%>');" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать Status praesens" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_praesens_<%=count%>" style="display:;position:relative; left:0;">
        <b>Status praesens:</b> <%=r.get("praesens_"+count)%>
    </div>
<%}%>
<%if(!r.empty("data_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_data_<%=count%>" onClick="hiddenField('div_data_<%=count%>.style', 'menu.hidden_data_<%=count%>');" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать Данные предварительного исследования" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_data_<%=count%>" style="display:;position:relative; left:0;">
        <b>Данные предварительного исследования:</b> <%=r.get("data_"+count)%>
    </div>
<%}%>
<%if(!r.empty("pred_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_pred_<%=count%>" onClick="hiddenField('div_pred_<%=count%>.style', 'menu.hidden_pred_<%=count%>');" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать Диагноз основной" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_pred_<%=count%>" style="display:;position:relative; left:0;">
        <b>Диагноз основной:</b> <%=r.get("pred_"+count)%>
    </div>
<%}%>
<%if(!r.empty("soput_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_soput_<%=count%>" onClick="hiddenField('div_soput_<%=count%>.style', 'menu.hidden_soput_<%=count%>');" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать Сопутствующие заболевания" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_soput_<%=count%>" style="display:;position:relative; left:0;">
        <b>Сопутствующие заболевания:</b> <%=r.get("soput_"+count)%>
    </div>
<%}%>

<%if(!r.empty("obsled_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_obsled_<%=count%>" onClick="hiddenField('div_obsled_<%=count%>.style', 'menu.hidden_obsled_<%=count%>');" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать Направлен на обследование" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_obsled_<%=count%>" style="display:;position:relative; left:0;">
        <b>Направлен на обследование:</b> <%=r.get("obsled_"+count)%>
    </div>
<%}%>

<%if(!r.empty("rekomend_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_rekomend_<%=count%>" onClick="hiddenField('div_rekomend_<%=count%>.style', 'menu.hidden_rekomend_<%=count%>');" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать Рекомендации" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_rekomend_<%=count%>" style="display:;position:relative; left:0;">
        <b>Рекомендации:</b> <%=r.get("rekomend_"+count)%>
    </div>
<%}%>
