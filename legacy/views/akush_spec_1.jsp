<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>

<%if(!r.empty("jalob_"+count)){%>
        <b>Жалобы:</b> <%=r.get("jalob_"+count)%><br>
<%}%>


<%if(!r.empty("an_akush_"+count)){%>
        <b>Акушерский анамнез:</b> <%=r.get("an_akush_"+count)%><br>
<%}%>
<%if(!r.empty("zab_gin_"+count)){%>
        <b>Гинекологические заболевания:</b> <%=r.get("zab_gin_"+count)%><br>
<%}%>

<%if(!r.empty("soput_"+count)){%>
        <b>Сопутствующие зоболевания:</b> <%=r.get("soput_"+count)%><br>
<%}%>
<%if(!r.empty("vitae_"+count)){%>
        <b>Anamnesis vitae:</b> <%=r.get("vitae_"+count)%><br>
<%}%>
<%if(!r.empty("status_o_"+count)){%>
        <b>St.praesens:</b> <%=r.get("status_o_"+count)%><br>
<%}%>
<%if(!r.empty("status_l_"+count)){%>
        <b>St.genitalis:</b> <%=r.get("status_l_"+count)%><br>
<%}%>
<%if(!r.empty("pred_iss_"+count)){%>
        <b>Обследована:</b> <%=r.get("pred_iss_"+count)%><br>
<%}%>
<%if(!r.empty("diag_"+count)){%>
        <b>Диагноз:</b> <%=r.get("diag_"+count)%><br>
<%}%>
<%if(!r.empty("rekomend_"+count)){%>
        <b>Рекомендации:</b> <%=r.get("rekomend_"+count)%><br>
<%}%>

