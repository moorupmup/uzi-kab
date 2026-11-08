<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%if(!r.empty("mens_text")){%> Первый день последней менструации <%=r.get("mens_text")%>.<br><%}%>
<%if(!r.empty("ned_text")){%> Срок беременности <%=r.get("ned_text")%>.<br><%}%>
<b>Плод:</b><br>
Определяется один живой плод.
<%if(!r.empty("plod")){%>Предлежащая часть <%=r.get("plod")%>.<%}%>
Положение плода <%=r.get("poloj_plod")%>.
<%if(!r.empty("serd")){%>Сердечная деятельность <%=r.get("serd")%>.<%}%>
<br><b>Сетометрия:</b><br>
<%if(!r.empty("bpr")){%>БПР <%=r.get("bpr")%>.<%}%>
<%if(!r.empty("sdj")){%>ЛЗ <%=r.get("sdj")%><%}%>
<%if(!r.empty("og")){%>ОГ <%=r.get("og")%>.<%}%>
<%if(!r.empty("oj")){%>ОЖ <%=r.get("oj")%><%}%>
<%if(!r.empty("dbk")){%>ДБК <%=r.get("dbk")%><%}%>
<%if(!r.empty("dop_iz")){%>Дополнительные измерения <%=r.get("dop_iz")%>.<%}%>
Размеры плода <%=r.get("razmer_p")%>
<%if(!r.empty("ned_ber")){%><%=r.get("ned_ber")%> неделям беременности<%}%>
<%if(!r.empty("massa")){%>Предпологаемая масса <%=r.get("massa")%><%}%>
<br><b>Плацента и околоплодные воды:</b><br>
Преимущественная докализация плаценты <%=r.get("placenta1")%> <%=r.get("placenta2")%>.
<%if(!r.empty("tolsh_p")){%>Толщина плаценты <%=r.get("tolsh_p")%>.<%}%>
<%if(!r.empty("struct_plac")){%>Струкртура плаценты <%=r.get("struct_plac")%><%}%>
<%if(!r.empty("okolop_v")){%>Количество околоплодных вод <%=r.get("okolop_v")%>.<%}%>
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
<%if(!r.empty("poch_ber")){%><br>Почки беременной <%=r.get("poch_ber")%>.<%}%>
