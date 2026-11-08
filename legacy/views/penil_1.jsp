<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<table width="80%" border="1">
    <tr><td colspan="3" align="center"><b>Фаза покоя</b></td></tr>
    <tr><td width="30%"> &nbsp;</td> 
        <td width="25%" align="center"><b> Справа</b></td> 
        <td width="25%" align="center"><b> Слева</b></td> 
    </tr>
    <tr><td width="30%" align="center"><b> Площадь кавернозных тел</b></td> 
        <td width="25%" align="center"> <%=r.get("r_s_kaver")%> см2</td> 
        <td width="25%" align="center"> <%=r.get("l_s_kaver")%> см2</td> 
    </tr>
    <tr> 
        <td align="center"><b> Диаметр кавернозных артерий</b></td> 
        <td align="center"> <%=r.get("r_d_kaver")%> мм</td> 
        <td align="center"> <%=r.get("l_d_kaver")%> мм</td> 
    </tr>    
    <tr><td align="center"><b> Ход сосудов</b></td> 
        <td align="center"> <%=r.get("r_hod")%></td> 
        <td align="center"> <%=r.get("l_hod")%></td> 
    </tr>
    <tr> 
        <td align="center"><b> Скоростные показатели в кавернозной артерии</b></td> 
        <td align="center"> V max = <%=r.get("r_v_max1")%> см/с<br>
                            V min = <%=r.get("r_v_min1")%> см/с<br>
                            JR = <%=r.get("r_jr1")%><br> 
                            PJ = <%=r.get("r_pj1")%> 
        </td> 
        <td align="center"> V max = <%=r.get("l_v_max1")%> см/с<br>
                            V min = <%=r.get("l_v_min1")%> см/с<br>
                            JR = <%=r.get("l_jr1")%><br> 
                            PJ = <%=r.get("l_pj1")%> 
        </td> 
    </tr>    
    <tr><td colspan="3" align="center"><b>Фаза тумесценции - через <%=r.get("faza_t")%>  мин</b></td></tr>
    <tr><td width="30%"> &nbsp;</td> 
        <td width="25%" align="center"><b> Справа</b></td> 
        <td width="25%" align="center"><b> Слева</b></td> 
    </tr>
    <tr><td width="30%" align="center"><b> Скоростные показатели в кавернозной артерии</b></td> 
        <td width="25%" align="center"> V max = <%=r.get("r_v_max2")%> см/с<br>
                                        V min = <%=r.get("r_v_min2")%> см/с<br>
                                        JR = <%=r.get("r_jr2")%><br> 
                                        PJ = <%=r.get("r_pj2")%>  
        </td>
        <td width="25%" align="center"> V max = <%=r.get("l_v_max2")%> см/с<br>
                                        V min = <%=r.get("l_v_min2")%> см/с<br>
                                        JR = <%=r.get("l_jr2")%><br> 
                                        PJ = <%=r.get("l_pj2")%> 
        </td> 
    </tr>
    <tr><td colspan="3" align="center"><b>Фаза эрекции - через <%=r.get("faza_e")%>  мин</b></td></tr>
    <tr><td width="30%"> &nbsp;</td> 
        <td width="25%" align="center"><b> Справа</b></td> 
        <td width="25%" align="center"><b> Слева</b></td> 
    </tr>
    <tr><td width="30%" align="center"><b> Площадь кавернозных тел</b></td> 
        <td width="25%" align="center"> <%=r.get("r_s_erek")%> см2</td> 
        <td width="25%" align="center"> <%=r.get("l_s_erek")%> см2</td> 
    </tr>
    <tr> 
        <td align="center"><b> Диаметр кавернозных артерий</b></td> 
        <td align="center"> <%=r.get("r_d_erek")%> мм</td> 
        <td align="center"> <%=r.get("l_d_erek")%> мм</td> 
    </tr>    
    <tr> 
        <td align="center"><b> Скоростные показатели в кавернозной артерии</b></td> 
        <td align="center"> V max = <%=r.get("r_v_max3")%> см/с<br>
                            V min = <%=r.get("r_v_min3")%> см/с<br>
                            JR = <%=r.get("r_jr3")%><br> 
                            PJ = <%=r.get("r_pj3")%> 
        </td> 
        <td align="center"> V max = <%=r.get("l_v_max3")%> см/с<br>
                            V min = <%=r.get("l_v_min3")%> см/с<br>
                            JR = <%=r.get("l_jr3")%><br> 
                            PJ = <%=r.get("l_pj3")%> 
        </td> 
    </tr>    
</table>
