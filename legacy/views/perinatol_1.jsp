<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>
<%if(!r.empty("jalob_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_jaloby_<%=count%>" onClick="hiddenField('div_jaloby_<%=count%>.style', 'menu.hidden_jaloby_<%=count%>')" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать жалобы" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_jaloby_<%=count%>" style="display:;position:relative; left:12;">
    <b>∆алобы</b>
        <%=r.get("jaloby_"+count)%>
    </div>
<%}%>
<%if(!r.empty("vitae_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_vitae_<%=count%>" onClick="hiddenField('div_vitae_<%=count%>.style', 'menu.hidden_vitae_<%=count%>')" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать AN. VITAE(норма)" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_vitae_<%=count%>" style="display:;position:relative; left:12;">
    <b>AN. VITAE(норма)</b>
        <%=r.get("vitae_"+count)%>
    </div>
<%}%>
<%if(!r.empty("vitaepat_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_vitaepat_<%=count%>" onClick="hiddenField('div_vitaepat_<%=count%>.style', 'menu.hidden_vitaepat_<%=count%>')" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать AN. VITAE(патологи€)" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_vitaepat_<%=count%>" style="display:;position:relative; left:12;">
    <b>AN. VITAE(патологи€)</b>
        <%=r.get("vitaepat_"+count)%>
    </div>
<%}%>
<%if(!r.empty("rod_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_rod_<%=count%>" onClick="hiddenField('div_rod_<%=count%>.style', 'menu.hidden_rod_<%=count%>')" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать родословную" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_rod_<%=count%>" style="display:;position:relative; left:12;">
    <b>–одословна€</b>
        <%=r.get("rod_"+count)%>
    </div>
<%}%>
<%if(!r.empty("anamnez_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_anamnez_<%=count%>" onClick="hiddenField('div_anamnez_<%=count%>.style', 'menu.hidden_anamnez_<%=count%>')" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать акушерский анамнез" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_anamnez_<%=count%>" style="display:;position:relative; left:12;">
    <b>јкушерский анамнез</b>
        <%=r.get("anamnez_"+count)%>
    </div>
<%}%>
<%if(!r.empty("paritet_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_paritet_<%=count%>" onClick="hiddenField('div_paritet_<%=count%>.style', 'menu.hidden_paritet_<%=count%>')" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать паритет" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_paritet_<%=count%>" style="display:;position:relative; left:12;">
    <b>ѕаритет</b>
        <%=r.get("paritet_"+count)%>
    </div>
<%}%>
<%if(!r.empty("berem_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_berem_<%=count%>" onClick="hiddenField('div_berem_<%=count%>.style', 'menu.hidden_berem_<%=count%>')" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать насто€щую беременность" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_berem_<%=count%>" style="display:;position:relative; left:12;">
    <b>Ќасто€ща€ беременность</b>
        <%=r.get("berem_"+count)%>
    </div>
<%}%>
<%if(!r.empty("praesens_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_praesens_<%=count%>" onClick="hiddenField('div_praesens_<%=count%>.style', 'menu.hidden_praesens_<%=count%>')" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать ST. PRAESENS" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_praesens_<%=count%>" style="display:;position:relative; left:12;">
    <b>ST. PRAESENS</b>
        <%=r.get("praesens_"+count)%>
    </div>
<%}%>
<%if(!r.empty("dop_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_dop_<%=count%>" onClick="hiddenField('div_dop_<%=count%>.style', 'menu.hidden_dop_<%=count%>')" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать дополнительные исследовани€" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_dop_<%=count%>" style="display:;position:relative; left:12;">
    <b>ƒополнительные исследовани€</b>
        <%=r.get("dop_"+count)%>
    </div>
<%}%>
<%if(!r.empty("diag_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_diag_<%=count%>" onClick="hiddenField('div_diag_<%=count%>.style', 'menu.hidden_diag_<%=count%>')" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать диагноз" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_diag_<%=count%>" style="display:;position:relative; left:12;">
    <b>ƒиагноз</b>
        <%=r.get("diag_"+count)%>
    </div>
<%}%>
<%if(!r.empty("preddiag_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_preddiag_<%=count%>" onClick="hiddenField('div_preddiag_<%=count%>.style', 'menu.hidden_preddiag_<%=count%>')" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать предварительный диагноз" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_preddiag_<%=count%>" style="display:;position:relative; left:12;">
    <b>ѕредварительный диагноз</b>
        <%=r.get("preddiag_"+count)%>
    </div>
<%}%>
<%if(!r.empty("decision_text_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_zakl_diagnoz_<%=count%>" onClick="hiddenField('div_zakl_diagnoz_<%=count%>.style', 'menu.hidden_zakl_diagnoz_<%=count%>');" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать «аключительный диагноз" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_zakl_diagnoz_<%=count%>" style="display:;position:relative; left:0;">
        <b>«аключительный диагноз:</b> <%=r.get("decision_text_"+count)%>
    </div>
<%}%>
<%if(!r.empty("rekomend_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_rekomend_<%=count%>" onClick="hiddenField('div_rekomend_<%=count%>.style', 'menu.hidden_rekomend_<%=count%>')" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать рекомендации" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_rekomend_<%=count%>" style="display:;position:relative; left:12;">
    <b>–екомендации</b>
        <%=r.get("rekomend_"+count)%>
    </div>
<%}%>
<%if(!r.empty("napravl_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_napravl_<%=count%>" onClick="hiddenField('div_napravl_<%=count%>.style', 'menu.hidden_napravl_<%=count%>')" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать направление на обследовани€" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_napravl_<%=count%>" style="display:;position:relative; left:12;">
    <b>Ќаправление на обследовани€</b>
        <%=r.get("napravl_"+count)%>
    </div>
<%}%>

