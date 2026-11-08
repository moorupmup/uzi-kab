<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>
<b>Правая почка</b> <%=r.get("rpochka_"+count)%>
<%if(!r.get("rpochka_"+count).equals("оперативно удалена, ложе без особенностей") && !r.get("rpochka_"+count).equals("в обычном месте не определяется")){%>
<%if(!r.empty("r_pochka_how_"+count)){%> <%=r.get("r_pochka_how_"+count)%> мм<%}%>.
<%if(!r.empty("r_pochka_razmer1_"+count) || !r.empty("r_parenhima_"+count) || !r.empty("r_pochka_razmer2_"+count)){%>Размеры:
<%if(!r.empty("r_pochka_razmer1_"+count) && !r.empty("r_pochka_razmer2_"+count)){%> почка 
<%=r.get("r_pochka_razmer1_"+count)%>*<%=r.get("r_pochka_razmer2_"+count)%> мм<%}%>
<%if(!r.empty("r_parenhima_"+count)){%> паренхима <%=r.get("r_parenhima_"+count)%> мм<%}%>.
<%}%>
Полостная система <%=r.get("rpolost_"+count)%>
<%if(r.get("rpolost_"+count).equals("расширена")){%>
<%if(!r.empty("rchash_"+count) || !r.empty("rlohanki_"+count)){%> за счет
<%if(!r.empty("rchash_"+count)){%> <%=r.get("rchash_"+count)%>
<%if(!r.empty("r_shasheshki_how_"+count)){%> <%=r.get("r_shasheshki_how_"+count)%><%}%><%}%>
<%if(!r.empty("rlohanki_"+count)){%> <%=r.get("rlohanki_"+count)%>
<%if(!r.empty("r_lohanki_how_"+count)){%> <%=r.get("r_lohanki_how_"+count)%><%}%><%}%><%}%><%}%>.
<%=r.get("rstru_"+count)%>
<%if(r.get("rstru_"+count).equals("Структура почки изменена")){%>
<%if(!r.empty("roovp_"+count) || !r.empty("roost_"+count) || !r.empty("roonp_"+count) || !r.empty("rjovp_"+count) || !r.empty("rjost_"+count) || !r.empty("rjonp_"+count) || !r.empty("rjop_"+count)){%> за счет
<%if(!r.empty("roovp_"+count)){%> <%=r.get("roovp_"+count)%><%if(!r.empty("r_obem_verh_how_"+count)){%> <%=r.get("r_obem_verh_how_"+count)%><%}%><%}%>
<%if(!r.empty("roost_"+count)){%> <%=r.get("roost_"+count)%><%if(!r.empty("r_obem_sredn_how_"+count)){%> <%=r.get("r_obem_sredn_how_"+count)%><%}%><%}%>
<%if(!r.empty("roonp_"+count)){%> <%=r.get("roonp_"+count)%><%if(!r.empty("r_obem_niz_how_"+count)){%> <%=r.get("r_obem_niz_how_"+count)%><%}%><%}%>
<%if(!r.empty("rjovp_"+count)){%> <%=r.get("rjovp_"+count)%><%if(!r.empty("r_jid_verh_how_"+count)){%> <%=r.get("r_jid_verh_how_"+count)%><%}%><%}%>
<%if(!r.empty("rjost_"+count)){%> <%=r.get("rjost_"+count)%><%if(!r.empty("r_jid_sredn_how_"+count)){%> <%=r.get("r_jid_sredn_how_"+count)%><%}%><%}%>
<%if(!r.empty("rjonp_"+count)){%> <%=r.get("rjonp_"+count)%><%if(!r.empty("r_jid_niz_how_"+count)){%> <%=r.get("r_jid_niz_how_"+count)%><%}%><%}%>
<%if(!r.empty("rjop_"+count)){%> <%=r.get("rjop_"+count)%><%if(!r.empty("r_jid_paralel_how_"+count)){%> <%=r.get("r_jid_paralel_how_"+count)%><%}%><%}%><%}%><%}%>.

Конкременты <%=r.get("rkonkrim_"+count)%><%if(r.get("rkonkrim_"+count).equals("определяются")){%><%if(!r.empty("rvgch_"+count) || !r.empty("rsgch_"+count) || !r.empty("rngch_"+count) || !r.empty("rpl_"+count)){%>
<%if(!r.empty("rvgch_"+count)){%> <%=r.get("rvgch_"+count)%><%if(!r.empty("r_verh_how_"+count)){%> <%=r.get("r_verh_how_"+count)%> мм<%}%><%}%>
<%if(!r.empty("rsgch_"+count)){%> <%=r.get("rsgch_"+count)%><%if(!r.empty("r_sred_how_"+count)){%> <%=r.get("r_sred_how_"+count)%> мм<%}%><%}%>
<%if(!r.empty("rngch_"+count)){%> <%=r.get("rngch_"+count)%><%if(!r.empty("r_niz_how_"+count)){%> <%=r.get("r_niz_how_"+count)%> мм<%}%><%}%>
<%if(!r.empty("rpl_"+count)){%> <%=r.get("rpl_"+count)%><%if(!r.empty("r_proekcii_how_"+count)){%> <%=r.get("r_proekcii_how_"+count)%> мм<%}%><%}%><%}%><%}%>.
Правый надпочечник <%=r.get("rnadpoch_"+count)%><%if(!r.empty("r_nadpoch_how_"+count)){%> <%=r.get("r_nadpoch_how_"+count)%> мм<%}%><%if(!r.empty("r_nadpochechnik_how_"+count)){%> <%=r.get("r_nadpochechnik_how_"+count)%><%}%><%}%>.

<br><b>Левая почка</b> <%=r.get("lpochka_"+count)%>
<%if(!r.get("lpochka_"+count).equals("оперативно удалена, ложе без особенностей") && !r.get("lpochka_"+count).equals("в обычном месте не определяется")){%>
<%if(!r.empty("l_pochka_how_"+count)){%> <%=r.get("l_pochka_how_"+count)%> мм<%}%>.
<%if(!r.empty("l_pochka_razmer1_"+count) || !r.empty("l_parenhima_"+count) || !r.empty("l_pochka_razmer2_"+count)){%>Размеры:
<%if(!r.empty("l_pochka_razmer1_"+count) && !r.empty("l_pochka_razmer2_"+count)){%> почка 
<%=r.get("l_pochka_razmer1_"+count)%>*<%=r.get("l_pochka_razmer2_"+count)%> мм<%}%>
<%if(!r.empty("l_parenhima_"+count)){%> паренхима <%=r.get("l_parenhima_"+count)%> мм<%}%>.<%}%>
Полостная система <%=r.get("lpolost_"+count)%>
<%if(r.get("rpolost_"+count).equals("расширена")){%>
<%if(!r.empty("lchash_"+count) || !r.empty("llohanki_"+count)){%> за счет
<%if(!r.empty("lchash_"+count)){%> <%=r.get("lchash_"+count)%>
<%if(!r.empty("l_shasheshki_how_"+count)){%> <%=r.get("l_shasheshki_how_"+count)%><%}%><%}%>
<%if(!r.empty("llohanki_"+count)){%> <%=r.get("llohanki_"+count)%><%if(!r.empty("l_lohanki_how_"+count)){%> <%=r.get("l_lohanki_how_"+count)%><%}%><%}%><%}%><%}%>.
<%=r.get("lstru_"+count)%><%if(r.get("lstru_"+count).equals("Структура почки изменена")){%><%if(!r.empty("loovp_"+count) || !r.empty("loost_"+count) || !r.empty("loonp_"+count) || !r.empty("ljovp_"+count) || !r.empty("ljost_"+count) || !r.empty("ljonp_"+count) || !r.empty("ljop_"+count)){%> за счет
<%if(!r.empty("loovp_"+count)){%> <%=r.get("loovp_"+count)%><%if(!r.empty("l_obem_verh_how_"+count)){%> <%=r.get("l_obem_verh_how_"+count)%><%}%><%}%>
<%if(!r.empty("loost_"+count)){%> <%=r.get("loost_"+count)%><%if(!r.empty("l_obem_sredn_how_"+count)){%> <%=r.get("l_obem_sredn_how_"+count)%><%}%><%}%>
<%if(!r.empty("loonp_"+count)){%> <%=r.get("loonp_"+count)%><%if(!r.empty("l_obem_niz_how_"+count)){%> <%=r.get("l_obem_niz_how_"+count)%><%}%><%}%>
<%if(!r.empty("ljovp_"+count)){%> <%=r.get("ljovp_"+count)%><%if(!r.empty("l_jid_verh_how_"+count)){%> <%=r.get("l_jid_verh_how_"+count)%><%}%><%}%>
<%if(!r.empty("ljost_"+count)){%> <%=r.get("ljost_"+count)%><%if(!r.empty("l_jid_sredn_how_"+count)){%> <%=r.get("l_jid_sredn_how_"+count)%><%}%><%}%>
<%if(!r.empty("ljonp_"+count)){%> <%=r.get("ljonp_"+count)%><%if(!r.empty("l_jid_niz_how_"+count)){%> <%=r.get("l_jid_niz_how_"+count)%><%}%><%}%>
<%if(!r.empty("ljop_"+count)){%> <%=r.get("ljop_"+count)%><%if(!r.empty("l_jid_paralel_how_"+count)){%> <%=r.get("l_jid_paralel_how_"+count)%><%}%><%}%><%}%><%}%>.

Конкременты <%=r.get("lkonkrim_"+count)%><%if(r.get("lkonkrim_"+count).equals("определяются")){%><%if(!r.empty("lvgch_"+count) || !r.empty("lsgch_"+count) || !r.empty("lngch_"+count) || !r.empty("lpl_"+count)){%>
<%if(!r.empty("lvgch_"+count)){%> <%=r.get("lvgch_"+count)%><%if(!r.empty("l_verh_how_"+count)){%> <%=r.get("l_verh_how_"+count)%> мм<%}%><%}%>
<%if(!r.empty("lsgch_"+count)){%> <%=r.get("lsgch_"+count)%><%if(!r.empty("l_sred_how_"+count)){%> <%=r.get("l_sred_how_"+count)%> мм<%}%><%}%>
<%if(!r.empty("lngch_"+count)){%> <%=r.get("lngch_"+count)%><%if(!r.empty("l_niz_how_"+count)){%> <%=r.get("l_niz_how_"+count)%> мм<%}%><%}%>
<%if(!r.empty("lpl_"+count)){%> <%=r.get("lpl_"+count)%><%if(!r.empty("l_proekcii_how_"+count)){%> <%=r.get("l_proekcii_how_"+count)%> мм<%}%><%}%><%}%><%}%>.
Левый надпочечник <%=r.get("lnadpoch_"+count)%><%if(!r.empty("l_nadpoch_how_"+count)){%> <%=r.get("l_nadpoch_how_"+count)%> мм<%}%><%if(!r.empty("l_nadpochechnik_how_"+count)){%> <%=r.get("l_nadpochechnik_how_"+count)%><%}%><%}%>.

<br><b>Яички</b> <%=r.get("jaichki_"+count)%>.
<%if(!r.get("jaichki_"+count).equals("оперативно удалены")){%>
<%if(!r.empty("jaichkigde_"+count)){%> <%=r.get("jaichkigde_"+count)%><%}%>.
Эхоструктура <%=r.get("jaichkieho_"+count)%><%if(r.get("jaichkieho_"+count).equals("неоднородная")){%><%if(!r.empty("jidkost_"+count) || !r.empty("kalcinat_"+count) || !r.empty("ychastok_"+count)){%> за счет
<%if(!r.empty("jidkost_"+count)){%> <%=r.get("jidkost_"+count)%><%}%>
<%if(!r.empty("kalcinat_"+count)){%> <%=r.get("kalcinat_"+count)%><%}%>
<%if(!r.empty("ychastok_"+count)){%> <%=r.get("ychastok_"+count)%><%}%><%}%><%}%>.
Эхогенность <%=r.get("jaichehogen_"+count)%>.
Избыточное количество свободной жидкости в оболочках яичек <%=r.get("izbitokjid_"+count)%><%if(!r.empty("izbitokjidgde_"+count)){%> <%=r.get("izbitokjidgde_"+count)%><%}%>.
Придатки яичек <%=r.get("pridatki_"+count)%><%if(!r.empty("pridatkigde_"+count)){%> <%=r.get("pridatkigde_"+count)%><%}%>.
Эхогенность <%=r.get("pridatehogen_"+count)%>.
Структура <%=r.get("jaistru_"+count)%><%if(r.get("jaistru_"+count).equals("неоднородная")){%><%if(!r.empty("ksprava_"+count) || !r.empty("ksleva_"+count)){%> за счет
<%if(!r.empty("ksprava_"+count)){%> <%=r.get("ksprava_"+count)%><%}%>
<%if(!r.empty("ksleva_"+count)){%> <%=r.get("ksleva_"+count)%><%}%><%}%><%}%>.
Расширение вен семенного канатика <%=r.get("rashirven_"+count)%><%if(!r.empty("rash_do_"+count)){%> <%=r.get("rash_do_"+count)%> мм<%}%>.
<%if(r.get("rashirven_"+count)!="не определяется"){%>Регургитация кровотока при пробе Вальсальвы <%=r.get("regir_"+count)%>.<%}%><%}%>

<br><b>Предстательная железа</b> <%=r.get("predstat_"+count)%>.
<%if(!r.get("predstat_"+count).equals("оперативно удалена")){%>
<%if(!r.empty("jeleza_r1_"+count) || !r.empty("jeleza_r2_"+count) || !r.empty("jeleza_r3_"+count)){%> Размеры
<%if(!r.empty("jeleza_r1_"+count)){%> <%=r.get("jeleza_r1_"+count)%><%}%>
<%if(!r.empty("jeleza_r2_"+count)){%>*<%=r.get("jeleza_r2_"+count)%><%}%>
<%if(!r.empty("jeleza_r3_"+count)){%>*<%=r.get("jeleza_r3_"+count)%><%}%> мм.<%}%>
<%if(!r.empty("jeleza_obem_"+count)){%> Объем <%=r.get("jeleza_obem_"+count)%> мл.<%}%>
Форма <%=r.get("forma_"+count)%>.
<%=r.get("vdaetsja_"+count)%> в просвет мочевого пузыря.
Капсула на всем протяжении <%=r.get("kapsula_"+count)%>.
Контур <%=r.get("kontur_"+count)%> <%=r.get("kontursim_"+count)%>.
Эхогенность <%=r.get("ehogennost_"+count)%>.
Эхоструктура <%=r.get("ehostru_"+count)%><%if(r.get("ehostru_"+count).equals("неоднородная за счет")){%><%if(!r.empty("cgvpz_"+count) || !r.empty("ppebat_"+count) || !r.empty("gy_"+count) || !r.empty("jv_"+count) || !r.empty("ret_"+count) || !r.empty("mr_"+count) || !r.empty("pdafz_"+count) || !r.empty("paej_"+count) || !r.empty("kp_"+count) || !r.empty("pmpbooj_"+count) || !r.empty("kk_"+count)){%>
<%if(!r.empty("cgvpz_"+count)){%> <%=r.get("cgvpz_"+count)%><%if(!r.empty("ppebat_"+count) || !r.empty("gy_"+count) || !r.empty("jv_"+count) || !r.empty("ret_"+count) || !r.empty("mr_"+count) || !r.empty("pdafz_"+count) || !r.empty("paej_"+count) || !r.empty("kp_"+count) || !r.empty("pmpbooj_"+count) || !r.empty("kk_"+count)){%>,<%}%><%}%>
<%if(!r.empty("ppebat_"+count)){%> <%=r.get("ppebat_"+count)%><%if(!r.empty("gy_"+count) || !r.empty("jv_"+count) || !r.empty("ret_"+count) || !r.empty("mr_"+count) || !r.empty("pdafz_"+count) || !r.empty("paej_"+count) || !r.empty("kp_"+count) || !r.empty("pmpbooj_"+count) || !r.empty("kk_"+count)){%>,<%}%><%}%>
<%if(!r.empty("gy_"+count)){%> <%=r.get("gy_"+count)%><%if(!r.empty("jv_"+count) || !r.empty("ret_"+count) || !r.empty("mr_"+count) || !r.empty("pdafz_"+count) || !r.empty("paej_"+count) || !r.empty("kp_"+count) || !r.empty("pmpbooj_"+count) || !r.empty("kk_"+count)){%>,<%}%><%}%>
<%if(!r.empty("jv_"+count)){%> <%=r.get("jv_"+count)%><%if(!r.empty("ret_"+count) || !r.empty("mr_"+count) || !r.empty("pdafz_"+count) || !r.empty("paej_"+count) || !r.empty("kp_"+count) || !r.empty("pmpbooj_"+count) || !r.empty("kk_"+count)){%>,<%}%><%}%>
<%if(!r.empty("ret_"+count)){%> <%=r.get("ret_"+count)%><%if(!r.empty("mr_"+count) || !r.empty("pdafz_"+count) || !r.empty("paej_"+count) || !r.empty("kp_"+count) || !r.empty("pmpbooj_"+count) || !r.empty("kk_"+count)){%>,<%}%><%}%>
<%if(!r.empty("mr_"+count)){%> <%=r.get("mr_"+count)%><%if(!r.empty("pdafz_"+count) || !r.empty("paej_"+count) || !r.empty("kp_"+count) || !r.empty("pmpbooj_"+count) || !r.empty("kk_"+count)){%>,<%}%><%}%>
<%if(!r.empty("pdafz_"+count)){%> <%=r.get("pdafz_"+count)%><%if(!r.empty("paej_"+count) || !r.empty("kp_"+count) || !r.empty("pmpbooj_"+count) || !r.empty("kk_"+count)){%>,<%}%><%}%>
<%if(!r.empty("paej_"+count)){%> <%=r.get("paej_"+count)%><%if(!r.empty("kp_"+count) || !r.empty("pmpbooj_"+count) || !r.empty("kk_"+count)){%>,<%}%><%}%>
<%if(!r.empty("kp_"+count)){%> <%=r.get("kp_"+count)%><%if(!r.empty("poloct_kistoz_how_"+count)){%> <%=r.get("poloct_kistoz_how_"+count)%><%}%><%if(!r.empty("pmpbooj_"+count) || !r.empty("kk_"+count)){%>,<%}%><%}%>
<%if(!r.empty("pmpbooj_"+count)){%> <%=r.get("pmpbooj_"+count)%><%if(!r.empty("kk_"+count)){%>,<%}%><%}%>
<%if(!r.empty("kk_"+count)){%> <%=r.get("kk_"+count)%><%if(!r.empty("big_kalcinat_how_"+count)){%> <%=r.get("big_kalcinat_how_"+count)%><%}%><%}%><%}%><%}%>.
Простатическая часть уретры <%=r.get("yretra_"+count)%> на всем протяжении.
Уретро-простатический угол <%=r.get("yretra_ygol_"+count)%>.
Везикуло-простатические углы <%=r.get("vezikylo_ygol_"+count)%>.
Парапростатическое венозное сплетение <%=r.get("spletenie_"+count)%>.
Гиперплазия <%=r.get("giperplaz_"+count)%><%if(r.get("giperplaz_"+count).equals("преимущественно")){%><%if(!r.empty("cz_"+count) || !r.empty("zpj_"+count) || !r.empty("pz_"+count) || !r.empty("ipz_"+count) || !r.empty("withy_"+count) || !r.empty("perehod_"+count)){%> за счет
<%if(!r.empty("cz_"+count)){%> <%=r.get("cz_"+count)%><%}%>
<%if(!r.empty("zpj_"+count)){%> <%=r.get("zpj_"+count)%><%}%>
<%if(!r.empty("pz_"+count)){%> <%=r.get("pz_"+count)%><%}%>
<%if(!r.empty("ipz_"+count)){%> <%=r.get("ipz_"+count)%><%}%>
<%if(!r.empty("withy_"+count)){%> <%=r.get("withy_"+count)%><%if(!r.empty("yzloobraz_how_"+count)){%> <%=r.get("yzloobraz_how_"+count)%><%}%><%}%>
<%if(!r.empty("perehod_"+count)){%> <%=r.get("perehod_"+count)%><%}%><%}%><%}%>.
<%if(!r.empty("perefir_"+count)){%> <%=r.get("perefir_"+count)%>.<%}%>
Очаговые изменения <%=r.get("ochagi_"+count)%><%if(r.get("ochagi_"+count).equals("выявлены")){%><%if(!r.empty("inpz_"+count) || !r.empty("incz_"+count) || !r.empty("inpfz_"+count) || !r.empty("pebchkr_"+count)){%>
<%if(!r.empty("inpz_"+count)){%> <%=r.get("inpz_"+count)%><%}%>
<%if(!r.empty("incz_"+count)){%> <%=r.get("incz_"+count)%><%}%>
<%if(!r.empty("inpfz_"+count)){%> <%=r.get("inpfz_"+count)%><%}%>
<%if(!r.empty("pebchkr_"+count)){%> <%=r.get("pebchkr_"+count)%><%if(!r.empty("ehogennosti_how_"+count)){%> <%=r.get("ehogennosti_how_"+count)%> мм<%}%><%}%><%}%><%}%>.<%}%>
<br><b>Семенные пузырьки</b><%if(!r.empty("puzirki_how_"+count)){%> <%=r.get("puzirki_how_"+count)%> мм,<%}%> <%=r.get("puzirkisim_"+count)%>.
<br><b>Мочевой пузырь</b> <%=r.get("mochpuzir_"+count)%>.
Стенка <%=r.get("stenka_"+count)%>.
Содержимое <%=r.get("soderjimoe_"+count)%>.
Объемные образования <%=r.get("obrazovanija_"+count)%><%if(!r.empty("obrazov1_"+count)){%> <%=r.get("obrazov1_"+count)%><%}%><%if(!r.empty("obrazov2_"+count)){%> <%=r.get("obrazov2_"+count)%><%}%>.
Конкременты <%=r.get("konkrimenti_"+count)%><%if(!r.empty("konkrim1_"+count)){%> <%=r.get("konkrim1_"+count)%><%}%><%if(!r.empty("konkrim2_"+count)){%> <%=r.get("konkrim2_"+count)%><%}%>.
Шейка мочевого пузыря <%=r.get("sheika_"+count)%>.
<%if(!r.empty("obiem_mochi_"+count)){%>Объем остаточной мочи составляет <%=r.get("obiem_mochi_"+count)%> мл.<%}%>
<%if(!r.empty("addition_" + count)){%><br><b>Дополнительные признаки:</b> <%=r.get("addition_" + count)%><%}%>
<br><b>Ультразвуковая картина характерна для:</b> <%=r.get("decision_" + count)%> <%=r.get("decision_text_" + count)%><br>
