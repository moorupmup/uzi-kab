<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>
<b>Воротная вена</b>
<%if(!r.empty("vorot_diametr_how_"+count)){%>Диаметр <%=r.get("vorot_diametr_how_"+count)%> мм.<%}%>
Направление кровотока: <%=r.get("napr_krovotok_"+count)%>.
Вид спектра: <%=r.get("vid_spectra_vorot_"+count)%>.
<%if(!r.empty("sred_v_krovotok_how_"+count)){%>Средняя линейная скорость кровотока (N - не ниже 15 см/сек.): <%=r.get("sred_v_krovotok_how_"+count)%> см/сек.<%}%>
<%if(!r.empty("o_v_krovotok_how_"+count)){%>Объемная скорость кровотока Vvol = <%=r.get("o_v_krovotok_how_"+count)%> л/мин.<%}%>
Реакция на пробу с пищевой нагрузкой: <%=r.get("reakciya_"+count)%>.
<%if(!r.empty("selez_diametr_how_"+count) || !r.empty("v_krovotok_how_"+count) || !r.empty("selez_v_krovotok_how_"+count)){%><br><b>Селезеночная вена</b><%}%>
<%if(!r.empty("selez_diametr_how_"+count)){%>Диаметр <%=r.get("selez_diametr_how_"+count)%> мм.<%}%>
<%if(!r.empty("v_krovotok_how_"+count)){%>Линейная скорость кровотока (в норме чуть меньше, чем ВВ, в среднем 17 - 20 см/сек.): <%=r.get("v_krovotok_how_"+count)%> см/сек.<%}%>
<%if(!r.empty("selez_v_krovotok_how_"+count)){%>Объемная скорость кровотока (примерно 50% от Vvol ВВ или Vvol CB/Vvol BB не более 50%) Vvol = <%=r.get("selez_v_krovotok_how_"+count)%> см/сек.<%}%>
<br><b>Печеночная артерия</b>
<%if(!r.empty("pechen_diametr_how_"+count)){%>Диаметр <%=r.get("pechen_diametr_how_"+count)%> мм.<%}%>
Вид спектра: <%=r.get("vid_spectra_pechen_"+count)%>.
<%if(!r.empty("sistol_how_"+count)){%>Систолическая скорость <%=r.get("sistol_how_"+count)%> мм.<%}%>
<%if(!r.empty("diastol_how_"+count)){%>Диастолическая скорость <%=r.get("diastol_how_"+count)%> мм.<%}%>
<br><b>Печеночные вены</b>
<%if(!r.empty("pechen_veny_diametr_how_"+count)){%>Диаметр <%=r.get("pechen_veny_diametr_how_"+count)%> мм.<%}%>
Печеночные вены <%=r.get("pechen_veny_"+count)%>.
Направление кровотока: <%=r.get("napr_krovotok_"+count)%>.
<br><b>Нижняя полая вена</b>
<%if(!r.empty("nign_polaya_vena_how_"+count)){%>Диаметр <%=r.get("nign_polaya_vena_how_"+count)%> мм.<%}%>
Реакция на пробу Вальсалова: <%=r.get("valsav_"+count)%>.
<br><b>Визуализация партокавальных шунтов</b> <%=r.get("partokaval_"+count)%>
<%if(r.get("partokaval_"+count).equals("визуализируются в бассейне")){%> <%=r.get("bassejn_"+count)%><%}%>.
<%if(!r.empty("addition_" + count)){%><br><b>Дополнительные признаки:</b> <%=r.get("addition_" + count)%><%}%>
<br><b>Ультразвуковая картина характерна для:</b> <%=r.get("decision_" + count)%> <%=r.get("decision_text_" + count)%><br>
