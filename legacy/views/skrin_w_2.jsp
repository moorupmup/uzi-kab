<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String pss="false";
String kds="false";
String ir="false";%>
<%String count=r.get("count").toString();%>



<b>ЩИТОВИДНАЯ ЖЕЛЕЗА:</b> <%=r.get("jeleza_"+count)%>
<%if(!r.get("jeleza_"+count).equals("оперативно удалена.")){%>

Контур <%=r.get("kontur_"+count)%>
<%if(!r.empty("rdolaj_sh_"+count)||!r.empty("rdolaj_tol_"+count)||!r.empty("rdolaj_dl_"+count)||!r.empty("ldolaj_sh_"+count)||!r.empty("ldolaj_tol_"+count)||!r.empty("ldolaj_dl_"+count)){%>
    </br><u>Размеры:</u> 
    <%if(!r.empty("rdolaj_sh_"+count)||!r.empty("rdolaj_tol_"+count)||!r.empty("rdolaj_dl_"+count)){%>
        Правая доля: 
        <%if(!r.empty("rdolaj_sh_"+count)){%> ширина <b><%=r.get("rdolaj_sh_"+count)%></b>(мм),<%}%>
        <%if(!r.empty("rdolaj_tol_"+count)){%> толщина <b><%=r.get("rdolaj_tol_"+count)%></b>(мм),<%}%>
        <%if(!r.empty("rdolaj_dl_"+count)){%> длина <b><%=r.get("rdolaj_dl_"+count)%></b>(мм).<%}%>
    <%}%>                                    
        <%if(!r.empty("ldolaj_sh_"+count)||!r.empty("ldolaj_tol_"+count)||!r.empty("ldolaj_dl_"+count) ){%>
        Левая доля:
        <%if(!r.empty("ldolaj_sh_"+count)){%> ширина <b><%=r.get("ldolaj_sh_"+count)%></b>(мм),<%}%>
        <%if(!r.empty("ldolaj_tol_"+count)){%> толщина <b><%=r.get("ldolaj_tol_"+count)%></b>(мм),<%}%>
        <%if(!r.empty("ldolaj_dl_"+count)){%> длина <b><%=r.get("ldolaj_dl_"+count)%></b>(мм).<%}%>
    <%}%>
<%}%>
<%if(!r.empty("peresheek_"+count)){%>
<u>Перешеек:</u> <b><%=r.get("peresheek_"+count)%></b>(мм).<%}%>

<%if(!r.empty("tir_obem_"+count)){%>  
<u>Тиреоидный объем:</u> <b><%=r.get("tir_obem_"+count)%></b>(мл).<%}%>
Эхогенность <%=r.get("ehogennost_"+count)%>. 
Эхоструктура <%=r.get("ehostructura_"+count)%>
<%if(!r.empty("sochetanie_"+count)){%> в сочетании с <%=r.get("sochetanie_"+count)%><%}%>
.<%}%>

Шейные лимфоузлы <%=r.get("sh_limfoyzli_"+count)%>
      <%if(r.get("sh_limfoyzli_"+count).equals("не увеличены")){%>
          , расположены цепочкой, обычной эхоструктуры, с четкими контурами.
      <%}%>
      <%if(r.get("sh_limfoyzli_"+count).equals("увеличены")){%>
            <%if(!r.empty("sh_gde1_"+count)){%><%=r.get("sh_gde1_"+count)%>,<%}%>
            <%if(!r.empty("sh_gde2_"+count)){%><%=r.get("sh_gde2_"+count)%>,<%}%>
            <%if(!r.empty("sh_gde3_"+count)){%>
            <%=r.get("sh_gde3_"+count)%>,
            <%if(!r.empty("limf_v_"+count)){%><%=r.get("limf_v_"+count)%>,<%}%>
         <%}%>
            <%if(!r.empty("sh_gde4_"+count)){%>
            <%=r.get("sh_gde4_"+count)%>,
            <%if(!r.empty("limf_s_"+count)){%><%=r.get("limf_s_"+count)%>,<%}%>
        <%}%>
            <%if(!r.empty("sh_gde5_"+count)){%>
            <%=r.get("sh_gde5_"+count)%>,
            <%if(!r.empty("limf_n_"+count)){%><%=r.get("limf_n_"+count)%>,<%}%>
        <%}%>
            структура <%=r.get("sh_str_limfoyzli_"+count)%>, 
            контур <%=r.get("sh_kontur_limfoyzli_"+count)%>. 
      <%}%>

<%if(!r.get("chel_limfoyzli_"+count).equals("")){%>
Подчелюстные лимфоузлы <%=r.get("chel_limfoyzli_"+count)%>
      <%if(r.get("chel_limfoyzli_"+count).equals("увеличены")){%>,
            <%if(!r.empty("chel_size_"+count)){%><%=r.get("chel_size_"+count)%>,<%}%>
            структура <%=r.get("chel_str_limfoyzli_"+count)%>, 
            контур <%=r.get("chel_kontur_limfoyzli_"+count)%> 
      <%}%>.
<%}%>

<%if(!r.get("nadkl_limfoyzli_"+count).equals("")){%>
Надключичные лимфоузлы <%=r.get("nadkl_limfoyzli_"+count)%>
      <%if(r.get("nadkl_limfoyzli_"+count).equals("увеличены")){%>,
            <%if(!r.empty("nadkl_size_"+count)){%><%=r.get("nadkl_size_"+count)%>,<%}%>
            структура <%=r.get("nadkl_str_limfoyzli_"+count)%>, 
            контур <%=r.get("nadkl_kontur_limfoyzli_"+count)%> 
      <%}%>.
<%}%>

<%if(!r.get("podkl_limfoyzli_"+count).equals("")){%>
Подключичные лимфоузлы <%=r.get("podkl_limfoyzli_"+count)%>
      <%if(r.get("podkl_limfoyzli_"+count).equals("увеличены")){%>,
            <%if(!r.empty("podkl_size_"+count)){%><%=r.get("podkl_size_"+count)%>,<%}%>            
            структура <%=r.get("podkl_str_limfoyzli_"+count)%>, 
            контур <%=r.get("podkl_kontur_limfoyzli_"+count)%> 
      <%}%>.
<%}%>

<%if(!r.empty("moloch_"+count)){%><br><b>МОЛОЧНЫЕ ЖЕЛЕЗЫ: </b>
<%if(!r.empty("den_"+count)){%>День цикла <%=r.get("den_"+count)%>.<%}%>
Кожный покров <%=r.get("pokrov_"+count)%><%if(!r.empty("pokrov_how_"+count)){%> <%=r.get("pokrov_how_"+count)%> мм<%}%>.
Область соска <%=r.get("sosok_"+count)%>.
Молочные железы представлены <%=r.get("m_jeleza_"+count)%>.
Паренхима <%=r.get("parenhima_"+count)%>.
Млечные протоки <%=r.get("protoki_"+count)%><%if(!r.empty("protoki_how_"+count)){%> <%=r.get("protoki_how_"+count)%> мм<%}%>.
Региональные лимфатические узлы <%=r.get("limf_"+count)%><%if(!r.empty("limf_how_"+count)){%> до <%=r.get("limf_how_"+count)%> мм<%}%>.
Соединительная ткань <%=r.get("tkani_"+count)%>.
<%}%>



<br><b>ОРГАНЫ БРЮШНОЙ ПОЛОСТИ:</b>
<b>Печень:</b> <%=r.get("pech_kak_"+count)%>
<%if(!r.empty("yvel_"+count)){%> <%=r.get("yvel_"+count)%>мм<%}%>.

<%if(!r.empty("tol_prav_"+count) || !r.empty("tol_lev_"+count)){%>Толщина<%if(!r.empty("tol_prav_"+count)){%> правой доли <%=r.get("tol_prav_"+count)%> мм.<%}%><%if(!r.empty("tol_lev_"+count)){%> левой доли <%=r.get("tol_lev_"+count)%><%}%> мм.<%}%>
Контур <%=r.get("kontur_pech_"+count)%>.
Структура <%=r.get("strukt_pech_"+count)%>.
Эхогенность <%=r.get("eho_pech_"+count)%>.
Внутрипеченочные желчные протоки <%=r.get("protok_pech_"+count)%>.
<%if(!r.empty("hole_pech_"+count)){%>Холедох <%=r.get("hole_pech_"+count)%> мм.<%}%>
Сосуды печени <%=r.get("sos_pechen_"+count)%>.
<%if(!r.empty("portal_"+count)){%>Портальная вена <%=r.get("portal_"+count)%> мм.<%}%>
<%if(!r.empty("vena_st_"+count) || !r.empty("vena_pech_"+count)){%>
На высоте максимального вдоха диаметр портальной вены<%if(!r.empty("vena_st_"+count)){%> <%=r.get("vena_st_"+count)%> мм.<%}%>
<%if(!r.empty("vena_pech_"+count)){%> <%=r.get("vena_pech_"+count)%><%}%>.<%}%>
В воротах печени л/узлы <%=r.get("yzli_pech_"+count)%>.

<b>Желчный пузырь</b> <%=r.get("puzir_"+count)%>.<%if(!r.get("puzir_"+count).equals("оперативно удален")){%>
<%if(!r.empty("puzr_raz1_puz_"+count) && !r.empty("puzr_raz2_puz_"+count)){%>
Размеры: <%=r.get("puzr_raz1_puz_"+count)%> * <%=r.get("puzr_raz2_puz_"+count)%> мм.<%}%>
Стенка <%=r.get("stenka_puz_"+count)%>.
<%if(!r.empty("jel_puz_"+count)){%>Толщина стенки желчного пузыря <%=r.get("jel_puz_"+count)%> мм.<%}%>
В полости <%=r.get("polos_puz_"+count)%>.
Конкременты <%=r.get("konkrement_puz_"+count)%>
<%if(!r.empty("konkrement_how_puz_"+count)){%> <%=r.get("konkrement_how_puz_"+count)%> мм<%}%>.<%}%>

<b>Поджелудочная железа</b> <%=r.get("pod_jelez_"+count)%>.
<%if(!r.empty("golov_podj_"+count) || !r.empty("telo_podj_"+count) || !r.empty("hvost_podj_"+count)){%>
Размеры:<%if(!r.empty("golov_podj_"+count)){%> головка <%=r.get("golov_podj_"+count)%> мм<%}%>
<%if(!r.empty("telo_podj_"+count)){%> тело <%=r.get("telo_podj_"+count)%> мм<%}%>
<%if(!r.empty("hvost_podj_"+count)){%> хвост <%=r.get("hvost_podj_"+count)%> мм<%}%>.<%}%>
Контур <%=r.get("kontur_podj_"+count)%>.
Структура <%=r.get("strukt_podj_"+count)%>.
Эхогенность <%=r.get("ehog_podj_"+count)%>.
Вирсунгов проток <%=r.get("prot_podj_"+count)%><%if(!r.empty("rash_podj_"+count)){%> до <%=r.get("rash_podj_"+count)%> мм<%}%>.
<%if(!r.empty("diam_selez_podj_"+count)){%>Диаметр селезеночной вены <%=r.get("diam_selez_podj_"+count)%> мм.<%}%>

<b>Брюшной отдел аорты</b> <%=r.get("aorta_bru_"+count)%>.
<%if(!r.empty("diam_bru_"+count)){%>Диаметр <%=r.get("diam_bru_"+count)%> мм.<%}%>
Склеротические изменения <%=r.get("skler_bru_"+count)%>.
<b>Селезенка</b> <%=r.get("selezen_"+count)%>.<%if(!r.get("selezen_"+count).equals("оперативно удалена")){%>
Структура <%=r.get("strukt_selezen_"+count)%>.
<%if(!r.empty("pl_selezen_"+count)){%>Площадь <%=r.get("pl_selezen_"+count)%> см2.<%}%><%}%>


<b>Правая почка</b> <%=r.get("r_pochka_"+count)%>
<%if(r.get("r_pochka_"+count).equals("оперативно удалена, ложе без особенностей") || r.get("r_pochka_"+count).equals("в обычном месте не определяется")){%>.<%}%>
<%if(!r.get("r_pochka_"+count).equals("оперативно удалена, ложе без особенностей") && !r.get("r_pochka_"+count).equals("в обычном месте не определяется")){%>
<%if(!r.empty("r_pochka_how_"+count)){%> <%=r.get("r_pochka_how_"+count)%> мм<%}%>.
<%if(!r.empty("r_pochka_razmer1_"+count) || !r.empty("r_pochka_parenhima_"+count) || !r.empty("r_pochka_razmer2_"+count)){%>
Размеры:<%if(!r.empty("r_pochka_razmer1_"+count) && !r.empty("r_pochka_razmer2_"+count)){%> 
почка <%=r.get("r_pochka_razmer1_"+count)%>*<%=r.get("r_pochka_razmer2_"+count)%> мм<%}%>
<%if(!r.empty("r_pochka_parenhima_"+count)){%> паренхима <%=r.get("r_pochka_parenhima_"+count)%> мм<%}%>.<%}%>

Полостная система <%=r.get("r_pochka_polost_"+count)%>
<%if(r.get("r_pochka_polost_"+count).equals("расширена")){%>
<%if(!r.empty("r_pochka_chash_"+count) || !r.empty("r_pochka_lohanki_"+count)){%> 
за счет<%if(!r.empty("r_pochka_chash_"+count)){%> 
<%=r.get("r_pochka_chash_"+count)%>
<%if(!r.empty("r_pochka_shash_how_"+count)){%> <%=r.get("r_pochka_shash_how_"+count)%><%}%>
<%}%>
<%if(!r.empty("r_pochka_lohanki_"+count)){%> 
<%=r.get("r_pochka_lohanki_"+count)%>
<%if(!r.empty("r_pochka_lohanki_how_"+count)){%> <%=r.get("r_pochka_lohanki_how_"+count)%><%}%>
  <%}%>
 <%}%>
<%}%>.

<%=r.get("r_pochka_stru_"+count)%>
<%if(r.get("r_pochka_stru_"+count).equals("Структура почки изменена")){%>
<%if(!r.empty("r_pochka_oovp_"+count) || !r.empty("r_pochka_oost_"+count) || !r.empty("r_pochka_oonp_"+count) || !r.empty("r_pochka_jovp_"+count) || !r.empty("r_pochka_jost_"+count) || !r.empty("r_pochka_jonp_"+count) || !r.empty("r_pochka_jop_"+count)){%> 
за счет
<%if(!r.empty("r_pochka_oovp_"+count)){%> <%=r.get("r_pochka_oovp_"+count)%>
   <%if(!r.empty("r_pochka_obem_verh_how_"+count)){%> <%=r.get("r_pochka_obem_verh_how_"+count)%><%}%>
<%}%>
<%if(!r.empty("r_pochka_oost_"+count)){%> <%=r.get("r_pochka_oost_"+count)%>
   <%if(!r.empty("r_pochka_obem_sredn_how_"+count)){%> <%=r.get("r_pochka_obem_sredn_how_"+count)%><%}%>
<%}%>
<%if(!r.empty("r_pochka_oonp_"+count)){%> <%=r.get("r_pochka_oonp_"+count)%>
   <%if(!r.empty("r_pochka_obem_niz_how_"+count)){%> <%=r.get("r_pochka_obem_niz_how_"+count)%><%}%>
<%}%>
<%if(!r.empty("r_pochka_jovp_"+count)){%> <%=r.get("r_pochka_jovp_"+count)%>
   <%if(!r.empty("r_pochka_jid_verh_how_"+count)){%> <%=r.get("r_pochka_jid_verh_how_"+count)%><%}%>
<%}%>
<%if(!r.empty("r_pochka_jost_"+count)){%> <%=r.get("r_pochka_jost_"+count)%>
   <%if(!r.empty("r_pochka_jid_sredn_how_"+count)){%> <%=r.get("r_pochka_jid_sredn_how_"+count)%><%}%>
<%}%>
<%if(!r.empty("r_pochka_jonp_"+count)){%> <%=r.get("r_pochka_jonp_"+count)%>
   <%if(!r.empty("r_pochka_jid_niz_how_"+count)){%> <%=r.get("r_pochka_jid_niz_how_"+count)%><%}%>
<%}%>
<%if(!r.empty("r_pochka_jop_"+count)){%> <%=r.get("r_pochka_jop_"+count)%>
   <%if(!r.empty("r_pochka_jid_paralel_how_"+count)){%> <%=r.get("r_pochka_jid_paralel_how_"+count)%><%}%>
<%}%>
<%}%>
<%}%>.

Конкременты <%=r.get("r_pochka_konkrim_"+count)%>
<%if(r.get("r_pochka_konkrim_"+count).equals("определяются")){%>
  <%if(!r.empty("r_pochka_vgch_"+count) || !r.empty("r_pochka_sgch_"+count) || !r.empty("r_pochka_ngch_"+count) || !r.empty("r_pochka_pl_"+count)){%>
<%if(!r.empty("r_pochka_vgch_"+count)){%> <%=r.get("r_pochka_vgch_"+count)%>
  <%if(!r.empty("r_pochka_verh_how_"+count)){%> <%=r.get("r_pochka_verh_how_"+count)%> мм<%}%>
<%}%>
<%if(!r.empty("r_pochka_sgch_"+count)){%> <%=r.get("r_pochka_sgch_"+count)%>
  <%if(!r.empty("r_pochka_sred_how_"+count)){%> <%=r.get("r_pochka_sred_how_"+count)%> мм<%}%>
<%}%>
<%if(!r.empty("r_pochka_ngch_"+count)){%> <%=r.get("r_pochka_ngch_"+count)%>
  <%if(!r.empty("r_pochka_niz_how_"+count)){%> <%=r.get("r_pochka_niz_how_"+count)%> мм<%}%>
<%}%>
<%if(!r.empty("r_pochka_pl_"+count)){%> <%=r.get("r_pochka_pl_"+count)%>
  <%if(!r.empty("r_pochka_proekcii_how_"+count)){%> <%=r.get("r_pochka_proekcii_how_"+count)%> мм<%}%>
<%}%>
<%}%>
<%}%>.
Правый надпочечник <%=r.get("r_pochka_nadpoch_"+count)%>
<%if(!r.empty("r_pochka_nadpoch_how_"+count)){%> <%=r.get("r_pochka_nadpoch_how_"+count)%> мм<%}%>
<%if(!r.empty("r_pochka_nadpochechnik_how_"+count)){%> <%=r.get("r_pochka_nadpochechnik_how_"+count)%><%}%>.
<%}%>

<b>Левая почка</b> <%=r.get("l_pochka_"+count)%>
<%if(r.get("l_pochka_"+count).equals("оперативно удалена, ложе без особенностей") || r.get("l_pochka_"+count).equals("в обычном месте не определяется")){%>.<%}%>
<%if(!r.get("l_pochka_"+count).equals("оперативно удалена, ложе без особенностей") && !r.get("l_pochka_"+count).equals("в обычном месте не определяется")){%>
<%if(!r.empty("l_pochka_how_"+count)){%> <%=r.get("l_pochka_how_"+count)%> мм<%}%>.
<%if(!r.empty("l_pochka_razmer1_"+count) || !r.empty("l_pochka_parenhima_"+count) || !r.empty("l_pochka_razmer2_"+count)){%>
Размеры:<%if(!r.empty("l_pochka_razmer1_"+count) && !r.empty("l_pochka_razmer2_"+count)){%> 
почка <%=r.get("l_pochka_razmer1_"+count)%>*<%=r.get("l_pochka_razmer2_"+count)%> мм<%}%>
<%if(!r.empty("l_pochka_parenhima_"+count)){%> паренхима <%=r.get("l_pochka_parenhima_"+count)%> мм<%}%>.<%}%>

Полостная система <%=r.get("l_pochka_polost_"+count)%>
<%if(r.get("l_pochka_polost_"+count).equals("расширена")){%>
<%if(!r.empty("l_pochka_chash_"+count) || !r.empty("l_pochka_lohanki_"+count)){%> 
за счет<%if(!r.empty("l_pochka_chash_"+count)){%> 
<%=r.get("l_pochka_chash_"+count)%>
<%if(!r.empty("l_pochka_shash_how_"+count)){%> <%=r.get("l_pochka_shash_how_"+count)%><%}%>
<%}%>
<%if(!r.empty("l_pochka_lohanki_"+count)){%> 
<%=r.get("l_pochka_lohanki_"+count)%>
<%if(!r.empty("l_pochka_lohanki_how_"+count)){%> <%=r.get("l_pochka_lohanki_how_"+count)%><%}%>
  <%}%>
 <%}%>
<%}%>.

<%=r.get("l_pochka_stru_"+count)%>
<%if(r.get("l_pochka_stru_"+count).equals("Структура почки изменена")){%>
<%if(!r.empty("l_pochka_oovp_"+count) || !r.empty("l_pochka_oost_"+count) || !r.empty("l_pochka_oonp_"+count) || !r.empty("l_pochka_jovp_"+count) || !r.empty("l_pochka_jost_"+count) || !r.empty("l_pochka_jonp_"+count) || !r.empty("l_pochka_jop_"+count)){%> 
за счет
<%if(!r.empty("l_pochka_oovp_"+count)){%> <%=r.get("l_pochka_oovp_"+count)%>
   <%if(!r.empty("l_pochka_obem_verh_how_"+count)){%> <%=r.get("l_pochka_obem_verh_how_"+count)%><%}%>
<%}%>
<%if(!r.empty("l_pochka_oost_"+count)){%> <%=r.get("l_pochka_oost_"+count)%>
   <%if(!r.empty("l_pochka_obem_sredn_how_"+count)){%> <%=r.get("l_pochka_obem_sredn_how_"+count)%><%}%>
<%}%>
<%if(!r.empty("l_pochka_oonp_"+count)){%> <%=r.get("l_pochka_oonp_"+count)%>
   <%if(!r.empty("l_pochka_obem_niz_how_"+count)){%> <%=r.get("l_pochka_obem_niz_how_"+count)%><%}%>
<%}%>
<%if(!r.empty("l_pochka_jovp_"+count)){%> <%=r.get("l_pochka_jovp_"+count)%>
   <%if(!r.empty("l_pochka_jid_verh_how_"+count)){%> <%=r.get("l_pochka_jid_verh_how_"+count)%><%}%>
<%}%>
<%if(!r.empty("l_pochka_jost_"+count)){%> <%=r.get("l_pochka_jost_"+count)%>
   <%if(!r.empty("l_pochka_jid_sredn_how_"+count)){%> <%=r.get("l_pochka_jid_sredn_how_"+count)%><%}%>
<%}%>
<%if(!r.empty("l_pochka_jonp_"+count)){%> <%=r.get("l_pochka_jonp_"+count)%>
   <%if(!r.empty("l_pochka_jid_niz_how_"+count)){%> <%=r.get("l_pochka_jid_niz_how_"+count)%><%}%>
<%}%>
<%if(!r.empty("l_pochka_jop_"+count)){%> <%=r.get("l_pochka_jop_"+count)%>
   <%if(!r.empty("l_pochka_jid_paralel_how_"+count)){%> <%=r.get("l_pochka_jid_paralel_how_"+count)%><%}%>
<%}%>
<%}%>
<%}%>.

Конкременты <%=r.get("l_pochka_konkrim_"+count)%>
<%if(r.get("l_pochka_konkrim_"+count).equals("определяются")){%>
  <%if(!r.empty("l_pochka_vgch_"+count) || !r.empty("l_pochka_sgch_"+count) || !r.empty("l_pochka_ngch_"+count) || !r.empty("l_pochka_pl_"+count)){%>
<%if(!r.empty("l_pochka_vgch_"+count)){%> <%=r.get("l_pochka_vgch_"+count)%>
  <%if(!r.empty("l_pochka_verh_how_"+count)){%> <%=r.get("l_pochka_verh_how_"+count)%> мм<%}%>
<%}%>
<%if(!r.empty("l_pochka_sgch_"+count)){%> <%=r.get("l_pochka_sgch_"+count)%>
  <%if(!r.empty("l_pochka_sred_how_"+count)){%> <%=r.get("l_pochka_sred_how_"+count)%> мм<%}%>
<%}%>
<%if(!r.empty("l_pochka_ngch_"+count)){%> <%=r.get("l_pochka_ngch_"+count)%>
  <%if(!r.empty("l_pochka_niz_how_"+count)){%> <%=r.get("l_pochka_niz_how_"+count)%> мм<%}%>
<%}%>
<%if(!r.empty("l_pochka_pl_"+count)){%> <%=r.get("l_pochka_pl_"+count)%>
  <%if(!r.empty("l_pochka_proekcii_how_"+count)){%> <%=r.get("l_pochka_proekcii_how_"+count)%> мм<%}%>
<%}%>
<%}%>
<%}%>.
Левый надпочечник <%=r.get("l_pochka_nadpoch_"+count)%>
<%if(!r.empty("l_pochka_nadpoch_how_"+count)){%> <%=r.get("l_pochka_nadpoch_how_"+count)%> мм<%}%>
<%if(!r.empty("l_pochka_nadpochechnik_how_"+count)){%> <%=r.get("l_pochka_nadpochechnik_how_"+count)%><%}%>.
<%}%>









<%if(!r.empty("addition_" + count)){%>
<br><b>Дополнительные признаки:</b> <%=r.get("addition_" + count)%><%}%>
<br><b>Ультразвуковая картина характерна для:</b> 
<%=r.get("decision_" + count)%> <%=r.get("decision_text_" + count)%><br>


