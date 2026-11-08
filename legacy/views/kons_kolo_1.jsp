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
<%if(!r.empty("status_"+count)){%>
        <b>Status:</b> <%=r.get("status_"+count)%><br>
<%}%>
<%if(!r.empty("rectum_"+count)){%>
        <b>Per rectum:</b> <%=r.get("rectum_"+count)%><br>
<%}%>
<%if(!r.empty("roman_"+count)){%>
        <b>Ректороманоскопия:</b> <%=r.get("roman_"+count)%><br>
<%}%>
<%if(!r.empty("anos_"+count)){%>
        <b>Аноскопия:</b> <%=r.get("anos_"+count)%><br>
<%}%>
<%if(!r.empty("pred_"+count)){%>
        <b>Диагноз:</b> <%=r.get("pred_"+count)%><br>
<%}%>
<%if(!r.empty("manip_"+count)){%>
        <b>Манипуляции:</b> <%=r.get("manip_"+count)%><br>
<%}%>
<%if(!r.empty("oper_"+count)){%>
        <b>Операции:</b> <%=r.get("oper_"+count)%><br>
<%}%>
<%if(!r.empty("rekomend_"+count)){%>
        <b>Рекомендации:</b> <%=r.get("rekomend_"+count)%><br>
<%}%>
