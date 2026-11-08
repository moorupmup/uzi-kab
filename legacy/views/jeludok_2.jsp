<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>
Акт глотания <%=r.get("akt_"+count)%>.<br>
<%if(!r.empty("pisha_"+count)){%>Пищевод <%=r.get("pisha_"+count)%>.<br><%}%>
Перорально желудок заполнен жидкостью в объеме <%if(!r.empty("pero_how_"+count)){%><%=r.get("pero_how_"+count)%> мл <%}%><%=r.get("pero_"+count)%>.
<%if(!r.empty("posl_"+count)){%><%=r.get("posl_"+count)%>.<%}%>
<%if(!r.empty("otch_"+count)){%><%=r.get("otch_"+count)%>.<%}%><br>
Перистальтика <%=r.get("peri_"+count)%>.<br>
Эвакуация <%=r.get("eval_"+count)%>.<br>
Рефлюксы: <%=r.get("refl_"+count)%><%if(r.get("refl_"+count).equals("определяются")){%>
<%if(!r.empty("duod_"+count)){%><%=r.get("duod_"+count)%><%}%>
<%if(!r.empty("bulba_"+count)){%><%=r.get("bulba_"+count)%><%}%>
<%if(!r.empty("gastro_"+count)){%><%=r.get("gastro_"+count)%><%}%>
<%if(!r.empty("regur_"+count)){%><%=r.get("regur_"+count)%><%}%><%}%>
<%if(!r.empty("addition_" + count)){%><br><b>Дополнительные признаки:</b> <%=r.get("addition_" + count)%><%}%>
<br><b>Ультразвуковая картина характерна для:</b> <%=r.get("decision_" + count)%> <%=r.get("decision_text_" + count)%><br>
