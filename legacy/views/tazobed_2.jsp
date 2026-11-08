<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>
<b>Правый тазобедренный сустав</b><br>
Форма головки бедренной кости <%=r.get("r_head_"+count)%>.
<%if(!r.empty("r_index_"+count)){%>Метэпифизарный индекс <%=r.get("r_index_"+count)%> мм.<%}%>
Выпот в полости сустава <%=r.get("r_vipot_"+count)%>.
<%if(!r.empty("r_raz_ob_"+count)){%>Толщина синовиального пространства в точке перехода шейки бедра в головку <%=r.get("r_raz_ob_"+count)%> мм.<%}%>
Капсула <%=r.get("r_kapsula_"+count)%><%if(!r.empty("r_dop_kapsula_"+count)){%> <%=r.get("r_dop_kapsula_"+count)%> мм<%}%><%if(!r.empty("r_kak_kaps_"+count)){%> <%=r.get("r_kak_kaps_"+count)%><%}%>.
Гиперэхогенные включения и узурация у места прикрепления к кости <%=r.get("r_yzur_"+count)%>.
Суставные поверхности <%=r.get("r_sus_pov_"+count)%><%if(!r.empty("r_sust_ost_"+count) || !r.empty("r_sust_yzur_"+count) || !r.empty("r_sust_kist_"+count)){%> за счет
<%if(!r.empty("r_sust_ost_"+count)){%> <%=r.get("r_sust_ost_"+count)%><%}%>
<%if(!r.empty("r_sust_yzur_"+count)){%> <%=r.get("r_sust_yzur_"+count)%><%}%>
<%if(!r.empty("r_sust_kist_"+count)){%> <%=r.get("r_sust_kist_"+count)%><%}%><%}%>.
Суставная щель <%=r.get("r_sust_shel_"+count)%>.
Гиалиновый хрящ <%=r.get("r_hrjash_"+count)%><%if(!r.empty("r_ghmm_"+count)){%> размером <%=r.get("r_ghmm_"+count)%> мм<%}%><%if(r.get("r_hrjash_"+count).equals("неоднородный")){%><%if(!r.empty("r_hrjsh_giper_"+count) || !r.empty("r_hrjsh_yzur_"+count) || !r.empty("r_hrjsh_kist_"+count)){%> за счет
<%if(!r.empty("r_hrjsh_giper_"+count)){%> <%=r.get("r_hrjsh_giper_"+count)%><%}%>
<%if(!r.empty("r_hrjsh_yzur_"+count)){%> <%=r.get("r_hrjsh_yzur_"+count)%><%}%>
<%if(!r.empty("r_hrjsh_kist_"+count)){%> <%=r.get("r_hrjsh_kist_"+count)%><%}%><%}%><%}%>.
Субхондральные и эпифизарные кисты <%=r.get("r_kist_"+count)%>.
Связки <%=r.get("r_menisk_"+count)%>.
Дегенеративно-дистрофические изменения в виде субхандрального склероза <%=r.get("r_deger_"+count)%>.
Гипертонус параартикулярных тканей <%=r.get("r_giper_"+count)%>.
<%if(!r.empty("r_giper_how_"+count)){%> <%=r.get("r_giper_how_"+count)%>.<%}%>
<br><b>Левый тазобедренный сустав</b><br>
Форма головки бедренной кости <%=r.get("l_head_"+count)%>.
<%if(!r.empty("l_index_"+count)){%>Метэпифизарный индекс <%=r.get("l_index_"+count)%> мм.<%}%>
Выпот в полости сустава <%=r.get("l_vipot_"+count)%>.
<%if(!r.empty("l_raz_ob_"+count)){%>Толщина синовиального пространства в точке перехода шейки бедра в головку <%=r.get("l_raz_ob_"+count)%> мм.<%}%>
Капсула <%=r.get("l_kapsula_"+count)%><%if(!r.empty("l_dop_kapsula_"+count)){%> <%=r.get("l_dop_kapsula_"+count)%> мм<%}%><%if(!r.empty("l_kak_kaps_"+count)){%> <%=r.get("l_kak_kaps_"+count)%><%}%>.
Гиперэхогенные включения и узурация у места прикрепления к кости <%=r.get("l_yzur_"+count)%>.
Суставные поверхности <%=r.get("l_sus_pov_"+count)%><%if(!r.empty("l_sust_ost_"+count) || !r.empty("l_sust_yzur_"+count) || !r.empty("l_sust_kist_"+count)){%> за счет
<%if(!r.empty("l_sust_ost_"+count)){%> <%=r.get("l_sust_ost_"+count)%><%}%>
<%if(!r.empty("l_sust_yzur_"+count)){%> <%=r.get("l_sust_yzur_"+count)%><%}%>
<%if(!r.empty("l_sust_kist_"+count)){%> <%=r.get("l_sust_kist_"+count)%><%}%><%}%>.
Суставная щель <%=r.get("l_sust_shel_"+count)%>.
Гиалиновый хрящ <%=r.get("l_hrjash_"+count)%><%if(!r.empty("l_ghmm_"+count)){%> размером <%=r.get("l_ghmm_"+count)%> мм<%}%><%if(r.get("l_hrjash_"+count).equals("неоднородный")){%><%if(!r.empty("l_hrjsh_giper_"+count) || !r.empty("l_hrjsh_yzur_"+count) || !r.empty("l_hrjsh_kist_"+count)){%> за счет
<%if(!r.empty("l_hrjsh_giper_"+count)){%> <%=r.get("l_hrjsh_giper_"+count)%><%}%>
<%if(!r.empty("l_hrjsh_yzur_"+count)){%> <%=r.get("l_hrjsh_yzur_"+count)%><%}%>
<%if(!r.empty("l_hrjsh_kist_"+count)){%> <%=r.get("l_hrjsh_kist_"+count)%><%}%><%}%><%}%>.
Субхондральные и эпифизарные кисты <%=r.get("l_kist_"+count)%>.
Связки <%=r.get("l_menisk_"+count)%>.
Дегенеративно-дистрофические изменения в виде субхандрального склероза <%=r.get("l_deger_"+count)%>.
Гипертонус параартикулярных тканей <%=r.get("l_giper_"+count)%>.
<%if(!r.empty("l_giper_how_"+count)){%> <%=r.get("l_giper_how_"+count)%>.<%}%>
<%if(!r.empty("addition_" + count)){%><br><b>Дополнительные признаки:</b> <%=r.get("addition_" + count)%><%}%>
<br><b>Ультразвуковая картина характерна для:</b> <%=r.get("decision_" + count)%> <%=r.get("decision_text_" + count)%><br>
