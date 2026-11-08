<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>
Первый день последней менструации<br> 
<%if(!r.empty("srok_berem_"+count)){%> Срок беременности <%=r.get("srok_berem_"+count)%> нед.<br><%}%>
В матке определяется <%=r.get("plod_"+count)%>.<br>
Положение <%=r.get("poloj_"+count)%>.<br>
Органы и системы <%=r.get("organ_"+count)%><%if(!r.empty("organ_text_"+count)){%> <%=r.get("organ_text_"+count)%><%}%>.<br>
Сердцебиение <%=r.get("serdce_"+count)%>.<br>
<%if(!r.empty("nos_"+count)){%>Длина костной части спинки носа плода <%=r.get("nos_"+count)%> мм.<br><%}%>
<%if(!r.empty("diam_glaz_"+count)){%>Диаметр глазницы <%=r.get("diam_glaz_"+count)%>мм.<br><%}%>
<%if(!r.empty("vorot_"+count)){%>Воротниковие пространство <%=r.get("vorot_"+count)%> мм.<br><%}%>
<%if(!r.empty("bpd1_"+count) || !r.empty("fl1_"+count) || !r.empty("ac1_"+count)){%>Размеры<%if(!r.empty("bpd2_"+count) || !r.empty("fl2_"+count) || !r.empty("ac2_"+count) || !r.empty("massa2_"+count)){%>(первого плода)<%}%>:
<%if(!r.empty("bpd1_"+count)){%>BPD <%=r.get("bpd1_"+count)%> мм<%}%>
<%if(!r.empty("fl1_"+count)){%>FL <%=r.get("fl1_"+count)%> мм<%}%>
<%if(!r.empty("ac1_"+count)){%>AC <%=r.get("ac1_"+count)%> мм<%}%>.<br><%}%>
<%if(!r.empty("massa1_"+count)){%>Масса: <%=r.get("massa1_"+count)%> гр.<br><%}%>
<%if(!r.empty("srok1_"+count)){%>По всем параметрам соответствует <%=r.get("srok1_"+count)%> нед.<br><%}%>
<%if(!r.empty("bpd2_"+count) || !r.empty("fl2_"+count) || !r.empty("ac2_"+count)){%>Размеры(второго плода):
<%if(!r.empty("bpd2_"+count)){%>BPD <%=r.get("bpd2_"+count)%> мм<%}%>
<%if(!r.empty("fl2_"+count)){%>FL <%=r.get("fl2_"+count)%> мм<%}%>
<%if(!r.empty("ac2_"+count)){%>AC <%=r.get("ac2_"+count)%> мм<%}%>.<br><%}%>
<%if(!r.empty("massa2_"+count)){%>Масса: <%=r.get("massa2_"+count)%> гр.<br><%}%>
<%if(!r.empty("srok2_"+count)){%>По всем параметрам соответствует <%=r.get("srok2_"+count)%> нед.<br><%}%>
<%if(!r.empty("plac_"+count)){%>Локализация плаценты <%=r.get("plac_"+count)%>
<%if(!r.empty("perehod_"+count)){%> по <%=r.get("perehod_"+count)%><%}%><%if(!r.empty("perehod_na_"+count)){%> с переходом на <%=r.get("perehod_na_"+count)%><%}%>. <%if(!r.empty("plac_text_"+count)){%> <%=r.get("plac_text_"+count)%>.<%}%><br><%}%>
<%if(!r.empty("second_zrelost_"+count)){%>Степень зрелости <%=r.get("second_zrelost_"+count)%>.<br><%}%>
Толщина плаценты <%=r.get("second_tolshina_"+count)%>
<%if(!r.empty("second_tolshina_how_"+count)){%> 
    до <%=r.get("second_tolshina_how_"+count)%> мм.
<%}%>
<%if(!r.empty("second_tolshina_text_"+count)){%> 
    <%=r.get("second_tolshina_text_"+count)%>.
<%}%><br>
Количество околоплодных вод <%=r.get("water_"+count)%>.<br>
<%if(!r.empty("krovotok1_"+count)){%>Кровоток в венозном протоке плода (первого): <%=r.get("krovotok1_"+count)%>.<br><%}%>
<%if(!r.empty("krovotok2_"+count)){%>Кровоток в венозном протоке плода (второго): <%=r.get("krovotok2_"+count)%>.<br><%}%>
Внутренний зев <%=r.get("zev_"+count)%>.
<%if(!r.empty("addition_" + count)){%><br><b>Дополнительные признаки:</b> <%=r.get("addition_" + count)%><%}%>
<br><b>Ультразвуковая картина характерна для:</b> <%=r.get("decision_" + count)%> <%=r.get("decision_text_" + count)%><br>
