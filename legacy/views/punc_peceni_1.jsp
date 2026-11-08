<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String pss="false";
String kds="false";
String ir="false";%>
<%String count=r.get("count").toString();%>
<br>
<b>Печень</b> <%=r.get("pech_kak_"+count)%><%if(!r.empty("r_kak_kaps_"+count)){%> <%=r.get("yvel_"+count)%><%}%>.
<%if(!r.empty("tol_prav_"+count) || !r.empty("tol_lev_"+count)){%>Толщина<%if(!r.empty("tol_prav_"+count)){%> правой доли <%=r.get("tol_prav_"+count)%> мм.<%}%><%if(!r.empty("tol_lev_"+count)){%> левой доли <%=r.get("tol_lev_"+count)%><%}%> мм.<%}%>
Контур <%=r.get("kontur_pech_"+count)%>.
Структура <%=r.get("strukt_pech_"+count)%>.
Эхогенность <%=r.get("eho_"+count)%>.
Внутрипеченочные желчные протоки <%=r.get("protok_"+count)%>.
<%if(!r.empty("hole_"+count)){%>Холедох <%=r.get("hole_"+count)%> мм.<%}%>
Сосуды печени <%=r.get("pechen_"+count)%>.
<%if(!r.empty("portal_"+count)){%>Портальная вена <%=r.get("portal_"+count)%> мм.<%}%>
<%if(!r.empty("vena_st_"+count) || !r.empty("vena_"+count)){%>На высоте максимального вдоха диаметр портальной вены<%if(!r.empty("vena_st_"+count)){%> <%=r.get("vena_st_"+count)%> мм.<%}%><%if(!r.empty("vena_"+count)){%> <%=r.get("vena_"+count)%><%}%>.<%}%>
В воротах печени л/узлы <%=r.get("yzli_"+count)%>.
<br><b>Желчный пузырь</b> <%=r.get("puzir_"+count)%>.<%if(!r.get("puzir_"+count).equals("оперативно удален")){%>
<%if(!r.empty("puzr_raz1_"+count) && !r.empty("puzr_raz2_"+count)){%>Размеры: <%=r.get("puzr_raz1_"+count)%> * <%=r.get("puzr_raz2_"+count)%> мм.<%}%>
Стенка <%=r.get("stenka_"+count)%>.
<%if(!r.empty("jel_"+count)){%>Толщина стенки желчного пузыря <%=r.get("jel_"+count)%> мм.<%}%>
В полости <%=r.get("polos_"+count)%>.
Конкременты <%=r.get("konkrement_"+count)%><%if(!r.empty("konkrement_how_"+count)){%> <%=r.get("konkrement_how_"+count)%> мм<%}%>.<%}%>

<%if(!r.empty("addition_" + count)){%><br><b>Дополнительные признаки:</b> <%=r.get("addition_" + count)%><%}%>
<br><b>Ультразвуковая картина характерна для:</b> <%=r.get("decision_" + count)%> <%=r.get("decision_text_" + count)%><br>
