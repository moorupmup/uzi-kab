<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title" align="center"><%=r.get("research")%></H3>

<table width="80%" border="1">
    <tr><td colspan="3" align="center"><b>Фаза покоя</b></td></tr>
    <tr><td width="30%"> &nbsp;</td> 
        <td width="25%" align="center"> <b>Справа</b></td> 
        <td width="25%" align="center"> <b>Слева</b></td> 
    </tr>
    <tr><td width="30%" > <b>Площадь кавернозных тел</b></td> 
        <td width="25%" align="center"> <%=r.getSizeInput("r_s_kaver")%> см2</td> 
        <SCRIPT LANGUAGE="JavaScript">
            document.protocol.r_s_kaver.focus();
        </script>
        <td width="25%" align="center"> <%=r.getSizeInput("l_s_kaver")%> см2</td> 
    </tr>
    <tr> 
        <td> <b>Диаметр кавернозных артерий</b></td> 
        <td align="center"> <%=r.getSizeInput("r_d_kaver")%> мм</td> 
        <td align="center"> <%=r.getSizeInput("l_d_kaver")%> мм</td> 
    </tr>    
    <tr><td><b> Ход сосудов</b></td> 
        <td align="center"> <%=r.getSelect("r_hod")%></td> 
        <td align="center"> <%=r.getSelect("l_hod")%></td> 
    </tr>
    <tr> 
        <td><b> Скоростные показатели в кавернозной артерии</b></td> 
        <td align="center"> V max = <%=r.getSizeInput("r_v_max1")%> см/с<br>
                            V min = <%=r.getSizeInput("r_v_min1")%> см/с<br>
                            IR = <%=r.getSizeInput("r_jr1")%><br> 
        </td> 
        <td align="center"> V max = <%=r.getSizeInput("l_v_max1")%> см/с<br>
                            V min = <%=r.getSizeInput("l_v_min1")%> см/с<br>
                            IR = <%=r.getSizeInput("l_jr1")%><br> 
        </td> 
    </tr>    
    <tr><td colspan="3" align="center"><b>Фаза тумесценции - через <%=r.getSizeInput("faza_t")%>  мин</b></td></tr>
    <tr><td width="30%"> &nbsp;</td> 
        <td width="25%" align="center"> <b>Справа</b></td> 
        <td width="25%" align="center"> <b>Слева</b></td> 
    </tr>
    <tr><td width="30%"> <b>Скоростные показатели в кавернозной артерии</b></td> 
        <td width="25%" align="center"> V max = <%=r.getSizeInput("r_v_max2")%> см/с<br>
                                        V min = <%=r.getSizeInput("r_v_min2")%> см/с<br>
                                        IR = <%=r.getSizeInput("r_jr2")%><br> 
        </td>
        <td width="25%" align="center"> V max = <%=r.getSizeInput("l_v_max2")%> см/с<br>
                                        V min = <%=r.getSizeInput("l_v_min2")%> см/с<br>
                                        IR = <%=r.getSizeInput("l_jr2")%><br> 
        </td> 
    </tr>
    <tr><td colspan="3" align="center"><b>Фаза эрекции - через <%=r.getSizeInput("faza_e")%>  мин</b></td></tr>
    <tr><td width="30%"> &nbsp;</td> 
        <td width="25%" align="center"><b> Справа</b></td> 
        <td width="25%" align="center"><b> Слева</b></td> 
    </tr>
    <tr><td width="30%" ><b> Площадь кавернозных тел</b></td> 
        <td width="25%" align="center"> <%=r.getSizeInput("r_s_erek")%> см2</td> 
        <td width="25%" align="center"> <%=r.getSizeInput("l_s_erek")%> см2</td> 
    </tr>
    <tr> 
        <td> <b>Диаметр кавернозных артерий</b></td> 
        <td align="center"> <%=r.getSizeInput("r_d_erek")%> мм</td> 
        <td align="center"> <%=r.getSizeInput("l_d_erek")%> мм</td> 
    </tr>    
    <tr> 
        <td><b> Скоростные показатели в кавернозной артерии</b></td> 
        <td align="center"> V max = <%=r.getSizeInput("r_v_max3")%> см/с<br>
                            V min = <%=r.getSizeInput("r_v_min3")%> см/с<br>
                            IR = <%=r.getSizeInput("r_jr3")%><br> 
        </td> 
        <td align="center"> V max = <%=r.getSizeInput("l_v_max3")%> см/с<br>
                            V min = <%=r.getSizeInput("l_v_min3")%> см/с<br>
                            IR = <%=r.getSizeInput("l_jr3")%><br> 
        </td> 
    </tr>
	<tr><td colspan="3">Дорзальная вена <%=r.getSelect("dorz")%></td></tr>    
	<tr><td colspan="3">Изменения в белочной оболочке <%=r.getSelect("izm_obol")%>
</table>

<%@include file="footer.jsp"%>