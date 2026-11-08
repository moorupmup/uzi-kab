<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
В матке определяется <%=r.get("plod")%>.<br>
Положение <%=r.get("poloj")%>.<br>
<%if(!r.empty("pred")){%>Предлежание <%=r.get("pred")%>.<br><%}%>
Органы и системы <%=r.get("organ")%><%if(!r.empty("organ_text")){%> <%=r.get("organ_text")%><%}%>.<br>
Сердцебиение <%=r.get("serdce")%>.<br>
<%if(!r.empty("nos")){%>Длина костной части спинки носа плода <%=r.get("nos")%> мм.<br><%}%>
<%if(!r.empty("srok")){%>По всем параметрам соответствует <%=r.get("srok")%> нед.<br><%}%>
<%if(!r.empty("bpd1") || !r.empty("fl1") || !r.empty("ac1")){%>Размеры<%if(!r.empty("bpd2") || !r.empty("fl2") || !r.empty("ac2") || !r.empty("massa2")){%>(первого плода)<%}%>:
<%if(!r.empty("bpd1")){%>BPD <%=r.get("bpd1")%> мм<%}%>
<%if(!r.empty("fl1")){%>FL <%=r.get("fl1")%> мм<%}%>
<%if(!r.empty("ac1")){%>AC <%=r.get("ac1")%> мм<%}%>.<br><%}%>
<%if(!r.empty("massa1")){%>Масса: <%=r.get("massa1")%> гр.<br><%}%>
<%if(!r.empty("bpd2") || !r.empty("fl2") || !r.empty("ac2")){%>Размеры(второго плода):
<%if(!r.empty("bpd2")){%>BPD <%=r.get("bpd2")%> мм<%}%>
<%if(!r.empty("fl2")){%>FL <%=r.get("fl2")%> мм<%}%>
<%if(!r.empty("ac2")){%>AC <%=r.get("ac2")%> мм<%}%>.<br><%}%>
<%if(!r.empty("massa2")){%>Масса: <%=r.get("massa2")%> гр.<br><%}%>
<%if(!r.empty("plac")){%>Локализация плаценты <%=r.get("plac")%>
<%if(!r.empty("perehod")){%> по <%=r.get("perehod")%><%}%><%if(!r.empty("perehod_na")){%> с переходом на <%=r.get("perehod_na")%><%}%>. <%if(!r.empty("plac_text")){%> <%=r.get("plac_text")%>.<%}%><br><%}%>
<%if(!r.empty("second_zrelost")){%>Степень зрелости <%=r.get("second_zrelost")%>.<%}%>
Толщина плаценты <%=r.get("second_zrelost")%><%if(!r.empty("second_tolshina_how")){%> до <%=r.get("second_tolshina_how")%> мм.<%}%><%if(!r.empty("second_tolshina_text")){%> <%=r.get("second_tolshina_text")%>.<%}%>
<%if(!r.empty("vorot")){%>Воротниковие пространство <%=r.get("vorot")%> мм.<br><%}%>
<%if(!r.empty("krovotok")){%>Кровоток в венозном протоке плода: <%=r.get("krovotok")%>.<br><%}%>
Внутренний зев <%=r.get("zev")%>.<br>
Количество околоплодных вод <%=r.get("water")%>.