<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>
<%=r.get("opis_" + count)%>
<br><b>Заключение:</b> <%=r.get("decision_" + count)%> <%=r.get("decision_text_" + count)%>
<%if(!r.empty("addition_" + count)){%><br><b>Дополнительные замечания:</b> <%=r.get("addition_" + count)%><%}%><br>

