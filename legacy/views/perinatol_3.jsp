<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>
<p style="line-height:15pt" align=justify>

<br><br>
<%if(!r.empty("jaloby_"+count)){%><b>Жалобы</b><br> <%=r.get("jaloby_"+count)%><%}%>
<%if(!r.empty("vitae_"+count)){%><br><b>AN. VITAE(норма)</b><br> <%=r.get("vitae_"+count)%><%}%>
<%if(!r.empty("vitaepat_"+count)){%><br><b>AN. VITAE(патология)</b><br> <%=r.get("vitaepat_"+count)%><%}%>
<%if(!r.empty("rod_"+count)){%><br><b>Родословная</b><br> <%=r.get("rod_"+count)%><%}%>
<%if(!r.empty("anamnez_"+count)){%><br><b>Акушерский анамнез</b><br> <%=r.get("anamnez_"+count)%><%}%>
<%if(!r.empty("paritet_"+count)){%><br><b>Паритет</b><br> <%=r.get("paritet_"+count)%><%}%>
<%if(!r.empty("berem_"+count)){%><br><b>Настоящая беременность</b><br> <%=r.get("berem_"+count)%><%}%>
<%if(!r.empty("praesens_"+count)){%><br><b>ST. PRAESENS</b><br> <%=r.get("praesens_"+count)%><%}%>
<%if(!r.empty("dop_"+count)){%><br><b>Дополнительные исследования</b><br> <%=r.get("dop_"+count)%><%}%>
<%if(!r.empty("diag_"+count)){%><br><b>Диагноз</b><br> <%=r.get("diag_"+count)%><%}%>
<%if(!r.empty("preddiag_"+count)){%><br><b>Предварительный диагноз</b><br> <%=r.get("preddiag_"+count)%><%}%>
<%if(!r.empty("decision_text_"+count)){%><br><b>Заключительный диагноз:</b><br> <%=r.get("decision_text_"+count)%><%}%>
<%if(!r.empty("rekomend_"+count)){%><br><b>Рекомендации</b><br> <%=r.get("rekomend_"+count)%><%}%>
<%if(!r.empty("napravl_"+count)){%><br><b>Направление на обследования</b><br> <%=r.get("napravl_"+count)%><%}%>
<br>
</p>