<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>
<b>Правый локтевой сустав</b><br>
Форма сустава <%=r.get("r_forma_"+count)%>.
Суставная щель <%=r.get("r_shel_"+count)%>.
В полости сустава <%=r.get("r_polost_"+count)%>.
Гиалиновый хрящ <%=r.get("r_hryash_"+count)%>.
Субхондральная пластина суставных концов <%=r.get("r_sub_konc_"+count)%>.
Капсула сустава <%=r.get("r_kapsula_"+count)%>.
Сухожилие у места прикрепления к надмыщелкам <%=r.get("r_suho_"+count)%>.
Контур латерального надмыщелка <%=r.get("r_lat_nad_"+count)%>.
Сухожилия разгибателей <%=r.get("r_suho_razg_"+count)%>.
<%if(!r.empty("r_vaska_"+count)){%>Васкуляризация <%=r.get("r_vaska_"+count)%>.<%}%>
Контур медиального надмыщелка <%=r.get("r_med_nad_"+count)%>.
Сухожилия сгибателей <%=r.get("r_suho_sgib_"+count)%>.

<br><b>Левый локтевой сустав</b><br>
Форма сустава <%=r.get("l_forma_"+count)%>.
Суставная щель <%=r.get("l_shel_"+count)%>.
В полости сустава <%=r.get("l_polost_"+count)%>.
Гиалиновый хрящ <%=r.get("l_hryash_"+count)%>.
Субхондральная пластина суставных концов <%=r.get("l_sub_konc_"+count)%>.
Капсула сустава <%=r.get("l_kapsula_"+count)%>.
Сухожилие у места прикрепления к надмыщелкам <%=r.get("l_suho_"+count)%>.
Контур латерального надмыщелка <%=r.get("l_lat_nad_"+count)%>.
Сухожилия разгибателей <%=r.get("l_suho_razg_"+count)%>.
<%if(!r.empty("l_vaska_"+count)){%>Васкуляризация <%=r.get("l_vaska_"+count)%>.<%}%>
Контур медиального надмыщелка <%=r.get("l_med_nad_"+count)%>.
Сухожилия сгибателей <%=r.get("l_suho_sgib_"+count)%>.
<%if(!r.empty("addition_" + count)){%><br><b>Дополнительные признаки:</b> <%=r.get("addition_" + count)%><%}%>
<br><b>Ультразвуковая картина характерна для:</b> <%=r.get("decision_" + count)%> <%=r.get("decision_text_" + count)%><br>
