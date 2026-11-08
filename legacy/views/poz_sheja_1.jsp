<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%if(!r.empty("nep_disk") || !r.empty("nep_disk1") || !r.empty("nep_disk2") || !r.empty("nep_disk3") || !r.empty("nep_disk4") || !r.empty("nep_disk5")){%> 
    <br>Непрозрачны
    <%if(!r.empty("nep_disk")){%> 
        на всех уровнях.
    <%}else{%> 
        на уровне:
        <%if(!r.empty("nep_disk1")){%><%=r.get("nep_disk1")%><%}%>
        <%if(!r.empty("nep_disk1") && (!r.empty("nep_disk2") || !r.empty("nep_disk3") || !r.empty("nep_disk4") || !r.empty("nep_disk5"))){%>,<%}%>
        <%if(!r.empty("nep_disk2")){%><%=r.get("nep_disk2")%><%}%>
        <%if(!r.empty("nep_disk2") && (!r.empty("nep_disk3") || !r.empty("nep_disk4") || !r.empty("nep_disk5"))){%>,<%}%>
        <%if(!r.empty("nep_disk3")){%><%=r.get("nep_disk3")%><%}%>
        <%if(!r.empty("nep_disk3") && (!r.empty("nep_disk4") || !r.empty("nep_disk5"))){%>,<%}%>
        <%if(!r.empty("nep_disk4")){%><%=r.get("nep_disk4")%><%}%>
        <%if(!r.empty("nep_disk4") && !r.empty("nep_disk5")){%>,<%}%>
        <%if(!r.empty("nep_disk5")){%><%=r.get("nep_disk5")%><%}%>.
    <%}%>
<%}%>

<%if(!r.empty("izm_disk") || !r.empty("izm_disk1") || !r.empty("izm_disk2") || !r.empty("izm_disk3") || !r.empty("izm_disk4") || !r.empty("izm_disk5")){%> 
    <br>Не выявлено структурных изменений дисков
    <%if(!r.empty("izm_disk")){%> 
        на всех уровнях.
    <%}else{%> 
        на уровне:
        <%if(!r.empty("izm_disk1")){%><%=r.get("izm_disk1")%><%}%>
        <%if(!r.empty("izm_disk1") && (!r.empty("izm_disk2") || !r.empty("izm_disk3") || !r.empty("izm_disk4") || !r.empty("izm_disk5"))){%>,<%}%>
        <%if(!r.empty("izm_disk2")){%><%=r.get("izm_disk2")%><%}%>
        <%if(!r.empty("izm_disk2") && (!r.empty("izm_disk3") || !r.empty("izm_disk4") || !r.empty("izm_disk5"))){%>,<%}%>
        <%if(!r.empty("izm_disk3")){%><%=r.get("izm_disk3")%><%}%>
        <%if(!r.empty("izm_disk3") && (!r.empty("izm_disk4") || !r.empty("izm_disk5"))){%>,<%}%>
        <%if(!r.empty("izm_disk4")){%><%=r.get("izm_disk4")%><%}%>
        <%if(!r.empty("izm_disk4") && !r.empty("izm_disk5")){%>,<%}%>
        <%if(!r.empty("izm_disk5")){%><%=r.get("izm_disk5")%><%}%>.
    <%}%>
<%}%>

<%if(!r.empty("struk_izm")){%>
    <br><%=r.get("struk_izm")%>    
    <%if(!r.empty("struk1")){%>уплотнения и фрагментации пульпозных ядер<%}%>
    <%if(!r.empty("struk1") && (!r.empty("struk2") || !r.empty("struk3"))){%>,<%}%>
    <%if(!r.empty("struk2")){%>истончения фиброзных колец<%}%>
    <%if(!r.empty("struk2") && (!r.empty("struk3"))){%>,<%}%>
    <%if(!r.empty("struk3")){%>снижения высоты дисков<%}%>
    <%if(!r.empty("str_disk")){%> 
        на всех уровнях.
    <%}else{%> 
        на уровне:
        <%if(!r.empty("str_disk1")){%><%=r.get("str_disk1")%><%}%>
        <%if(!r.empty("str_disk1") && (!r.empty("str_disk2") || !r.empty("str_disk3") || !r.empty("str_disk4") || !r.empty("str_disk5"))){%>,<%}%>
        <%if(!r.empty("str_disk2")){%><%=r.get("str_disk2")%><%}%>
        <%if(!r.empty("str_disk2") && (!r.empty("str_disk3") || !r.empty("str_disk4") || !r.empty("str_disk5"))){%>,<%}%>
        <%if(!r.empty("str_disk3")){%><%=r.get("str_disk3")%><%}%>
        <%if(!r.empty("str_disk3") && (!r.empty("str_disk4") || !r.empty("str_disk5"))){%>,<%}%>
        <%if(!r.empty("str_disk4")){%><%=r.get("str_disk4")%><%}%>
        <%if(!r.empty("str_disk4") && !r.empty("str_disk5")){%>,<%}%>
        <%if(!r.empty("str_disk5")){%><%=r.get("str_disk5")%><%}%>.
    <%}%>
    Степень выраженности указанных изменений <%=r.get("vir_izm")%>.
<%}%>

<%if(!r.empty("kanal_disk") || !r.empty("kanal_disk1") || !r.empty("kanal_disk2") || !r.empty("kanal_disk3") || !r.empty("kanal_disk4") || !r.empty("kanal_disk5")){%> 
    <br>Спинномозговой канал не изменен
    <%if(!r.empty("kanal_disk")){%> 
        на всех уровнях.
    <%}else{%> 
        на уровне:
        <%if(!r.empty("kanal_disk1")){%><%=r.get("kanal_disk1")%><%}%>
        <%if(!r.empty("kanal_disk1") && (!r.empty("kanal_disk2") || !r.empty("kanal_disk3") || !r.empty("kanal_disk4") || !r.empty("kanal_disk5"))){%>,<%}%>
        <%if(!r.empty("kanal_disk2")){%><%=r.get("kanal_disk2")%><%}%>
        <%if(!r.empty("kanal_disk2") && (!r.empty("kanal_disk3") || !r.empty("kanal_disk4") || !r.empty("kanal_disk5"))){%>,<%}%>
        <%if(!r.empty("kanal_disk3")){%><%=r.get("kanal_disk3")%><%}%>
        <%if(!r.empty("kanal_disk3") && (!r.empty("kanal_disk4") || !r.empty("kanal_disk5"))){%>,<%}%>
        <%if(!r.empty("kanal_disk4")){%><%=r.get("kanal_disk4")%><%}%>
        <%if(!r.empty("kanal_disk4") && !r.empty("kanal_disk5")){%>,<%}%>
        <%if(!r.empty("kanal_disk5")){%><%=r.get("kanal_disk5")%><%}%>
    <%}%>
    каналы корешковых нервов симметричны.
<%}%>

<%if(!r.empty("def_disk") || !r.empty("def_disk1") || !r.empty("def_disk2") || !r.empty("def_disk3") || !r.empty("def_disk4") || !r.empty("def_disk5")){%> 
    <br>Спинномозговой канал подвержен сужению и деформации
    <%if(!r.empty("def_disk")){%> 
        на всех уровнях.
    <%}else{%> 
        на уровне:
        <%if(!r.empty("def_disk1")){%><%=r.get("def_disk1")%><%}%>
        <%if(!r.empty("def_disk1") && (!r.empty("def_disk2") || !r.empty("def_disk3") || !r.empty("def_disk4") || !r.empty("def_disk5"))){%>,<%}%>
        <%if(!r.empty("def_disk2")){%><%=r.get("def_disk2")%><%}%>
        <%if(!r.empty("def_disk2") && (!r.empty("def_disk3") || !r.empty("def_disk4") || !r.empty("def_disk5"))){%>,<%}%>
        <%if(!r.empty("def_disk3")){%><%=r.get("def_disk3")%><%}%>
        <%if(!r.empty("def_disk3") && (!r.empty("def_disk4") || !r.empty("def_disk5"))){%>,<%}%>
        <%if(!r.empty("def_disk4")){%><%=r.get("def_disk4")%><%}%>
        <%if(!r.empty("def_disk4") && !r.empty("def_disk5")){%>,<%}%>
        <%if(!r.empty("def_disk5")){%><%=r.get("def_disk5")%><%}%>.
    <%}%>
<%}%>

<%if(!r.empty("prol_disk") || !r.empty("prol_disk1") || !r.empty("prol_disk2") || !r.empty("prol_disk3") || !r.empty("prol_disk4") || !r.empty("prol_disk5")){%> 
    <br>Пролабирование контура диска без разрыва фиброзного кольца по дуге большого радиуса
    <%if(!r.empty("prolab_mm")){%> 
        до <%=r.get("prolab_mm")%> мм
    <%}%> 
    <%if(!r.empty("prol_disk")){%> 
        на всех уровнях.
    <%}else{%> 
        на уровне:
        <%if(!r.empty("prol_disk1")){%><%=r.get("prol_disk1")%><%}%>
        <%if(!r.empty("prol_disk1") && (!r.empty("prol_disk2") || !r.empty("prol_disk3") || !r.empty("prol_disk4") || !r.empty("prol_disk5"))){%>,<%}%>
        <%if(!r.empty("prol_disk2")){%><%=r.get("prol_disk2")%><%}%>
        <%if(!r.empty("prol_disk2") && (!r.empty("prol_disk3") || !r.empty("prol_disk4") || !r.empty("prol_disk5"))){%>,<%}%>
        <%if(!r.empty("prol_disk3")){%><%=r.get("prol_disk3")%><%}%>
        <%if(!r.empty("prol_disk3") && (!r.empty("prol_disk4") || !r.empty("prol_disk5"))){%>,<%}%>
        <%if(!r.empty("prol_disk4")){%><%=r.get("prol_disk4")%><%}%>
        <%if(!r.empty("prol_disk4") && !r.empty("prol_disk5")){%>,<%}%>
        <%if(!r.empty("prol_disk5")){%><%=r.get("prol_disk5")%><%}%>.
    <%}%>
<%}%>

<%if(!r.empty("raz_disk") || !r.empty("raz_disk1") || !r.empty("raz_disk2") || !r.empty("raz_disk3") || !r.empty("raz_disk4") || !r.empty("raz_disk5")){%> 
    <br>Выявлен разрыв фиброзного кольца и выбухание контура диска по дуге малого радиуса
    <%if(!r.empty("raz_vib_mm")){%> 
        до <%=r.get("raz_vib_mm")%> мм
    <%}%> 
    <%if(!r.empty("raz_disk")){%> 
        на всех уровнях.
    <%}else{%> 
        на уровне:
        <%if(!r.empty("raz_disk1")){%><%=r.get("raz_disk1")%><%}%>
        <%if(!r.empty("raz_disk1") && (!r.empty("raz_disk2") || !r.empty("raz_disk3") || !r.empty("raz_disk4") || !r.empty("raz_disk5"))){%>,<%}%>
        <%if(!r.empty("raz_disk2")){%><%=r.get("raz_disk2")%><%}%>
        <%if(!r.empty("raz_disk2") && (!r.empty("raz_disk3") || !r.empty("raz_disk4") || !r.empty("raz_disk5"))){%>,<%}%>
        <%if(!r.empty("raz_disk3")){%><%=r.get("raz_disk3")%><%}%>
        <%if(!r.empty("raz_disk3") && (!r.empty("raz_disk4") || !r.empty("raz_disk5"))){%>,<%}%>
        <%if(!r.empty("raz_disk4")){%><%=r.get("raz_disk4")%><%}%>
        <%if(!r.empty("raz_disk4") && !r.empty("raz_disk5")){%>,<%}%>
        <%if(!r.empty("raz_disk5")){%><%=r.get("raz_disk5")%><%}%>.
    <%}%>
<%}%>

<%if(!r.empty("gip_disk") || !r.empty("gip_disk1") || !r.empty("gip_disk2") || !r.empty("gip_disk3") || !r.empty("gip_disk4") || !r.empty("gip_disk5")){%> 
    <br>Гипертрофия желтой связки на уровне
    <%if(!r.empty("gip_disk")){%> 
        на всех уровнях.
    <%}else{%> 
        на уровне:
        <%if(!r.empty("gip_disk1")){%><%=r.get("gip_disk1")%><%}%>
        <%if(!r.empty("gip_disk1") && (!r.empty("gip_disk2") || !r.empty("gip_disk3") || !r.empty("gip_disk4") || !r.empty("gip_disk5"))){%>,<%}%>
        <%if(!r.empty("gip_disk2")){%><%=r.get("gip_disk2")%><%}%>
        <%if(!r.empty("gip_disk2") && (!r.empty("gip_disk3") || !r.empty("gip_disk4") || !r.empty("gip_disk5"))){%>,<%}%>
        <%if(!r.empty("gip_disk3")){%><%=r.get("gip_disk3")%><%}%>
        <%if(!r.empty("gip_disk3") && (!r.empty("gip_disk4") || !r.empty("gip_disk5"))){%>,<%}%>
        <%if(!r.empty("gip_disk4")){%><%=r.get("gip_disk4")%><%}%>
        <%if(!r.empty("gip_disk4") && !r.empty("gip_disk5")){%>,<%}%>
        <%if(!r.empty("gip_disk5")){%><%=r.get("gip_disk5")%><%}%>.
    <%}%>
<%}%>

<%if(!r.empty("rub_disk") || !r.empty("rub_disk1") || !r.empty("rub_disk2") || !r.empty("rub_disk3") || !r.empty("rub_disk4") || !r.empty("rub_disk5")){%> 
    <br>Признаки рубцового эпидурита на уровне
    <%if(!r.empty("rub_disk")){%> 
        на всех уровнях.
    <%}else{%> 
        на уровне:
        <%if(!r.empty("rub_disk1")){%><%=r.get("rub_disk1")%><%}%>
        <%if(!r.empty("rub_disk1") && (!r.empty("rub_disk2") || !r.empty("rub_disk3") || !r.empty("rub_disk4") || !r.empty("rub_disk5"))){%>,<%}%>
        <%if(!r.empty("rub_disk2")){%><%=r.get("rub_disk2")%><%}%>
        <%if(!r.empty("rub_disk2") && (!r.empty("rub_disk3") || !r.empty("rub_disk4") || !r.empty("rub_disk5"))){%>,<%}%>
        <%if(!r.empty("rub_disk3")){%><%=r.get("rub_disk3")%><%}%>
        <%if(!r.empty("rub_disk3") && (!r.empty("rub_disk4") || !r.empty("rub_disk5"))){%>,<%}%>
        <%if(!r.empty("rub_disk4")){%><%=r.get("rub_disk4")%><%}%>
        <%if(!r.empty("rub_disk4") && !r.empty("rub_disk5")){%>,<%}%>
        <%if(!r.empty("rub_disk5")){%><%=r.get("rub_disk5")%><%}%>.
    <%}%>
<%}%>

<%if(!r.empty("kost_disk") || !r.empty("kost_disk1") || !r.empty("kost_disk2") || !r.empty("kost_disk3") || !r.empty("kost_disk4") || !r.empty("kost_disk5")){%> 
    <br>Костная деформация
    <%if(!r.empty("def_1")){%><%=r.get("def_1")%><%}%>
    <%if(!r.empty("def_1") && (!r.empty("def_2") || !r.empty("def_3") || !r.empty("def_4") || !r.empty("def_5"))){%>,<%}%>
    <%if(!r.empty("def_2")){%><%=r.get("def_2")%><%}%>
    <%if(!r.empty("def_2") && (!r.empty("def_3") || !r.empty("def_4") || !r.empty("def_5"))){%>,<%}%>
    <%if(!r.empty("def_3")){%><%=r.get("def_3")%><%}%>
    <%if(!r.empty("def_3") && (!r.empty("def_4") || !r.empty("def_5"))){%>,<%}%>
    <%if(!r.empty("def_4")){%><%=r.get("def_4")%><%}%>
    <%if(!r.empty("def_4") && !r.empty("def_5")){%>,<%}%>
    <%if(!r.empty("def_5")){%><%=r.get("def_5")%><%}%>
        на уровне:
        <%if(!r.empty("kost_disk")){%><%=r.get("kost_disk")%><%}%>
        <%if(!r.empty("kost_disk") && (!r.empty("kost_disk1") || !r.empty("kost_disk2") || !r.empty("kost_disk3") || !r.empty("kost_disk4") || !r.empty("kost_disk5"))){%>,<%}%>
        <%if(!r.empty("kost_disk1")){%><%=r.get("kost_disk1")%><%}%>
        <%if(!r.empty("kost_disk1") && (!r.empty("kost_disk2") || !r.empty("kost_disk3") || !r.empty("kost_disk4") || !r.empty("kost_disk5"))){%>,<%}%>
        <%if(!r.empty("kost_disk2")){%><%=r.get("kost_disk2")%><%}%>
        <%if(!r.empty("kost_disk2") && (!r.empty("kost_disk3") || !r.empty("kost_disk4") || !r.empty("kost_disk5"))){%>,<%}%>
        <%if(!r.empty("kost_disk3")){%><%=r.get("kost_disk3")%><%}%>
        <%if(!r.empty("kost_disk3") && (!r.empty("kost_disk4") || !r.empty("kost_disk5"))){%>,<%}%>
        <%if(!r.empty("kost_disk4")){%><%=r.get("kost_disk4")%><%}%>
        <%if(!r.empty("kost_disk4") && !r.empty("kost_disk5")){%>,<%}%>
        <%if(!r.empty("kost_disk5")){%><%=r.get("kost_disk5")%><%}%>.
<%}%>
<%if(!r.empty("zad_txt") || !r.get("zad_sel").equals("")){%> 
    <br>При осмотре из заднего доступа <%=r.get("zad_sel")%>
    <%=r.get("zad_txt")%>.
<%}%> 

<br><b>Функциональные пробы</b>
<%if(!r.get("f_proba").equals("При")){%> 
    <br><%=r.get("f_proba")%>.
<%}else{%> 
    <%if(!r.empty("ant_disk") || !r.empty("ant_disk1") || !r.empty("ant_disk2") || !r.empty("ant_disk3") || !r.empty("ant_disk4") || !r.empty("ant_disk5") || !r.empty("ant_proba")){%>
        <br>При сгибательной пробе - антелистез
        <%if(!r.empty("ant_proba")){%> на <%=r.get("ant_proba")%> мм <%}%>
        <%if(!r.empty("ant_disk") || !r.empty("ant_disk1") || !r.empty("ant_disk2") || !r.empty("ant_disk3") || !r.empty("ant_disk4") || !r.empty("ant_disk5")){%>
            <%if(!r.empty("ant_disk")){%> 
                на всех уровнях.
            <%}else{%> 
                на уровне:
                <%if(!r.empty("ant_disk1")){%><%=r.get("ant_disk1")%><%}%>
                <%if(!r.empty("ant_disk1") && (!r.empty("ant_disk2") || !r.empty("ant_disk3") || !r.empty("ant_disk4") || !r.empty("ant_disk5"))){%>,<%}%>
                <%if(!r.empty("ant_disk2")){%><%=r.get("ant_disk2")%><%}%>
                <%if(!r.empty("ant_disk2") && (!r.empty("ant_disk3") || !r.empty("ant_disk4") || !r.empty("ant_disk5"))){%>,<%}%>
                <%if(!r.empty("ant_disk3")){%><%=r.get("ant_disk3")%><%}%>
                <%if(!r.empty("ant_disk3") && (!r.empty("ant_disk4") || !r.empty("ant_disk5"))){%>,<%}%>
                <%if(!r.empty("ant_disk4")){%><%=r.get("ant_disk4")%><%}%>
                <%if(!r.empty("ant_disk4") && !r.empty("ant_disk5")){%>,<%}%>
                <%if(!r.empty("ant_disk5")){%><%=r.get("ant_disk5")%><%}%>.
            <%}%>
        <%}%>
    <%}%>      
    <%if(!r.empty("ret_disk") || !r.empty("ret_disk1") || !r.empty("ret_disk2") || !r.empty("ret_disk3") || !r.empty("ret_disk4") || !r.empty("ret_disk5") || !r.empty("ret_proba")){%>
        <br>При разгибательной пробе - ретролистез
        <%if(!r.empty("ret_proba")){%> на <%=r.get("ret_proba")%> мм <%}%>
        <%if(!r.empty("ret_disk") || !r.empty("ret_disk1") || !r.empty("ret_disk2") || !r.empty("ret_disk3") || !r.empty("ret_disk4") || !r.empty("ret_disk5")){%>
            <%if(!r.empty("ret_disk")){%> 
                на всех уровнях.
            <%}else{%> 
                на уровне:
                <%if(!r.empty("ret_disk1")){%><%=r.get("ret_disk1")%><%}%>
                <%if(!r.empty("ret_disk1") && (!r.empty("ret_disk2") || !r.empty("ret_disk3") || !r.empty("ret_disk4") || !r.empty("ret_disk5"))){%>,<%}%>
                <%if(!r.empty("ret_disk2")){%><%=r.get("ret_disk2")%><%}%>
                <%if(!r.empty("ret_disk2") && (!r.empty("ret_disk3") || !r.empty("ret_disk4") || !r.empty("ret_disk5"))){%>,<%}%>
                <%if(!r.empty("ret_disk3")){%><%=r.get("ret_disk3")%><%}%>
                <%if(!r.empty("ret_disk3") && (!r.empty("ret_disk4") || !r.empty("ret_disk5"))){%>,<%}%>
                <%if(!r.empty("ret_disk4")){%><%=r.get("ret_disk4")%><%}%>
                <%if(!r.empty("ret_disk4") && !r.empty("ret_disk5")){%>,<%}%>
                <%if(!r.empty("ret_disk5")){%><%=r.get("ret_disk5")%><%}%>.
            <%}%>
        <%}%>
    <%}%>      
<%}%> 

