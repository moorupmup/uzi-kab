<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>

<%if(!r.empty("dayc_"+count)){%>День цикла <%=r.get("dayc_"+count)%>.<br><%}%>

<%if(r.empty("dayc_"+count) && !r.empty("menop_"+count)){%>Менопауза <%=r.get("menop_"+count)%> лет.<br><%}%>

<b>Тело матки</b> <%=r.get("polojen_"+count)%>.<%if(!r.get("polojen_"+count).equals("оперативно удалено")){%>
Размеры <%=r.get("razmeri_"+count)%>.
<%if(!r.empty("dlina_m_"+count)){%>Длина <%=r.get("dlina_m_"+count)%> мм.<%}%>
<%if(!r.empty("tolshina_m_"+count)){%>Толщина <%=r.get("tolshina_m_"+count)%> мм.<%}%>
<%if(!r.empty("persten_m_"+count)){%>Толщина передней стенки <%=r.get("persten_m_"+count)%> мм.<%}%>
<%if(!r.empty("zadsten_m_"+count)){%>Толщина задней стенки <%=r.get("zadsten_m_"+count)%> мм.<%}%>
<%if(!r.empty("shir_m_"+count)){%>Ширина <%=r.get("shir_m_"+count)%> мм.<%}%>
Форма <%=r.get("forma_gl_"+count)%>.
<%if(!r.empty("rost_yzl_"+count)){%>Рост узлов <%=r.get("rost_yzl_"+count)%>.<%}%>
<%if(!r.empty("razm_yy_"+count)){%>Размеры <%=r.get("razm_yy_"+count)%>.<%}%>
<%if(!r.empty("miom_"+count)){%><%=r.get("miom_"+count)%><%}%>

<br><b>Эндометрий</b><%if(!r.empty("endom_vyr_"+count)){%> 
<%=r.get("endom_vyr_"+count)%>
<%}else{%>
<%if(!r.empty("tolshina_e_"+count)){%> Толщина <%=r.get("tolshina_e_"+count)%> мм <%=r.get("endom_"+count)%>.<%}%>
Cтруктура <%=r.get("struct_e_"+count)%>.
Контуры эндометрия на границе с внутренним мышечным <%=r.get("gran_"+count)%>, кальцинаты <%=r.get("kalch_"+count)%><%}%>.

Полость матки <%if(r.get("polost_"+count).equals("расширена")){%><%=r.get("polost_"+count)%> до <%=r.get("ras_"+count)%>мм.<%}else{%><%=r.get("polost_"+count)%><%}%>, <%=r.get("deform_"+count)%><%if(r.get("deform_"+count).equals("деформирована")){%><%if(!r.empty("polipo_"+count) || !r.empty("yzel_"+count) || !r.empty("obem_"+count) || !r.empty("ottesn_"+count)){%> за счет
<%if(!r.empty("polipo_"+count)){%> <%=r.get("polipo_"+count)%><%if(!r.empty("polipo_how_"+count)){%> <%=r.get("polipo_how_"+count)%> мм<%}%><%}%>
<%if(!r.empty("yzel_"+count)){%> <%=r.get("yzel_"+count)%><%if(!r.empty("yzel_how_"+count)){%> <%=r.get("yzel_how_"+count)%> мм<%}%><%}%>
<%if(!r.empty("obem_"+count)){%> <%=r.get("obem_"+count)%><%if(!r.empty("obem_how_"+count)){%> <%=r.get("obem_how_"+count)%> мм<%}%><%}%>
<%if(!r.empty("ottesn_"+count)){%> <%=r.get("ottesn_"+count)%><%}%><%}%><%}%><%}%>.


<br><b>Шейка матки</b><%if(!r.empty("ydalena_"+count)){%> <%=r.get("ydalena_"+count)%>.<%}%><%if(r.empty("ydalena_"+count)){%><%if(!r.empty("dl_sm_"+count) || !r.empty("shir_sm_"+count) || !r.empty("tol_sm_"+count)){%>. Размеры:
<%if(!r.empty("dl_sm_"+count)){%> длина <%=r.get("dl_sm_"+count)%> мм<%}%><%if(!r.empty("shir_sm_"+count)){%>, ширина <%=r.get("shir_sm_"+count)%> мм<%}%><%if(!r.empty("tol_sm_"+count)){%>, толщина <%=r.get("tol_sm_"+count)%> мм<%}%><%}%>.
Структура <%=r.get("struct_sm_"+count)%><%if(!r.empty("zach_"+count)){%> <%=r.get("zach_"+count)%><%}%> <%if(!r.empty("odn_"+count)){%> <%=r.get("odn_"+count)%><%}%><%if(!r.empty("raz_"+count)){%> структуры размерами  <%=r.get("raz_"+count)%> мм<%}%>.

Цервикальный канал <%=r.get("cerv_"+count)%><%if(!r.empty("kanal_"+count)){%> до <%=r.get("kanal_"+count)%> мм<%}%><%if(!r.empty("kanal_text_"+count)){%> <%=r.get("kanal_text_"+count)%><%}%>.
Эндоцервикс <%=r.get("cerviks_"+count)%><%if(!r.empty("cerviks_how_"+count)){%> <%=r.get("cerviks_how_"+count)%> мм<%}%>.<%}%>

<br><b>Правый яичник</b><%if(!r.empty("r_ydalen_"+count)){%> <%=r.get("r_ydalen_"+count)%>.<%}%><%if(r.empty("r_ydalen_"+count)){%><%if(!r.empty("dl_rj_"+count) || !r.empty("tolh_rj_"+count) || !r.empty("shir_rj_"+count)){%>. Размеры:
<%if(!r.empty("dl_rj_"+count)){%> длина <%=r.get("dl_rj_"+count)%> мм<%}%><%if(!r.empty("tolh_rj_"+count)){%>, толщина <%=r.get("tolh_rj_"+count)%> мм<%}%><%if(!r.empty("shir_rj_"+count)){%>, ширина <%=r.get("shir_rj_"+count)%> мм<%}%>
<%if(!r.empty("rj_obem_"+count)){%> объем <%=r.get("rj_obem_"+count)%> мм3<%}%>
<%}%>.
Форма <%=r.get("forma_rj_"+count)%>.
Структура <%=r.get("struct_rj_"+count)%><%if(r.get("struct_rj_"+count).equals("неоднородная")){%><%if(!r.empty("r_jidkost_"+count) || !r.empty("r_jidkostnogo_"+count) || !r.empty("r_difuziy_"+count) || !r.empty("r_kalcinat_"+count) || !r.empty("r_obrazov_"+count) || !r.empty("r_kista_"+count)){%> за счет
<%if(!r.empty("r_jidkostnogo_"+count)){%> <%=r.get("r_jidkostnogo_"+count)%><%}%><%if(!r.empty("r_jidkostnogo_how_"+count)){%> <%=r.get("r_jidkostnogo_how_"+count)%> мм.<%}%>
<%if(!r.empty("r_jidkost_"+count)){%> <%=r.get("r_jidkost_"+count)%><%}%><%if(!r.empty("r_jidkost_how_"+count)){%> <%=r.get("r_jidkost_how_"+count)%> мм.<%}%>
<%if(!r.empty("r_difuziy_"+count)){%> <%=r.get("r_difuziy_"+count)%><%}%>
<%if(!r.empty("r_kalcinat_"+count)){%> <%=r.get("r_kalcinat_"+count)%><%}%>
<%if(!r.empty("r_obrazov_"+count)){%> <%=r.get("r_obrazov_"+count)%><%if(!r.empty("r_obrazov_how_"+count)){%> <%=r.get("r_obrazov_how_"+count)%> мм<%}%><%}%>
<%if(!r.empty("r_kista_"+count)){%> <%=r.get("r_kista_"+count)%><%if(!r.empty("r_kista_how_"+count)){%> <%=r.get("r_kista_how_"+count)%> мм      <%}%> <%=r.get("sel1_"+count)%>     <%}%><%}%><%}%>.
<%if(!r.empty("kist_rj_"+count) || !r.empty("kist_rj_text_"+count)){%>Объемные образования в проекции правых придатков<%}%><%if(!r.empty("kist_rj_"+count)){%> <%=r.get("kist_rj_"+count)%><%}%><%if(!r.empty("kist_rj_text_"+count)){%> <%=r.get("kist_rj_text_"+count)%><%}%><%if(!r.empty("kist_rj_"+count) || !r.empty("kist_rj_text_"+count)){%>.<%}%>
<%if(!r.empty("r_follik_"+count)){%>Антральные фолликулы - <%=r.get("r_follik_"+count)%><%}%><%}%>
<%if(!r.empty("dop_rj_"+count)){%><%=r.get("dop_rj_"+count)%>.<%}%>

<br><b>Левый яичник</b><%if(!r.empty("l_ydalen_"+count)){%> <%=r.get("l_ydalen_"+count)%>.<%}%><%if(r.empty("l_ydalen_"+count)){%><%if(!r.empty("dl_lj_"+count) || !r.empty("tolh_lj_"+count) || !r.empty("shir_lj_"+count)){%>. Размеры:
<%if(!r.empty("dl_lj_"+count)){%> длина <%=r.get("dl_lj_"+count)%> мм<%}%><%if(!r.empty("tolh_lj_"+count)){%>, толщина <%=r.get("tolh_lj_"+count)%> мм<%}%><%if(!r.empty("shir_lj_"+count)){%>, ширина <%=r.get("shir_lj_"+count)%> мм<%}%>
<%if(!r.empty("lj_obem_"+count)){%> объем <%=r.get("lj_obem_"+count)%> мм3<%}%>
<%}%>.
Форма <%=r.get("forma_lj_"+count)%>.
Структура <%=r.get("struct_lj_"+count)%><%if(r.get("struct_lj_"+count).equals("неоднородная")){%><%if(!r.empty("l_jidkostnogo_"+count) || !r.empty("l_jidkost_"+count) || !r.empty("l_difuziy_"+count) || !r.empty("l_kalcinat_"+count) || !r.empty("l_obrazov_"+count) || !r.empty("l_kista_"+count)){%> за счет
<%if(!r.empty("l_jidkostnogo_"+count)){%> <%=r.get("l_jidkostnogo_"+count)%><%}%><%if(!r.empty("l_jidkostnogo_how_"+count)){%> <%=r.get("l_jidkostnogo_how_"+count)%> мм.<%}%>
<%if(!r.empty("l_jidkost_"+count)){%> <%=r.get("l_jidkost_"+count)%><%}%><%if(!r.empty("l_jidkost_how_"+count)){%> <%=r.get("l_jidkost_how_"+count)%> мм.<%}%>
<%if(!r.empty("l_difuziy_"+count)){%> <%=r.get("l_difuziy_"+count)%><%}%>
<%if(!r.empty("l_kalcinat_"+count)){%> <%=r.get("l_kalcinat_"+count)%><%}%>
<%if(!r.empty("l_obrazov_"+count)){%> <%=r.get("l_obrazov_"+count)%><%if(!r.empty("l_obrazov_how_"+count)){%> <%=r.get("l_obrazov_how_"+count)%> мм<%}%><%}%>
<%if(!r.empty("l_kista_"+count)){%> <%=r.get("l_kista_"+count)%><%if(!r.empty("l_kista_how_"+count)){%> <%=r.get("l_kista_how_"+count)%> мм  <%}%> <%=r.get("sel3_"+count)%>    <%}%><%}%><%}%>.
<%if(!r.empty("kist_lj_"+count) || !r.empty("kist_lj_text_"+count)){%>Объемные образования в проекции левых придатков<%}%><%if(!r.empty("kist_lj_"+count)){%> <%=r.get("kist_lj_"+count)%><%}%><%if(!r.empty("kist_lj_text_"+count)){%> <%=r.get("kist_lj_text_"+count)%><%}%><%if(!r.empty("kist_lj_"+count) || !r.empty("kist_lj_text_"+count)){%>.<%}%>
<%if(!r.empty("l_follik_"+count)){%>Антральные фолликулы - <%=r.get("l_follik_"+count)%><%}%><%}%>
<%if(!r.empty("dop_lj_"+count)){%><%=r.get("dop_lj_"+count)%>.<%}%>
<br><b>Жидкость в позадиматочном пространстве</b> <%=r.get("jid_"+count)%><%if(!r.empty("how_"+count)){%> <%=r.get("how_"+count)%><%}%>.
<%if(!r.empty("spai_"+count)){%>Признаки спаечного процесса малого таза <%=r.get("spai_"+count)%>.<%}%>


<%if(!r.empty("addition_" + count)){%><br><b>Дополнительные признаки:</b> <%=r.get("addition_" + count)%><%}%>
<br><b>Ультразвуковая картина характерна для:</b> <%=r.get("decision_" + count)%> <%=r.get("decision_text_" + count)%><br>
