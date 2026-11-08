<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>

<%if(r.get("del").equals("")){%>
    <b>Локализация железы:</b> 
    <%if(r.get("local").equals("обычная")){%> <%=r.get("local")%>.<%}%> 
    <%if(r.get("local").equals("смещена до")){%> 
        <%if(!r.empty("local_size")){%> 
            <%=r.get("local")%> 
            <%=r.get("local_size")%> мм.
        <%}%>
    <%}%>
    <%if(!r.empty("r_dolya_1") || !r.empty("r_dolya_2") || !r.empty("r_dolya_3")){%><br><b>Правая доля</b>
    <%if(!r.empty("r_dolya_1")){%>a = <%=r.get("r_dolya_1")%> мм<%}%>
    <%if(!r.empty("r_dolya_2")){%>b = <%=r.get("r_dolya_2")%> мм<%}%>
    <%if(!r.empty("r_dolya_3")){%>c = <%=r.get("r_dolya_3")%> мм<%}%>
    <%if(!r.empty("v1")){%>V1 = <%=r.get("v1")%> мм<%}%>
    <%}%>
    <%if(!r.empty("l_dolya_1") || !r.empty("l_dolya_2") || !r.empty("l_dolya_3")){%><b><br>Левая доля</b>
    <%if(!r.empty("l_dolya_1")){%>a = <%=r.get("l_dolya_1")%> мм<%}%>
    <%if(!r.empty("l_dolya_2")){%>b = <%=r.get("l_dolya_2")%> мм<%}%>
    <%if(!r.empty("l_dolya_3")){%>c = <%=r.get("l_dolya_3")%> мм<%}%>
    <%if(!r.empty("v2")){%>V2 = <%=r.get("v2")%> мм<%}%>
    <%}%>
    <%if(!r.empty("sum")){%><br><b>Vсум = <%=r.get("sum")%> мм</b>.<%}%>
    <%if(!r.empty("peresh")){%><br>Перешеек <%=r.get("peresh")%> мм.<%}%>
    <br>Границы <%=r.get("gran")%>.
    Эхогенность <%=r.get("plot")%>.
    <br><b>Структура</b> <%=r.get("shit_struct")%> <%=r.get("vkluch")%>.
    <br>Лимфоузлы <%=r.get("limf")%>
    <%if(r.get("limf").equals("увеличены до")){%>
    <%if(!r.empty("limf_size_do")){%> <%=r.get("limf_size_do")%> мм<%}%>
    <%}%>.
    <%if(!r.get("sim").equals("") || !r.get("usilen").equals("") || !r.empty("krov_text")){%>
        <br>При ЦДК кровоток <%=r.get("sim")%> <%=r.get("usilen")%> <%=r.get("krov_text")%>.
    <%}%>
<%}%>
<%if(r.get("del").equals("Удалена оперативно:")){%>
    <b><%=r.getSelect("del")%></b>
    <%if(!r.empty("del1")){%> 
            <%=r.get("del1")%> 
    <%}%>
    <%if(!r.empty("del1") && (!r.empty("del2") || !r.empty("del3"))){%>,<%}%>
    <%if(!r.empty("del2")){%> 
            <%=r.get("del2")%> 
    <%}%>
    <%if(!r.empty("del2") && !r.empty("del3")){%>,<%}%>
    <%if(!r.empty("del3")){%> 
            <%=r.get("del3")%> 
    <%}%>
    <%if(!r.empty("del_text")){%> 
            <br><%=r.get("del_text")%>.
    <%}%>
    <br><b>Локализация железы:</b> 
    <%if(r.get("local").equals("обычная")){%> <%=r.get("local")%>.<%}%> 
    <%if(r.get("local").equals("смещена до")){%> 
        <%if(!r.empty("local_size")){%> 
            <%=r.get("local")%> 
            <%=r.get("local_size")%> мм.
        <%}%>
    <%}%>
    <%if(!r.empty("r_dolya_1") || !r.empty("r_dolya_2") || !r.empty("r_dolya_3")){%><br><b>Правая доля</b>
    <%if(!r.empty("r_dolya_1")){%>a = <%=r.get("r_dolya_1")%> мм<%}%>
    <%if(!r.empty("r_dolya_2")){%>b = <%=r.get("r_dolya_2")%> мм<%}%>
    <%if(!r.empty("r_dolya_3")){%>c = <%=r.get("r_dolya_3")%> мм<%}%>
    <%if(!r.empty("v1")){%>V1 = <%=r.get("v1")%> мм<%}%>
    <%}%>
    <%if(!r.empty("l_dolya_1") || !r.empty("l_dolya_2") || !r.empty("l_dolya_3")){%><b><br>Левая доля</b>
    <%if(!r.empty("l_dolya_1")){%>a = <%=r.get("l_dolya_1")%> мм<%}%>
    <%if(!r.empty("l_dolya_2")){%>b = <%=r.get("l_dolya_2")%> мм<%}%>
    <%if(!r.empty("l_dolya_3")){%>c = <%=r.get("l_dolya_3")%> мм<%}%>
    <%if(!r.empty("v2")){%>V2 = <%=r.get("v2")%> мм<%}%>
    <%}%>
    <%if(!r.empty("sum")){%><br><b>Vсум = <%=r.get("sum")%> мм</b>.<%}%>
    <%if(!r.empty("peresh")){%><br>Перешеек <%=r.get("peresh")%> мм.<%}%>
    <br>Границы <%=r.get("gran")%>.
    Эхогенность <%=r.get("plot")%>.
    <br><b>Структура</b> <%=r.get("shit_struct")%> <%=r.get("vkluch")%>.
    <br>Лимфоузлы <%=r.get("limf")%>
    <%if(r.get("limf").equals("увеличены до")){%>
    <%if(!r.empty("limf_size_do")){%> <%=r.get("limf_size_do")%> мм<%}%>
    <%}%>.
    <%if(!r.get("sim").equals("") || !r.get("usilen").equals("") || !r.empty("krov_text")){%>
        <br>При ЦДК кровоток <%=r.get("sim")%> <%=r.get("usilen")%> <%=r.get("krov_text")%>.
    <%}%>
<%}%>
<%if(r.get("del").equals("Щитовидная железа удалена оперативно")){%>
    <b><%=r.getSelect("del")%></b>
    <%if(!r.empty("del_god")){%> в <%=r.get("del_god")%> году.<%}%>
    <%if(!r.empty("del_loje")){%> <br> <%=r.get("del_loje")%><%}%>
    <%if(!r.empty("del_loje") && r.empty("loje_text")){%>.<%}%>
    <%if(!r.empty("loje_text")){%> <%=r.get("loje_text")%>.<%}%>
    <%if(!r.empty("del_proek")){%> <br><%=r.get("del_proek")%><%}%>
    <%if(!r.empty("del_potolog")){%> <%=r.get("del_potolog")%><%}%>
    <%if(!r.empty("del_potolog") && r.empty("proek_text")){%>.<%}%>
    <%if(!r.empty("proek_text")){%> <%=r.get("proek_text")%>.<%}%>
    <br>Лимфоузлы <%=r.get("limf")%>
    <%if(r.get("limf").equals("увеличены до")){%>
    <%if(!r.empty("limf_size_do")){%> <%=r.get("limf_size_do")%> мм<%}%>
    <%}%>.
<%}%>
  
 