<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%if(!r.empty("priznak")){%>1 день последней менструации <%=r.get("priznak")%>.<%}%>
<%if(!r.empty("diametr")){%>В полости матки, <%=r.get("polost")%> определяется плодное яйцо диаметром <%=r.get("diametr")%> мм.<%}%>
Плодное яйцо <%=r.get("jaico")%>.
Хорион <%=r.get("horion")%>.
Отслойка хориона <%=r.get("horion_ot")%>.
Эмбрион <%=r.get("embrion")%>.
<%if(r.get("embrion").equals("определяется")){%>
    <%if(!r.empty("jeltok")){%>Диаметр желточного мешка <%=r.get("jeltok")%> мм.<%}%>
    <%if(!r.empty("kopchik")){%>Копчико-теменной размер <%=r.get("kopchik")%> мм.<%}%>
    Воротниковое пространство <%=r.get("zona")%><%if(!r.empty("zona_how")){%> <%=r.get("zona_how")%> мм.<%}%>.
<%}%>
Структура миометрия <%=r.get("meom")%>.
Шейка матки <%=r.get("matka")%><%if(!r.empty("matka_how")){%> <%=r.get("matka_how")%> мм.<%}%>.
Внутренний зев <%=r.get("zev")%><%if(!r.empty("zev_how")){%> <%=r.get("zev_how")%> мм.<%}%>.
Придатки <%=r.get("pridat")%>.