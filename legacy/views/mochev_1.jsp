<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>
Форма мочевого пузыря <%=r.get("forma_"+count)%>.<br>
<%if(!r.empty("mocha_how_"+count)){%>Содержит <%=r.get("mocha_how_"+count)%>.<br><%}%>
Содержимое <%=r.get("soder_"+count)%>.<br>
<%if(!r.empty("stenka_how_"+count) || !r.empty("otch_"+count) || !r.empty("vnutr_"+count)){%>Стенка
    <%if(!r.empty("stenka_how_"+count)){%> <%=r.get("stenka_how_"+count)%> мм.<%}%>
    <%if(!r.empty("otch_"+count)){%> <%=r.get("otch_"+count)%><%}%>
    <%if(!r.empty("vnutr_"+count)){%> <%=r.get("vnutr_"+count)%><%}%>
.<br><%}%>
В полости <%=r.get("polost_"+count)%><%if(!r.empty("polost_how_"+count)){%> <%=r.get("polost_how_"+count)%> мм<%}%>.
<%if(!r.empty("sod_"+count) || !r.empty("ostat_"+count)){%><br>После микции
    <%if(!r.empty("sod_how_"+count)){%> <%=r.get("sod_how_"+count)%><%}%>
    <%if(!r.empty("sod_"+count)){%> <%=r.get("sod_"+count)%><%}%>
    <%if(!r.empty("ostat_"+count)){%> <%=r.get("ostat_"+count)%><%}%>
.<%}%>
<%if(!r.empty("addition_" + count)){%><br><b>Дополнительные признаки:</b> <%=r.get("addition_" + count)%><%}%>
<br><b>Ультразвуковая картина характерна для:</b> <%=r.get("decision_" + count)%> <%=r.get("decision_text_" + count)%><br>
