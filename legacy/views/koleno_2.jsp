<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>
<b>Правый коленный сустав</b><br>
Форма сустава <%=r.get("r_sust_"+count)%>.
Выпот <%=r.getSelect("r_gde_"+count)%> завороте <%=r.get("r_zavorot_"+count)%> <%if(!r.empty("r_zavorot_how_"+count)){%><%=r.get("r_zavorot_how_"+count)%><%}%>.
Капсула <%=r.getSelect("r_kapsula_"+count)%><%if(!r.empty("r_kak_kaps_"+count)){%> <%=r.getSelect("r_kak_kaps_"+count)%><%}%>.
<%=r.getSelect("r_nal_"+count)%> у места прикрепления к кости <%=r.getSelect("r_yzur_"+count)%>.
Структура <%=r.getSelect("r_struct_"+count)%>.
Суставные поверхности <%=r.getSelect("r_sus_pov_"+count)%>.
Суставная щель <%=r.getSelect("r_sust_shel_"+count)%>.
<%if(!r.empty("r_ghmm_how_"+count)){%>Гиалиновый хрящ медиального мыщелка <%=r.get("r_ghmm_how_"+count)%>, <%=r.get("r_hrjash_"+count)%>.<%}%>
Контур <%=r.getSelect("r_konth_"+count)%>, узурации <%=r.getSelect("r_yzh_"+count)%>.
Синовиальная <%=r.getSelect("r_obol_"+count)%><%if(!r.empty("r_raz_ob_how_"+count)){%> до <%=r.get("r_raz_ob_how_"+count)%> мм<%}%>.
Субхондральные и эпифизарные кисты <%=r.getSelect("r_sub_kist_"+count)%>.
Мениски <%=r.getSelect("r_menisk_"+count)%>.
Связки <%=r.getSelect("r_svyazki_"+count)%><%if(!r.empty("r_svyazki_text_"+count)){%> <%=r.getSelect("r_svyazki_text_"+count)%><%}%>.
Медиальный мениск <%=r.getSelect("r_medial_"+count)%>.
Остеофиты в бедренной и б/берцовой кости <%=r.getSelect("r_osteof_"+count)%>.
Интракапсулярная гематома <%=r.getSelect("r_gemot_"+count)%>.
Травматические повреждения менисков <%=r.getSelect("r_tramva_"+count)%><%if(!r.empty("r_oblrog_"+count) && !r.empty("r_oblmenisk_"+count)){%> в области <%=r.getSelect("r_oblrog_"+count)%> <%=r.getSelect("r_oblmenisk_"+count)%><%}%>.
Внесуставного скопления синовиальной жидкости (киста Бейкера) <%=r.getSelect("r_nal_kist_"+count)%><%if(!r.empty("r_nal_kist_how_"+count)){%> <%=r.getSelect("r_nal_kist_how_"+count)%> мм<%}%>.
<br>
<b>Левый коленный сустав</b><br>
Форма сустава <%=r.get("l_sust_"+count)%>.
Выпот <%=r.getSelect("l_gde_"+count)%> завороте <%=r.get("l_zavorot_"+count)%> <%if(!r.empty("l_zavorot_how_"+count)){%><%=r.get("l_zavorot_how_"+count)%><%}%>.
Капсула <%=r.getSelect("l_kapsula_"+count)%><%if(!r.empty("l_kak_kaps_"+count)){%> <%=r.getSelect("l_kak_kaps_"+count)%><%}%>.
<%=r.getSelect("l_nal_"+count)%> у места прикрепления к кости <%=r.getSelect("l_yzur_"+count)%>.
Структура <%=r.getSelect("l_struct_"+count)%>.
Суставные поверхности <%=r.getSelect("l_sus_pov_"+count)%>.
Суставная щель <%=r.getSelect("l_sust_shel_"+count)%>.
<%if(!r.empty("l_ghmm_how_"+count)){%>Гиалиновый хрящ медиального мыщелка <%=r.get("l_ghmm_how_"+count)%>, <%=r.get("l_hrjash_"+count)%>.<%}%>
Контур <%=r.getSelect("l_konth_"+count)%>, узурации <%=r.getSelect("l_yzh_"+count)%>.
Синовиальная <%=r.getSelect("l_obol_"+count)%><%if(!r.empty("l_raz_ob_how_"+count)){%> до <%=r.get("l_raz_ob_how_"+count)%> мм<%}%>.
Субхондральные и эпифизарные кисты <%=r.getSelect("l_sub_kist_"+count)%>.
Мениски <%=r.getSelect("l_menisk_"+count)%>.
Связки <%=r.getSelect("l_svyazki_"+count)%><%if(!r.empty("l_svyazki_text_"+count)){%> <%=r.getSelect("l_svyazki_text_"+count)%><%}%>.
Медиальный мениск <%=r.getSelect("l_medial_"+count)%>.
Остеофиты в бедренной и б/берцовой кости <%=r.getSelect("l_osteof_"+count)%>.
Интракапсулярная гематома <%=r.getSelect("l_gemot_"+count)%>.
Травматические повреждения менисков <%=r.getSelect("l_tramva_"+count)%><%if(!r.empty("l_oblrog_"+count) && !r.empty("l_oblmenisk_"+count)){%> в области <%=r.getSelect("l_oblrog_"+count)%> <%=r.getSelect("l_oblmenisk_"+count)%><%}%>.
Внесуставного скопления синовиальной жидкости (киста Бейкера) <%=r.getSelect("l_nal_kist_"+count)%><%if(!r.empty("l_nal_kist_how_"+count)){%> <%=r.getSelect("l_nal_kist_how_"+count)%><%}%>.
<%if(!r.empty("addition_" + count)){%><br><b>Дополнительные признаки:</b> <%=r.get("addition_" + count)%><%}%>
<br><b>Ультразвуковая картина характерна для:</b> <%=r.get("decision_" + count)%> <%=r.get("decision_text_" + count)%><br>
