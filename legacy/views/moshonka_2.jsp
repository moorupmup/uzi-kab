<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>
<b>Правое яичко</b> <%=r.get("r_rasp_"+count)%>.<br>
<%if(!r.empty("r_forma_"+count)){%>Форма <%=r.get("r_forma_"+count)%>.<br><%}%>
Эхоструктура <%=r.get("r_echo_"+count)%>.<br>
Эхоплотность <%=r.get("r_plot_"+count)%>.<br>
<%if(!r.empty("r_size1_"+count) || !r.empty("r_size2_"+count) || !r.empty("r_size3_"+count)){%>Раэмеры
    <%if(!r.empty("r_size1_"+count)){%><%=r.get("r_size1_"+count)%>*<%}%>
    <%if(!r.empty("r_size2_"+count)){%><%=r.get("r_size2_"+count)%>*<%}%>
    <%if(!r.empty("r_size3_"+count)){%><%=r.get("r_size3_"+count)%><%}%>
 мм.<br><%}%>
Придаток: <%=r.get("r_prid_"+count)%><%if(!r.empty("r_prid_how_"+count)){%> <%=r.get("r_prid_how_"+count)%><%}%> мм.<br>
Свободная жидкость в оболочках яичка <%=r.get("r_free_"+count)%><%if(!r.empty("r_free_how_"+count)){%> <%=r.get("r_free_how_"+count)%><%}%>.<br>
Гидатиды <%=r.get("r_gidat_"+count)%>.

<br><b>Левое яичко</b> <%=r.get("l_rasp_"+count)%>.<br>
<%if(!r.empty("l_forma_"+count)){%>Форма <%=r.get("l_forma_"+count)%>.<br><%}%>
Эхоструктура <%=r.get("l_echo_"+count)%>.<br>
Эхоплотность <%=r.get("l_plot_"+count)%>.<br>
<%if(!r.empty("l_size1_"+count) || !r.empty("l_size2_"+count) || !r.empty("l_size3_"+count)){%>Раэмеры
    <%if(!r.empty("l_size1_"+count)){%><%=r.get("l_size1_"+count)%>*<%}%>
    <%if(!r.empty("l_size2_"+count)){%><%=r.get("l_size2_"+count)%>*<%}%>
    <%if(!r.empty("l_size3_"+count)){%><%=r.get("l_size3_"+count)%><%}%>
мм.<br><%}%>
Придаток: <%=r.get("l_prid_"+count)%><%if(!r.empty("l_prid_how_"+count)){%> <%=r.get("l_prid_how_"+count)%><%}%> мм.<br>
Свободная жидкость в оболочках яичка <%=r.get("l_free_"+count)%><%if(!r.empty("l_free_how_"+count)){%> <%=r.get("l_free_how_"+count)%><%}%>.<br>
Гидатиды <%=r.get("l_gidat_"+count)%>.

<br><b>Вены гроздьевидного сплетения</b> <%=r.get("veni_"+count)%><%if(r.get("veni_"+count).equals("расширены до")){%>
<%if(!r.empty("veni_how_"+count)){%><%=r.get("veni_how_"+count)%> мм.<%}%>
<%if(!r.empty("veni_right_"+count) || !r.empty("veni_left_"+count)){%>
    <%if(!r.empty("veni_right_"+count)){%><%=r.get("veni_right_"+count)%><%}%>
    <%if(!r.empty("veni_left_"+count)){%><%=r.get("veni_left_"+count)%><%}%>
.<%}%><%}%>
<br><b>Проба Вальсальвы</b> <%=r.get("vals_"+count)%><%if(!r.empty("vals_right_"+count) || !r.empty("vals_left_"+count)){%>
    <%if(!r.empty("vals_right_"+count)){%><%=r.get("vals_right_"+count)%><%}%>
    <%if(!r.empty("vals_left_"+count)){%><%=r.get("vals_left_"+count)%><%}%>
.<%}%>
<%if(!r.empty("diametr_"+count)){%><br>Диаметр вен до <%=r.get("diametr_"+count)%> мм.<%}%>
<%if(!r.empty("addition_" + count)){%><br><b>Дополнительные признаки:</b> <%=r.get("addition_" + count)%><%}%>
<br><b>Ультразвуковая картина характерна для:</b> <%=r.get("decision_" + count)%> <%=r.get("decision_text_" + count)%><br>
