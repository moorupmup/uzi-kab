<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title">Ультразвуковое исследование мочевого пузыря</H3>

<table width="100%" border="1">
    <tr> 
        <td width="25%" class="simple_str">Форма мочевого пузыря 
        </td>
        <td colspan="2"><%=r.getSelect("forma")%>
        </td>
		<SCRIPT LANGUAGE="JavaScript">
			document.protocol.forma.focus();
		</script>
    </tr>
    <tr> 
        <td width="25%" class="simple_str">Содержит
        </td>
        <td colspan="2"><%=r.getSizeInput("mocha_how")%>
        	<span class="ed_izm"> мл мочи</span>
        </td>
    </tr>
    <tr> 
        <td width="25%" class="simple_str">Содержимое
        </td>
        <td colspan="2"><%=r.getSelect("soder")%>
        </td>
    </tr>
    <tr> 
        <td width="25%" class="simple_str">Стенка 
        </td>
        <td>
			<%=r.getSizeInput("stenka_how")%>
        	<span class="ed_izm"> мм</span>
		</td>
		<td>
        	<%=r.getCheckbox("otch")%><br>
        	<%=r.getCheckbox("vnutr")%>
        </td>
    </tr>
    <tr> 
        <td width="25%" class="simple_str">В полости
        </td>
        <td colspan="2">
        	<%=r.getSelect("polost")%>
        	<%=r.getSizeInput("polost_how")%>
        	<span class="ed_izm"> мм</span>
        </td>
    </tr>
    <tr> 
        <td width="25%" class="simple_str">После микции
        </td>
        <td colspan="2">
        	<%=r.getCheckbox("sod")%>
        	<%=r.getSizeInput("sod_how")%><br>
        	<%=r.getCheckbox("ostat")%>
        </td>
    </tr>
</table>

<%@include file="footer.jsp"%>