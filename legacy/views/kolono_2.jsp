<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>

<%if(!r.empty("col_rect_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_col_rect_<%=count%>" onClick="hiddenField('div_col_rect_<%=count%>.style', 'menu.hidden_col_rect_<%=count%>');" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать Col.Rect" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_col_rect_<%=count%>" style="display:;position:relative; left:0;">
        <b>Прямая кишка:</b> <%=r.get("col_rect_"+count)%>
    </div>
<%}%>
<%if(!r.empty("s_roman_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_s_roman_<%=count%>" onClick="hiddenField('div_s_roman_<%=count%>.style', 'menu.hidden_s_roman_<%=count%>');" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать S-roman" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_s_roman_<%=count%>" style="display:;position:relative; left:0;">
        <b>Сигмовидная кишка:</b> <%=r.get("s_roman_"+count)%>
    </div>
<%}%>
<%if(!r.empty("col_desc_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_col_desc_<%=count%>" onClick="hiddenField('div_col_desc_<%=count%>.style', 'menu.hidden_col_desc_<%=count%>');" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать Col.desc" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_col_desc_<%=count%>" style="display:;position:relative; left:0;">
        <b>Нисходящая кишка:</b> <%=r.get("col_desc_"+count)%>
    </div>
<%}%>
<%if(!r.empty("col_transv_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_col_transv_<%=count%>" onClick="hiddenField('div_col_transv_<%=count%>.style', 'menu.hidden_col_transv_<%=count%>');" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать Col.transv" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_col_transv_<%=count%>" style="display:;position:relative; left:0;">
        <b>Поперечно-ободочная кишка:</b> <%=r.get("col_transv_"+count)%>
    </div>
<%}%>
<%if(!r.empty("col_ascend_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_col_ascend_<%=count%>" onClick="hiddenField('div_col_ascend_<%=count%>.style', 'menu.hidden_col_ascend_<%=count%>');" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать Col.ascend" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_col_ascend_<%=count%>" style="display:;position:relative; left:0;">
        <b>Восходящая кишка:</b> <%=r.get("col_ascend_"+count)%>
    </div>
<%}%>
<%if(!r.empty("cecum_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_cecum_<%=count%>" onClick="hiddenField('div_cecum_<%=count%>.style', 'menu.hidden_cecum_<%=count%>');" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать Cecum" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_cecum_<%=count%>" style="display:;position:relative; left:0;">
        <b>Слепая кишка:</b> <%=r.get("cecum_"+count)%>
    </div>
<%}%>
<%if(!r.empty("zakl_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_zakl_<%=count%>" onClick="hiddenField('div_zakl_<%=count%>.style', 'menu.hidden_zakl_<%=count%>');" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать Заключение" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_zakl_<%=count%>" style="display:;position:relative; left:0;">
        <b>Заключение:</b> <%=r.get("zakl_"+count)%>
    </div>
<%}%>
