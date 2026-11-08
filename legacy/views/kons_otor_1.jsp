<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>

<%if(!r.empty("jalob_"+count)){%>
        <b>Жалобы:</b> <%=r.get("jalob_"+count)%><br>
<%}%>
<%if(!r.empty("morbi_"+count)){%>
        <b>Anamnesis morbi:</b> <%=r.get("morbi_"+count)%><br>
<%}%>
<%if(!r.empty("vitae_"+count)){%>
        <b>Anamnesis vitae:</b> <%=r.get("vitae_"+count)%><br>
<%}%>
<%if(!r.empty("obekt_"+count)){%>
        <b>Объективно:</b> <%=r.get("obekt_"+count)%><br>
<%}%>
<%if(!r.empty("status_"+count)){%>
        <b>Лорстатус:</b> <%=r.get("status_"+count)%><br>
<%}%>
<%if(!r.empty("oper_"+count)){%>
        <b>Операция:</b> <%=r.get("oper_"+count)%><br>
<%}%>
<%if(!r.empty("obsled_"+count)){%>
        <b>Обследование:</b> <%=r.get("obsled_"+count)%><br>
<%}%>
<%if(!r.empty("pred_"+count)){%>
        <b>Диагноз:</b> <%=r.get("pred_"+count)%><br>
<%}%>
<%if(!r.empty("rekomend_"+count)){%>
        <b>Рекомендации:</b> <%=r.get("rekomend_"+count)%><br>
<%}%>

