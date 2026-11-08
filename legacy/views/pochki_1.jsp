<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%String count=r.get("count").toString();%>
<br><b>Правая почка</b> <%=r.getSelect("r_pochka")%>
<%if(r.get("r_pochka").equals("расположена в обычном месте") || r.get("r_pochka").equals("расположена в подвздошной области") || r.get("r_pochka").equals("расположена в малом тазу")){%> 
    <%if(!r.empty("r_razm_poch_1") || !r.empty("r_razm_poch_2")){%> 
        Размеры
        <%if(!r.empty("r_razm_poch_1")){%> <%=r.get("r_razm_poch_1")%> мм<%}%>
        <%if(!r.empty("r_razm_poch_2")){%> <%=r.get("r_razm_poch_2")%> мм<%}%>.
    <%}%>
    Контуры <%=r.get("r_kontur_poch")%>.
    <%if(!r.empty("r_tolsh_paren_1") || !r.empty("r_tolsh_paren_2") || !r.empty("r_tolsh_paren_3")){%> 
        Толщина паренхимы в средней трети
        <%if(!r.empty("r_tolsh_paren_1")){%> <%=r.get("r_tolsh_paren_1")%> мм <%}%>
        <%if(!r.empty("r_tolsh_paren_2")){%> <%=r.get("r_tolsh_paren_2")%> мм <%}%>
        <%if(!r.empty("r_tolsh_paren_3")){%> <%=r.get("r_tolsh_paren_3")%> мм <%}%>.
    <%}%>
    Эхогенность паренхимы <%=r.get("r_eho_paren")%>.
    Кортико-медуллярная дифференциация <%=r.get("r_differ")%>.
    Чашечно - лоханочная система <%=r.get("r_chash")%>
    <%if(r.get("r_chash").equals("расширена")){%> 
        <%if(!r.empty("r_chash_check") || !r.empty("r_lohanki")){%> 
            за счет
            <%if(!r.empty("r_chash_check")){%> 
                <%=r.get("r_chash_check")%> <%=r.get("r_chash_local")%>
                <%if(!r.empty("r_chash_size")){%>до <%=r.get("r_chash_size")%> мм <%}%>
            <%}%>
            <%if(!r.empty("r_lohanki")){%> 
                <%=r.get("r_lohanki")%> 
                <%if(!r.empty("r_lohan_size")){%>до <%=r.get("r_lohan_size")%> мм <%}%>
            <%}%>
        <%}%>
    <%}%>
    <%if(!r.empty("r_pochka_text")){%> <%=r.get("r_pochka_text")%> <%}%>
    <%if(!r.get("r_nadpoch").equals("") || !r.empty("r_nadpoch_text")){%>
        В проекции надпочечников <%=r.get("r_nadpoch")%> <%=r.get("r_nadpoch_text")%>
    <%}%>
<%}%>
<%if(r.get("r_pochka").equals("опущена в положении стоя") || r.get("r_pochka").equals("опущена в положении лежа") || r.get("r_pochka").equals("смещается при изменении положения тела")){%> 
    <%=r.get("r_pochka_izm")%>
    <%if(!r.empty("r_razm_poch_1") || !r.empty("r_razm_poch_2")){%> 
        Размеры
        <%if(!r.empty("r_razm_poch_1")){%> <%=r.get("r_razm_poch_1")%> мм<%}%>
        <%if(!r.empty("r_razm_poch_2")){%> <%=r.get("r_razm_poch_2")%> мм<%}%>.
    <%}%>
    Контуры <%=r.get("r_kontur_poch")%>.
    <%if(!r.empty("r_tolsh_paren_1") || !r.empty("r_tolsh_paren_2") || !r.empty("r_tolsh_paren_3")){%> 
        Толщина паренхимы в средней трети
        <%if(!r.empty("r_tolsh_paren_1")){%> <%=r.get("r_tolsh_paren_1")%> мм <%}%>
        <%if(!r.empty("r_tolsh_paren_2")){%> <%=r.get("r_tolsh_paren_2")%> мм <%}%>
        <%if(!r.empty("r_tolsh_paren_3")){%> <%=r.get("r_tolsh_paren_3")%> мм <%}%>.
    <%}%>
    Эхогенность паренхимы <%=r.get("r_eho_paren")%>.
    Кортико-медуллярная дифференциация <%=r.get("r_differ")%>.
    Чашечно - лоханочная система <%=r.get("r_chash")%>
    <%if(r.get("r_chash").equals("расширена")){%> 
        <%if(!r.empty("r_chash_check") || !r.empty("r_lohanki")){%> 
            за счет
            <%if(!r.empty("r_chash_check")){%> 
                <%=r.get("r_chash_check")%> <%=r.get("r_chash_local")%>
                <%if(!r.empty("r_chash_size")){%>до <%=r.get("r_chash_size")%> мм <%}%>
            <%}%>
            <%if(!r.empty("r_lohanki")){%> 
                <%=r.get("r_lohanki")%> 
                <%if(!r.empty("r_lohan_size")){%>до <%=r.get("r_lohan_size")%> мм <%}%>
            <%}%>
        <%}%>
    <%}%>
    <%if(!r.empty("r_pochka_text")){%> <%=r.get("r_pochka_text")%> <%}%>
    <%if(!r.get("r_nadpoch").equals("") || !r.empty("r_nadpoch_text")){%>
        В проекции надпочечников <%=r.get("r_nadpoch")%> <%=r.get("r_nadpoch_text")%>
    <%}%>
<%}%>
<%if(r.get("r_pochka").equals("не определяется")){%> 
    <%=r.get("r_pochka_izm")%>
<%}%>


<br><b>Левая почка</b> <%=r.getSelect("l_pochka")%>
<%if(r.get("l_pochka").equals("расположена в обычном месте") || r.get("l_pochka").equals("расположена в подвздошной области") || r.get("l_pochka").equals("расположена в малом тазу")){%> 
    <%if(!r.empty("l_razm_poch_1") || !r.empty("l_razm_poch_2")){%> 
        Размеры
        <%if(!r.empty("l_razm_poch_1")){%> <%=r.get("l_razm_poch_1")%> мм<%}%>
        <%if(!r.empty("l_razm_poch_2")){%> <%=r.get("l_razm_poch_2")%> мм<%}%>.
    <%}%>
    Контуры <%=r.get("l_kontur_poch")%>.
    <%if(!r.empty("l_tolsh_paren_1") || !r.empty("l_tolsh_paren_2") || !r.empty("l_tolsh_paren_3")){%> 
        Толщина паренхимы в средней трети
        <%if(!r.empty("l_tolsh_paren_1")){%> <%=r.get("l_tolsh_paren_1")%> мм <%}%>
        <%if(!r.empty("l_tolsh_paren_2")){%> <%=r.get("l_tolsh_paren_2")%> мм <%}%>
        <%if(!r.empty("l_tolsh_paren_3")){%> <%=r.get("l_tolsh_paren_3")%> мм <%}%>.
    <%}%>
    Эхогенность паренхимы <%=r.get("l_eho_paren")%>.
    Кортико-медуллярная дифференциация <%=r.get("l_differ")%>.
    Чашечно - лоханочная система <%=r.get("l_chash")%>
    <%if(r.get("l_chash").equals("расширена")){%> 
        <%if(!r.empty("l_chash_check") || !r.empty("l_lohanki")){%> 
            за счет
            <%if(!r.empty("l_chash_check")){%> 
                <%=r.get("l_chash_check")%> <%=r.get("l_chash_local")%>
                <%if(!r.empty("l_chash_size")){%>до <%=r.get("l_chash_size")%> мм <%}%>
            <%}%>
            <%if(!r.empty("l_lohanki")){%> 
                <%=r.get("l_lohanki")%> 
                <%if(!r.empty("l_lohan_size")){%>до <%=r.get("l_lohan_size")%> мм <%}%>
            <%}%>
        <%}%>
    <%}%>
    <%if(!r.empty("l_pochka_text")){%> <%=r.get("l_pochka_text")%> <%}%>
    <%if(!r.get("l_nadpoch").equals("") || !r.empty("l_nadpoch_text")){%>
        В проекции надпочечников <%=r.get("l_nadpoch")%> <%=r.get("l_nadpoch_text")%>
    <%}%>
<%}%>
<%if(r.get("l_pochka").equals("опущена в положении стоя") || r.get("l_pochka").equals("опущена в положении лежа") || r.get("l_pochka").equals("смещается при изменении положения тела")){%> 
    <%=r.get("l_pochka_izm")%>
    <%if(!r.empty("l_razm_poch_1") || !r.empty("l_razm_poch_2")){%> 
        Размеры
        <%if(!r.empty("l_razm_poch_1")){%> <%=r.get("l_razm_poch_1")%> мм<%}%>
        <%if(!r.empty("l_razm_poch_2")){%> <%=r.get("l_razm_poch_2")%> мм<%}%>.
    <%}%>
    Контуры <%=r.get("l_kontur_poch")%>.
    <%if(!r.empty("l_tolsh_paren_1") || !r.empty("l_tolsh_paren_2") || !r.empty("l_tolsh_paren_3")){%> 
        <br>Толщина паренхимы в средней трети
        <%if(!r.empty("l_tolsh_paren_1")){%> <%=r.get("l_tolsh_paren_1")%> мм <%}%>
        <%if(!r.empty("l_tolsh_paren_2")){%> <%=r.get("l_tolsh_paren_2")%> мм <%}%>
        <%if(!r.empty("l_tolsh_paren_3")){%> <%=r.get("l_tolsh_paren_3")%> мм <%}%>.
    <%}%>
    Эхогенность паренхимы <%=r.get("l_eho_paren")%>.
    Кортико-медуллярная дифференциация <%=r.get("l_differ")%>.
    Чашечно - лоханочная система <%=r.get("l_chash")%>
    <%if(r.get("l_chash").equals("расширена")){%> 
        <%if(!r.empty("l_chash_check") || !r.empty("l_lohanki")){%> 
            за счет
            <%if(!r.empty("l_chash_check")){%> 
                <%=r.get("l_chash_check")%> <%=r.get("l_chash_local")%>
                <%if(!r.empty("l_chash_size")){%>до <%=r.get("l_chash_size")%> мм <%}%>
            <%}%>
            <%if(!r.empty("l_lohanki")){%> 
                <%=r.get("l_lohanki")%> 
                <%if(!r.empty("l_lohan_size")){%>до <%=r.get("l_lohan_size")%> мм <%}%>
            <%}%>
        <%}%>
    <%}%>
    <%if(!r.empty("l_pochka_text")){%> <%=r.get("l_pochka_text")%> <%}%>
    <%if(!r.get("l_nadpoch").equals("") || !r.empty("l_nadpoch_text")){%>
        В проекции надпочечников <%=r.get("l_nadpoch")%> <%=r.get("l_nadpoch_text")%>
    <%}%>
<%}%>
<%if(r.get("l_pochka").equals("не определяется")){%> 
    <%=r.get("l_pochka_izm")%>
<%}%>


