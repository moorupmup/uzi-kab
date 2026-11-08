<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>
<%if(!r.empty("last_mens_"+count)){%>1-й день последней менструации &nbsp;<%=r.get("last_mens_"+count)%>.</b><%}%>
<%if(!r.empty("srok_ber_"+count)){%>срок беременности &nbsp;<%=r.get("srok_ber_"+count)%> нед.</b><%}%>
<br>В матке определяется <%=r.get("plod_"+count)%>. 
<%=r.get("predlej_"+count)%>, <%=r.get("poza_"+count)%>.
<%if(!r.empty("biparietalnii1_"+count)||!r.empty("okrujnost1_"+count)||!r.empty("lobnii_r1_"+count)||!r.empty("okrujnost_jivot1_"+count)||!r.empty("bedro_l1_"+count)||!r.empty("bedro_r1_"+count)||!r.empty("golen_l1_"+count)||!r.empty("golen_r1_"+count)||!r.empty("plecho_l1_"+count)||!r.empty("plecho_r1_"+count)||!r.empty("predplechie_l1_"+count)||!r.empty("predplechie_r1_"+count)||!r.empty("massa1_"+count)||!r.empty("srokneopred1_"+count)||!r.empty("razmer_ploda1_"+count)){%><br><b>Фетометрия <%if(r.get("plod_"+count).equals("два живых плода")){%>первого плода<%}%></b><%}%>
<%if(!r.empty("biparietalnii1_"+count)){%>Бипариетальный размер головки <%=r.get("biparietalnii1_"+count)%> мм.<%}%>
<%if(!r.empty("okrujnost1_"+count)){%>Окружность головы <%=r.get("okrujnost1_"+count)%> мм.<%}%>
<%if(!r.empty("lobnii_r1_"+count)){%><br>Лобно-затылочный размер    <%=r.get("lobnii_r1_"+count)%> мм.<%}%>
<%if(!r.empty("okrujnost_jivot1_"+count)){%>Окружность живота <%=r.get("okrujnost_jivot1_"+count)%> мм.<%}%>
<%if(!r.empty("bedro_l1_"+count)||!r.empty("bedro_r1_"+count)){%><br>Длина бедренной кости:<%if(!r.empty("bedro_l1_"+count)){%> левой <%=r.get("bedro_l1_"+count)%> мм.<%}%> <%if(!r.empty("bedro_r1_"+count)){%> правой <%=r.get("bedro_r1_"+count)%> мм.<%}%> <%}%>
<%if(!r.empty("golen_l1_"+count)||!r.empty("golen_r1_"+count)){%><br>Длина костей голени:<%if(!r.empty("golen_l1_"+count)){%> левой <%=r.get("golen_l1_"+count)%> мм.<%}%>  <%if(!r.empty("golen_r1_"+count)){%> правой <%=r.get("golen_r1_"+count)%> мм.<%}%> <%}%>
<%if(!r.empty("plecho_l1_"+count)||!r.empty("plecho_r1_"+count)){%><br>Длина плечевой кости:<%if(!r.empty("plecho_l1_"+count)){%> левой  <%=r.get("plecho_l1_"+count)%> мм.<%}%><%if(!r.empty("plecho_r1_"+count)){%> правой <%=r.get("plecho_r1_"+count)%> мм.<%}%> <%}%>
<%if(!r.empty("predplechie_l1_"+count)||!r.empty("predplechie_r1_"+count)){%><br>Длина костей предплечья:<%if(!r.empty("predplechie_l1_"+count)){%> левой <%=r.get("predplechie_l1_"+count)%> мм.<%}%><%if(!r.empty("predplechie_r1_"+count)){%> правой <%=r.get("predplechie_r1_"+count)%> мм.<%}%><%}%>
<%if(!r.empty("massa1_"+count)){%>Масса <%=r.get("massa1_"+count)%> гр.<%}%>
<%if(!r.empty("srokneopred1_"+count)){%><br>Размеры плода: <%=r.get("srokneopred1_"+count)%>.</b><%}%><%else{%><%if(!r.empty("razmer_ploda1_"+count)){%>Размеры плода соответствуют <%=r.get("razmer_ploda1_"+count)%> нед.<%}%><%}%>
<%if(r.get("plod_"+count).equals("два живых плода")){%>
<%if(!r.empty("biparietalnii2_"+count)||!r.empty("okrujnost2_"+count)||!r.empty("lobnii_r2_"+count)||!r.empty("okrujnost_jivot2_"+count)||!r.empty("bedro_l2_"+count)||!r.empty("bedro_r2_"+count)||!r.empty("golen_l2_"+count)||!r.empty("golen_r2_"+count)||!r.empty("plecho_l2_"+count)||!r.empty("plecho_r2_"+count)||!r.empty("predplechie_l2_"+count)||!r.empty("predplechie_r2_"+count)||!r.empty("massa2_"+count)||!r.empty("srokneopred2_"+count)||!r.empty("razmer_ploda2_"+count)){%><br><b>Фетометрия второго плода</b><br><%}%>
Положение <%=r.get("poloj2_"+count)%>
<%if(!r.empty("biparietalnii2_"+count)){%>Бипариетальный размер головки <%=r.get("biparietalnii2_"+count)%> мм.<%}%>
<%if(!r.empty("okrujnost2_"+count)){%>Окружность головы <%=r.get("okrujnost2_"+count)%> мм.<%}%>
<%if(!r.empty("lobnii_r2_"+count)){%><br>Лобно-затылочный размер    <%=r.get("lobnii_r2_"+count)%> мм.<%}%>
<%if(!r.empty("okrujnost_jivot2_"+count)){%>Окружность живота <%=r.get("okrujnost_jivot2_"+count)%> мм.<%}%>
<%if(!r.empty("bedro_l2_"+count)||!r.empty("bedro_r2_"+count)){%><br>Длина бедренной кости:<%if(!r.empty("bedro_l2_"+count)){%> левой <%=r.get("bedro_l2_"+count)%> мм.<%}%> <%if(!r.empty("bedro_r2_"+count)){%> правой <%=r.get("bedro_r2_"+count)%> мм.<%}%> <%}%>
<%if(!r.empty("golen_l2_"+count)||!r.empty("golen_r2_"+count)){%><br>Длина костей голени:<%if(!r.empty("golen_l2_"+count)){%> левой <%=r.get("golen_l2_"+count)%> мм.<%}%>  <%if(!r.empty("golen_r2_"+count)){%> правой <%=r.get("golen_r2_"+count)%> мм.<%}%> <%}%>
<%if(!r.empty("plecho_l2_"+count)||!r.empty("plecho_r2_"+count)){%><br>Длина плечевой кости:<%if(!r.empty("plecho_l2_"+count)){%> левой  <%=r.get("plecho_l2_"+count)%> мм.<%}%><%if(!r.empty("plecho_r2_"+count)){%> правой <%=r.get("plecho_r2_"+count)%> мм.<%}%> <%}%>
<%if(!r.empty("predplechie_l2_"+count)||!r.empty("predplechie_r2_"+count)){%><br>Длина костей предплечья:<%if(!r.empty("predplechie_l2_"+count)){%> левой <%=r.get("predplechie_l2_"+count)%> мм.<%}%><%if(!r.empty("predplechie_r2_"+count)){%> правой <%=r.get("predplechie_r2_"+count)%> мм.<%}%><%}%>
<%if(!r.empty("massa2_"+count)){%>Масса <%=r.get("massa2_"+count)%> гр.<%}%>
<%if(!r.empty("srokneopred2_"+count)){%><br>Размеры плода: <%=r.get("srokneopred2_"+count)%>.</b><%}%><%else{%><%if(!r.empty("razmer_ploda2_"+count)){%>Размеры плода соответствуют <%=r.get("razmer_ploda2_"+count)%> нед.<%}%><%}%>
<%}%>
<%if(!r.empty("ocenka_"+count)){%> <%=r.get("ocenka_"+count)%>.<br><%}%>
<%if(r.empty("ocenka_"+count)){%> 
    <br><b>Анатомия плода</b><br>
    Боковые желудочки мозга <%=r.get("mozg_"+count)%>  <%if(!r.empty("mozg_how_"+count)){%><%=r.get("mozg_how_"+count)%> мм.<%}%> <%if(!r.empty("mozg_text_"+count)){%><%=r.get("mozg_text_"+count)%><%}%>.
    Мозжечок <%=r.get("mozjechok_"+count)%><%if(!r.empty("mozjechok_how_"+count)){%> <%=r.get("mozjechok_how_"+count)%><%}%>.
    Большая цистерна <%=r.get("cisterna_"+count)%> <%if(!r.empty("cisterna_how_"+count)){%><%=r.get("cisterna_how_"+count)%> мм<%}%>.
    <br>Лицевые структуры: профиль <%=r.get("profil_"+count)%><%if(!r.empty("profil_how_"+count)){%> <%=r.get("profil_how_"+count)%><%}%>,
     носогубный треугольник <%=r.get("nos_"+count)%><%if(!r.empty("nos_how_"+count)){%> <%=r.get("nos_how_"+count)%><%}%>,
     глазницы <%=r.get("glaznica_"+count)%><%if(!r.empty("glaznica_how_"+count)){%> <%=r.get("glaznica_how_"+count)%> мм<%}%>.<%if(!r.empty("glaznica_text_"+count)){%> <%=r.get("glaznica_text_"+count)%>.<%}%>
    Позвоночник <%=r.get("pozvonochnik_"+count)%><%if(!r.empty("defectpoz_"+count)){%> <%=r.get("defectpoz_"+count)%> <%=r.get("pozv_how_"+count)%><%}%>.
    Легкие <%=r.get("legkie_"+count)%> <%=r.get("stadlegkie_"+count)%><%if(!r.empty("legkie_how_"+count)){%> <%=r.get("legkie_how_"+count)%><%}%>.
    <br>Эхокардиография: <%=r.get("ehokard_"+count)%><%if(!r.empty("ehokardio_how_"+count)){%> <%=r.get("ehokardio_how_"+count)%><%}%>.
    <br>Желудок <%=r.get("jeludok_"+count)%><%if(!r.empty("jeludok_how_"+count)){%> <%=r.get("jeludok_how_"+count)%><%}%>.
    Мочевой пузырь <%=r.get("mocha_"+count)%><%if(!r.empty("mocha_how_"+count)){%> <%=r.get("mocha_how_"+count)%><%}%>.
    Кишечник <%=r.get("kishki_"+count)%> <%=r.get("stadkishki_"+count)%><%if(!r.empty("kishki_how_"+count)){%> <%=r.get("kishki_how_"+count)%><%}%>.
    Почки <%if(!r.empty("pochki_"+count)){%><%=r.get("pochki_"+count)%><%}%> <%if(!r.empty("lohanka_how_"+count)){%> <%=r.get("lohanka_how_"+count)%><%}%>. 
    <%if(!r.empty("lohankar_"+count)){%><%=r.get("lohankar_"+count)%> <%=r.get("lohanka_r_"+count)%> мм.<%}%>
    <%if(!r.empty("lohankal_"+count)){%><%=r.get("lohankal_"+count)%> <%=r.get("lohanka_l_"+count)%> мм.<%}%>
    <br>Место прикрепления пуповины к передней брюшной стенке <%=r.get("mesto_"+count)%><%if(!r.empty("mesto_how_"+count)){%> <%=r.get("mesto_how_"+count)%> мм<%}%>.
    <br>
<%}%>
<%if(r.get("kolplacent_"+count).equals("визуализируются две плаценты")){%>Визуализируются две плаценты:<br><b>Плацента первого плода</b><%}else{%><b>Плацента.</b><br><%if(!r.empty("kolplacent_"+count)){%> <%=r.get("kolplacent_"+count)%>.<%}%><%}%>
Преимущественная локализация плаценты <%=r.get("first_placenta_"+count)%><%if(!r.empty("first_perehod_"+count)){%> с переходом на <%=r.get("first_perehod_"+count)%><%}%>. <%if(!r.empty("first_placenta_how_"+count)){%> <%=r.get("first_placenta_how_"+count)%>.<%}%>
Степень зрелости <%=r.get("first_zrelost_"+count)%>.
<br>Толщина плаценты <%=r.get("first_tolshina_"+count)%> <%if(!r.empty("first_tolshina_how_"+count)){%>до <%=r.get("first_tolshina_how_"+count)%> мм<%}%>.
<%if(!r.empty("first_tolshina_text_"+count)){%> <%=r.get("first_tolshina_text_"+count)%>.<%}%>
<%if(r.get("kolplacent_"+count).equals("визуализируются две плаценты")){%><br><b>Плацента второго плода</b>
Преимущественная локализация плаценты <%=r.get("second_placenta_"+count)%><%if(!r.empty("second_perehod_"+count)){%> с переходом на <%=r.get("second_perehod_"+count)%><%}%>. <%if(!r.empty("second_placenta_how_"+count)){%> <%=r.get("second_placenta_how_"+count)%>.<%}%>
Степень зрелости <%=r.get("second_zrelost_"+count)%>.
<br>Толщина плаценты <%=r.get("second_tolshina_"+count)%> <%if(!r.empty("second_tolshina_how_"+count)){%>до <%=r.get("second_tolshina_how_"+count)%> мм<%}%>.
<%if(!r.empty("second_tolshina_text_"+count)){%> <%=r.get("second_tolshina_text_"+count)%>.<%}%>
<%}%>
<br><b>Околоплодные воды, пуповина</b><br>
Количество околоплодных вод <%=r.get("vodi_"+count)%>. <%if(!r.empty("vodi_text_"+count)){%><%=r.get("vodi_text_"+count)%>.<%}%>
<%if(!r.empty("index_jidkosti_"+count)){%>Индекс амниотической жидкости <%=r.get("index_jidkosti_"+count)%> мм.<%}%>
<br>Пуповина имеет <%=r.get("pupovina_"+count)%> сосуда. <%=r.get("obvitie_"+count)%>

<%if(r.get("plod_"+count).equals("один живой плод")){%>
    <%if(!r.empty("yzgd_how1_"+count)){%><br>УЗДГ плода. Плодово-плацентарный кровоток <%=r.get("yzgd1_"+count)%> <%=r.get("yzgd_how1_"+count)%>.<%}%>
<%}%>
<%if(r.get("plod_"+count).equals("два живых плода")){%>
    <%if(!r.empty("yzgd_how11_"+count)){%><br>УЗДГ первого плода. Плодово-плацентарный кровоток <%=r.get("yzgd11_"+count)%> <%=r.get("yzgd_how11_"+count)%>.<%}%>
    <%if(!r.empty("yzgd_how22_"+count)){%><br>УЗДГ второго плода. Плодово-плацентарный кровоток <%=r.get("yzgd22_"+count)%> <%=r.get("yzgd_how22_"+count)%>.<%}%>
<%}%>
Врожденные пороки развития плода при исследовании <%=r.get("poroki_"+count)%>.
<br>
<%if(r.get("osobmatki_"+count).equals("без особенностей")){%><b>Особенностей строения шейки и стенок матки нет.</b><br><%}else{%>
<b>Особенности строения шейки и стенок матки</b><br>
<%if(!r.empty("myppsr_"+count) && !r.empty("yzel_pered_how_"+count)){%><%=r.get("myppsr_"+count)%> <%=r.get("yzel_pered_how_"+count)%> мм.<%}%>
<%if(!r.empty("mypzadsr_"+count) && !r.empty("yzel_zad_how_"+count)){%><%=r.get("mypzadsr_"+count)%> <%=r.get("yzel_zad_how_"+count)%> мм.<%}%>
<%if(!r.empty("mypprr_"+count)&&!r.empty("yzel_rebro_r_how_"+count)){%><%=r.get("mypprr_"+count)%> <%=r.get("yzel_rebro_r_how_"+count)%> мм.<%}%>
<%if(!r.empty("myplrr_"+count)&&!r.empty("yzel_rebro_l_how_"+count)){%><%=r.get("myplrr_"+count)%> <%=r.get("yzel_rebro_l_how_"+count)%> мм.<%}%>
<%if(!r.empty("myvdr_"+count)&&!r.empty("yzel_dno_how_"+count)){%><%=r.get("myvdr_"+count)%> <%=r.get("yzel_dno_how_"+count)%> мм.<%}%>
<%}%>
Область придатков <%=r.get("pridatki_"+count)%><%if(!r.empty("pridatki_how_"+count)){%> <%=r.get("pridatki_how_"+count)%> мм<%}%>.
Визуализация <%=r.get("vizualizac_"+count)%><%if(!r.empty("vizualizac_how_"+count)){%> <%=r.get("vizualizac_how_"+count)%><%}%>.
Почки беременной: <%if(!r.empty("pochki_berem_"+count)){%><%=r.get("pochki_berem_"+count)%>.<%}else{%><%if(!r.empty("chkalik_"+count)||!r.empty("chpoliek_"+count)||!r.empty("chtransform_"+count)){%>
<%if(!r.empty("chkalik_"+count)){%><%=r.get("chkalik_"+count)%> <%=r.get("kalik_"+count)%><%if(!r.empty("chkalik_how_"+count)){%> <%=r.get("chkalik_how_"+count)%> мм.<%}%><%}%>
<%if(!r.empty("chpoliek_"+count)){%><%=r.get("chpoliek_"+count)%> <%=r.get("poliek_"+count)%><%if(!r.empty("chpoliek_how_"+count)){%> <%=r.get("chpoliek_how_"+count)%> мм.<%}%><%}%>
<%if(!r.empty("chtransform_"+count)){%><%=r.get("chtransform_"+count)%> <%=r.get("transform_"+count)%><%}%><%}%>.<%}%>
<%if(!r.empty("addition_" + count)){%><br><b>Дополнительные признаки:</b> <%=r.get("addition_" + count)%><%}%>
<br><b>Ультразвуковая картина характерна для:</b> <%=r.get("decision_" + count)%> <%=r.get("decision_text_" + count)%><br>
