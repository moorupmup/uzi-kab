<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>

<%if(!r.empty("micro_"+count)){%>
        <b>Микроскопическое описание:</b> <%=r.get("micro_"+count)%><br>
<%}%>
<%if(!r.empty("zakl_"+count)){%>
        <b>Заключение:</b> <%=r.get("zakl_"+count)%><br>
<%}%>
<%if(!r.empty("dopol_"+count)){%>
        <b>Дополнительные замечания:</b> <%=r.get("dopol_"+count)%><br>
<%}%>
