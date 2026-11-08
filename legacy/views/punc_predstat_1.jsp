<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>

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
