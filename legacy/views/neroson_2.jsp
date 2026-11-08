<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>
<%if(!r.empty("bespok_"+count)){%><%=r.get("bespok_"+count)%>.<br><%}%>
<%if(!r.empty("sredin_"+count)){%><%=r.get("sredin_"+count)%>.<%}%>
Межполушарная щель <%=r.get("megpol_"+count)%><%if(!r.empty("megpol_how_"+count)){%> <%=r.get("megpol_how_"+count)%> мм<%}%>.
<%if(!r.empty("prav_jeludok_how_"+count) || !r.empty("lev_jeludok_how_"+count)){%>Боковые желудочки:
<%if(!r.empty("prav_jeludok_how_"+count)){%> правый <%=r.get("prav_jeludok_how_"+count)%> мм.<%}%>
<%if(!r.empty("lev_jeludok_how_"+count)){%> левый <%=r.get("lev_jeludok_how_"+count)%> мм.<%}%>
<%}%>
<%if(!r.empty("jeludok_3_how_"+count)){%>3-й желудочек <%=r.get("jeludok_3_how_"+count)%> мм.<%}%>
4-й желудочек <%=r.get("jeludok_"+count)%><%if(!r.empty("jeludok_how_"+count)){%> <%=r.get("jeludok_how_"+count)%> мм.<%}%>
<%if(!r.empty("sosud_"+count)){%> <%=r.get("sosud_"+count)%>.<%}%>
<%if(!r.empty("perv_"+count)){%> <%=r.get("perv_"+count)%>.<%}%>
<%if(!r.empty("kaudo_"+count)){%> <%=r.get("kaudo_"+count)%>.<%}%>
<%if(!r.empty("dopol_"+count)){%> <%=r.get("dopol_"+count)%>.<%}%>
При ЦДК передней артерии: пульсация сосудов мозга <%=r.get("cdk_"+count)%> на всех уровнях.
<%if(!r.empty("vs_"+count)){%> Vs = <%=r.get("vs_"+count)%> см/с.<%}%>
<%if(!r.empty("vd_"+count)){%> Vd = <%=r.get("vd_"+count)%> см/с.<%}%>
<%if(!r.empty("ri_"+count)){%> RI = <%=r.get("ri_"+count)%>.<%}%>
<%if(!r.empty("pi_"+count)){%> PI = <%=r.get("pi_"+count)%>.<%}%>
<%if(!r.empty("addition_" + count)){%><br><b>Дополнительные признаки:</b> <%=r.get("addition_" + count)%><%}%>
<br><b>Ультразвуковая картина характерна для:</b> <%=r.get("decision_" + count)%> <%=r.get("decision_text_" + count)%><br>
