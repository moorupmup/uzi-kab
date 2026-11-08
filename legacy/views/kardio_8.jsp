<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>

<br>
<%if(!r.empty("chss_"+count)){%>ЧСС: <%=r.get("chss_"+count)%>.<%}%>
<%if(!r.empty("rost_"+count)){%>Рост: <%=r.get("rost_"+count)%>.<%}%>
<%if(!r.empty("ves_"+count)){%>Вес: <%=r.get("ves_"+count)%>.<%}%>
<%if(!r.empty("ploshad_"+count)){%>Площадь поверхности тела: <%=r.get("ploshad_"+count)%> м2.<%}%>
<%if(!r.empty("chss_"+count) || !r.empty("rost_"+count) || !r.empty("ves_"+count)){%><br><%}%>
<br>Аорта <%=r.get("aorta_"+count)%>.
<%if(!r.empty("koren_"+count)){%> Корень аорты <%=r.get("koren_"+count)%> см.<%}%>
<%if(!r.empty("otdel_"+count)){%> Восх.отдел <%=r.get("otdel_"+count)%> см.<%}%><br>
Левое предсердие <%=r.get("predserdie_"+count)%><%if(!r.empty("lpred_"+count)){%> <%=r.get("lpred_"+count)%> см<%}%>.
<br>
Левый желудочек <%=r.get("jeludochek_"+count)%>.<br>
<table width="90%" border="0">
<%if(!r.empty("kdr_"+count)){%><tr>
        <td width="16%"><%if(!r.empty("kdr_"+count)){%>КДР:<%}%></td>
        <td width="16%"><%if(!r.empty("kdr_"+count)){%><%=r.get("kdr_"+count)%> см.<%}%></td>
        <td width="16%"><%if(!r.empty("kdo_"+count)){%>КДО:<%}%></td>
        <td width="16%"><%if(!r.empty("kdo_"+count)){%><%=r.get("kdo_"+count)%> мл.<%}%></td>
        <td width="16%"><%if(!r.empty("yo_"+count)){%>УО:<%}%></td>
        <td width="16%"><%if(!r.empty("yo_"+count)){%><%=r.get("yo_"+count)%> мл.<%}%></td>
    </tr><%}%>
<%if(!r.empty("kcr_"+count)){%><tr>
        <td width="16%"><%if(!r.empty("kcr_"+count)){%>КСР:<%}%></td>
        <td width="16%"><%if(!r.empty("kcr_"+count)){%><%=r.get("kcr_"+count)%> см.<%}%></td>
        <td width="16%"><%if(!r.empty("kco_"+count)){%>КСО:<%}%></td>
        <td width="16%"><%if(!r.empty("kco_"+count)){%><%=r.get("kco_"+count)%> мл.<%}%></td>
        <td width="16%"><%if(!r.empty("mo_"+count)){%>МО:<%}%></td>
        <td width="16%"><%if(!r.empty("mo_"+count)){%><%=r.get("mo_"+count)%> л/мин.<%}%></td>
    </tr><%}%>
</table>
<%if(!r.empty("mpj_"+count)){%>МЖП <%=r.get("mpj_"+count)%> см.</br><%}%>
<%if(!r.empty("zs_lj_"+count)){%>Задняя стенка ЛЖ <%=r.get("zs_lj_"+count)%> см.</br><%}%>
<%if(!r.empty("ots_lj_"+count)){%>Относительная толщина стенок ЛЖ <%=r.get("ots_lj_"+count)%>. </br><%}%>

Правое предсердие <%=r.get("r_predserdie_"+count)%> <%if(!r.empty("ppred1_"+count) && !r.empty("ppred2_"+count)){%><%=r.get("ppred1_"+count)%>*<%=r.get("ppred2_"+count)%> см<%}%>.<br>
Правый желудочек <%=r.get("r_jeludochek_"+count)%> <%if(!r.empty("pjel_"+count)){%><%=r.get("pjel_"+count)%> см<%}%>.<br>
<br>
<b>Сократительная способность миокарда:</b> <%=r.get("frakcija_"+count)%>.<br>
<%if(!r.empty("vibros_"+count)){%>Фракция выброса <%=r.get("vibros_"+count)%> %<br><%}%>
<%if(!r.empty("ykor_"+count)){%>Фракция укорочения ЛЖ <%=r.get("ykor_"+count)%> %<br><%}%>
<%if(!r.empty("massa_mk_"+count)){%>Масса миокарда ЛЖ <%=r.get("massa_mk_"+count)%> г.</br><%}%>
<%if(!r.empty("index_mm_"+count)){%>Индекс массы миокарда <%=r.get("index_mm_"+count)%> г/м2</br><%}%>
<%if(!r.empty("fk_ak_"+count)){%>Фиброзное кольцо АК <%=r.get("fk_ak_"+count)%> см.<%if(r.empty("fk_mk_"+count)){%><br><%}%><%}%>
<%if(!r.empty("fk_mk_"+count)){%>Фиброзное кольцо МК <%=r.get("fk_mk_"+count)%> см.</br><%}%>
<%if(!r.empty("fk_la_"+count)){%>Фиброзное кольцо ЛА <%=r.get("fk_la_"+count)%> см.<%if(r.empty("fk_tk_"+count)){%><br><%}%><%}%>
<%if(!r.empty("fk_tk_"+count)){%>Фиброзное кольцо ТК <%=r.get("fk_tk_"+count)%> см.<br><%}%>

<br>
<b>Допплерометрия:</b> 
<%if(!r.empty("doplero_"+count)){%> <%=r.get("doplero_"+count)%><%}%>
<%if(!r.empty("trans_"+count)){%> <%=r.get("trans_"+count)%>.<%}%>

<%if(!r.empty("sm_size_"+count) || !r.empty("em_size_"+count) || !r.empty("am_size_"+count)){%>
Тканевая допплерометрия митрального фиброзного кольца:
<%if(!r.empty("sm_size_"+count)){%>Sm <%=r.get("sm_size_"+count)%> м/с,<%}%> 
<%if(!r.empty("em_size_"+count)){%>Em <%=r.get("em_size_"+count)%> м/с,<%}%>
<%if(!r.empty("am_size_"+count)){%>Am <%=r.get("am_size_"+count)%> м/с,<%}%>
<%if(!r.empty("em_am_"+count)){%>Em/Am <%=r.get("em_am_"+count)%><%}%>.
<%}%>

<%if(r.empty("doplero_"+count) && r.empty("ssap_"+count) && r.empty("sspp_"+count) && r.empty("sdmp_"+count) && r.empty("sshp_"+count)){%> патологических потоков нет.<%} else{%>
<%if(!r.empty("ssap_"+count) || !r.empty("ssap_gd_"+count)){%></br>Скорость сист. аортального потока
    <%if(!r.empty("ssap_"+count)){%> <%=r.get("ssap_"+count)%> м/с<%}%>
    <%if(!r.empty("ssap_gd_"+count)){%> ГД= <%=r.get("ssap_gd_"+count)%> мм рт.ст.<%}%>
<%}%>
<%if(!r.empty("sspp_"+count) || !r.empty("sspp_gd_"+count)){%></br>Скорость сист. пульмонального потока
    <%if(!r.empty("sspp_"+count)){%> <%=r.get("sspp_"+count)%> м/с<%}%>
    <%if(!r.empty("sspp_gd_"+count)){%> ГД= <%=r.get("sspp_gd_"+count)%> мм рт.ст.<%}%>
<%}%>
<%if(!r.empty("sdmp_a_"+count) || !r.empty("sdmp_gd_"+count)){%></br>Скорость диаст. митрального потока
    <%if(!r.empty("sdmp_e_"+count)){%>E = <%=r.get("sdmp_e_"+count)%> м/с<%}%>
    <%if(!r.empty("sdmp_a_"+count)){%>A = <%=r.get("sdmp_a_"+count)%> м/с<%}%>
    <%if(!r.empty("sdmp_gd_"+count)){%> ГД= <%=r.get("sdmp_gd_"+count)%> мм рт.ст.<%}%>
    <%if(!r.empty("sdmp_ea_"+count)){%> E/A= <%=r.get("sdmp_ea_"+count)%><%}%>
<%}%>
<%if(!r.empty("sshp_a_"+count) || !r.empty("sshp_gd_"+count)){%></br>Скорость шунтируемого потока
    <%if(!r.empty("sshp_"+count)){%> <%=r.get("sshp_"+count)%> м/с<%}%>
    <%if(!r.empty("sshp_gd_"+count)){%> ГД= <%=r.get("sshp_gd_"+count)%> мм рт.ст.<%}%>
<%}%><%}%>
<%if(!r.empty("chrhmk_pr_"+count)){%><br><%=r.get("chrhmk_pr_"+count)%> <%=r.get("rhmk_pr_"+count)%> при цветном картировании площадь регургитации занимает <%=r.get("rhmkp_pr_"+count)%> площади предсердия.<%}%>
<%if(!r.empty("chrhmk_int_"+count)){%><br><%=r.get("chrhmk_int_"+count)%> <%=r.get("rhmk_int_"+count)%> при цветном картировании площадь струи регургитации составляет <%=r.get("rhmkp_int_"+count)%> см2.<%}%>
<%if(!r.empty("chrhak_"+count)){%><br><%=r.get("chrhak_"+count)%> <%=r.get("rhak_"+count)%>.<%}%>
<%if(!r.empty("chrhtk_pr_"+count)){%><br><%=r.get("chrhtk_pr_"+count)%> <%=r.get("rhtk_pr_"+count)%> при цветном картировании площадь регургитации занимает <%=r.get("rhtkp_pr_"+count)%> площади предсердия.<%}%>
<%if(!r.empty("chrhtk_int_"+count)){%><br><%=r.get("chrhtk_int_"+count)%> <%=r.get("rhtk_int_"+count)%> при цветном картировании площадь струи регургитации составляет <%=r.get("rhtkp_int_"+count)%> см2.<%}%>
<%if(!r.empty("chrhkla_"+count)){%><br><%=r.get("chrhkla_"+count)%> <%=r.get("rhkla_"+count)%>.<%}%>

<%if(!r.empty("komment_"+count)){%><br><br><b>Комментарии:</b> <%=r.get("komment_"+count)%><%}%>

<%if(!r.empty("addition_" + count)){%><br><br><b>Дополнительные признаки:</b> <%=r.get("addition_" + count)%><%}%>
<br><br><b>Ультразвуковая картина характерна для:</b> <%=r.get("decision_" + count)%> <%=r.get("decision_text_" + count)%><br>
