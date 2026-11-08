<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%
    //request.setCharacterEncoding("Cp1251");
    RequestWrapper r = new RequestWrapper(request);
%>


<b>Печень</b> <%=r.get("pechen")%>.
<%if(!r.empty("kosoi_r") || !r.empty("kosoi_l") || !r.empty("tolsh_r") || !r.empty("tolsh_l")){%> 
    Размеры:
    <%if(!r.empty("kosoi_r")){%>Косой вертикальный размер правой доли <%=r.get("kosoi_r")%> мм. <%}%>
    <%if(!r.empty("kosoi_l")){%>Кранио-каудальный размер левой доли <%=r.get("kosoi_l")%> мм. <%}%>
    <%if(!r.empty("tolsh_r")){%>Толщина правой доли <%=r.get("tolsh_r")%> мм. <%}%>
    <%if(!r.empty("tolsh_l")){%>Толщина левой доли <%=r.get("tolsh_l")%> мм. <%}%>
<%}%>
Контуры <%=r.get("kontur")%>.
Структура <%=r.get("struktura")%>
<%if(r.get("struktura").equals("неоднородная за счет")){%> 
    <%if(!r.empty("one_o")){%> 
        <%if(!r.get("one_obraz1").equals("")){%> 
            <%=r.get("one_obraz1")%> <%=r.get("eho_obraz1")%> <%=r.get("str_obraz1")%>
            <%if(!r.empty("vkl_obraz1")){%><%=r.get("vkl_obraz1")%> <%}%>
            <%=r.get("kontur_obraz1")%> <%=r.get("obod_obraz1")%> <%=r.get("gde_obraz1")%>
            <%if(!r.get("cdk_obraz1").equals("")){%> 
                При ЦДК <%=r.get("cdk_obraz1")%>            
            <%}%>
            <%if(!r.empty("r1_obraz1") || !r.empty("r2_obraz1") || !r.empty("r3_obraz1")){%> 
                Размером
                <%if(!r.empty("r1_obraz1")){%> <%=r.get("r1_obraz1")%> <%}%>
                <%if(!r.empty("r1_obraz1") && !r.empty("r2_obraz1")){%> x <%}%>
                <%if(!r.empty("r2_obraz1")){%> <%=r.get("r2_obraz1")%><%}%>
                <%if(!r.empty("r2_obraz1") && !r.empty("r3_obraz1")){%> x <%}%>
                <%if(!r.empty("r3_obraz1")){%><%=r.get("r3_obraz1")%><%}%>
                <%if(!r.empty("r1_obraz1") || !r.empty("r2_obraz1") || !r.empty("r3_obraz1")){%> мм<%}%>
                <%if(!r.empty("do_obraz1")){%>до <%=r.get("do_obraz1")%> мм <%}%>.
            <%}%>
        <%}%>
        <%if(!r.get("one_obraz2").equals("")){%> 
            <%=r.get("one_obraz2")%> <%=r.get("eho_obraz2")%> <%=r.get("str_obraz2")%>
            <%if(!r.empty("vkl_obraz2")){%><%=r.get("vkl_obraz2")%> <%}%>
            <%=r.get("kontur_obraz2")%> <%=r.get("obod_obraz2")%> <%=r.get("gde_obraz2")%>
            <%if(!r.get("cdk_obraz2").equals("")){%> 
                При ЦДК <%=r.get("cdk_obraz2")%>            
            <%}%>
            <%if(!r.empty("r1_obraz2") || !r.empty("r2_obraz2") || !r.empty("r3_obraz2")){%> 
                Размером
                <%if(!r.empty("r1_obraz2")){%> <%=r.get("r1_obraz2")%> <%}%>
                <%if(!r.empty("r1_obraz2") && !r.empty("r2_obraz2")){%> x <%}%>
                <%if(!r.empty("r2_obraz2")){%> <%=r.get("r2_obraz2")%><%}%>
                <%if(!r.empty("r2_obraz2") && !r.empty("r3_obraz2")){%> x <%}%>
                <%if(!r.empty("r3_obraz2")){%><%=r.get("r3_obraz2")%><%}%>
                <%if(!r.empty("r1_obraz2") || !r.empty("r2_obraz2") || !r.empty("r3_obraz2")){%> мм<%}%>
                <%if(!r.empty("do_obraz2")){%>до <%=r.get("do_obraz2")%> мм <%}%>.
            <%}%>
        <%}%>
        <%if(!r.get("one_obraz3").equals("")){%> 
            <%=r.get("one_obraz3")%> <%=r.get("eho_obraz3")%> <%=r.get("str_obraz3")%>
            <%if(!r.empty("vkl_obraz3")){%><%=r.get("vkl_obraz3")%> <%}%>
            <%=r.get("kontur_obraz3")%> <%=r.get("obod_obraz3")%> <%=r.get("gde_obraz3")%>
            <%if(!r.get("cdk_obraz3").equals("")){%> 
                При ЦДК <%=r.get("cdk_obraz3")%>            
            <%}%>
            <%if(!r.empty("r1_obraz3") || !r.empty("r2_obraz3") || !r.empty("r3_obraz3")){%> 
                Размером
                <%if(!r.empty("r1_obraz3")){%> <%=r.get("r1_obraz3")%> <%}%>
                <%if(!r.empty("r1_obraz3") && !r.empty("r2_obraz3")){%> x <%}%>
                <%if(!r.empty("r2_obraz3")){%> <%=r.get("r2_obraz3")%><%}%>
                <%if(!r.empty("r2_obraz3") && !r.empty("r3_obraz3")){%> x <%}%>
                <%if(!r.empty("r3_obraz3")){%><%=r.get("r3_obraz3")%><%}%>
                <%if(!r.empty("r1_obraz3") || !r.empty("r2_obraz3") || !r.empty("r3_obraz3")){%> мм<%}%>
                <%if(!r.empty("do_obraz3")){%>до <%=r.get("do_obraz3")%> мм <%}%>.
            <%}%>
        <%}%>
    <%}%>
    <%if(!r.empty("many_o")){%> 
        <%if(!r.empty("m_ochag")){%> <%=r.get("m_ochag")%> <%}%>
        <%if(!r.empty("m_obem")){%> <%=r.get("m_obem")%><%}%>
        <%if(!r.empty("m_jid")){%> <%=r.get("m_jid")%> <%}%>
        <%if(!r.empty("m_kalc")){%> <%=r.get("m_kalc")%> <%}%>
        <%if(!r.empty("m_gipo")){%> <%=r.get("m_gipo")%> <%}%>
        <%if(!r.empty("m_giper")){%> <%=r.get("m_giper")%> <%}%>
        <%if(!r.empty("m_izo")){%> <%=r.get("m_izo")%> <%}%>
        <%if(!r.empty("m_aneho")){%> <%=r.get("m_aneho")%> <%}%>
        <%if(!r.get("m_str").equals("")){%> <%=r.get("m_str")%> <%}%>
        <%if(!r.empty("m_jid_vkl")){%> <%=r.get("m_jid_vkl")%> <%}%>
        <%if(!r.get("m_dolja").equals("")){%> <%=r.get("m_dolja")%> <%}%>
        <%if(!r.empty("m_seg1") || !r.empty("m_seg2") || !r.empty("m_seg3") || !r.empty("m_seg4") || !r.empty("m_seg5") || !r.empty("m_seg6") || !r.empty("m_seg7") || !r.empty("m_seg8")){%>
            В <%if(!r.empty("m_seg1")){%> <%=r.get("m_seg1")%> <%}%>
            <%if(!r.empty("m_seg2")){%> <%=r.get("m_seg2")%> <%}%>
            <%if(!r.empty("m_seg3")){%> <%=r.get("m_seg3")%> <%}%>
            <%if(!r.empty("m_seg4")){%> <%=r.get("m_seg4")%> <%}%>
            <%if(!r.empty("m_seg5")){%> <%=r.get("m_seg5")%> <%}%>
            <%if(!r.empty("m_seg6")){%> <%=r.get("m_seg6")%> <%}%>
            <%if(!r.empty("m_seg7")){%> <%=r.get("m_seg7")%> <%}%>
            <%if(!r.empty("m_seg8")){%> <%=r.get("m_seg8")%> <%}%> сегментах.
        <%}%>
        <%if(!r.get("m_cdk").equals("")){%> При ЦДК <%=r.get("m_cdk")%>.<%}%>
        <%if(!r.empty("m_razot") || !r.empty("m_razdo")){%> 
            Размерами
            <%if(!r.empty("m_razot")){%> от <%=r.get("m_razot")%> мм <%}%>
            <%if(!r.empty("m_razdo")){%> до <%=r.get("m_razdo")%> мм <%}%>
        <%}%> 
    <%}%>
<%}%>
<%if(!r.empty("pechen_str_text")){%> <%=r.get("pechen_str_text")%>.<%}%>
Эхогенность <%=r.get("ehogen")%>.
Внутрипеченочные желчные протоки <%=r.get("jelch_prot")%>.
Портальная вена <%=r.get("port_vena")%> 
<%if(!r.empty("port_vena_text")){%> 
    <%=r.get("port_vena_text")%> мм
<%}%>
Нижняя полая вена <%=r.get("polaj_vena")%>
<%if(!r.empty("polaj_vena1")){%> <%=r.get("polaj_vena1")%> мм на вдохе <%}%>
<%if(!r.empty("polaj_vena2")){%> <%=r.get("polaj_vena2")%> мм на выдохе <%}%>
<%if(!r.empty("pechen_text")){%> <br><%=r.get("pechen_text")%><%}%>



<br><b>Желчный пузырь</b> <%=r.getSelect("forma_izm")%>
<%if(r.get("forma_izm").equals("")){%> 
    <%=r.get("forma")%>.
    <%if(!r.empty("jelch_dl") || !r.empty("jelch_sh") || !r.empty("jelch_tol") || !r.empty("jelch_ob")){%> 
        Размеры:
        <%if(!r.empty("jelch_dl")){%>Длина <%=r.get("jelch_dl")%> мм. <%}%>
        <%if(!r.empty("jelch_sh")){%>Ширина <%=r.get("jelch_sh")%> мм. <%}%>
        <%if(!r.empty("jelch_tol")){%>Толщина <%=r.get("jelch_tol")%> мм. <%}%>
        <%if(!r.empty("jelch_ob")){%>Объем <%=r.get("jelch_ob")%> мл. <%}%>
    <%}%>
    Стенки <%=r.get("stenki")%>
    <%if(!r.empty("stenki_size")){%> 
        <%=r.get("stenki_size")%> мм
    <%}%>.
    <%if(!r.get("soderg").equals("") || !r.empty("v_polosti")){%> 
        В полости <%=r.get("soderg")%> <%=r.get("v_polosti")%>.
    <%}%>
    Общий желчный проток <%=r.get("jelch_protok")%>    
    <%if(!r.empty("protok_mm")){%> <%=r.get("protok_mm")%> мм<%}%>.
<%}else{%>
    <%if(!r.empty("jelch_p")){%> <%=r.get("jelch_p")%> <%}%>
<%}%>



<br><b>Поджелудочная Железа</b> <%=r.getSelect("pod_jel")%>
<%if(r.get("pod_jel").equals("")){%> 
    <%if(!r.empty("golov") || !r.empty("telo") || !r.empty("hvost")){%> 
        Размеры:
        <%if(!r.empty("golov")){%>Головка <%=r.get("golov")%> мм. <%}%>
        <%if(!r.empty("telo")){%>Тело <%=r.get("telo")%> мм. <%}%>
        <%if(!r.empty("hvost")){%>Хвост <%=r.get("hvost")%> мм. <%}%>
    <%}%>
    Контуры <%=r.get("kontur_pod")%>.
    Структура <%=r.get("struktura_pod")%> <%=r.get("str_pod_jel")%>.
    Эхогенность <%=r.get("eho_pod")%>.
    Вирсунгов проток <%=r.get("virs_rash")%>
    <%if(!r.empty("virs_size")){%> <%=r.get("virs_size")%> мм<%}%>.
    <%if(!r.empty("sel_vena")){%>Селезеночная вена <%=r.get("sel_vena")%> мм.<%}%>
<%}else{%>
    <%if(!r.empty("jel_net")){%> <%=r.get("jel_net")%> <%}%>
<%}%>



<br><b>Селезенка</b> <%=r.get("selez")%>.
<%if(!r.get("selez").equals("удалена оперативно")){%> 
    <%if(!r.empty("sel_dl") || !r.empty("sel_sh") || !r.empty("sel_tol") || !r.empty("sel_obem")){%> 
        Размеры:
        <%if(!r.empty("sel_dl")){%>Длина <%=r.get("sel_dl")%> мм. <%}%>
        <%if(!r.empty("sel_tol")){%>Толщина <%=r.get("sel_tol")%> мм. <%}%>
        <%if(!r.empty("sel_sh")){%>Ширина <%=r.get("sel_sh")%> мм. <%}%>
        <%if(!r.empty("sel_obem")){%>Площадь <%=r.get("sel_obem")%> см2. <%}%>
    <%}%>
    Контуры <%=r.get("sel_kon")%>.
    Структура <%=r.get("struktura_sel")%> <%=r.get("str_sel")%>
    Эхогенность <%=r.get("eho_sel")%>.  <%if(!r.empty("selez_text")){%>  <br> <%=r.get("selez_text")%>. <%}%>  
<%}else{%>
    <%if(!r.empty("selez_text")){%> <%=r.get("selez_text")%>. <%}%>    
<%}%>

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
<%if(r.get("r_pochka").equals("в положении стоя ниже обычного уровня") || r.get("r_pochka").equals("в положении лежа ниже обычного уровня") || r.get("r_pochka").equals("смещается при изменении положения тела")){%> 
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
<%if(r.get("l_pochka").equals("в положении стоя ниже обычного уровня") || r.get("l_pochka").equals("в положении лежа ниже обычного уровня") || r.get("l_pochka").equals("смещается при изменении положения тела")){%> 
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


