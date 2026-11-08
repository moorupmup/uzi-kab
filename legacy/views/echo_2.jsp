<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>
<%if(!r.empty("puzir_how_"+count)){%>Объём желчного пузыря <%=r.get("puzir_how_"+count)%> мл.<br><%}%>
Через <%=r.get("cherez_how_"+count)%> мин после приема  желчегонного завтрака: <%=r.get("zavtrak_"+count)%>.<br>
<b>Объем</b>
<%if(!r.empty("jelch_"+count)){%><br><%=r.get("jelch_"+count)%> <%if(!r.empty("jelch_how_"+count)){%><%=r.get("jelch_how_"+count)%> мл<%}%>.<%}%>
<%if(!r.empty("puzir_"+count)){%><br><%=r.get("puzir_"+count)%> <%=r.get("izm_"+count)%> <%if(!r.empty("izm_how_"+count)){%><%=r.get("izm_how_"+count)%> мл<%}%>.<%}%>
<%if(!r.empty("svid_"+count)){%><br><%=r.get("svid_"+count)%> <%=r.get("gip_"+count)%> сфинктеров желчевыводящих путей.<%}%>
<%if(!r.empty("harak_"+count)){%><br><%=r.get("harak_"+count)%> <%=r.get("disk_"+count)%> дискинезии.<%}%>
<%if(!r.empty("vozrost_"+count)){%><br><%=r.get("vozrost_"+count)%>.<%}%>
<%if(!r.empty("addition_" + count)){%><br><b>Дополнительные признаки:</b> <%=r.get("addition_" + count)%><%}%>
<br><b>Ультразвуковая картина характерна для:</b> <%=r.get("decision_" + count)%> <%=r.get("decision_text_" + count)%><br>
