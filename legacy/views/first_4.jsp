<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>
<%if(!r.empty("priznak_"+count)){%>1 день последней менструации <%=r.get("priznak_"+count)%>.<%}%>
<%if(!r.empty("diametr_"+count)){%>В полости матки, <%=r.get("polost_"+count)%> определяется плодное яйцо диаметром <%=r.get("diametr_"+count)%> мм.<%}%>
Плодное яйцо <%=r.get("jaico_"+count)%>.
Хорион <%=r.get("horion_"+count)%>.
Отслойка хориона <%=r.get("horion_ot_"+count)%>.
Эмбрион <%=r.get("embrion_"+count)%>.
<%if(r.get("embrion_"+count).equals("определяется")){%>
    <%if(!r.empty("kopchik_"+count)){%>Копчико-теменной размер <%=r.get("kopchik_"+count)%> мм.<%}%>
    <%if(!r.empty("jeltok_"+count)){%>Диаметр желточного мешка <%=r.get("jeltok_"+count)%> мм.<%}%>
<%}%>
Структура миометрия <%=r.get("meom_"+count)%>.
Шейка матки <%=r.get("matka_"+count)%><%if(!r.empty("matka_how_"+count)){%> <%=r.get("matka_how_"+count)%> мм.<%}%>.
Внутренний зев <%=r.get("zev_"+count)%><%if(!r.empty("zev_how_"+count)){%> <%=r.get("zev_how_"+count)%> мм.<%}%>.
Придатки <%=r.get("pridat_"+count)%>.

Почки беременной: <%if(!r.empty("pochki_berem_"+count)){%><%=r.get("pochki_berem_"+count)%>.<%}else{%><%if(!r.empty("chkalik_"+count)||!r.empty("chpoliek_"+count)||!r.empty("chtransform_"+count)){%>
<%if(!r.empty("chkalik_"+count)){%><%=r.get("chkalik_"+count)%> <%=r.get("kalik_"+count)%><%if(!r.empty("chkalik_how_"+count)){%> <%=r.get("chkalik_how_"+count)%> мм.<%}%><%}%>
<%if(!r.empty("chpoliek_"+count)){%><%=r.get("chpoliek_"+count)%> <%=r.get("poliek_"+count)%><%if(!r.empty("chpoliek_how_"+count)){%> <%=r.get("chpoliek_how_"+count)%> мм.<%}%><%}%>
<%if(!r.empty("chtransform_"+count)){%><%=r.get("chtransform_"+count)%> <%=r.get("transform_"+count)%><%}%><%}%>.<%}%>
<%if(!r.empty("addition_" + count)){%><br><b>

Дополнительные признаки:</b> <%=r.get("addition_" + count)%><%}%>
<br><b>Ультразвуковая картина характерна для:</b> <%=r.get("decision_" + count)%> <%=r.get("decision_text_" + count)%><br>
