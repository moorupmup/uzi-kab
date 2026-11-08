<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>
<b>Правый голеностопный сустав</b><br>
Форма <%=r.get("r_forma_"+count)%>.
Суставные поверхности <%=r.get("r_sus_pov_"+count)%>.
Суставная щель <%=r.get("r_sust_shel_"+count)%>.
Гиалиновый хрящ <%=r.get("r_hrjash_"+count)%><%if(r.get("r_hrjash_"+count).equals("неоднородный")){%><%if(!r.empty("r_hrjsh_giper_"+count) || !r.empty("r_hrjsh_yzur_"+count) || !r.empty("r_hrjsh_kist_"+count)){%> за счет
<%if(!r.empty("r_hrjsh_giper_"+count)){%> <%=r.get("r_hrjsh_giper_"+count)%><%}%>
<%if(!r.empty("r_hrjsh_yzur_"+count)){%> <%=r.get("r_hrjsh_yzur_"+count)%><%}%>
<%if(!r.empty("r_hrjsh_kist_"+count)){%> <%=r.get("r_hrjsh_kist_"+count)%><%}%><%}%><%}%>.
Субхондральные и эпифизарные кисты <%=r.get("r_kist_"+count)%>.
Связки <%=r.get("r_menisk_"+count)%>.
Дегенеративно-дистрофические изменения в виде субхандрального склероза <%=r.get("r_deger_"+count)%>.<br>
Свободная жидкость <%=r.get("r_jidkost_"+count)%>.
<%if(!r.empty("r_giper_how_"+count)){%><br><%=r.get("r_giper_how_"+count)%>.<%}%>
<br><b>Левый голеностопный сустав</b><br>
Форма <%=r.get("l_forma_"+count)%>.
Суставные поверхности <%=r.get("l_sus_pov_"+count)%>.
Суставная щель <%=r.get("l_sust_shel_"+count)%>.
Гиалиновый хрящ <%=r.get("l_hrjash_"+count)%><%if(r.get("l_hrjash_"+count).equals("неоднородный")){%><%if(!r.empty("l_hrjsh_giper_"+count) || !r.empty("l_hrjsh_yzur_"+count) || !r.empty("l_hrjsh_kist_"+count)){%> за счет
<%if(!r.empty("l_hrjsh_giper_"+count)){%> <%=r.get("l_hrjsh_giper_"+count)%><%}%>
<%if(!r.empty("l_hrjsh_yzur_"+count)){%> <%=r.get("l_hrjsh_yzur_"+count)%><%}%>
<%if(!r.empty("l_hrjsh_kist_"+count)){%> <%=r.get("l_hrjsh_kist_"+count)%><%}%><%}%><%}%>.
Субхондральные и эпифизарные кисты <%=r.get("l_kist_"+count)%>.
Связки <%=r.get("l_menisk_"+count)%>.
Дегенеративно-дистрофические изменения в виде субхандрального склероза <%=r.get("l_deger_"+count)%>.<br>
Свободная жидкость <%=r.get("l_jidkost_"+count)%>.
<%if(!r.empty("l_giper_how_"+count)){%><br><%=r.get("l_giper_how_"+count)%>.<%}%>
<%if(!r.empty("addition_" + count)){%><br><b>Дополнительные признаки:</b> <%=r.get("addition_" + count)%><%}%>
<br><b>Ультразвуковая картина характерна для:</b> <%=r.get("decision_" + count)%> <%=r.get("decision_text_" + count)%><br>
