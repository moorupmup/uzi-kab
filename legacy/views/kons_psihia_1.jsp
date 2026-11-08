<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>
    <br>
Добровольное информированное согласие пациента(его законного представителя) на проведение консультации получено.
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
        <b>Анамнез жизни:</b> <%=r.get("morbi_"+count)%>
    </div>
<%}%>
<%if(!r.empty("vitae_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_vitae_<%=count%>" onClick="hiddenField('div_vitae_<%=count%>.style', 'menu.hidden_vitae_<%=count%>');" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать Anamnesis vitae" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_vitae_<%=count%>" style="display:;position:relative; left:0;">
        <b>Анамнез заболевания:</b> <%=r.get("vitae_"+count)%>
    </div>
<%}%>
<%if(!r.empty("status_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_status_<%=count%>" onClick="hiddenField('div_status_<%=count%>.style', 'menu.hidden_status_<%=count%>');" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать Психический статус" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_status_<%=count%>" style="display:;position:relative; left:0;">
        <b>Психический статус:</b> <%=r.get("status_"+count)%>
    </div>
<%}%>
<%if(!r.empty("pred_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_pred_<%=count%>" onClick="hiddenField('div_pred_<%=count%>.style', 'menu.hidden_pred_<%=count%>');" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать Заключение" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_pred_<%=count%>" style="display:;position:relative; left:0;">
        <b>Диагноз:</b> <%=r.get("pred_"+count)%>
    </div>
<%}%>

<%if(!r.empty("rekomend_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_rekomend_<%=count%>" onClick="hiddenField('div_rekomend_<%=count%>.style', 'menu.hidden_rekomend_<%=count%>');" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать Рекомендации" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_rekomend_<%=count%>" style="display:;position:relative; left:0;">
        <b>Рекомендации:</b> <%=r.get("rekomend_"+count)%>
    </div>
<%}%>
<br> Добровольное информированное согласие пациента(его законного представителя)________________________________________на назначение лечения и размещения информации о психическом состоянии здоровья в амбулаторной карте получено________. <br>
