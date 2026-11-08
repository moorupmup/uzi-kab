<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>

<br>
<%if(!r.empty("jalob_"+count)){%>
        <b>Жалобы:</b> <%=r.get("jalob_"+count)%><br>
<%}%> <br>
<%if(!r.empty("morbi_"+count)){%>
        <b>Anamnesis morbi:</b> <%=r.get("morbi_"+count)%><br>
<%}%>
<%if(!r.empty("vitae_"+count)){%> <br>
        <b>Anamnesis vitae:</b> <%=r.get("vitae_"+count)%><br>
<%}%>
<%if(!r.empty("jalob_po_"+count)){%>  <br>
        <b>Жалобы с посистемным уточнением:</b> <%=r.get("jalob_po_"+count)%><br>
<%}%>
<%if(!r.empty("status_"+count)){%> <br>
        <b>Status praesens:</b> <%=r.get("status_"+count)%><br>
<%}%>
<%if(!r.empty("pred_"+count)){%>   <br>
        <b>Диагноз:</b> <%=r.get("pred_"+count)%><br>
<%}%>
<%if(!r.empty("rekomend_"+count)){%>  <br>
        <b>Рекомендации:</b> <%=r.get("rekomend_"+count)%><br>
<%}%>   <br>


