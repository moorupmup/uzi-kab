<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>
Щитовидная железа <%=r.get("jeleza_"+count)%><%if(!r.get("jeleza_"+count).equals("оперативно удалена.")){%>
<br>Контур <%=r.get("kontur_"+count)%>
<%if(!r.empty("rdolaj_sh_"+count)||!r.empty("rdolaj_tol_"+count)||!r.empty("rdolaj_dl_"+count)||!r.empty("ldolaj_sh_"+count)||!r.empty("ldolaj_tol_"+count)||!r.empty("ldolaj_dl_"+count)){%>
    </br><u>Размеры:</u> 
    <%if(!r.empty("rdolaj_sh_"+count)||!r.empty("rdolaj_tol_"+count)||!r.empty("rdolaj_dl_"+count)){%>
        </br>&nbsp &nbsp &nbspПравая доля: 
        <%if(!r.empty("rdolaj_sh_"+count)){%>&nbsp ширина <b><%=r.get("rdolaj_sh_"+count)%></b>(мм)<%}%>
        <%if(!r.empty("rdolaj_tol_"+count)){%>&nbsp толщина <b><%=r.get("rdolaj_tol_"+count)%></b>(мм)<%}%>
        <%if(!r.empty("rdolaj_dl_"+count)){%>&nbsp длина <b><%=r.get("rdolaj_dl_"+count)%></b>(мм)<%}%>
    <%}%>
    <%if(!r.empty("ldolaj_sh_"+count)||!r.empty("ldolaj_tol_"+count)||!r.empty("ldolaj_dl_"+count) ){%>
        </br>&nbsp &nbsp &nbspЛевая доля:
        <%if(!r.empty("ldolaj_sh_"+count)){%>&nbsp &nbsp ширина <b><%=r.get("ldolaj_sh_"+count)%></b>(мм)<%}%>
        <%if(!r.empty("ldolaj_tol_"+count)){%>&nbsp толщина <b><%=r.get("ldolaj_tol_"+count)%></b>(мм)<%}%>
        <%if(!r.empty("ldolaj_dl_"+count)){%>&nbsp длина <b><%=r.get("ldolaj_dl_"+count)%></b>(мм)<%}%>
    <%}%>
<%}%>
<%if(!r.empty("peresheek_"+count)){%></br><u>Перешеек:</u> <b><%=r.get("peresheek_"+count)%></b>(мм)<%}%>
<%if(!r.empty("tir_obem_"+count)){%></br><u>Тиреоидный объем:</u> <b><%=r.get("tir_obem_"+count)%></b>(мл)<%}%>
</br>Эхогенность <%=r.get("ehogennost_"+count)%>. 
Эхоструктура <%=r.get("ehostructura_"+count)%><%if(!r.empty("sochetanie_"+count)){%> в сочетании с <%=r.get("sochetanie_"+count)%><%}%>
<%=r.get("limfoyzli_"+count)%>.<%}%>
<%if(!r.empty("addition_" + count)){%><br><b>Дополнительные признаки:</b> <%=r.get("addition_" + count)%><%}%>
<br><b>Ультразвуковая картина характерна для:</b> <%=r.get("decision_" + count)%> <%=r.get("decision_text_" + count)%><br>
