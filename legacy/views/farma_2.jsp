<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>
<b>Правая лоханка</b> <%=r.get("r_lohanka_do_"+count)%><%if(r.get("r_lohanka_do_"+count).equals("расширена до")){%>
<%if(!r.empty("r_lohanka_do_how_"+count)){%> <%=r.get("r_lohanka_do_how_"+count)%> мм.<%}%>
<%if(!r.empty("r_verh_do_"+count)){%> 
    <%=r.get("r_verh_do_"+count)%>
<%}%>
<%if(!r.empty("r_niz_do_"+count)){%> 
    <%=r.get("r_niz_do_"+count)%>
    <%if(!r.empty("r_niz_do_how_"+count)){%> <%=r.get("r_niz_do_how_"+count)%> мм.<%}%>
<%}%>
<%if(!r.empty("r_chls_do_"+count)){%> 
    <%=r.get("r_chls_do_"+count)%>
    <%if(!r.empty("r_chls_do_how_"+count)){%> <%=r.get("r_chls_do_how_"+count)%> мм.<%}%>
<%}%><%}%>
<br><b>Левая лоханка</b> <%=r.get("l_lohanka_do_"+count)%><%if(r.get("l_lohanka_do_"+count).equals("расширена до")){%>
<%if(!r.empty("l_lohanka_do_how_"+count)){%> <%=r.get("l_lohanka_do_how_"+count)%> мм.<%}%>
<%if(!r.empty("l_verh_do_"+count)){%> 
    <%=r.get("l_verh_do_"+count)%>
<%}%>
<%if(!r.empty("l_niz_do_"+count)){%> 
    <%=r.get("l_niz_do_"+count)%>
    <%if(!r.empty("l_niz_do_how_"+count)){%> <%=r.get("l_niz_do_how_"+count)%> мм.<%}%>
<%}%>
<%if(!r.empty("l_chls_do_"+count)){%> 
    <%=r.get("l_chls_do_"+count)%>
    <%if(!r.empty("l_chls_do_how_"+count)){%> <%=r.get("l_chls_do_how_"+count)%> мм.<%}%>
<%}%><%}%>
<%if(!r.empty("cherez_how_"+count)){%><br><b>Через <%=r.get("cherez_how_"+count)%> мин. после перорального приёма фуросемида (1-й позыв к микции):</b><%}%><br>
<b>Правая лоханка</b> <%=r.get("r_lohanka_min_"+count)%><%if(r.get("r_lohanka_min_"+count).equals("расширена до")){%>
<%if(!r.empty("r_lohanka_min_how_"+count)){%> <%=r.get("r_lohanka_min_how_"+count)%> мм.<%}%>
<%if(!r.empty("r_verh_min_"+count)){%> 
    <%=r.get("r_verh_min_"+count)%>
<%}%>
<%if(!r.empty("r_niz_min_"+count)){%> 
    <%=r.get("r_niz_min_"+count)%>
    <%if(!r.empty("r_niz_min_how_"+count)){%> <%=r.get("r_niz_min_how_"+count)%> мм.<%}%>
<%}%>
<%if(!r.empty("r_chls_min_"+count)){%> 
    <%=r.get("r_chls_min_"+count)%>
    <%if(!r.empty("r_chls_min_how_"+count)){%> <%=r.get("r_chls_min_how_"+count)%> мм.<%}%>
<%}%><%}%>
<br><b>Левая лоханка</b> <%=r.get("l_lohanka_min_"+count)%><%if(r.get("l_lohanka_min_"+count).equals("расширена до")){%>
<%if(!r.empty("l_lohanka_min_how_"+count)){%> <%=r.get("l_lohanka_min_how_"+count)%> мм.<%}%>
<%if(!r.empty("l_verh_min_"+count)){%> 
    <%=r.get("l_verh_min_"+count)%>
<%}%>
<%if(!r.empty("l_niz_min_"+count)){%> 
    <%=r.get("l_niz_min_"+count)%>
    <%if(!r.empty("l_niz_min_how_"+count)){%> <%=r.get("l_niz_min_how_"+count)%> мм.<%}%>
<%}%>
<%if(!r.empty("l_chls_min_"+count)){%> 
    <%=r.get("l_chls_min_"+count)%>
    <%if(!r.empty("l_chls_min_how_"+count)){%> <%=r.get("l_chls_min_how_"+count)%> мм.<%}%>
<%}%><%}%>
<br><b>После микции: </b><br>
<b>Правая лоханка</b> <%=r.get("r_lohanka_mik_"+count)%><%if(r.get("r_lohanka_mik_"+count).equals("расширена до")){%>
<%if(!r.empty("r_lohanka_mik_how_"+count)){%> <%=r.get("r_lohanka_mik_how_"+count)%> мм.<%}%>
<%if(!r.empty("r_verh_mik_"+count)){%> 
    <%=r.get("r_verh_mik_"+count)%>
<%}%>
<%if(!r.empty("r_niz_mik_"+count)){%> 
    <%=r.get("r_niz_mik_"+count)%>
    <%if(!r.empty("r_niz_mik_how_"+count)){%> <%=r.get("r_niz_mik_how_"+count)%> мм.<%}%>
<%}%>
<%if(!r.empty("r_chls_mik_"+count)){%> 
    <%=r.get("r_chls_mik_"+count)%>
    <%if(!r.empty("r_chls_mik_how_"+count)){%> <%=r.get("r_chls_mik_how_"+count)%> мм.<%}%>
<%}%><%}%>
<br><b>Левая лоханка</b> <%=r.get("l_lohanka_mik_"+count)%><%if(r.get("l_lohanka_mik_"+count).equals("расширена до")){%>
<%if(!r.empty("l_lohanka_mik_how_"+count)){%> <%=r.get("l_lohanka_mik_how_"+count)%> мм.<%}%>
<%if(!r.empty("l_verh_mik_"+count)){%> 
    <%=r.get("l_verh_mik_"+count)%>
<%}%>
<%if(!r.empty("l_niz_mik_"+count)){%> 
    <%=r.get("l_niz_mik_"+count)%>
    <%if(!r.empty("l_niz_mik_how_"+count)){%> <%=r.get("l_niz_mik_how_"+count)%> мм.<%}%>
<%}%>
<%if(!r.empty("l_chls_mik_"+count)){%> 
    <%=r.get("l_chls_mik_"+count)%>
    <%if(!r.empty("l_chls_mik_how_"+count)){%> <%=r.get("l_chls_mik_how_"+count)%> мм.<%}%>
<%}%><%}%>
<%if(!r.empty("addition_" + count)){%><br><b>Дополнительные признаки:</b> <%=r.get("addition_" + count)%><%}%>
<br><b>Ультразвуковая картина характерна для:</b> <%=r.get("decision_" + count)%> <%=r.get("decision_text_" + count)%><br>
