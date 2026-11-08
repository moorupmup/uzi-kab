<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String pss="false";
String kds="false";
String ir="false";%>
<%String count=r.get("count").toString();%>
<br>

<br><b>Поджелудочная железа</b> <%=r.get("jelez_"+count)%>.
<%if(!r.empty("golov_"+count) || !r.empty("telo_"+count) || !r.empty("hvost_"+count)){%>Размеры:<%if(!r.empty("golov_"+count)){%> головка <%=r.get("golov_"+count)%> мм<%}%><%if(!r.empty("telo_"+count)){%> тело <%=r.get("telo_"+count)%> мм<%}%><%if(!r.empty("hvost_"+count)){%> хвост <%=r.get("hvost_"+count)%> мм<%}%>.<%}%>
Контур <%=r.get("kontur_jel_"+count)%>.
Структура <%=r.get("strukt_jel_"+count)%>.
Эхогенность <%=r.get("ehog_"+count)%>.
Вирсунгов проток <%=r.get("prot_"+count)%><%if(!r.empty("rash_"+count)){%> до <%=r.get("rash_"+count)%> мм<%}%>.
<%if(!r.empty("diam_selez_"+count)){%>Диаметр селезеночной вены <%=r.get("diam_selez_"+count)%> мм.<%}%>

<%if(!r.empty("addition_" + count)){%><br><b>Дополнительные признаки:</b> <%=r.get("addition_" + count)%><%}%>
<br><b>Ультразвуковая картина характерна для:</b> <%=r.get("decision_" + count)%> <%=r.get("decision_text_" + count)%><br>
