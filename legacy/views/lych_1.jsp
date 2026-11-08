<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>

<H3 class="p_title" align="center">Ультразвуковое исследование лучезапястных суставов</H3>

<b>Правый лучезапястный сустав</b>
<br>Форма сустава <%=r.get("form_r_"+count)%>.
Суставная щель <%=r.get("shel_r_"+count)%>.
Субхондральный склероз <%=r.get("subsk_r_"+count)%>.
Гиалиновый хрящ <%=r.get("geoh_r_"+count)%>.
Суставные поверхности <%=r.get("syst_pov_r_"+count)%>.
Избыточное количество свободной жидкости в полости сустава <%=r.get("svobj_r_"+count)%>.
Выпот во влагалище сухожилий сгибателей пальцев <%=r.get("vip_syh_r_"+count)%>.
Сужение суставных щелей пястнофаланговых, межфаланговых суставов <%=r.get("syj_sys_r_"+count)%>.
Избыточное количество свободной жидкости в полости суставов <%=r.get("svobjsys_r_"+count)%> <%=r.get("svobj_text_r_"+count)%>.
Выпот во влагалище сухожилий межфаланговых суставов <%=r.get("vip_mej_r_"+count)%>.
<%if(!r.empty("dop_r_"+count)){%> <%=r.get("dop_r_"+count)%> <%}%>

<br><b>Левый лучезапястный сустав</b>
<br>Форма сустава <%=r.get("form_l_"+count)%>.
Суставная щель <%=r.get("shel_l_"+count)%>.
Субхондральный склероз <%=r.get("subsk_l_"+count)%>.
Гиалиновый хрящ <%=r.get("geoh_l_"+count)%>.
Суставные поверхности <%=r.get("syst_pov_l_"+count)%>.
Избыточное количество свободной жидкости в полости сустава <%=r.get("svobj_l_"+count)%>.
Выпот во влагалище сухожилий сгибателей пальцев <%=r.get("vip_syh_l_"+count)%>.
Сужение суставных щелей пястнофаланговых, межфаланговых суставов <%=r.get("syj_sys_l_"+count)%>.
Избыточное количество свободной жидкости в полости суставов <%=r.get("svobjsys_l_"+count)%> <%=r.get("svobj_text_l_"+count)%>.
Выпот во влагалище сухожилий межфаланговых суставов <%=r.get("vip_mej_l_"+count)%>.
<%if(!r.empty("dop_l_"+count)){%> <%=r.get("dop_l_"+count)%> <%}%>

<%if(!r.empty("addition_" + count)){%><br><b>Дополнительные признаки:</b> <%=r.get("addition_" + count)%><%}%>
<br><b>Ультразвуковая картина характерна для:</b> <%=r.get("decision_" + count)%> <%=r.get("decision_text_" + count)%><br>