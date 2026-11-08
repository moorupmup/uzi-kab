<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title" align="center">Дуплексное сканирование сосудов нижних конечностей (артерий и вен)</H3>

<b>ДУПЛЕКСНОЕ СКАНИРОВАНИЕ АРТЕРИЙ НИЖНИХ КОНЕЧНОСТЕЙ:</b><br>
<%=r.get("art")%>

<br><b>ДУПЛЕКСНОЕ СКАНИРОВАНИЕ ВЕН НИЖНИХ КОНЕЧНОСТЕЙ:</b><br>
<%=r.get("ven")%><br>



<%@include file="footer.jsp"%>
