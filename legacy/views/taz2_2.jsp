<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>
Ядра окостенения <%=r.get("yadro_"+count)%>
    <%if(!r.empty("oba_yadro_"+count)){%> <%=r.get("oba_yadro_"+count)%><%}%>
    <%if(!r.empty("right_yadro_"+count)){%> <%=r.get("right_yadro_"+count)%><%}%>
    <%if(!r.empty("left_yadro_"+count)){%> <%=r.get("left_yadro_"+count)%><%}%>.<br>
Интенсивность <%=r.get("intens_"+count)%>
    <%if(!r.empty("right_intens_"+count)){%> <%=r.get("right_intens_"+count)%><%}%>
    <%if(!r.empty("left_intens_"+count)){%> <%=r.get("left_intens_"+count)%><%}%>.<br>
<%if(!r.empty("sootn_"+count) || !r.empty("preobl_"+count)){%>
    <%if(!r.empty("sootn_"+count)){%> <%=r.get("sootn_"+count)%>.<br><%}%>
    <%if(!r.empty("preobl_"+count)){%> <%=r.get("preobl_"+count)%>.<br><%}%>
<%}%>
<%if(!r.empty("tbs_"+count)){%>Головки ТБС <%=r.get("tbs_"+count)%>.<br><%}%>
Угловые параметры <%=r.get("param_"+count)%>.
<%if(!r.empty("right_alfa_"+count) || !r.empty("right_betta_"+count) || !r.empty("right_gamma_"+count)){%><br>Справа:
    <%if(!r.empty("right_alfa_"+count)){%>a - <%=r.get("right_alfa_"+count)%><%}%>
    <%if(!r.empty("right_betta_"+count)){%>b - <%=r.get("right_betta_"+count)%><%}%>
    <%if(!r.empty("right_gamma_"+count)){%>g - <%=r.get("right_gamma_"+count)%><%}%>
<br><%}%>
<%if(!r.empty("left_alfa_"+count) || !r.empty("left_betta_"+count) || !r.empty("left_gamma_"+count)){%>Слева:
    <%if(!r.empty("left_alfa_"+count)){%>a - <%=r.get("left_alfa_"+count)%><%}%>
    <%if(!r.empty("left_betta_"+count)){%>b - <%=r.get("left_betta_"+count)%><%}%>
    <%if(!r.empty("left_gamma_"+count)){%>g - <%=r.get("left_gamma_"+count)%><%}%>
<%}%>
<%if(!r.empty("addition_" + count)){%><br><b>Дополнительные признаки:</b> <%=r.get("addition_" + count)%><%}%>
<br><b>Ультразвуковая картина характерна для:</b> <%=r.get("decision_" + count)%> <%=r.get("decision_text_" + count)%><br>
