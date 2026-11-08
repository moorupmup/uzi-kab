<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>


Выполнен рентген: <b><%=r.get("vipolll_"+count)%></b>
<br>

<%if(!r.empty("jalob_"+count)){%><br>
    <b>ЖАЛОБЫ:</b> <%=r.get("jalob_"+count)%>
<%}%>
<%if(!r.empty("komment_"+count)){%><br>
        <b>КОММЕНТАРИИ:</b> <%=r.get("komment_"+count)%>
<%}%>
<%if(!r.empty("zakl_"+count)){%><br>
        <b>ЗАКЛЮЧЕНИЕ:</b> <%=r.get("zakl_"+count)%>
<%}%>
<%if(!r.empty("rekomen_"+count)){%><br>
        <b>РЕКОМЕНДАЦИИ:</b> <%=r.get("rekomen_"+count)%>
<%}%>
<br><br>
Рентгенлаборант: <%=r.get("labor_"+count)%>
<br>
