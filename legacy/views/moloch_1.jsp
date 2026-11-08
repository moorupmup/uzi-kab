<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>



<%if(!r.get("moloch_del").equals("")){%> 
    Молочная железа <%=r.get("moloch_del")%> удалена оперативно 
    <%if(!r.empty("moloch_god")){%> 
        в <%=r.get("moloch_god")%> году
    <%}%>.<br>
<%}%>

<%=r.get("moloch_text")%>


<%if(!r.get("moloch_del").equals("с обеих сторон")){%> 

<%if(!r.get("moloch_koja").equals("")){%> 
    Кожные покровы, ареолы <%=r.get("moloch_koja")%> <%=r.get("moloch_koja_text")%>.<br>
<%}%>
<%if(!r.get("moloch_sosok").equals("")){%> 
    Сосок <%=r.get("moloch_sosok")%>.<br>
<%}%>
<%if(!r.get("moloch_jel").equals("")){%> 
    Молочные железы представлены <%=r.get("moloch_jel")%>.<br>
<%}%>
<%if(!r.get("moloch_protok").equals("")){%> 
    Млечные протоки <%=r.get("moloch_protok")%>
<%}%>
<%if(r.get("moloch_protok").equals("расширены")){%> 
    <%if(!r.empty("m_protok_mm")){%> 
        до <%=r.get("m_protok_mm")%> мм
    <%}%>
    <%=r.get("m_protok_ravn")%>
    <%=r.get("m_protok_gde")%>
<%}%>.<br>
<%if(!r.get("sost_protok").equals("")){%> 
    Состояние протоков <%=r.get("sost_protok")%>.<br>
<%}%>
<%if(!r.get("moloch_stroma").equals("")){%> 
    Строма <%=r.get("moloch_stroma")%>.<br>
<%}%>
<%if(!r.get("moloch_ochag").equals("не определяются")){%> 
    <%=r.get("moloch_obraz")%>.<br>
<%}%>
<%if(!r.get("moloch_limfou").equals("")){%> 
    Региональные лимфатические узлы <%=r.getSelect("moloch_limfou")%> 
<%}%>
<%if(r.get("moloch_limfou").equals("увеличены")){%> 
    <%if(!r.empty("m_limf_mm")){%> 
        до <%=r.get("m_limf_mm")%> мм
    <%}%>
    <%=r.get("m_limf_gde")%> <%=r.get("m_limf_text")%>
<%}%>.

<%}%>