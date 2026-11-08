<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>
<b>Диаметр ВСВ в области наружного пахового кольца в положении стоя.</b><%if(!r.empty("vsv_pokoi_"+count)){%> В покое <%=r.get("vsv_pokoi_"+count)%> мм.<%}%>
<%if(!r.empty("vsv_natug_"+count)){%> При натуживании <%=r.get("vsv_natug_"+count)%> мм.<%}%>
<b>Рефлюкс.</b> Продолжительность <%=r.get("diametr_"+count)%>.
<%if(!r.empty("speed_"+count)){%> Скорость <%=r.get("speed_"+count)%> см/c.<%}%>
<%if(!r.empty("razm_prav_yaichka1_"+count) || !r.empty("razm_prav_yaichka2_"+count) || !r.empty("razm_prav_yaichka3_"+count)){%>
<b>Размер правого яичка:</b>
<%if(!r.empty("razm_prav_yaichka1_"+count)){%> <%=r.get("razm_prav_yaichka1_"+count)%> мм.<%}%>
<%if(!r.empty("razm_prav_yaichka2_"+count)){%> <%=r.get("razm_prav_yaichka2_"+count)%> мм.<%}%>
<%if(!r.empty("razm_prav_yaichka3_"+count)){%> <%=r.get("razm_prav_yaichka3_"+count)%> мм.<%}%>
<%}%>
<%if(!r.empty("razm_lev_yaichka1_"+count) || !r.empty("razm_lev_yaichka2_"+count) || !r.empty("razm_lev_yaichka3_"+count)){%>
<b>Размер левого яичка:</b>
<%if(!r.empty("razm_lev_yaichka1_"+count)){%> <%=r.get("razm_lev_yaichka1_"+count)%> мм.<%}%>
<%if(!r.empty("razm_lev_yaichka2_"+count)){%> <%=r.get("razm_lev_yaichka2_"+count)%> мм.<%}%>
<%if(!r.empty("razm_lev_yaichka3_"+count)){%> <%=r.get("razm_lev_yaichka3_"+count)%> мм.<%}%>
<%}%>
<%if(!r.empty("r_rezis_how_"+count) || !r.empty("l_rezis_how_"+count)){%> Индекс резистентности
<%if(!r.empty("r_rezis_how_"+count)){%> Справа: <%=r.get("r_rezis_how_"+count)%> (норма 0.62 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 0.05).<%}%>
<%if(!r.empty("l_rezis_how_"+count)){%> Слева: <%=r.get("l_rezis_how_"+count)%> (норма 0.62 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 0.05).<%}%>
<%}%>
<%if(!r.empty("komp_vsv_pokoi_"+count) || !r.empty("komp_vsv_natug_"+count)){%>
<br><b>При проведении пробы Тробетта.</b>
При компрессии в положении стоя диаметр ВСВ:
<%if(!r.empty("komp_vsv_pokoi_"+count)){%> В покое <%=r.get("komp_vsv_pokoi_"+count)%> мм.<%}%>
<%if(!r.empty("komp_vsv_natug_"+count)){%> При натуживании <%=r.get("komp_vsv_natug_"+count)%> мм.<%}%>
<%}%>
<%if(!r.empty("posle_vsv_"+count)){%><br>После снятия компрессии диаметр ВСВ: <%=r.get("posle_vsv_"+count)%> мм.<%}%>
<%if(!r.empty("visual_"+count)){%><br><b><%=r.get("visual_"+count)%></b>
<%if(!r.empty("visual_vsv_pokoi_"+count) || !r.empty("visual_vsv_natug_"+count)){%>
<br><b>Диаметр ВСВ:</b>
<%if(!r.empty("visual_vsv_pokoi_"+count)){%> В покое <%=r.get("visual_vsv_pokoi_"+count)%> мм.<%}%>
<%if(!r.empty("visual_vsv_natug_"+count)){%> При натуживании <%=r.get("visual_vsv_natug_"+count)%> мм.<%}%>
<%}%>
<b>Рефлюкс.</b> Продолжительность:<%=r.get("diametr_vis_"+count)%>
<%if(!r.empty("proks_chast_"+count) || !r.empty("aorta_mez_"+count) || !r.empty("dist_chast_"+count)){%>
<br><b>Диаметр ЛПВ:</b>
<%if(!r.empty("proks_chast_"+count)){%> Проксимальная часть <%=r.get("proks_chast_"+count)%> мм.<%}%>
<%if(!r.empty("aorta_mez_"+count)){%> Аорто - мезентериальный сегмент <%=r.get("aorta_mez_"+count)%> мм.<%}%>
<%if(!r.empty("dist_chast_"+count)){%> Дистальная часть <%=r.get("dist_chast_"+count)%> мм.<%}%>
<%}%>
<%if(!r.empty("haracter_"+count)){%> Характер кровотока по ЛПВ <%=r.get("haracter_"+count)%>.<%}%>
<%if(!r.empty("linel_skor_lpv_"+count) || !r.empty("linel_skor_ppv_"+count)){%>
<%if(!r.empty("diamtr_ppv_"+count)){%> <b>Диаметр ППВ</b> <%=r.get("diamtr_ppv_"+count)%> мм.<%}%>
<%if(!r.empty("diamtr_npv_"+count)){%> <b>Диаметр НПВ</b> <%=r.get("diamtr_npv_"+count)%> мм.<%}%>
<br>Линейная скорость кровотока:
<%if(!r.empty("linel_skor_lpv_"+count)){%> по ЛПВ <%=r.get("linel_skor_lpv_"+count)%> см/c.<%}%>
<%if(!r.empty("linel_skor_ppv_"+count)){%> по ППВ <%=r.get("linel_skor_ppv_"+count)%> см/c.<%}%>
<%}%>
<%}%>
<%if(!r.empty("addition_" + count)){%><br><b>Дополнительные признаки:</b> <%=r.get("addition_" + count)%><%}%>
<br><b>Ультразвуковая картина характерна для:</b> <%=r.get("decision_" + count)%> <%=r.get("decision_text_" + count)%><br>
