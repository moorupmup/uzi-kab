<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>


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
        <td align="center"> <%=r.get("r_hod_"+count)%></td> 
        <td align="center"> <%=r.get("l_hod_"+count)%></td> 
    </tr>
    <tr> 
        <td align="center"><b> Скоростные показатели в кавернозной артерии</b></td> 
        <td align="center"> V max = <%=r.get("r_v_max1")%> см/с<br>
                            V min = <%=r.get("r_v_min1")%> см/с<br>
                            IR = <%=r.get("r_jr1")%><br> 
        </td> 
        <td align="center"> V max = <%=r.get("l_v_max1")%> см/с<br>
                            V min = <%=r.get("l_v_min1")%> см/с<br>
                            IR = <%=r.get("l_jr1")%><br> 
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
                                        IR = <%=r.get("r_jr2")%><br> 
        </td>
        <td width="25%" align="center"> V max = <%=r.get("l_v_max2")%> см/с<br>
                                        V min = <%=r.get("l_v_min2")%> см/с<br>
                                        IR = <%=r.get("l_jr2")%><br> 
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
                            IR = <%=r.get("r_jr3")%><br> 
        </td> 
        <td align="center"> V max = <%=r.get("l_v_max3")%> см/с<br>
                            V min = <%=r.get("l_v_min3")%> см/с<br>
                            IR = <%=r.get("l_jr3")%><br> 
        </td> 
    </tr>    
</table>
Дорзальная вена <%=r.get("dorz_"+count)%>.<br>
Изменения в белочной оболочке <%=r.get("izm_obol_"+count)%>.
<%if(!r.empty("addition_" + count)){%><br><b>Дополнительные признаки:</b> <%=r.get("addition_" + count)%><%}%>
<br><b>Ультразвуковая картина характерна для:</b> <%=r.get("decision_" + count)%> <%=r.get("decision_text_" + count)%><br>