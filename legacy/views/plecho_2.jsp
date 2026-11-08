<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>
<b>Правый плечевой сустав</b><br>
Целостность ротарной манжетки <%=r.get("mang_r_"+count)%>.<br>
<b>Структура сухожилий:</b><br>
надостной мышцы <%=r.get("nadost_r_"+count)%>,
подостной мышцы <%=r.get("podost_r_"+count)%>,
подлопаточной мышцы <%=r.get("podlop_r_"+count)%>.<br>
Поддельтовидная сумка <%=r.get("poddelto_r_"+count)%>.<br>
Дельтовидная мышца <%=r.get("delto_r_"+count)%>, ход волокон ее <%=r.get("volokna_r_"+count)%>.<br>
Контур плечевой кости <%=r.get("kontur_r_"+count)%>.<br>
Сухожилие двуглавой мышцы плеча <%=r.get("dvuglavo_r_"+count)%>.<br>
Целостность ключично - акромиального сочленения <%=r.get("sochlen_r_"+count)%>.<br>
Свободной жидкости <%=r.get("gidkost_r_"+count)%><br><br>

<b>Левый плечевой сустав</b><br>
Целостность ротарной манжетки <%=r.get("mang_l_"+count)%>.<br>
<b>Структура сухожилий:</b><br>
надостной мышцы <%=r.get("nadost_l_"+count)%>,
подостной мышцы <%=r.get("podost_l_"+count)%>,
подлопаточной мышцы <%=r.get("podlop_l_"+count)%>.<br>
Поддельтовидная сумка <%=r.get("poddelto_l_"+count)%>.<br>
Дельтовидная мышца <%=r.get("delto_l_"+count)%>, ход волокон ее <%=r.get("volokna_l_"+count)%>.<br>
Контур плечевой кости <%=r.get("kontur_l_"+count)%>.<br>
Сухожилие двуглавой мышцы плеча <%=r.get("dvuglavo_l_"+count)%>.<br>
Целостность ключично - акромиального сочленения <%=r.get("sochlen_l_"+count)%>.<br>
Свободной жидкости <%=r.get("gidkost_l_"+count)%>
<%if(!r.empty("addition_" + count)){%><br><b>Дополнительные признаки:</b> <%=r.get("addition_" + count)%><%}%>
<br><b>Ультразвуковая картина характерна для:</b> <%=r.get("decision_" + count)%> <%=r.get("decision_text_" + count)%><br>
