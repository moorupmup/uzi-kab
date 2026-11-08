<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>

<%if(!r.empty("art_"+count)){%>
<b>дсокейямне яйюмхпнбюмхе юпрепхи мхфмху йнмевмняреи:</b><br>
<%=r.get("art_"+count)%>
<%}%>

<%if(!r.empty("ven_"+count)){%>
<br><b>дсокейямне яйюмхпнбюмхе бем мхфмху йнмевмняреи:</b><br>
<%=r.get("ven_"+count)%><br>
<%}%>
                  


<%if(!r.empty("addition_" + count)){%><br><b>дНОНКМХРЕКЭМШЕ ОПХГМЮЙХ:</b> <%=r.get("addition_" + count)%><%}%>
<br><b>гЮЙКЧВЕМХЕ:</b> <%=r.get("decision_" + count)%> <%=r.get("decision_text_" + count)%><br>
