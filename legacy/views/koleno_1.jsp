<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>
<b>Правый коленный сустав</b><br>
<b>Жидкость в суставах:</b> <%=r.get("r_opred_gyd")%>
<%if(r.get("r_opred_gyd").equals("определяется")){%>
<%=r.get("r_jid_opred")%>
<%}%>.
<%if(!r.empty("r_gyd_text")){%> <%=r.get("r_gyd_text")%>.<%}%>
<%if(!r.empty("r_zav_size1") || !r.empty("r_zav_size2")){%><b>Размеры верхнего заворота:</b>
<%if(!r.empty("r_zav_size1")){%> <%=r.get("r_zav_size1")%> мм<%}%>
<%if(!r.empty("r_zav_size2")){%> <%=r.get("r_zav_size2")%> мм<%}%>
.<%}%>
<b>Синовиальная оболочка:</b> <%=r.get("r_sinov")%>
<%if(r.get("r_sinov").equals("утолщена")){%>
<%if(!r.empty("r_sinov_size")){%>до <%=r.get("r_sinov_size")%> мм<%}%>
<%}%>.
<b>Сухожилие прямой мышцы бедра:</b> <%=r.get("r_suho")%>.
<b>Надколенник:</b> контуры <%=r.get("r_nadkol")%>.
Бурсит <%=r.get("r_opred_burs")%>.
<b>Собственная связка надколенника:</b>
Целостность <%=r.get("r_cel")%>.
Структура <%=r.get("r_struc")%>.
Эхогенность <%=r.get("r_ehogen")%>
<%if(r.get("r_ehogen").equals("снижена") || r.get("r_ehogen").equals("повышена")){%><%=r.get("r_eho_po")%><%}%>.
<%if(!r.empty("r_tolsh_size")){%>Толщина <%=r.get("r_tolsh_size")%> мм.<%}%>
Бурсит <%=r.get("r_opred_burs")%>.
<b>Состояние жировых тел:</b>.
Структура <%=r.get("r_gir_struc")%>.
Гипертрофия <%=r.get("r_gipertr")%>.
<b>Боковые связки:</b>
Структура <%=r.get("r_strucbok")%>.
<b>Суставные поверхности бедренной и большеберцовой костей:</b> <%=r.get("r_pov_kost")%>.
Костные разрастания <%=r.get("r_opred_razr")%>.
<b>Гиалиновый хрящ:</b>
Контуры <%=r.get("r_kontur")%>.
толщина <%=r.get("r_tolsh")%>
<%if(r.get("r_tolsh").equals("истончен")){%>
<%if(!r.empty("r_tolsh_size")){%>до <%=r.get("r_tolsh_size")%> мм<%}%>
<%}%>.
<b>Мениски:</b>
<b>Наружный:</b>
Форма <%=r.get("r_n_menisk_forma")%>.
Структура <%=r.get("r_n_menisk_struc")%>.
Контуры <%=r.get("r_n_menisk_kon")%>.
Фрагментация <%=r.get("r_n_menisk_frag")%>
<%if(r.get("r_n_menisk_frag").equals("определяется")){%>
в области <%=r.get("r_n_frag_opred")%>
<%}%>.
Кальцинаты <%=r.get("r_n_menisk_kal")%>.
Наличие жидкостных образований в паракапсулярной зоне <%=r.get("r_n_menisk_para")%>.
<b>Внутренний:</b>
Форма <%=r.get("r_v_menisk_forma")%>.
Структура <%=r.get("r_v_menisk_struc")%>.
Контуры <%=r.get("r_v_menisk_kon")%>.
Фрагментация <%=r.get("r_v_menisk_frag")%>
<%if(r.get("r_v_menisk_frag").equals("определяется")){%>
в области <%=r.get("r_v_frag_opred")%>
<%}%>.
Кальцинаты <%=r.get("r_v_menisk_kal")%>.
Наличие жидкостных образований в паракапсулярной зоне <%=r.get("r_v_menisk_para")%>.
<b>Киста Бейкера в подколенной области:</b> <%=r.get("r_beker")%>
<%if(r.get("r_beker").equals("определяется")){%>
<%=r.get("r_beker_opred")%>
<%if(!r.empty("r_beker_size1")){%> <%=r.get("r_beker_size1")%> мм<%}%>
<%if(!r.empty("r_beker_size2")){%> <%=r.get("r_beker_size2")%> мм<%}%>
<%}%>.
<br><b>Левый коленный сустав</b><br>
<b>Жидкость в суставах:</b> <%=r.get("l_opred_gyd")%>
<%if(r.get("l_opred_gyd").equals("определяется")){%>
<%=r.get("l_jid_opred")%>
<%}%>.
<%if(!r.empty("l_gyd_text")){%> <%=r.get("l_gyd_text")%>.<%}%>
<%if(!r.empty("l_zav_size1") || !r.empty("l_zav_size2")){%><b>Размеры верхнего заворота:</b>
<%if(!r.empty("l_zav_size1")){%> <%=r.get("l_zav_size1")%> мм<%}%>
<%if(!r.empty("l_zav_size2")){%> <%=r.get("l_zav_size2")%> мм<%}%>
.<%}%>
<b>Синовиальная оболочка:</b> <%=r.get("l_sinov")%>
<%if(r.get("l_sinov").equals("утолщена")){%>
<%if(!r.empty("l_sinov_size")){%>до <%=r.get("l_sinov_size")%> мм<%}%>
<%}%>.
<b>Сухожилие прямой мышцы бедра:</b> <%=r.get("l_suho")%>.
<b>Надколенник:</b> контуры <%=r.get("l_nadkol")%>.
Бурсит <%=r.get("l_opred_burs")%>.
<b>Собственная связка надколенника:</b>
Целостность <%=r.get("l_cel")%>.
Структура <%=r.get("l_struc")%>.
Эхогенность <%=r.get("l_ehogen")%>
<%if(r.get("l_ehogen").equals("снижена") || r.get("l_ehogen").equals("повышена")){%><%=r.get("l_eho_po")%><%}%>.
<%if(!r.empty("l_tolsh_size")){%>Толщина <%=r.get("l_tolsh_size")%> мм.<%}%>
Бурсит <%=r.get("l_opred_burs")%>.
<b>Состояние жировых тел:</b>.
Структура <%=r.get("l_gir_struc")%>.
Гипертрофия <%=r.get("l_gipertr")%>.
<b>Боковые связки:</b>
Структура <%=r.get("l_strucbok")%>.
<b>Суставные поверхности бедренной и большеберцовой костей:</b> <%=r.get("l_pov_kost")%>.
Костные разрастания <%=r.get("l_opred_razr")%>.
<b>Гиалиновый хрящ:</b>
Контуры <%=r.get("l_kontur")%>.
толщина <%=r.get("l_tolsh")%>
<%if(r.get("l_tolsh").equals("истончен")){%>
<%if(!r.empty("l_tolsh_size")){%>до <%=r.get("l_tolsh_size")%> мм<%}%>
<%}%>.
<b>Мениски:</b>
<b>Наружный:</b>
Форма <%=r.get("l_n_menisk_forma")%>.
Структура <%=r.get("l_n_menisk_struc")%>.
Контуры <%=r.get("l_n_menisk_kon")%>.
Фрагментация <%=r.get("l_n_menisk_frag")%>
<%if(r.get("l_n_menisk_frag").equals("определяется")){%>
в области <%=r.get("l_n_frag_opred")%>
<%}%>.
Кальцинаты <%=r.get("l_n_menisk_kal")%>.
Наличие жидкостных образований в паракапсулярной зоне <%=r.get("l_n_menisk_para")%>.
<b>Внутренний:</b>
Форма <%=r.get("l_v_menisk_forma")%>.
Структура <%=r.get("l_v_menisk_struc")%>.
Контуры <%=r.get("l_v_menisk_kon")%>.
Фрагментация <%=r.get("l_v_menisk_frag")%>
<%if(r.get("l_v_menisk_frag").equals("определяется")){%>
в области <%=r.get("l_v_frag_opred")%>
<%}%>.
Кальцинаты <%=r.get("l_v_menisk_kal")%>.
Наличие жидкостных образований в паракапсулярной зоне <%=r.get("l_v_menisk_para")%>.
<b>Киста Бейкера в подколенной области:</b> <%=r.get("l_beker")%>
<%if(r.get("l_beker").equals("определяется")){%>
<%=r.get("l_beker_opred")%>
<%if(!r.empty("l_beker_size1")){%> <%=r.get("l_beker_size1")%> мм<%}%>
<%if(!r.empty("l_beker_size2")){%> <%=r.get("l_beker_size2")%> мм<%}%>
<%}%>.
<%if(!r.empty("addition")){%><br><b>Дополнительные признаки:</b> <%=r.get("addition")%><%}%>
<br><b>Ультразвуковая картина характерна для:</b> <%=r.get("decision")%> <%=r.get("decision_text")%><br>
