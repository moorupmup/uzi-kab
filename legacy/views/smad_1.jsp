
    <%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>






<b>Проведено суточное мониторирование АД</b><br>
Продолжительность записи <%=r.get("prodolj_zap_" + count)%> часов
<table width="100%" class="print">
    <tr><td width="19%" rowspan="2" align="center"> Период</td> 
        <td width="27%" colspan="3" align="center"> Общий</td> 
        <td width="27%" colspan="3" align="center"> День</td> 
        <td width="27%" colspan="3" align="center"> Ночь</td> 
    </tr>
    <tr> 
        <td width="9%" align="center"> Средняя</td> 
        <td width="9%" align="center"> Мin.</td> 
        <td width="9%" align="center"> Мах.</td> 
        <td width="9%" align="center"> Средняя</td> 
        <td width="9%" align="center"> Мin.</td> 
        <td width="9%" align="center"> Мах.</td> 
        <td width="9%" align="center"> Средняя</td> 
        <td width="9%" align="center"> Мin.</td> 
        <td width="9%" align="center"> Мах.</td> 
    </tr>
    <tr><td width="19%"> Систолическое АД</td> 
        <td width="9%" align="center"> <%=r.get("sistAD_o_sr_" + count)%></td> 
        <td width="9%" align="center"> <%=r.get("sistAD_o_mi_" + count)%></td> 
        <td width="9%" align="center"> <%=r.get("sistAD_o_ma_" + count)%></td> 
        <td width="9%" align="center"> <%=r.get("sistAD_d_sr_" + count)%></td> 
        <td width="9%" align="center"> <%=r.get("sistAD_d_mi_" + count)%></td> 
        <td width="9%" align="center"> <%=r.get("sistAD_d_ma_" + count)%></td> 
        <td width="9%" align="center"> <%=r.get("sistAD_n_sr_" + count)%></td> 
        <td width="9%" align="center"> <%=r.get("sistAD_n_mi_" + count)%></td> 
        <td width="9%" align="center"> <%=r.get("sistAD_n_ma_" + count)%></td> 
    </tr>
    <tr><td width="19%"> Диастолическое АД</td> 
        <td width="9%" align="center"> <%=r.get("diastAD_o_sr_" + count)%></td> 
        <td width="9%" align="center"> <%=r.get("diastAD_o_mi_" + count)%></td> 
        <td width="9%" align="center"> <%=r.get("diastAD_o_ma_" + count)%></td> 
        <td width="9%" align="center"> <%=r.get("diastAD_d_sr_" + count)%></td> 
        <td width="9%" align="center"> <%=r.get("diastAD_d_mi_" + count)%></td> 
        <td width="9%" align="center"> <%=r.get("diastAD_d_ma_" + count)%></td> 
        <td width="9%" align="center"> <%=r.get("diastAD_n_sr_" + count)%></td> 
        <td width="9%" align="center"> <%=r.get("diastAD_n_mi_" + count)%></td> 
        <td width="9%" align="center"> <%=r.get("diastAD_n_ma_" + count)%></td> 
    </tr>               
    <tr><td width="19%"> ИВ САД %</td> 
        <td width="9%" align="center"> <%=r.get("ivSAD_o_sr_" + count)%></td>
        <td width="9%" align="center"> <%=r.get("ivSAD_o_mi_" + count)%></td>
        <td width="9%" align="center"> <%=r.get("ivSAD_o_ma_" + count)%></td>
        <td width="9%" align="center"> <%=r.get("ivSAD_d_sr_" + count)%></td>
        <td width="9%" align="center"> <%=r.get("ivSAD_d_mi_" + count)%></td>
        <td width="9%" align="center"> <%=r.get("ivSAD_d_ma_" + count)%></td>
        <td width="9%" align="center"> <%=r.get("ivSAD_n_sr_" + count)%></td>
        <td width="9%" align="center"> <%=r.get("ivSAD_n_mi_" + count)%></td>
        <td width="9%" align="center"> <%=r.get("ivSAD_n_ma_" + count)%></td>
    </tr>
    <tr><td width="19%"> ИВ ДАД %</td> 
        <td width="9%" align="center"> <%=r.get("ivDAD_o_sr_" + count)%></td>
        <td width="9%" align="center"> <%=r.get("ivDAD_o_mi_" + count)%></td>
        <td width="9%" align="center"> <%=r.get("ivDAD_o_ma_" + count)%></td>
        <td width="9%" align="center"> <%=r.get("ivDAD_d_sr_" + count)%></td>
        <td width="9%" align="center"> <%=r.get("ivDAD_d_mi_" + count)%></td>
        <td width="9%" align="center"> <%=r.get("ivDAD_d_ma_" + count)%></td>
        <td width="9%" align="center"> <%=r.get("ivDAD_n_sr_" + count)%></td>
        <td width="9%" align="center"> <%=r.get("ivDAD_n_mi_" + count)%></td>
        <td width="9%" align="center"> <%=r.get("ivDAD_n_ma_" + count)%></td>
    </tr>
    <tr><td width="19%"> Суточный индекс САД</td> 
        <td width="9%" align="center"> <%=r.get("siSAD_o_sr_" + count)%></td>
        <td width="9%" align="center"> <%=r.get("siSAD_o_mi_" + count)%></td>
        <td width="9%" align="center"> <%=r.get("siSAD_o_ma_" + count)%></td>
        <td width="9%" align="center"> <%=r.get("siSAD_d_sr_" + count)%></td>
        <td width="9%" align="center"> <%=r.get("siSAD_d_mi_" + count)%></td>
        <td width="9%" align="center"> <%=r.get("siSAD_d_ma_" + count)%></td>
        <td width="9%" align="center"> <%=r.get("siSAD_n_sr_" + count)%></td>
        <td width="9%" align="center"> <%=r.get("siSAD_n_mi_" + count)%></td>
        <td width="9%" align="center"> <%=r.get("siSAD_n_ma_" + count)%></td>
    </tr>
    <tr><td width="19%"> Суточный индекс ДАД</td> 
        <td width="27%" colspan="3" align="center"> <%=r.get("siDAD_sr_" + count)%></td>
        <td width="27%" colspan="3" align="center"> <%=r.get("siDAD_de_" + count)%></td>
        <td width="27%" colspan="3" align="center"> <%=r.get("siDAD_no_" + count)%></td>
    </tr>
</table>
   <%if(!r.empty("addition_" + count)){%> 

<b>
Комментарии:</b> <%=r.get("addition_" + count)%><%}%>
<br><b>Заключение:</b> <%=r.get("decision_" + count)%> <%=r.get("decision_text_" + count)%><br>

