<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>
<b>Правый коленный сустав</b><br>
В полости сустава <%=r.get("r_polost_"+count)%>
<%if(r.get("r_polost_"+count).equals("незначительно избыточное количество свободной жидкости") || r.get("r_polost_"+count).equals("умеренно избыточное количество свободной жидкости") || r.get("r_polost_"+count).equals("выраженно избыточное количество свободной жидкости")){%>
размеры верхнего заворота 
<%if(!r.empty("r_size_a_"+count)){%><%=r.get("r_size_a_"+count)%> мм *<%}%> 
<%if(!r.empty("r_size_b_"+count)){%><%=r.get("r_size_b_"+count)%> мм *<%}%>
<%if(!r.empty("r_size_c_"+count)){%><%=r.get("r_size_c_"+count)%> мм<%}%>
<%if(!r.empty("r_size_v_"+count)){%>; объем <%=r.get("r_size_v_"+count)%> мл<%}%> <%}%>.

<%if(!r.empty("r_vypot_"+count)){%>Характер выпота <%=r.get("r_vypot_"+count)%>.<%}%>
Синовиальная оболочка <%=r.get("r_sinov_"+count)%><%if(!r.empty("r_sinov_size_"+count)){%> <%=r.get("r_sinov_size_"+count)%> мм<%}%>.
Васкуляризация <%=r.get("r_vaskul_"+count)%>.
Сухожилие четырехглавой мышцы бедра <%=r.get("r_suho_"+count)%><%if(r.get("r_suho_"+count).equals("изменено")){%><%if(!r.empty("r_suho_giper_"+count)){%> за счет <%=r.get("r_suho_giper_"+count)%><%}%><%}%>.
Капсула сустава <%=r.get("r_kapsula_"+count)%>.
Клечатка Гаффа <%=r.get("r_gaffa_"+count)%>.
Субхондральная пластинка <%=r.get("r_plastina_"+count)%><%if(r.get("r_plastina_"+count).equals("деформирована")){%><%if(!r.empty("r_osteof_"+count)){%> за счет <%=r.get("r_osteof_"+count)%><%}%><%}%>.
Суставная щель <%=r.get("r_sust_shel_"+count)%>.
Медиальный мениск <%=r.get("r_medial_"+count)%>.
Краевые костные разрастания в бедренной и б/берцовой кости <%=r.get("r_krai_"+count)%>.
Гиалиновый хрящ медиального мыщелка <%=r.get("r_hryash_"+count)%><%if(!r.empty("r_hryash_how_"+count)){%> <%=r.get("r_hryash_how_"+count)%> мм<%}%>.
Связки <%=r.get("r_svyazki_"+count)%><%if(r.get("r_svyazki_"+count).equals("изменены")){%><%if(!r.empty("r_koll_"+count) || !r.empty("r_narug_"+count) || !r.empty("r_sobstv_"+count) || !r.empty("r_zad_"+count) || !r.empty("r_pered_"+count)){%> за счет:
    <%if(!r.empty("r_koll_"+count)){%> <%=r.get("r_koll_"+count)%> <%if(!r.empty("r_koll_text_"+count)){%> <%=r.get("r_koll_text_"+count)%><%}%><%}%>
    <%if(!r.empty("r_narug_"+count)){%> <%=r.get("r_narug_"+count)%> <%if(!r.empty("r_narug_text_"+count)){%> <%=r.get("r_narug_text_"+count)%><%}%><%}%>
    <%if(!r.empty("r_sobstv_"+count)){%> <%=r.get("r_sobstv_"+count)%> <%if(!r.empty("r_sobstv_text_"+count)){%> <%=r.get("r_sobstv_text_"+count)%><%}%><%}%>
    <%if(!r.empty("r_zad_"+count)){%> <%=r.get("r_zad_"+count)%><%}%>
    <%if(!r.empty("r_pered_"+count)){%> <%=r.get("r_pered_"+count)%><%}%>
<%}%><%}%>.
Мениски <%=r.get("r_men_"+count)%><%if(r.get("r_men_"+count).equals("изменены")){%><%if(!r.empty("r_giper_"+count) || !r.empty("r_gipo_"+count) || !r.empty("r_sign_"+count)){%> за счет:
    <%if(!r.empty("r_giper_"+count)){%> <%=r.get("r_giper_"+count)%><%}%>
    <%if(!r.empty("r_gipo_"+count)){%> <%=r.get("r_gipo_"+count)%><%}%>
    <%if(!r.empty("r_sign_"+count)){%> <%=r.get("r_sign_"+count)%><%}%>
<%}%>
<%if(!r.empty("r_oblast_"+count)){%>в области <%=r.get("r_oblast_"+count)%><%}%><%if(!r.empty("r_oblmenisk_"+count)){%> <%=r.get("r_oblmenisk_"+count)%><%}%><%if(!r.empty("r_menisk_how_"+count)){%> <%=r.get("r_menisk_how_"+count)%> мм<%}%><%}%>.
<%=r.get("r_vnesus_"+count)%><%if(!r.empty("r_mesto_"+count)){%> <%=r.get("r_mesto_"+count)%><%}%>.
Киста Бейкера <%=r.get("r_beker_"+count)%><%if(!r.empty("r_beker_how_"+count)){%> <%=r.get("r_beker_how_"+count)%> мм<%}%><%if(!r.empty("r_beker2_"+count)){%> <%=r.get("r_beker2_"+count)%><%}%>.
<%if(r.get("r_beker_"+count).equals("определяется размером")){%>Васкуляризация стенки кисты <%=r.get("r_beker_ki_"+count)%>.<%}%>

<br><b>Левый коленный сустав</b><br>
В полости сустава <%=r.get("l_polost_"+count)%>
<%if(r.get("l_polost_"+count).equals("незначительно избыточное количество свободной жидкости") || r.get("l_polost_"+count).equals("умеренно избыточное количество свободной жидкости") || r.get("l_polost_"+count).equals("выраженно избыточное количество свободной жидкости")){%>
размеры верхнего заворота 
<%if(!r.empty("l_size_a_"+count)){%><%=r.get("l_size_a_"+count)%> мм *<%}%> 
<%if(!r.empty("l_size_b_"+count)){%><%=r.get("l_size_b_"+count)%> мм *<%}%>
<%if(!r.empty("l_size_c_"+count)){%><%=r.get("l_size_c_"+count)%> мм<%}%>
<%if(!r.empty("l_size_v_"+count)){%>; объем <%=r.get("l_size_v_"+count)%> мл<%}%> <%}%>.

<%if(!r.empty("l_vypot_"+count)){%>Характер выпота <%=r.get("l_vypot_"+count)%>.<%}%>
Синовиальная оболочка <%=r.get("l_sinov_"+count)%><%if(!r.empty("l_sinov_size_"+count)){%> <%=r.get("l_sinov_size_"+count)%> мм<%}%>.
Васкуляризация <%=r.get("l_vaskul_"+count)%>.
Сухожилие четырехглавой мышцы бедра <%=r.get("l_suho_"+count)%><%if(r.get("l_suho_"+count).equals("изменено")){%><%if(!r.empty("r_suho_giper_"+count)){%> за счет <%=r.get("r_suho_giper_"+count)%><%}%><%}%>.
Капсула сустава <%=r.get("l_kapsula_"+count)%>.
Клечатка Гаффа <%=r.get("l_gaffa_"+count)%>.
Субхондральная пластинка <%=r.get("l_plastina_"+count)%><%if(r.get("l_plastina_"+count).equals("деформирована")){%><%if(!r.empty("l_osteof_"+count)){%> за счет <%=r.get("l_osteof_"+count)%><%}%><%}%>.
Суставная щель <%=r.get("l_sust_shel_"+count)%>.
Медиальный мениск <%=r.get("l_medial_"+count)%>.
Краевые костные разрастания в бедренной и б/берцовой кости <%=r.get("l_krai_"+count)%>.
Гиалиновый хрящ медиального мыщелка <%=r.get("l_hryash_"+count)%><%if(!r.empty("l_hryash_how_"+count)){%> <%=r.get("l_hryash_how_"+count)%> мм<%}%>.
Связки <%=r.get("l_svyazki_"+count)%><%if(r.get("l_svyazki_"+count).equals("изменены")){%><%if(!r.empty("l_koll_"+count) || !r.empty("l_narug_"+count) || !r.empty("l_sobstv_"+count) || !r.empty("l_zad_"+count) || !r.empty("l_pered_"+count)){%> за счет:
    <%if(!r.empty("l_koll_"+count)){%> <%=r.get("l_koll_"+count)%> <%if(!r.empty("l_koll_text_"+count)){%> <%=r.get("l_koll_text_"+count)%><%}%><%}%>
    <%if(!r.empty("l_narug_"+count)){%> <%=r.get("l_narug_"+count)%> <%if(!r.empty("l_narug_text_"+count)){%> <%=r.get("l_narug_text_"+count)%><%}%><%}%>
    <%if(!r.empty("l_sobstv_"+count)){%> <%=r.get("l_sobstv_"+count)%> <%if(!r.empty("l_sobstv_text_"+count)){%> <%=r.get("l_sobstv_text_"+count)%><%}%><%}%>
    <%if(!r.empty("l_zad_"+count)){%> <%=r.get("l_zad_"+count)%><%}%>
    <%if(!r.empty("l_pered_"+count)){%> <%=r.get("l_pered_"+count)%><%}%>
<%}%><%}%>.
Мениски <%=r.get("l_men_"+count)%><%if(r.get("l_men_"+count).equals("изменены")){%><%if(!r.empty("l_giper_"+count) || !r.empty("l_gipo_"+count) || !r.empty("l_sign_"+count)){%> за счет:
    <%if(!r.empty("l_giper_"+count)){%> <%=r.get("l_giper_"+count)%><%}%>
    <%if(!r.empty("l_gipo_"+count)){%> <%=r.get("l_gipo_"+count)%><%}%>
    <%if(!r.empty("l_sign_"+count)){%> <%=r.get("l_sign_"+count)%><%}%>
<%}%>
<%if(!r.empty("l_oblast_"+count)){%>в области <%=r.get("l_oblast_"+count)%><%}%><%if(!r.empty("l_oblmenisk_"+count)){%> <%=r.get("l_oblmenisk_"+count)%><%}%><%if(!r.empty("l_menisk_how_"+count)){%> <%=r.get("l_menisk_how_"+count)%> мм<%}%><%}%>.
<%=r.get("l_vnesus_"+count)%><%if(!r.empty("l_mesto_"+count)){%> <%=r.get("l_mesto_"+count)%><%}%>.
Киста Бейкера <%=r.get("l_beker_"+count)%><%if(!r.empty("l_beker_how_"+count)){%> <%=r.get("l_beker_how_"+count)%> мм<%}%><%if(!r.empty("l_beker2_"+count)){%> <%=r.get("l_beker2_"+count)%><%}%>.
<%if(r.get("l_beker_"+count).equals("определяется размером")){%>Васкуляризация стенки кисты <%=r.get("l_beker_ki_"+count)%>.<%}%>

<%if(!r.empty("addition_" + count)){%><br><b>Дополнительные признаки:</b> <%=r.get("addition_" + count)%><%}%>
<br><b>Ультразвуковая картина характерна для:</b> <%=r.get("decision_" + count)%> <%=r.get("decision_text_" + count)%><br>
