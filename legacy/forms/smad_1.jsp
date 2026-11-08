<%@page import = "java.util.Date" import="my_pack.beans.*" import="my_pack.tools.* java.text.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title" align="center"><%=r.get("research")%></H3>


  <H3 class="p_title">Суточное мониторирование АД</H3>




<table width="100%" border="1">
    <tr><td> Проведено суточное мониторирование АД</td> </tr>
    <tr><td> Продолжительность записи <%=r.getSizeInput("prodolj_zap")%> часов</td></tr>    
</table>
<table width="100%" border="1">
    <tr><td width="19%"> Период</td> 
        <td width="27%" colspan="3"> Общий</td> 
        <td width="27%" colspan="3"> День</td> 
        <td width="27%" colspan="3"> Ночь</td> 
    </tr>
    <tr><td width="19%"> &nbsp;</td> 
        <td width="9%"> Средняя</td> 
        <td width="9%"> Мin.</td> 
        <td width="9%"> Мах.</td> 
        <td width="9%"> Средняя</td> 
        <td width="9%"> Мin.</td> 
        <td width="9%"> Мах.</td> 
        <td width="9%"> Средняя</td> 
        <td width="9%"> Мin.</td> 
        <td width="9%"> Мах.</td> 
    </tr>
    <tr><td width="19%"> Систолическое АД</td> 
        <td width="9%"> <%=r.getSizeInput("sistAD_o_sr")%></td> 
        <td width="9%"> <%=r.getSizeInput("sistAD_o_mi")%></td> 
        <td width="9%"> <%=r.getSizeInput("sistAD_o_ma")%></td> 
        <td width="9%"> <%=r.getSizeInput("sistAD_d_sr")%></td> 
        <td width="9%"> <%=r.getSizeInput("sistAD_d_mi")%></td> 
        <td width="9%"> <%=r.getSizeInput("sistAD_d_ma")%></td> 
        <td width="9%"> <%=r.getSizeInput("sistAD_n_sr")%></td> 
        <td width="9%"> <%=r.getSizeInput("sistAD_n_mi")%></td> 
        <td width="9%"> <%=r.getSizeInput("sistAD_n_ma")%></td> 
    </tr>
    <tr><td width="19%"> Диастолическое АД</td> 
        <td width="9%"> <%=r.getSizeInput("diastAD_o_sr")%></td> 
        <td width="9%"> <%=r.getSizeInput("diastAD_o_mi")%></td> 
        <td width="9%"> <%=r.getSizeInput("diastAD_o_ma")%></td> 
        <td width="9%"> <%=r.getSizeInput("diastAD_d_sr")%></td> 
        <td width="9%"> <%=r.getSizeInput("diastAD_d_mi")%></td> 
        <td width="9%"> <%=r.getSizeInput("diastAD_d_ma")%></td> 
        <td width="9%"> <%=r.getSizeInput("diastAD_n_sr")%></td> 
        <td width="9%"> <%=r.getSizeInput("diastAD_n_mi")%></td> 
        <td width="9%"> <%=r.getSizeInput("diastAD_n_ma")%></td> 
    </tr>               
    <tr><td width="19%"> ИВ САД %</td> 
        <td width="9%"> <%=r.getSizeInput("ivSAD_o_sr")%></td>
        <td width="9%"> <%=r.getSizeInput("ivSAD_o_mi")%></td>
        <td width="9%"> <%=r.getSizeInput("ivSAD_o_ma")%></td>
        <td width="9%"> <%=r.getSizeInput("ivSAD_d_sr")%></td>
        <td width="9%"> <%=r.getSizeInput("ivSAD_d_mi")%></td>
        <td width="9%"> <%=r.getSizeInput("ivSAD_d_ma")%></td>
        <td width="9%"> <%=r.getSizeInput("ivSAD_n_sr")%></td>
        <td width="9%"> <%=r.getSizeInput("ivSAD_n_mi")%></td>
        <td width="9%"> <%=r.getSizeInput("ivSAD_n_ma")%></td>
    </tr>
    <tr><td width="19%"> ИВ ДАД %</td> 
        <td width="9%"> <%=r.getSizeInput("ivDAD_o_sr")%></td>
        <td width="9%"> <%=r.getSizeInput("ivDAD_o_mi")%></td>
        <td width="9%"> <%=r.getSizeInput("ivDAD_o_ma")%></td>
        <td width="9%"> <%=r.getSizeInput("ivDAD_d_sr")%></td>
        <td width="9%"> <%=r.getSizeInput("ivDAD_d_mi")%></td>
        <td width="9%"> <%=r.getSizeInput("ivDAD_d_ma")%></td>
        <td width="9%"> <%=r.getSizeInput("ivDAD_n_sr")%></td>
        <td width="9%"> <%=r.getSizeInput("ivDAD_n_mi")%></td>
        <td width="9%"> <%=r.getSizeInput("ivDAD_n_ma")%></td>
    </tr>
    <tr><td width="19%"> Суточный индекс САД</td> 
        <td width="9%"> <%=r.getSizeInput("siSAD_o_sr")%></td>
        <td width="9%"> <%=r.getSizeInput("siSAD_o_mi")%></td>
        <td width="9%"> <%=r.getSizeInput("siSAD_o_ma")%></td>
        <td width="9%"> <%=r.getSizeInput("siSAD_d_sr")%></td>
        <td width="9%"> <%=r.getSizeInput("siSAD_d_mi")%></td>
        <td width="9%"> <%=r.getSizeInput("siSAD_d_ma")%></td>
        <td width="9%"> <%=r.getSizeInput("siSAD_n_sr")%></td>
        <td width="9%"> <%=r.getSizeInput("siSAD_n_mi")%></td>
        <td width="9%"> <%=r.getSizeInput("siSAD_n_ma")%></td>
    </tr>
    <tr><td width="19%"> Суточный индекс ДАД</td> 
        <td width="27%" colspan="3"> <%=r.getSizeInput("siDAD_sr")%></td>
        <td width="27%" colspan="3"> <%=r.getSizeInput("siDAD_de")%></td>
        <td width="27%" colspan="3"> <%=r.getSizeInput("siDAD_no")%></td>
    </tr>
</table>
<%@include file="footer.jsp"%>
