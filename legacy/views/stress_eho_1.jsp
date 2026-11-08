<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>

<br>
С пациентом (его законным представителем) проведено собеседование о предстоящем исследовании:
добровольное информированное согласие получено.

<br><br>
Исследование выполнено на аппарате: VIVID 7 Dimension, фирмы General Electric, США- кардиоваскулярном ультразвуковом сканере экспертного класса, электрофизиологическом комплексе "Биоток-150КС".

<br>

<%if(!r.empty("komment_"+count)){%>
        <b>Комментарии:</b> <%=r.get("komment_"+count)%><br>
<%}%>


<%if(!r.empty("zakl_"+count)){%>
        <b>Заключение:</b> <%=r.get("zakl_"+count)%><br>
<%}%>
<%if(!r.empty("rekomend_"+count)){%>
        <b>Рекомендации:</b> <%=r.get("rekomend_"+count)%><br>
<%}%>
