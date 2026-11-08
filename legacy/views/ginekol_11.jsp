<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>

<%if(!r.empty("faza_c")){%>Первый день последней менструации <%=r.get("faza_c")%>.<br><%}%>
<%if(!r.empty("payza")){%>Менопауза <%=r.get("payza")%> лет.<br><%}%>
<%if(!r.empty("krov")){%> <%=r.get("krov")%><br><%}%>
<b>ТЕЛО МАТКИ</b> <%=r.get("telo_matki")%>
<%if(r.get("telo_matki").equals("оперативно удалено")){%>
    <%if(!r.empty("del_matka")){%> в <%=r.get("del_matka")%> году.<%}%>
    <%if(!r.empty("kyl_dl") || !r.empty("kyl_tol") || !r.empty("kyl_sh")){%>
        <br>Культя: размеры:
        <%if(!r.empty("kyl_dl")){%> Длина <%=r.get("kyl_dl")%> мм.<%}%>
        <%if(!r.empty("kyl_tol")){%> Толщина <%=r.get("kyl_tol")%> мм.<%}%>
        <%if(!r.empty("kyl_sh")){%> Ширина <%=r.get("kyl_sh")%> мм.<%}%>

        <br>
    <%}%>
    <%if(!r.empty("kyl_stroi_text") || !r.get("kyl_stroi").equals("")){%>
        Строение <%=r.get("kyl_stroi")%> <%=r.get("kyl_stroi_text")%>.
    <%}%>        
    <%if(!r.get("cer_kanal").equals("")){%>
        Цервикальный канал <%=r.get("cer_kanal")%>.
    <%}%>        
<%}%>
<%if(r.get("telo_matki").equals("не определяется")){%>
    <%if(!r.empty("matka_neopred")){%>  <%=r.get("matka_neopred")%><%}%>
<%}%>
<%if(!r.get("telo_matki").equals("не определяется") && !r.get("telo_matki").equals("оперативно удалено")){%>
    <%if(!r.empty("matka_dl") || !r.empty("matka_tol") || !r.empty("matka_sh")){%>
        Размеры:
        <%if(!r.empty("matka_dl")){%> Длина <%=r.get("matka_dl")%> мм.<%}%>
        <%if(!r.empty("matka_tol")){%> Толщина <%=r.get("matka_tol")%> мм.<%}%>
        <%if(!r.empty("matka_sh")){%> Ширина <%=r.get("matka_sh")%> мм.<%}%>
 <%if(!r.empty("matka_ob")){%> Объем <%=r.get("matka_ob")%> cм3 <%}%>
    <%}%>
    Форма <%=r.get("forma_matka")%> <%=r.get("forma_matka_text")%>.
    Строение миометрия <%=r.get("struct_matka")%> <%=r.get("str_miom")%>.<br>
    <b>ЭНДОМЕТРИЙ</b> <%=r.get("endometrii")%><br>
    <%if(!r.empty("endom_soot_text") || !r.get("endom_soot").equals("")){%>
        <%if(r.get("endom_soot").equals("не соответствует фазе цикла")){%>
            Не соответствует фазе цикла  <%=r.get("endom_soot_text")%>.
        <%}else{%>
            Соответствует <%=r.get("endom_soot")%> <%=r.get("endom_soot_text")%>.
        <%}%>
    <%}%>
    <%if(!r.empty("endom_tol")){%>Толщина <%=r.get("endom_tol")%> мм.<%}%>
    Строение <%=r.get("endom_struct")%> <%=r.get("endom_text")%>.
    Контуры эндометрия на границе с внутренним мышечным слоем <%=r.get("endom_kontur")%> <%=r.get("endom_kontur_text")%>.<br>
    <b>ПОЛОСТЬ МАТКИ</b>
    <%=r.get("polost_m")%> <%=r.get("polost_m_raz")%> <%=r.get("polost_m_text")%>.<br>
    <b>ШЕЙКА МАТКИ</b> <%=r.get("sheika_m")%>
    <%if(r.get("sheika_m").equals("")){%>
    
    <%if(!r.empty("sheika_dl") || !r.empty("sheika_sh")){%>
    
      Размеры:
            <%if(!r.empty("sheika_dl")){%>Длина <%=r.get("sheika_dl")%> мм.<%}%>
            <%if(!r.empty("sheika_sh")){%>Ширина <%=r.get("sheika_sh")%> мм.<%}%>
        <%}%>

        Форма <%=r.get("sheika_forma")%>.
        Строение <%=r.get("sheika_str")%>

        <%if(r.get("sheika_str").equals("изменено за счет")){%>
            <%=r.get("sheika_str_izm")%> кистозных включений 
            <%if(!r.empty("sheika_kist")){%>
                до <%=r.get("sheika_kist")%> мм
            <%}%><%}%>


 <%if(!r.empty("sheika_m_net")){%> <br> <%=r.get("sheika_m_net")%>
        <%}%>.

    <%}else{%>
        <%if(!r.empty("sheika_m_net")){%> <%=r.get("sheika_m_net")%> <%}%>
    <%}%>
<%}%>

<br><b>ПРАВЫЙ ЯИЧНИК</b> <%=r.get("r_ja")%>
<%if(r.get("r_ja").equals("не определяется")){%>
    <%if(!r.empty("r_god")){%>
        оперативно удален в <%=r.get("r_god")%> году    
    <%}%>
<%}else{%>
    <%if(!r.empty("r_dlina") || !r.empty("r_tolsh") || !r.empty("r_shir") || !r.empty("r_obem")){%>
        Размеры:
        <%if(!r.empty("r_dlina")){%>Длина <%=r.get("r_dlina")%> мм. <%}%>
        <%if(!r.empty("r_tolsh")){%>Толщина <%=r.get("r_tolsh")%> мм. <%}%>
        <%if(!r.empty("r_shir")){%>Ширина <%=r.get("r_shir")%> мм. <%}%>
        <%if(!r.empty("r_obem")){%>Объем <%=r.get("r_obem")%> мл. <%}%>
    <%}%>
    <%=r.get("r_yvelich")%>.
    Форма <%=r.get("r_form")%> <%=r.get("r_form_text")%>.
    Строение <%=r.get("r_str")%> <%=r.get("r_structura")%>.
<%}%>
<%if(!r.empty("r_text")){%><br><%=r.get("r_text")%><%}%>

<br><b>ЛЕВЫЙ ЯИЧНИК</b> <%=r.get("l_ja")%>
<%if(r.get("l_ja").equals("не определяется")){%>
    <%if(!r.empty("l_god")){%>
        оперативно удален в <%=r.get("l_god")%> году    
    <%}%>
<%}else{%>
    <%if(!r.empty("l_dlina") || !r.empty("l_tolsh") || !r.empty("l_shir") || !r.empty("l_obem")){%>
        Размеры:
        <%if(!r.empty("l_dlina")){%>Длина <%=r.get("l_dlina")%> мм. <%}%>
        <%if(!r.empty("l_tolsh")){%>Толщина <%=r.get("l_tolsh")%> мм. <%}%>
        <%if(!r.empty("l_shir")){%>Ширина <%=r.get("l_shir")%> мм. <%}%>
        <%if(!r.empty("l_obem")){%>Объем <%=r.get("l_obem")%> мл. <%}%>
    <%}%>
    <%=r.get("l_yvelich")%>.
    Форма <%=r.get("l_form")%> <%=r.get("l_form_text")%>.
    Строение <%=r.get("l_str")%> <%=r.get("l_structura")%>.
<%}%>
<%if(!r.empty("l_text")){%><br><%=r.get("l_text")%><%}%>
<%if(!r.empty("jidkost")){%>
    <br><%=r.getCheckbox("jidkost")%> <%=r.get("svob_jid")%> <%=r.get("svob_jid_sel")%>.
<%}%>
<BR>Внутритазовые сосуды <%=r.get("sosud_sel")%>  <%=r.get("sosud")%> 











