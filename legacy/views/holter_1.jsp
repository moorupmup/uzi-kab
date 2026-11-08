<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>

<B>Время мониторирования:</B> <%=r.get("mon_chas_"+count)%>ч.<%=r.get("mon_min_"+count)%>мин.<BR>
Проанализированно <%=r.get("anal_kompl_"+count)%> комплексов<BR>
Максимальная чсс <%=r.get("chss_max_"+count)%> уд/мин<BR>
Минимальная чсс <%=r.get("chss_min_"+count)%> уд/мин<BR>
Средняя чсс <%=r.get("chss_sr_"+count)%> уд/мин<BR>
<%if(!r.empty("smesh_st_"+count)){%> Смещение интервала ST происходило <%=r.get("smesh_st_"+count)%> раз, общей продолжительностью <%=r.get("smesh_st_prodol_"+count)%> минут <%}%>

<%if(!r.empty("gel_ekstra_odin_"+count) || !r.empty("gel_ekstra_par_"+count) || !r.empty("epizod_gel_ritm_kol_"+count) || !r.empty("epizod_tah_kol"+count) || !r.empty("ritmir_big"+count) || !r.empty("ritmir_trig"+count)){%> Желудочковая эктопическая активность зарегистрировано:<BR>
<%if(!r.empty("gel_ekstra_odin_"+count)){%> <%=r.get("gel_ekstra_odin_"+count)%> желудочковых одиночных экстрасистол <BR>  <%}%>
<%if(!r.empty("gel_ekstra_par_"+count)){%> <%=r.get("gel_ekstra_par_"+count)%> желудочковых парных экстрасистол <BR>  <%}%>
<%if(!r.empty("epizod_gel_ritm_kol_"+count)){%> <%=r.get("epizod_gel_ritm_kol_"+count)%> эпизодов желудочкового ритма  <BR> <%}%>
<%if(!r.empty("epizod_tah_kol_"+count)){%> <%=r.get("epizod_tah_kol_"+count)%> эпизодов пароксизмальной желудочковой тахикардии  <BR> <%}%><%}%>
<%if(!r.empty("ritmir_big_"+count)){%> <%=r.get("ritmir_big_"+count)%> ритмированных по типу бигемении экстрасистол  <BR> <%}%>
<%if(!r.empty("ritmir_trig_"+count)){%> <%=r.get("ritmir_trig_"+count)%> ритмированных по типу тригемении экстрасистол <BR>  <%}%>
<%if(!r.empty("ekstra_supra_kol_"+count) || !r.empty("ekstra_odin_kol_"+count) || !r.empty("ekstra_par_kol_"+count)){%> Суправентрикулярная эктопическая активность зарегистрировано:<BR>
<%if(!r.empty("ekstra_supra_kol_"+count)){%> <%=r.get("ekstra_supra_kol_"+count)%> суправентрикулярных экстрасистол  <BR> <%}%>
<%if(!r.empty("ekstra_odin_kol_"+count)){%> <%=r.get("ekstra_odin_kol_"+count)%> одиночных экстрасистол <BR>   <%}%>
<%if(!r.empty("ekstra_par_kol_"+count)){%> <%=r.get("ekstra_par_kol_"+count)%> парных экстрасистол  <BR>  <%}%><%}%>
<%if(!r.empty("par_supra_ekstra_kol_"+count)){%> <%=r.get("par_supra_ekstra_kol_"+count)%> пароксизмов суправентрикулярной тахикардии, продолжительностью от <%=r.get("prod_par_1_"+count)%> секунд <%if(!r.empty("prod_par_2_"+count)){%> до <%=r.get("prod_par_2_"+count)%> секунд<%}%><BR>  <%}%> 
<%if(!r.empty("merc_pred_kol_"+count)){%> Регистрируется постоянная форма мерцания предсердий со средней чсс <%=r.get("merc_pred_kol_"+count)%> уд/мин  <BR> <%}%>
<%if(!r.empty("pauzi_kol_"+count)){%> Зарегистрированн <%=r.get("pauzi_kol_"+count)%> пауз длительность <%=r.get("pauzi_dlit_"+count)%> м/сек., связанных с <%=r.get("pauzi_text_1_"+count)%> блокадой <%=r.get("pauzi_text_2_"+count)%> <BR>  <%}%>
<%if(!r.empty("ish_depr_kol_1_"+count)){%> За сутки зарегистрировано <%=r.get("ish_depr_kol_1_"+count)%> эпизодов косовосходящей ишемической депрессии ST общей продолжительностью <%=r.get("ish_dlit_1_"+count)%> <BR>  <%}%>
<%if(!r.empty("ish_depr_kol_2_"+count)){%> За сутки зарегистрировано <%=r.get("ish_depr_kol_2_"+count)%> эпизодов косонисходящей ишемической депрессии ST общей продолжительностью <%=r.get("ish_dlit_2_"+count)%> <BR> <%}%>
<%if(!r.empty("inter_st_check_"+count)){%> Интерпретация ST <%=r.get("inter_st_"+count)%> из-за полной блокады <%=r.get("nogka_gisa_"+count)%> ножки п.Гиса  <BR> <%}%>

<%if(!r.empty("addition_" +count)){%> 

<b>
Комментарии:</b> <%=r.get("addition_" + count)%><%}%>
<br><b>Заключение:</b> <%=r.get("decision_" + count)%> <%=r.get("decision_text_" + count)%><br>
