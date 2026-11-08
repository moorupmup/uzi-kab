<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>

<%if(!r.empty("mens_text")){%>Дата последней менструации <%=r.get("mens_text")%>.<br><%}%>
<%if(!r.empty("srok_ber")){%> Срок беременности по менструации <%=r.get("srok_ber")%>.<br><%}%>
<%if(!r.empty("data_roda")){%> Предполагаемая дата родов <%=r.get("data_roda")%>.<br><%}%>
В полости матки  <%=r.get("plod")%>   <br>

<%if(!r.empty("razm_gol")){%>КТР <%=r.get("razm_gol")%> <%}%>



<%if(!r.empty("okr_golov")){%>BPD <%=r.get("okr_golov")%> мм <%}%>

<%if(!r.empty("lob_zat")){%> HC <%=r.get("lob_zat")%> мм <%}%>


<%if(!r.empty("okr_jiv")){%> FL <%=r.get("okr_jiv")%> мм<%}%>

<%if(!r.empty("ac")){%> AC <%=r.get("ac")%> мм<%}%> <br>

<%if(!r.empty("tol_pr")){%> Толщина воротникового пространства <%=r.get("tol_pr")%> мм<%}%>
<%if(!r.empty("dl_nos_kost")){%>   Длина носовой кости  <%=r.get("dl_nos_kost")%> мм<%}%>

<br><b>Анатомия плода:</b><br>


<%if(!r.empty("mozg") || !r.get("sel_mozg").equals("")){%>
   Кости черепа <%=r.get("sel_mozg")%> 
    <%if(!r.empty("mozg")){%>
        <%=r.get("mozg")%> .
    <%}%>
<%}%>

<%if(!r.empty("legkie") || !r.get("sel_legkie").equals("")){%>
    Структуры головного мозга <%=r.get("sel_legkie")%> <%=r.get("legkie")%>.
<%}%>
<%if(!r.empty("pozv") || !r.get("sel_pozv").equals("")){%>
    Позвоночник <%=r.get("sel_pozv")%> <%=r.get("pozv")%>.
<%}%>

<%if(!r.empty("serdce") || !r.get("sel_serdce").equals("")){%>
    Четырехкамерный срез сердца <%=r.get("sel_serdce")%> <%=r.get("serdce")%>.
<%}%>


<%if(!r.empty("css")){%>
    ЧСС плода <%=r.get("css")%> уд. мин
<%}%>


<%if(!r.empty("jelud") || !r.get("sel_jelud").equals("")){%>
    Желудок <%=r.get("sel_jelud")%> <%=r.get("jelud")%>.
<%}%>

<%if(!r.empty("mocha") || !r.get("sel_mocha").equals("")){%>
    Мочевой пузырь <%=r.get("sel_mocha")%> <%=r.get("mocha")%>.
<%}%>

<%if(!r.empty("kishki") || !r.get("stenka").equals("")){%>
    Передняя брюшная стенка <%=r.get("stenka")%> <%=r.get("kishki")%>.
<%}%>

<%if(!r.empty("pochki") || !r.get("pupo").equals("")){%>
    Место прикрепления пуповины <%=r.get("pupo")%> <%=r.get("pochki")%>.
<%}%>



<br><b>Врожденные пороки развития плода:</b> <%=r.get("poroki")%> <%=r.get("poroki_text")%>.

<br>Преимущественная локализация хориона: <%=r.get("loc_hor")%> <%=r.get("loc_text")%>.
<br>Структура хориона: <%=r.get("horion")%> <%=r.get("hor_text")%>.




<%if(!r.empty("stenki_text") || !r.get("osob_stroi").equals("")){%><BR>Особенности строения шейки и стенок матки <%=r.get("osob_stroi")%> <%=r.get("stenki_text")%>.<%}%>
<%if(!r.empty("pridatki")|| !r.get("obl_pr").equals("")){%><br>Область придатков <%=r.get("obl_pr")%> <%=r.get("pridatki")%>.<%}%>
<br>Визуализация: <%=r.get("vizual")%>
<%if(!r.empty("viz_text")){%> <%=r.get("viz_text")%><%}%>.
<BR>Почки беременной <%=r.get("pochki_ber")%> 
<%if(!r.empty("chash")){%>
    чашечки расширенные до <%=r.get("chash")%> мм <%=r.get("chash_gde")%>
<%}%>
<%if(!r.empty("loh")){%>
    лоханка расширенна до <%=r.get("loh")%> мм <%=r.get("loh_gde")%>
<%}%>
<%=r.get("pochki_text")%>.
