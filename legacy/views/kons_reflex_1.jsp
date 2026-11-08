<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>



  <%if(!r.empty("jalob_"+count)){%>
        <b>Жалобы:</b> <%=r.get("jalob_"+count)%><br>
<%}%>
<%if(!r.empty("dsss_"+count)){%>
        <b>Диагноз:</b> <%=r.get("dsss_"+count)%><br>
<%}%>
<%if(!r.empty("protiv_"+count)){%>
        <b>Противопоказания:</b> <%=r.get("protiv_"+count)%><br>
<%}%>
<%if(!r.empty("fizio_"+count)){%>
        <b>Аккупунктурное назначение:</b> <%=r.get("fizio_"+count)%><br>
<%}%>
<%if(!r.empty("napr_"+count)){%>
        <b>Направлен:</b> <%=r.get("napr_"+count)%><br>
<%}%>












   

