<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>

<%if(!r.empty("pish_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_pish_<%=count%>" onClick="hiddenField('div_pish_<%=count%>.style', 'menu.hidden_pish_<%=count%>');" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать Пищевод" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_pish_<%=count%>" style="display:;position:relative; left:0;">
        <b>Пищевод:</b> <%=r.get("pish_"+count)%>
    </div>
<%}%>
<%if(!r.empty("jelud_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_jelud_<%=count%>" onClick="hiddenField('div_jelud_<%=count%>.style', 'menu.hidden_jelud_<%=count%>');" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать Желудок" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_jelud_<%=count%>" style="display:;position:relative; left:0;">
        <b>Желудок:</b> <%=r.get("jelud_"+count)%>
    </div>
<%}%>
<%if(!r.empty("kish_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_kish_<%=count%>" onClick="hiddenField('div_kish_<%=count%>.style', 'menu.hidden_kish_<%=count%>');" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать Двенадцатиперстная кишка" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_kish_<%=count%>" style="display:;position:relative; left:0;">
        <b>Двенадцатиперстная кишка:</b> <%=r.get("kish_"+count)%>
    </div>
<%}%>
<%if(!r.empty("zakl_"+count)){%>
    <input id="remove" type="checkbox" name="hidden_zakl_<%=count%>" onClick="hiddenField('div_zakl_<%=count%>.style', 'menu.hidden_zakl_<%=count%>');" checked>
    &nbsp;<input id="remove" type="text" size="55" value="печатать Заключение" disabled style="border-width : 0; background-color : transparent;">
    <div id="div_zakl_<%=count%>" style="display:;position:relative; left:0;">
        <b>Заключение:</b> <%=r.get("zakl_"+count)%>
    </div>
<%}%>
