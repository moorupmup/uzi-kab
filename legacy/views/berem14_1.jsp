<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>


1-й день последней менструации <%=r.get("last_mens_"+count)%>
<br>Срок беременности <%=r.get("srok_ber_"+count)%> нед.  <%=r.get("srok_ber_day_"+count)%> дн.
<br>Предполагаемая дата родов  <%=r.get("eeeee_"+count)%> 
<br>Вид исследования <%=r.get("vid_iss_"+count)%>

<br>В полости матки <%=r.get("vizual_"+count)%> <%=r.get("kol_plod_"+count)%> <%=r.get("plod_"+count)%>

<br>Копчико-теменной размер плода <%=r.get("kop_tem_size_"+count)%> мм, 
<%=r.get("kop_tem_soot_"+count)%> менструальному сроку беременности <%=r.get("kop_tem_text_"+count)%>

<%if(!r.empty("chss_"+count)){%>
<br>Частота сердечных сокращений плода <%=r.get("chss_"+count)%> уд./мин
<%}%>

<%if(!r.empty("tol_vor_pr_"+count)){%>
<br>Толщина воротникового пространства плода <%=r.get("tol_vor_pr_"+count)%> мм.
<%}%>

<br>Кости носа: <%=r.get("kosti_viz_"+count)%> 
          <%if(!r.empty("kosti_size_"+count)){%>
               длина <%=r.get("kosti_size_"+count)%> мм
          <%}%>

<br>
<b>АНАТОМИЯ ПЛОДА</b>: 
<br>

    Кости свода черепа <%=r.get("kosti_ch_"+count)%> <%=r.get("kosti_ch_text_"+count)%>.
<br>Головной мозг <%=r.get("mozg_"+count)%> <%=r.get("mozg_text_"+count)%>.
<br>Позвоночник <%=r.get("pozv_"+count)%> <%=r.get("pozv_text_"+count)%>.
<br>Сердце <%=r.get("serdz_"+count)%> <%=r.get("serdz_text_"+count)%>.
<br>Желудок <%=r.get("jelud_"+count)%> <%=r.get("jelud_text_"+count)%>.
<br>Передняя брюшная стенка <%=r.get("brush_"+count)%> <%=r.get("brush_text_"+count)%>.
<br>Мочевой пузызь и почки <%=r.get("mochev_"+count)%> <%=r.get("mochev_text_"+count)%>.
<br>Конечности <%=r.get("konech_"+count)%> <%=r.get("konech_text_"+count)%>.


<br>Желточный мешок <%=r.get("meshok_"+count)%>.
<%if(!r.empty("dia_jel_size_"+count)){%>
    <br>Средний внутренний диаметр желточного мешка <%=r.get("dia_jel_size_"+count)%> мм. 
<%}%>
<br>Преимущественная локализация хориона: <%=r.get("lok_hori_"+count)%>.
<br>Структура хориона <%=r.get("str_hori_"+count)%> <%=r.get("str_hori_text_"+count)%>.
<br>Придатки матки <%=r.get("prid_mat_"+count)%> <%=r.get("prid_mat_text_"+count)%>.
<br>Строение стенок матки <%=r.get("sten_mat_"+count)%> <%=r.get("sten_mat_text_"+count)%>.
<br>Визуализация: <%=r.get("vizual_"+count)%> <%=r.get("vizual_text_"+count)%>.
<%if(!r.empty("osob_"+count)){%>
     <br>Особенности: <%=r.get("osob_"+count)%>
<%}%>
<br>Кровоток в венозном протоке <%=r.get("krovot_"+count)%>.
<br>Трикуспидальная регургитация: <%=r.get("trikus_"+count)%> <%=r.get("trikus_text_"+count)%>.



<%if(!r.empty("addition_" + count)){%><br><b>Дополнительные признаки:</b> <%=r.get("addition_" + count)%><%}%>
<br><b>Ультразвуковая картина характерна для:</b> <%=r.get("decision_" + count)%> <%=r.get("decision_text_" + count)%><br>

