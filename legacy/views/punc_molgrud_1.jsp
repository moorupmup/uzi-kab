<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>
<br>
<%if(!r.empty("den_"+count)){%>День цикла <%=r.get("den_"+count)%>.<br><%}%>
Кожный покров <%=r.get("pokrov_"+count)%><%if(!r.empty("pokrov_how_"+count)){%> <%=r.get("pokrov_how_"+count)%> мм<%}%>.<br>
Область соска <%=r.get("sosok_"+count)%>.<br>
Молочные железы представлены <%=r.get("jeleza_"+count)%>.<br>
Паренхима <%=r.get("parenhima_"+count)%>.<br>
Млечные протоки <%=r.get("protoki_"+count)%><%if(!r.empty("protoki_how_"+count)){%> <%=r.get("protoki_how_"+count)%> мм<%}%>.<br>
Региональные лимфатические узлы <%=r.get("limf_"+count)%><%if(!r.empty("limf_how_"+count)){%> до <%=r.get("limf_how_"+count)%> мм<%}%>.<br>
Соединительная ткань <%=r.get("tkani_"+count)%>.
<%if(!r.empty("addition_" + count)){%><br><b>Дополнительные признаки:</b> <%=r.get("addition_" + count)%><%}%>
<br><b>Ультразвуковая картина характерна для:</b> <%=r.get("decision_" + count)%> <%=r.get("decision_text_" + count)%><br>
