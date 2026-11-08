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
<br><b>Поджелудочная железа</b> <%=r.get("jelez_"+count)%>.
<%if(!r.empty("golov_"+count) || !r.empty("telo_"+count) || !r.empty("hvost_"+count)){%>Размеры:<%if(!r.empty("golov_"+count)){%> головка <%=r.get("golov_"+count)%> мм<%}%><%if(!r.empty("telo_"+count)){%> тело <%=r.get("telo_"+count)%> мм<%}%><%if(!r.empty("hvost_"+count)){%> хвост <%=r.get("hvost_"+count)%> мм<%}%>.<%}%>
Контур <%=r.get("kontur_jel_"+count)%>.
Структура <%=r.get("strukt_jel_"+count)%>.
Эхогенность <%=r.get("ehog_"+count)%>.
Вирсунгов проток <%=r.get("prot_"+count)%><%if(!r.empty("rash_"+count)){%> до <%=r.get("rash_"+count)%> мм<%}%>.
<%if(!r.empty("diam_selez_"+count)){%>Диаметр селезеночной вены <%=r.get("diam_selez_"+count)%> мм.<%}%>
<br><b>Брюшной отдел аорты</b> <%=r.get("aorta_"+count)%>.
<%if(!r.empty("diam_"+count)){%>Диаметр <%=r.get("diam_"+count)%> мм.<%}%>
Склеротические изменения <%=r.get("skler_"+count)%>.
<br><b>Селезенка</b> <%=r.get("selez_"+count)%>.<%if(!r.get("selez_"+count).equals("оперативно удалена")){%>
Структура <%=r.get("strukt_sel_"+count)%>.
<%if(!r.empty("pl_"+count)){%>Площадь <%=r.get("pl_"+count)%> см2.<%}%><%}%>

<br><b>ПРАВАЯ ПОЧКА</b> <%=r.get("r_pochka_"+count)%>
<%if(r.get("r_pochka_"+count).equals("оперативно удалена, ложе без особенностей") || r.get("r_pochka_"+count).equals("в обычном месте не определяется")){%>.<%}%>
<%if(!r.get("r_pochka_"+count).equals("оперативно удалена, ложе без особенностей") && !r.get("r_pochka_"+count).equals("в обычном месте не определяется")){%>
<%if(!r.empty("r_pochka_how_"+count)){%> <%=r.get("r_pochka_how_"+count)%> мм<%}%>.
<%if(!r.empty("r_pochka_razmer1_"+count) || !r.empty("r_parenhima_"+count) || !r.empty("r_pochka_razmer2_"+count)){%>Размеры:<%if(!r.empty("r_pochka_razmer1_"+count) && !r.empty("r_pochka_razmer2_"+count)){%> почка <%=r.get("r_pochka_razmer1_"+count)%>*<%=r.get("r_pochka_razmer2_"+count)%> мм<%}%><%if(!r.empty("r_parenhima_"+count)){%> паренхима <%=r.get("r_parenhima_"+count)%> мм<%}%>.<%}%>
Полостная система <%=r.get("r_polost_"+count)%><%if(r.get("r_polost_"+count).equals("расширена")){%><%if(!r.empty("r_chash_"+count) || !r.empty("r_lohanki_"+count)){%> за счет<%if(!r.empty("r_chash_"+count)){%> <%=r.get("r_chash_"+count)%><%if(!r.empty("r_shasheshki_how_"+count)){%> <%=r.get("r_shasheshki_how_"+count)%><%}%><%}%><%if(!r.empty("r_lohanki_"+count)){%> <%=r.get("r_lohanki_"+count)%><%if(!r.empty("r_lohanki_how_"+count)){%> <%=r.get("r_lohanki_how_"+count)%><%}%><%}%><%}%><%}%>.
<%=r.get("r_stru_"+count)%><%if(r.get("r_stru_"+count).equals("Структура почки изменена")){%><%if(!r.empty("r_oovp_"+count) || !r.empty("r_oost_"+count) || !r.empty("r_oonp_"+count) || !r.empty("r_jovp_"+count) || !r.empty("r_jost_"+count) || !r.empty("r_jonp_"+count) || !r.empty("r_jop_"+count)){%> за счет
<%if(!r.empty("r_oovp_"+count)){%> <%=r.get("r_oovp_"+count)%><%if(!r.empty("r_obem_verh_how_"+count)){%> <%=r.get("r_obem_verh_how_"+count)%><%}%><%}%>
<%if(!r.empty("r_oost_"+count)){%> <%=r.get("r_oost_"+count)%><%if(!r.empty("r_obem_sredn_how_"+count)){%> <%=r.get("r_obem_sredn_how_"+count)%><%}%><%}%>
<%if(!r.empty("r_oonp_"+count)){%> <%=r.get("r_oonp_"+count)%><%if(!r.empty("r_obem_niz_how_"+count)){%> <%=r.get("r_obem_niz_how_"+count)%><%}%><%}%>
<%if(!r.empty("r_jovp_"+count)){%> <%=r.get("r_jovp_"+count)%><%if(!r.empty("r_jid_verh_how_"+count)){%> <%=r.get("r_jid_verh_how_"+count)%><%}%><%}%>
<%if(!r.empty("r_jost_"+count)){%> <%=r.get("r_jost_"+count)%><%if(!r.empty("r_jid_sredn_how_"+count)){%> <%=r.get("r_jid_sredn_how_"+count)%><%}%><%}%>
<%if(!r.empty("r_jonp_"+count)){%> <%=r.get("r_jonp_"+count)%><%if(!r.empty("r_jid_niz_how_"+count)){%> <%=r.get("r_jid_niz_how_"+count)%><%}%><%}%>
<%if(!r.empty("r_jop_"+count)){%> <%=r.get("r_jop_"+count)%><%if(!r.empty("r_jid_paralel_how_"+count)){%> <%=r.get("r_jid_paralel_how_"+count)%><%}%><%}%><%}%><%}%>.

Конкременты <%=r.get("r_konkrim_"+count)%><%if(r.get("r_konkrim_"+count).equals("определяются")){%><%if(!r.empty("r_vgch_"+count) || !r.empty("r_sgch_"+count) || !r.empty("r_ngch_"+count) || !r.empty("r_pl_"+count)){%>
<%if(!r.empty("r_vgch_"+count)){%> <%=r.get("r_vgch_"+count)%><%if(!r.empty("r_verh_how_"+count)){%> <%=r.get("r_verh_how_"+count)%> мм<%}%><%}%>
<%if(!r.empty("r_sgch_"+count)){%> <%=r.get("r_sgch_"+count)%><%if(!r.empty("r_sred_how_"+count)){%> <%=r.get("r_sred_how_"+count)%> мм<%}%><%}%>
<%if(!r.empty("r_ngch_"+count)){%> <%=r.get("r_ngch_"+count)%><%if(!r.empty("r_niz_how_"+count)){%> <%=r.get("r_niz_how_"+count)%> мм<%}%><%}%>
<%if(!r.empty("r_pl_"+count)){%> <%=r.get("r_pl_"+count)%><%if(!r.empty("r_proekcii_how_"+count)){%> <%=r.get("r_proekcii_how_"+count)%> мм<%}%><%}%><%}%><%}%>.
Правый надпочечник <%=r.get("r_nadpoch_"+count)%><%if(!r.empty("r_nadpoch_how_"+count)){%> <%=r.get("r_nadpoch_how_"+count)%> мм<%}%><%if(!r.empty("r_nadpochechnik_how_"+count)){%> <%=r.get("r_nadpochechnik_how_"+count)%><%}%>.

<%if(!r.empty("r_krovis_"+count)){%>

<%if(!r.empty("r_angi_"+count)){%><br><b>Ангиоархитектоника</b> <%=r.get("r_angi_"+count)%>.<%if(r.get("r_angi_"+count).equals("изменена")){%> Сосудистый рисунок <%=r.get("r_obogashen_"+count)%>.<%}%>
<%if(!r.empty("r_stvol_krovotok_"+count)){%>
<br><b>Ствол почечной артерии. </b>
Тип кровотока <%=r.get("r_stvol_krovotok_"+count)%>.
<%if(!r.empty("r_stvol_sist_how_"+count)){%><%pss="true";%>Пиковая систолическая скорость кровотока <%=r.get("r_stvol_sist_how_"+count)%> см/с (норма 73.6 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 26.4 см/с).<%}%>
<%if(!r.empty("r_stvol_diastol_how_"+count)){%><%kds="true";%>Конечная диастолическая скорость кровотока <%=r.get("r_stvol_diastol_how_"+count)%> см/с (норма 37.2 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 11.7 см/с).<%}%>
<%if(!r.empty("r_stvol_rezis_how_"+count)){%><%ir="true";%>Индекс резистентности <%=r.get("r_stvol_rezis_how_"+count)%> (норма 0.62 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 0.05).<%}%>
<%}%>
<%if(!r.empty("r_arter_krovotok_"+count)){%>
<br><b>Сегментарные артерии. </b>
Тип кровотока <%=r.get("r_arter_krovotok_"+count)%>.
<%if(!r.empty("r_arter_sist_how_"+count)){%><%if(pss.equals("true")){%>ПСС кровотока <%=r.get("r_arter_sist_how_"+count)%><%}else{%><%pss="true";%>Пиковая систолическая скорость кровотока <%=r.get("r_arter_sist_how_"+count)%><%}%> см/с (норма 47 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 6 см/с).<%}%>
<%if(!r.empty("r_arter_diastol_how_"+count)){%><%if(kds.equals("true")){%>КДС кровотока <%=r.get("r_arter_diastol_how_"+count)%><%}else{%><%kds="true";%>Конечная диастолическая скорость кровотока <%=r.get("r_arter_diastol_how_"+count)%><%}%> см/с (норма 20 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 3 см/с).<%}%>
<%if(!r.empty("r_arter_rezis_how_"+count)){%><%if(ir.equals("true")){%>ИР <%=r.get("r_arter_rezis_how_"+count)%><%}else{%><%ir="true";%>Индекс резистентности <%=r.get("r_arter_rezis_how_"+count)%><%}%> (норма 0.6 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 0.05).<%}%>
<%}%>
<%if(!r.empty("r_megdol_krovotok_"+count)){%>
<br><b>Междолевые артерии. </b>
Тип кровотока <%=r.get("r_megdol_krovotok_"+count)%>.
<%if(!r.empty("r_megdol_sist_how_"+count)){%><%if(pss.equals("true")){%>ПСС кровотока <%=r.get("r_megdol_sist_how_"+count)%><%}else{%><%pss="true";%>Пиковая систолическая скорость кровотока <%=r.get("r_megdol_sist_how_"+count)%><%}%> см/с (норма 34 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 4 см/с).<%}%>
<%if(!r.empty("r_megdol_diastol_how_"+count)){%><%if(kds.equals("true")){%>КДС кровотока <%=r.get("r_megdol_diastol_how_"+count)%><%}else{%><%kds="true";%>Конечная диастолическая скорость кровотока <%=r.get("r_megdol_diastol_how_"+count)%><%}%> см/с (норма 14 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 2 см/с).<%}%>
<%if(!r.empty("r_megdol_rezis_how_"+count)){%><%if(ir.equals("true")){%>ИР <%=r.get("r_megdol_rezis_how_"+count)%><%}else{%><%ir="true";%>Индекс резистентности <%=r.get("r_megdol_rezis_how_"+count)%><%}%> (норма 0.59 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 0.04).<%}%>
<%}%>
<%if(!r.empty("r_dugov_krovotok_"+count)){%>
<br><b>Дуговые артерии. </b>
Тип кровотока <%=r.get("r_dugov_krovotok_"+count)%>.
<%if(!r.empty("r_dugov_sist_how_"+count)){%><%if(pss.equals("true")){%>ПСС кровотока <%=r.get("r_dugov_sist_how_"+count)%><%}else{%><%pss="true";%>Пиковая систолическая скорость кровотока <%=r.get("r_dugov_sist_how_"+count)%><%}%> см/с (норма 25 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 4 см/с).<%}%>
<%if(!r.empty("r_dugov_diastol_how_"+count)){%><%if(kds.equals("true")){%>КДС кровотока <%=r.get("r_dugov_diastol_how_"+count)%><%}else{%><%kds="true";%>Конечная диастолическая скорость кровотока <%=r.get("r_dugov_diastol_how_"+count)%><%}%> см/с (норма 11 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 2 см/с).<%}%>
<%if(!r.empty("r_dugov_rezis_how_"+count)){%><%if(ir.equals("true")){%>ИР <%=r.get("r_dugov_rezis_how_"+count)%><%}else{%><%ir="true";%>Индекс резистентности <%=r.get("r_dugov_rezis_how_"+count)%><%}%> (норма 0.59 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 0.02).<%}%>
<%}%>
<br><b>Устья почечной артерии.</b> <%=r.get("r_ustj_"+count)%>.<%if(r.get("r_ustj_"+count).equals("осматривались")){%>
<%=r.get("r_osmotr_"+count)%>.
<%if(r.get("r_osmotr_"+count).equals("Выявлен стенатический патологический кровоток")){%>
<%if(!r.empty("r_ustj_sist_how_"+count)){%><%if(pss.equals("true")){%>ПСС кровотока <%=r.get("r_ustj_sist_how_"+count)%><%}else{%><%pss="true";%>Пиковая систолическая скорость кровотока <%=r.get("r_ustj_sist_how_"+count)%><%}%> см/с.<%}%>
<%if(!r.empty("r_ustj_diastol_how_"+count)){%><%if(kds.equals("true")){%>КДС кровотока <%=r.get("r_ustj_diastol_how_"+count)%><%}else{%><%kds="true";%>Конечная диастолическая скорость кровотока <%=r.get("r_ustj_diastol_how_"+count)%><%}%> см/с.<%}%>
<%if(!r.empty("r_reno_how_"+count)){%>Рено - артальное соотношение <%=r.get("r_reno_how_"+count)%>.<%}%>
<%}%>
<%}%>
<%}%>
<%}%>
<%}%>
<br><b>ЛЕВАЯ ПОЧКА</b> <%=r.get("l_pochka_"+count)%>
<%if(r.get("l_pochka_"+count).equals("оперативно удалена, ложе без особенностей") || r.get("l_pochka_"+count).equals("в обычном месте не определяется")){%>.<%}%>
<%if(!r.get("l_pochka_"+count).equals("оперативно удалена, ложе без особенностей") && !r.get("l_pochka_"+count).equals("в обычном месте не определяется")){%>
<%if(!r.empty("l_pochka_how_"+count)){%> <%=r.get("l_pochka_how_"+count)%> мм<%}%>.
<%if(!r.empty("l_pochka_razmer1_"+count) || !r.empty("l_parenhima_"+count) || !r.empty("l_pochka_razmer2_"+count)){%>Размеры:<%if(!r.empty("l_pochka_razmer1_"+count) && !r.empty("l_pochka_razmer2_"+count)){%> почка <%=r.get("l_pochka_razmer1_"+count)%>*<%=r.get("l_pochka_razmer2_"+count)%> мм<%}%><%if(!r.empty("l_parenhima_"+count)){%> паренхима <%=r.get("l_parenhima_"+count)%> мм<%}%>.<%}%>
Полостная система <%=r.get("l_polost_"+count)%><%if(r.get("l_polost_"+count).equals("расширена")){%><%if(!r.empty("l_chash_"+count) || !r.empty("l_lohanki_"+count)){%> за счет<%if(!r.empty("l_chash_"+count)){%> <%=r.get("l_chash_"+count)%><%if(!r.empty("l_shasheshki_how_"+count)){%> <%=r.get("l_shasheshki_how_"+count)%><%}%><%}%><%if(!r.empty("l_lohanki_"+count)){%> <%=r.get("l_lohanki_"+count)%><%if(!r.empty("l_lohanki_how_"+count)){%> <%=r.get("l_lohanki_how_"+count)%><%}%><%}%><%}%><%}%>.
<%=r.get("l_stru_"+count)%><%if(r.get("l_stru_"+count).equals("Структура почки изменена")){%><%if(!r.empty("l_oovp_"+count) || !r.empty("l_oost_"+count) || !r.empty("l_oonp_"+count) || !r.empty("l_jovp_"+count) || !r.empty("l_jost_"+count) || !r.empty("l_jonp_"+count) || !r.empty("l_jop_"+count)){%> за счет
<%if(!r.empty("l_oovp_"+count)){%> <%=r.get("l_oovp_"+count)%><%if(!r.empty("l_obem_verh_how_"+count)){%> <%=r.get("l_obem_verh_how_"+count)%><%}%><%}%>
<%if(!r.empty("l_oost_"+count)){%> <%=r.get("l_oost_"+count)%><%if(!r.empty("l_obem_sredn_how_"+count)){%> <%=r.get("l_obem_sredn_how_"+count)%><%}%><%}%>
<%if(!r.empty("l_oonp_"+count)){%> <%=r.get("l_oonp_"+count)%><%if(!r.empty("l_obem_niz_how_"+count)){%> <%=r.get("l_obem_niz_how_"+count)%><%}%><%}%>
<%if(!r.empty("l_jovp_"+count)){%> <%=r.get("l_jovp_"+count)%><%if(!r.empty("l_jid_verh_how_"+count)){%> <%=r.get("l_jid_verh_how_"+count)%><%}%><%}%>
<%if(!r.empty("l_jost_"+count)){%> <%=r.get("l_jost_"+count)%><%if(!r.empty("l_jid_sredn_how_"+count)){%> <%=r.get("l_jid_sredn_how_"+count)%><%}%><%}%>
<%if(!r.empty("l_jonp_"+count)){%> <%=r.get("l_jonp_"+count)%><%if(!r.empty("l_jid_niz_how_"+count)){%> <%=r.get("l_jid_niz_how_"+count)%><%}%><%}%>
<%if(!r.empty("l_jop_"+count)){%> <%=r.get("l_jop_"+count)%><%if(!r.empty("l_jid_paralel_how_"+count)){%> <%=r.get("l_jid_paralel_how_"+count)%><%}%><%}%><%}%><%}%>.

Конкременты <%=r.get("l_konkrim_"+count)%><%if(r.get("l_konkrim_"+count).equals("определяются")){%><%if(!r.empty("l_vgch_"+count) || !r.empty("l_sgch_"+count) || !r.empty("l_ngch_"+count) || !r.empty("l_pl_"+count)){%>
<%if(!r.empty("l_vgch_"+count)){%> <%=r.get("l_vgch_"+count)%><%if(!r.empty("l_verh_how_"+count)){%> <%=r.get("l_verh_how_"+count)%> мм<%}%><%}%>
<%if(!r.empty("l_sgch_"+count)){%> <%=r.get("l_sgch_"+count)%><%if(!r.empty("l_sred_how_"+count)){%> <%=r.get("l_sred_how_"+count)%> мм<%}%><%}%>
<%if(!r.empty("l_ngch_"+count)){%> <%=r.get("l_ngch_"+count)%><%if(!r.empty("l_niz_how_"+count)){%> <%=r.get("l_niz_how_"+count)%> мм<%}%><%}%>
<%if(!r.empty("l_pl_"+count)){%> <%=r.get("l_pl_"+count)%><%if(!r.empty("l_proekcii_how_"+count)){%> <%=r.get("l_proekcii_how_"+count)%> мм<%}%><%}%><%}%><%}%>.
Левый надпочечник <%=r.get("l_nadpoch_"+count)%><%if(!r.empty("l_nadpoch_how_"+count)){%> <%=r.get("l_nadpoch_how_"+count)%> мм<%}%><%if(!r.empty("l_nadpochechnik_how_"+count)){%> <%=r.get("l_nadpochechnik_how_"+count)%><%}%>.

<%if(!r.empty("l_krovis_"+count)){%>
<%if(!r.empty("l_angi_"+count)){%><br><b>Ангиоархитектоника</b> <%=r.get("l_angi_"+count)%>.<%if(r.get("l_angi_"+count).equals("изменена")){%> Сосудистый рисунок <%=r.get("l_obogashen_"+count)%>.<%}%>
<%if(!r.empty("l_stvol_krovotok_"+count)){%>
<br><b>Ствол почечной артерии. </b>
Тип кровотока <%=r.get("l_stvol_krovotok_"+count)%>.
<%if(!r.empty("l_stvol_sist_how_"+count)){%><%if(pss.equals("true")){%>ПСС кровотока <%=r.get("l_stvol_sist_how_"+count)%><%}else{%><%pss="true";%>Пиковая систолическая скорость кровотока <%=r.get("l_stvol_sist_how_"+count)%><%}%> см/с (норма 73.6 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 26.4 см/с).<%}%>
<%if(!r.empty("l_stvol_diastol_how_"+count)){%><%if(kds.equals("true")){%>КДС кровотока <%=r.get("l_stvol_diastol_how_"+count)%><%}else{%><%kds="true";%>Конечная диастолическая скорость кровотока <%=r.get("l_stvol_diastol_how_"+count)%><%}%> см/с (норма 37.2 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 11.7 см/с).<%}%>
<%if(!r.empty("l_stvol_rezis_how_"+count)){%><%ir="true";%><%if(ir.equals("true")){%>ИР <%=r.get("l_stvol_rezis_how_"+count)%><%}else{%><%ir="true";%>Индекс резистентности <%=r.get("l_stvol_rezis_how_"+count)%><%}%> (норма 0.62 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 0.05).<%}%>
<%}%>
<%if(!r.empty("l_arter_krovotok_"+count)){%>
<br><b>Сегментарные артерии. </b>
Тип кровотока <%=r.get("l_arter_krovotok_"+count)%>.
<%if(!r.empty("l_arter_sist_how_"+count)){%><%if(pss.equals("true")){%>ПСС кровотока <%=r.get("l_arter_sist_how_"+count)%><%}else{%><%pss="true";%>Пиковая систолическая скорость кровотока <%=r.get("l_arter_sist_how_"+count)%><%}%> см/с (норма 47 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 6 см/с).<%}%>
<%if(!r.empty("l_arter_diastol_how_"+count)){%><%if(kds.equals("true")){%>КДС кровотока <%=r.get("l_arter_diastol_how_"+count)%><%}else{%><%kds="true";%>Конечная диастолическая скорость кровотока <%=r.get("l_arter_diastol_how_"+count)%><%}%> см/с (норма 20 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 3 см/с).<%}%>
<%if(!r.empty("l_arter_rezis_how_"+count)){%><%if(ir.equals("true")){%>ИР <%=r.get("l_arter_rezis_how_"+count)%><%}else{%><%ir="true";%>Индекс резистентности <%=r.get("l_arter_rezis_how_"+count)%><%}%> (норма 0.6 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 0.05).<%}%>
<%}%>
<%if(!r.empty("l_megdol_krovotok_"+count)){%>
<br><b>Междолевые артерии. </b>
Тип кровотока <%=r.get("l_megdol_krovotok_"+count)%>.
<%if(!r.empty("l_megdol_sist_how_"+count)){%><%if(pss.equals("true")){%>ПСС кровотока <%=r.get("l_megdol_sist_how_"+count)%><%}else{%><%pss="true";%>Пиковая систолическая скорость кровотока <%=r.get("l_megdol_sist_how_"+count)%><%}%> см/с (норма 34 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 4 см/с).<%}%>
<%if(!r.empty("l_megdol_diastol_how_"+count)){%><%if(kds.equals("true")){%>КДС кровотока <%=r.get("l_megdol_diastol_how_"+count)%><%}else{%><%kds="true";%>Конечная диастолическая скорость кровотока <%=r.get("l_megdol_diastol_how_"+count)%><%}%> см/с (норма 14 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 2 см/с).<%}%>
<%if(!r.empty("l_megdol_rezis_how_"+count)){%><%if(ir.equals("true")){%>ИР <%=r.get("l_megdol_rezis_how_"+count)%><%}else{%><%ir="true";%>Индекс резистентности <%=r.get("l_megdol_rezis_how_"+count)%><%}%> (норма 0.59 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 0.04).<%}%>
<%}%>
<%if(!r.empty("l_dugov_krovotok_"+count)){%>
<br><b>Дуговые артерии. </b>
Тип кровотока <%=r.get("l_dugov_krovotok_"+count)%>.
<%if(!r.empty("l_dugov_sist_how_"+count)){%><%if(pss.equals("true")){%>ПСС кровотока <%=r.get("l_dugov_sist_how_"+count)%><%}else{%><%pss="true";%>Пиковая систолическая скорость кровотока <%=r.get("l_dugov_sist_how_"+count)%><%}%> см/с (норма 25 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 4 см/с).<%}%>
<%if(!r.empty("l_dugov_diastol_how_"+count)){%><%if(kds.equals("true")){%>КДС кровотока <%=r.get("l_dugov_diastol_how_"+count)%><%}else{%><%kds="true";%>Конечная диастолическая скорость кровотока <%=r.get("l_dugov_diastol_how_"+count)%><%}%> см/с (норма 11 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 2 см/с).<%}%>
<%if(!r.empty("l_dugov_rezis_how_"+count)){%><%if(ir.equals("true")){%>ИР <%=r.get("l_dugov_rezis_how_"+count)%><%}else{%><%ir="true";%>Индекс резистентности <%=r.get("l_dugov_rezis_how_"+count)%><%}%> (норма 0.59 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 0.02).<%}%>
<%}%>
<br><b>Устья почечной артерии.</b> <%=r.get("l_ustj_"+count)%>.<%if(r.get("l_ustj_"+count).equals("осматривались")){%>
<%=r.get("l_osmotr_"+count)%>.
<%if(r.get("l_osmotr_"+count).equals("Выявлен стенатический патологический кровоток")){%>
<%if(!r.empty("l_ustj_sist_how_"+count)){%><%if(pss.equals("true")){%>ПСС кровотока <%=r.get("l_ustj_sist_how_"+count)%><%}else{%><%pss="true";%>Пиковая систолическая скорость кровотока <%=r.get("l_ustj_sist_how_"+count)%><%}%> см/с.<%}%>
<%if(!r.empty("l_ustj_diastol_how_"+count)){%><%if(kds.equals("true")){%>КДС кровотока <%=r.get("l_ustj_diastol_how_"+count)%><%}else{%><%kds="true";%>Конечная диастолическая скорость кровотока <%=r.get("l_ustj_diastol_how_"+count)%><%}%> см/с.<%}%>
<%if(!r.empty("l_reno_how_"+count)){%>Рено - артальное соотношение <%=r.get("l_reno_how_"+count)%>.<%}%>
<%}%>
<%}%>
<%}%>
<%}%>
<%}%>
<%if(!r.empty("addition_" + count)){%><br><b>Дополнительные признаки:</b> <%=r.get("addition_" + count)%><%}%>
<br><b>Ультразвуковая картина характерна для:</b> <%=r.get("decision_" + count)%> <%=r.get("decision_text_" + count)%><br>
