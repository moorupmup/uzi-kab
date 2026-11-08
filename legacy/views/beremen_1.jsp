<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>

<%if(!r.empty("mens_text")){%> Первый день последней менструации <%=r.get("mens_text")%>.<br><%}%>
<%if(!r.empty("srok_ber")){%> Срок беременности <%=r.get("srok_ber")%>.<br><%}%>
<%if(!r.empty("data_roda")){%> Предполагаемая дата родов <%=r.get("data_roda")%>.<br><%}%>
В полости матки визуализируется <%=r.get("plod")%>
в <%=r.get("plod_predl")%> предлежании
Положение плода <%=r.get("plod_poloj")%>.<br>
Позиция <%=r.get("poza")%>.
Вид <%=r.get("vid")%>.<br>
<b>Фетометрия:</b><br>
<%if(!r.empty("razm_gol")){%> Бипариетальный размер головки <%=r.get("razm_gol")%> мм.<%}%>
<%if(!r.empty("okr_golov")){%>Окружность головы <%=r.get("okr_golov")%> мм.<%}%>
<%if(!r.empty("lob_zat")){%>Лобно-затылочный размер <%=r.get("lob_zat")%> мм.<%}%>
<%if(!r.empty("okr_jiv")){%>Окружность живота <%=r.get("okr_jiv")%> мм.<%}%>
<%if(!r.empty("bed_l") || !r.empty("bed_r")){%>
    Длина бедренной кости 
    <%if(!r.empty("bed_l")){%>левой <%=r.get("bed_l")%> мм<%}%>
    <%if(!r.empty("bed_r")){%>правой <%=r.get("bed_r")%> мм<%}%>.
<%}%>
<%if(!r.empty("golen_l") || !r.empty("golen_r")){%> 
    Длина костей голени
    <%if(!r.empty("golen_l")){%>левой <%=r.get("golen_l")%> мм<%}%>
    <%if(!r.empty("golen_r")){%>правой <%=r.get("golen_r")%> мм<%}%>.
<%}%>
<%if(!r.empty("plech_l") || !r.empty("plech_r")){%>
    Длина плечевой кости 
    <%if(!r.empty("plech_l")){%>левой <%=r.get("plech_l")%> мм<%}%>
    <%if(!r.empty("plech_r")){%>правой <%=r.get("plech_r")%> мм<%}%>.
<%}%>
<%if(!r.empty("predp_l") || !r.empty("predp_r")){%>
    Длина костей предплечья 
    <%if(!r.empty("predp_l")){%>левой <%=r.get("predp_l")%> мм<%}%>
    <%if(!r.empty("predp_r")){%>правой <%=r.get("predp_r")%> мм<%}%>.
<%}%>
<%if(!r.empty("ned_ber")){%>Размеры плода соответствуют <%=r.get("ned_ber")%> нед.<%}%>
<%if(!r.empty("bad_srok")){%> <%=r.get("bad_srok")%>.<%}%>
<%if(!r.empty("ves")){%>Вес <%=r.get("ves")%> г.<%}%>
<br><b>Анатомия плода:</b><br>
<%if(!r.empty("mozg") || !r.get("sel_mozg").equals("")){%>
    Боковые желудочки мозга <%=r.get("sel_mozg")%> 
    <%if(!r.empty("mozg")){%>
        <%=r.get("mozg")%> мм
    <%}%>.
<%}%>
<%if(!r.empty("mozj") || !r.get("sel_mozj").equals("")){%>
    Мозжечок <%=r.get("sel_mozj")%> <%=r.get("mozj")%>.
<%}%>
<%if(!r.empty("bolsh_c") || !r.get("sel_bolsh_c").equals("")){%>
    Большая цистерна <%=r.get("sel_bolsh_c")%>
    <%if(!r.empty("bolsh_c")){%>
        <%=r.get("bolsh_c")%> мм
    <%}%>.
<%}%>
<%if(!r.empty("prof") || !r.empty("nos") || !r.empty("glaz") || !r.get("sel_prof").equals("") || !r.get("sel_nos").equals("") || !r.get("sel_glaz").equals("")){%> 
    Лицевые структуры:
    <%if(!r.empty("prof") || !r.get("sel_prof").equals("")){%>
        профиль <%=r.get("sel_prof")%> <%=r.get("prof")%>
    <%}%>
    <%if(!r.empty("nos") || !r.get("sel_nos").equals("")){%>
        носогубный треугольник <%=r.get("sel_nos")%> <%=r.get("nos")%>
    <%}%>
    <%if(!r.empty("glaz") || !r.get("sel_glaz").equals("")){%>
        глазницы <%=r.get("sel_glaz")%> <%=r.get("glaz")%>
    <%}%>.
<%}%>
<%if(!r.empty("pozv") || !r.get("sel_pozv").equals("")){%>
    Позвоночник <%=r.get("sel_pozv")%> <%=r.get("pozv")%>.
<%}%>
<%if(!r.empty("legkie") || !r.get("sel_legkie").equals("")){%>
    Легкие <%=r.get("sel_legkie")%> <%=r.get("legkie")%>.
<%}%>
<%if(!r.empty("serdce") || !r.get("sel_serdce").equals("")){%>
    Четырехкамерный срез сердца <%=r.get("sel_serdce")%> <%=r.get("serdce")%>.
<%}%>
<%if(!r.empty("jelud") || !r.get("sel_jelud").equals("")){%>
    Желудок <%=r.get("sel_jelud")%> <%=r.get("jelud")%>.
<%}%>
<%if(!r.empty("kishki") || !r.get("sel_kishki").equals("")){%>
    Кишечник <%=r.get("sel_kishki")%> <%=r.get("kishki")%>.
<%}%>
<%if(!r.empty("pochki") || !r.get("sel_pochki").equals("")){%>
    Почки <%=r.get("sel_pochki")%> <%=r.get("pochki")%>.
<%}%>
<%if(!r.empty("mocha") || !r.get("sel_mocha").equals("")){%>
    Мочевой пузырь <%=r.get("sel_mocha")%> <%=r.get("mocha")%>.
<%}%>

<br><b>Плацента, околоплодные воды, пуповина:</b>
Преимущественная локализация плаценты <%=r.get("plac1")%> <%=r.get("plac2")%>.
Толщина плаценты <%=r.get("tolsh_p")%>
<%if(!r.empty("tolsh_text")){%> <%=r.get("tolsh_text")%> мм.<%}%>
<%if(!r.empty("zrelost")){%>Степень зрелости плаценты <%=r.get("zrelost")%>.<%}%>
Количество околоплодных вод <%=r.get("vodi")%>
<%if(!r.empty("index")){%>индекс амниотической жидкости <%=r.get("index")%> мм.<%}%>
<%if(!r.empty("sosud")){%>Пуповина имеет <%=r.get("sosud")%> сосуда.<%}%>
<%if(!r.empty("pp_sd") || !r.empty("pp_ir")){%>
    <br><b>УЗДГ плода:</b>плодово-плацентарный кровоток
    <%if(!r.empty("pp_sd")){%>
        С/Д <%=r.get("pp_sd")%>    
    <%}%>
    <%if(!r.empty("pp_ir")){%>
        ИР <%=r.get("pp_ir")%>
    <%}%>
    <%=r.get("pp_norma")%>
<%}%>
<%if(!r.empty("mp_sd") || !r.empty("mp_ir")){%>
    <br>маточно-плацентарный кровоток
    <%if(!r.empty("mp_sd")){%>
        С/Д <%=r.get("mp_sd")%>    
    <%}%>
    <%if(!r.empty("mp_ir")){%>
        ИР <%=r.get("mp_ir")%>
    <%}%>
    <%=r.get("mp_norma")%>
<%}%>
<br><b>Врожденные пороки развития плода:</b> <%=r.get("poroki")%> <%=r.get("poroki_text")%>.
<%if(!r.empty("stenki_text") || !r.get("osob_stroi").equals("")){%><BR><b>Особенности строения шейки и стенок матки</b> <%=r.get("osob_stroi")%> <%=r.get("stenki_text")%>.<%}%>
<%if(!r.empty("pridatki")|| !r.get("obl_pr").equals("")){%><br><b>Область придатков</b> <%=r.get("obl_pr")%> <%=r.get("pridatki")%>.<%}%>
<br>Визуализация: <%=r.get("vizual")%>
<%if(!r.empty("viz_text")){%> <%=r.get("viz_text")%><%}%>.
<BR>Почки беременной <%=r.get("pochki_ber")%> 
<%if(!r.empty("chash")){%>
    чашечки расширенные до <%=r.get("chash")%> мм <%=r.get("chash_gde")%>
<%}%>
<%if(!r.empty("loh")){%>
    лоханка расширенна до <%=r.get("loh")%> мм <%=r.get("loh_gde")%>
<%}%>
<%=r.get("pochki_text")%>.
<%if(!r.empty("rek_text")){%><BR>Рекомендации: <%=r.get("rek_text")%>.<%}%>
<%if(!r.empty("kontrol_text")){%><BR>Ультразвуковой контроль в <%=r.get("kontrol_text")%> нед.<%}%>
