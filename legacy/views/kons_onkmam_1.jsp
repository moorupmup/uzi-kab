<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>

<%if(!r.empty("jalob_"+count)){%>
        <b>Жалобы:</b> <%=r.get("jalob_"+count)%><br>
<%}%>
<%if(!r.empty("morbi_"+count)){%>
        <b>Anamnesis vitae:</b> <%=r.get("morbi_"+count)%><br>
<%}%>
<%if(!r.empty("vitae_"+count)){%>
        <b>Данные предварительного обследования:</b> <%=r.get("vitae_"+count)%><br>
<%}%>
<%if(!r.empty("status_"+count)){%>
        <b>Объективно:</b> <%=r.get("status_"+count)%><br>
<%}%>

<%if(!r.empty("status_"+count)){%>
        <b>Сопутствующие патологии:</b> <%=r.get("soput_"+count)%><br>
<%}%>

<%if(!r.empty("status_"+count)){%>
        <b>Осложнения:</b> <%=r.get("oslog_"+count)%><br>
<%}%>







<%if(!r.empty("pred_"+count)){%>
        <b>Диагноз:</b> <%=r.get("pred_"+count)%><br>
<%}%>
<%if(!r.empty("rekomend_"+count)){%>
        <b>Рекомендации:</b> <%=r.get("rekomend_"+count)%><br>
<%}%>


<%if(!r.empty("lech_"+count)){%>
        <b>Лечение:</b> <%=r.get("lech_"+count)%><br>
<%}%>