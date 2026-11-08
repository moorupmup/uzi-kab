<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title">Пункционное лечение при гидроцелле</H3>

<table width="100%" border="1">
    <tr> 
        <td width="25%" class="simple_str"><b>Правое яичко</b>
        </td>
        <td colspan="2"><%=r.getSelect("r_rasp")%>
        </td>
        <SCRIPT LANGUAGE="JavaScript">
            document.protocol.r_rasp.focus();
        </script>
    </tr>
    <tr> 
        <td width="25%" class="simple_str">Форма
        </td>
        <td colspan="2"><%=r.getSelect("r_forma")%>
        </td>
    </tr>
    <tr> 
        <td width="25%" class="simple_str">Эхоструктура 
        </td>
        <td colspan="2"><%=r.getSelect("r_echo")%>
        </td>
    </tr>
    <tr> 
        <td width="25%" class="simple_str">Эхоплотность
        </td>
        <td colspan="2"><%=r.getSelect("r_plot")%>
        </td>
    </tr>
    <tr> 
        <td width="25%" class="simple_str">Размеры
        </td>
        <td colspan="2">
            <%=r.getSizeInput("r_size1")%>*
            <%=r.getSizeInput("r_size2")%>*
            <%=r.getSizeInput("r_size3")%>
            <span class="ed_izm"> мм</span>
        </td>
    </tr>
    <tr> 
        <td width="25%" class="simple_str">Придаток
        </td>
        <td colspan="2">
            <%=r.getSelect("r_prid")%>
            <%=r.getSizeInput("r_prid_how")%>
            <span class="ed_izm"> мм</span>
        </td>
    </tr>
    <tr> 
        <td colspan="3" class="simple_str">Свободная жидкость в оболочках яичка 
            <%=r.getSelect("r_free")%>
            <%=r.getSizeInput("r_free_how")%>
        </td>
    </tr>
    <tr> 
        <td width="25%" class="simple_str">Гидатиды 
        </td>
        <td colspan="2">
            <%=r.getSelect("r_gidat")%>
        </td>
    </tr>
</table>

<table width="100%" border="1">
    <tr> 
        <td width="25%" class="simple_str"><b>Левое яичко</b>
        </td>
        <td colspan="2"><%=r.getSelect("l_rasp")%>
        </td>
    </tr>
    <tr> 
        <td width="25%" class="simple_str">Форма
        </td>
        <td colspan="2"><%=r.getSelect("l_forma")%>
        </td>
    </tr>
    <tr> 
        <td width="25%" class="simple_str">Эхоструктура 
        </td>
        <td colspan="2"><%=r.getSelect("l_echo")%>
        </td>
    </tr>
    <tr> 
        <td width="25%" class="simple_str">Эхоплотность
        </td>
        <td colspan="2"><%=r.getSelect("l_plot")%>
        </td>
    </tr>
    <tr> 
        <td width="25%" class="simple_str">Размеры
        </td>
        <td colspan="2">
            <%=r.getSizeInput("l_size1")%>*
            <%=r.getSizeInput("l_size2")%>*
            <%=r.getSizeInput("l_size3")%>
            <span class="ed_izm"> мм</span>
        </td>
    </tr>
    <tr> 
        <td width="25%" class="simple_str">Придаток
        </td>
        <td colspan="2">
            <%=r.getSelect("l_prid")%>
            <%=r.getSizeInput("l_prid_how")%>
            <span class="ed_izm"> мм</span>
        </td>
    </tr>
    <tr> 
        <td colspan="3" class="simple_str">Свободная жидкость в оболочках яичка 
            <%=r.getSelect("l_free")%>
            <%=r.getSizeInput("l_free_how")%>
        </td>
    </tr>
    <tr> 
        <td width="25%" class="simple_str">Гидатиды 
        </td>
        <td colspan="2">
            <%=r.getSelect("l_gidat")%>
        </td>
    </tr>
</table>

<table width="100%" border="1">
    <tr>
        <td width="40%" class="simple_str">Вены гроздьевидного сплетения 
            <%=r.getSelect("veni")%>
        </td>
        <td>
            <%=r.getChangeHidden("veni", "1", "2323")%>
                <%=r.getSizeInput("veni_how")%>мм<br>
                <%=r.getCheckbox("veni_right")%><br>
                <%=r.getCheckbox("veni_left")%>
            </div>
        </td>
    </tr>
    <tr>
        <td class="simple_str">Проба Вальсальвы
            <%=r.getSelect("vals")%>
        </td>
        <td>
            <%=r.getCheckbox("vals_right")%><br>
            <%=r.getCheckbox("vals_left")%>
        </td>
    </tr>
    <tr>
        <td colspan="2" class="simple_str">Диаметр вен до
            <%=r.getSizeInput("diametr")%>
            <span class="ed_izm"> мм</span>
        </td>
    </tr>
</table>

<%@include file="footer.jsp"%>
