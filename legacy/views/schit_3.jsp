<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>

Щитовидная железа <%=r.get("jeleza_"+count)%>
<%if(!r.get("jeleza_"+count).equals("оперативно удалена.")){%>

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
<%if(!r.empty("peresheek_"+count)){%>
</br><u>Перешеек:</u> <b><%=r.get("peresheek_"+count)%></b>(мм)<%}%>

<%if(!r.empty("tir_obem_"+count)){%>
</br><u>Тиреоидный объем:</u> <b><%=r.get("tir_obem_"+count)%></b>(мл)<%}%>
</br>Эхогенность <%=r.get("ehogennost_"+count)%>. 
Эхоструктура <%=r.get("ehostructura_"+count)%>
<%if(!r.empty("sochetanie_"+count)){%> в сочетании с <%=r.get("sochetanie_"+count)%><%}%>
.<%}%>
<br>
Шейные лимфоузлы <%=r.get("sh_limfoyzli_"+count)%>
      <%if(r.get("sh_limfoyzli_"+count).equals("не увеличены")){%>
          , расположены цепочкой, обычной эхоструктуры, с четкими контурами.
      <%}%>
      <%if(r.get("sh_limfoyzli_"+count).equals("увеличены")){%>
            <%if(!r.empty("sh_gde1_"+count)){%><%=r.get("sh_gde1_"+count)%>,<%}%>
            <%if(!r.empty("sh_gde2_"+count)){%><%=r.get("sh_gde2_"+count)%>,<%}%>
            <%if(!r.empty("sh_gde3_"+count)){%><%=r.get("sh_gde3_"+count)%>,<%}%>
            <%if(!r.empty("sh_gde4_"+count)){%><%=r.get("sh_gde4_"+count)%>,<%}%>
            <%if(!r.empty("sh_gde5_"+count)){%><%=r.get("sh_gde5_"+count)%>,<%}%>
            структура <%=r.get("sh_str_limfoyzli_"+count)%>, 
            контур <%=r.get("sh_kontur_limfoyzli_"+count)%>. 
      <%}%>

<%if(!r.get("chel_limfoyzli_"+count).equals("")){%>
Подчелюстные лимфоузлы <%=r.get("chel_limfoyzli_"+count)%>
      <%if(r.get("chel_limfoyzli_"+count).equals("увеличены")){%>,
            структура <%=r.get("chel_str_limfoyzli_"+count)%>, 
            контур <%=r.get("chel_kontur_limfoyzli_"+count)%> 
      <%}%>.
<%}%>

<%if(!r.get("nadkl_limfoyzli_"+count).equals("")){%>
Надключичные лимфоузлы <%=r.get("nadkl_limfoyzli_"+count)%>
      <%if(r.get("nadkl_limfoyzli_"+count).equals("увеличены")){%>,
            структура <%=r.get("nadkl_str_limfoyzli_"+count)%>, 
            контур <%=r.get("nadkl_kontur_limfoyzli_"+count)%> 
      <%}%>.
<%}%>

<%if(!r.get("podkl_limfoyzli_"+count).equals("")){%>
Подключичные лимфоузлы <%=r.get("podkl_limfoyzli_"+count)%>
      <%if(r.get("podkl_limfoyzli_"+count).equals("увеличены")){%>,
            структура <%=r.get("podkl_str_limfoyzli_"+count)%>, 
            контур <%=r.get("podkl_kontur_limfoyzli_"+count)%> 
      <%}%>.
<%}%>

<%if(!r.empty("addition_" + count)){%>
<br><b>Дополнительные признаки:</b> <%=r.get("addition_" + count)%><%}%>
<br><b>Ультразвуковая картина характерна для:</b> 
<%=r.get("decision_" + count)%> <%=r.get("decision_text_" + count)%><br>
