<%@page import = "java.util.Date" import="my_pack.beans.*" import="my_pack.tools.* java.text.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title" align="center"><%=r.get("research")%></H3>
<table width="90%" border="1">
    <tr><td colspan="3"><b>Правый коленный сустав</b></td></tr>
    <tr><td>Жидкость в суставах</td>
        <td colspan="2"><%=r.getSelect("r_opred_gyd")%><%=r.getChangeHidden("r_opred_gyd", "5", "351")%> <%=r.getSelect("r_jid_opred")%></div> <%=r.getTextInput("r_gyd_text")%>
            <SCRIPT LANGUAGE="JavaScript">
                document.protocol.r_opred_gyd.focus();
            </script>
        </td></tr>
    <tr><td>Размеры верхнего заворота</td>
        <td colspan="2"><%=r.getSizeInput("r_zav_size1")%> мм
            <%=r.getSizeInput("r_zav_size2")%> мм
        </td></tr>
    <tr><td>Синовиальная оболочка</td>
        <td><%=r.getSelect("r_sinov")%></td>
        <td><%=r.getChangeHidden("r_sinov", "3", "353")%>до <%=r.getSizeInput("r_sinov_size")%> мм</div></td></tr>
    <tr><td>Сухожилие прямой мышцы бедра</td>
        <td colspan="2"><%=r.getSelect("r_suho")%>
        </td></tr>
    <tr><td>Надколенник - контуры</td>
        <td colspan="2"><%=r.getSelect("r_nadkol")%>
        </td></tr>
    <tr><td>Бурсит</td>
        <td colspan="2"><%=r.getSelect("r_opred_burs")%>
        </td></tr>
    <tr><td colspan="3"><b>Собственная связка надколенника</b></td></tr>
    <tr><td>целостность</td>
        <td colspan="2"><%=r.getSelect("r_cel")%>
        </td></tr>
    <tr><td>структура</td>
        <td colspan="2"><%=r.getSelect("r_struc")%>
        </td></tr>
    <tr><td>эхогенность</td>
        <td><%=r.getSelect("r_ehogen")%></td>
        <td><div id="display4" style="display:none;position:relative; left:12;">
            <%=r.getSelect("r_eho_po")%>
            <SCRIPT LANGUAGE="JavaScript">changeHidden4();
                document.protocol.r_ehogen.onchange  = changeHidden4
                function changeHidden4()
                {
                    if(document.protocol.r_ehogen.value == "363" || document.protocol.r_ehogen.value == "364")
                        display4.style.display = "";
                    else display4.style.display = "none";
                }
            </SCRIPT></td></tr>

        </tr>
    <tr><td>толщина</td>
        <td colspan="2"><%=r.getSizeInput("r_tolsh_size")%> мм
        </td></tr>
    <tr><td>бурсит</td>
        <td colspan="2"><%=r.getSelect("r_opred_burs")%>
        </td></tr>
    <tr><td colspan="3"><b>Состояние жировых тел</b></td></tr>
    <tr><td>структура</td>
        <td colspan="2"><%=r.getSelect("r_gir_struc")%>
        </td></tr>
    <tr><td>гипертрофия</td>
        <td colspan="2"><%=r.getSelect("r_gipertr")%>
        </td></tr>
    <tr><td colspan="3"><b>Боковые связки</b></td></tr>
    <tr><td>структура</td>
        <td colspan="2"><%=r.getSelect("r_strucbok")%>
        </td></tr>
    <tr><td colspan="3"><b>Суставные поверхности бедренной и большеберцовой костей</b> <%=r.getSelect("r_pov_kost")%></td></tr>
    <tr><td>костные разрастания</td>
        <td colspan="2"><%=r.getSelect("r_opred_razr")%>
        </td></tr>
    <tr><td colspan="3"><b>Гиалиновый хрящ</b></td></tr>
    <tr><td>контуры</td>
        <td colspan="2"><%=r.getSelect("r_kontur")%>
        </td></tr>
    <tr><td>толщина</td>
        <td><%=r.getSelect("r_tolsh")%></td>
        <td><%=r.getChangeHidden("r_tolsh", "1", "376")%>до <%=r.getSizeInput("r_tolsh_size")%> мм</div></td></tr>
    <tr><td colspan="3"><b>Мениски</b></td></tr>
    <tr><td><b>Наружный</b></td>
        <td>форма</td>
        <td><%=r.getSelect("r_n_menisk_forma")%></td></tr>
    <tr><td>&nbsp;</td>
        <td>структура</td>
        <td><%=r.getSelect("r_n_menisk_struc")%></td></tr>
    <tr><td>&nbsp;</td>
        <td>контуры</td>
        <td><%=r.getSelect("r_n_menisk_kon")%></td></tr>
    <tr><td>&nbsp;</td>
        <td>фрагментация</td>
        <td><%=r.getSelect("r_n_menisk_frag")%>
            <%=r.getChangeHidden("r_n_menisk_frag", "6", "351")%> <%=r.getSelect("r_n_frag_opred")%></div>
        </td></tr>
    <tr><td>&nbsp;</td>
        <td>кальцинаты</td>
        <td><%=r.getSelect("r_n_menisk_kal")%></td></tr>
    <tr><td>&nbsp;</td>
        <td>наличие жидкостных образований в паракапсулярной зоне</td>
        <td><%=r.getSelect("r_n_menisk_para")%></td></tr>
    <tr><td><b>Внутренний</b></td>
        <td>форма</td>
        <td><%=r.getSelect("r_v_menisk_forma")%></td></tr>
    <tr><td>&nbsp;</td>
        <td>структура</td>
        <td><%=r.getSelect("r_v_menisk_struc")%></td></tr>
    <tr><td>&nbsp;</td>
        <td>контуры</td>
        <td><%=r.getSelect("r_v_menisk_kon")%></td></tr>
    <tr><td>&nbsp;</td>
        <td>фрагментация</td>
        <td><%=r.getSelect("r_v_menisk_frag")%>
            <%=r.getChangeHidden("r_v_menisk_frag", "7", "351")%> <%=r.getSelect("r_v_frag_opred")%></div>
        </td></tr>
    <tr><td>&nbsp;</td>
        <td>кальцинаты</td>
        <td><%=r.getSelect("r_v_menisk_kal")%></td></tr>
    <tr><td>&nbsp;</td>
        <td>наличие жидкостных образований в паракапсулярной зоне</td>
        <td><%=r.getSelect("r_v_menisk_para")%></td></tr>
    <tr><td colspan="3">Киста Бейкера в подколенной области <%=r.getSelect("r_beker")%>
            <%=r.getChangeHidden("r_beker", "2", "351")%> <%=r.getSelect("r_beker_opred")%>
                <%=r.getSizeInput("r_beker_size1")%> мм
                <%=r.getSizeInput("r_beker_size2")%> мм
            </div>
        </td></tr>
    </table><br>
<table width="90%" border="1">
    <tr><td colspan="3"><b>Левый коленный сустав</b></td></tr>
    <tr><td>Жидкость в суставах</td>
        <td colspan="2"><%=r.getSelect("l_opred_gyd")%><%=r.getChangeHidden("l_opred_gyd", "10", "351")%> <%=r.getSelect("l_jid_opred")%></div> <%=r.getTextInput("l_gyd_text")%>
        </td></tr>
    <tr><td>Размеры верхнего заворота</td>
        <td colspan="2"><%=r.getSizeInput("l_zav_size1")%> мм
            <%=r.getSizeInput("l_zav_size2")%> мм
        </td></tr>
    <tr><td>Синовиальная оболочка</td>
        <td><%=r.getSelect("l_sinov")%></td>
        <td><%=r.getChangeHidden("l_sinov", "11", "353")%>до <%=r.getSizeInput("l_sinov_size")%> мм</div></td></tr>
    <tr><td>Сухожилие прямой мышцы бедра</td>
        <td colspan="2"><%=r.getSelect("l_suho")%>
        </td></tr>
    <tr><td>Надколенник - контуры</td>
        <td colspan="2"><%=r.getSelect("l_nadkol")%>
        </td></tr>
    <tr><td>Бурсит</td>
        <td colspan="2"><%=r.getSelect("l_opred_burs")%>
        </td></tr>
    <tr><td colspan="3"><b>Собственная связка надколенника</b></td></tr>
    <tr><td>целостность</td>
        <td colspan="2"><%=r.getSelect("l_cel")%>
        </td></tr>
    <tr><td>структура</td>
        <td colspan="2"><%=r.getSelect("l_struc")%>
        </td></tr>
    <tr><td>эхогенность</td>
        <td><%=r.getSelect("l_ehogen")%></td>
        <td><div id="display12" style="display:none;position:relative; left:12;">
            <%=r.getSelect("l_eho_po")%>
            <SCRIPT LANGUAGE="JavaScript">changeHidden12();
                document.protocol.l_ehogen.onchange  = changeHidden12
                function changeHidden12()
                {
                    if(document.protocol.l_ehogen.value == "363" || document.protocol.l_ehogen.value == "364")
                        display12.style.display = "";
                    else display12.style.display = "none";
                }
            </SCRIPT></td></tr>

        </tr>
    <tr><td>толщина</td>
        <td colspan="2"><%=r.getSizeInput("l_tolsh_size")%> мм
        </td></tr>
    <tr><td>бурсит</td>
        <td colspan="2"><%=r.getSelect("l_opred_burs")%>
        </td></tr>
    <tr><td colspan="3"><b>Состояние жировых тел</b></td></tr>
    <tr><td>структура</td>
        <td colspan="2"><%=r.getSelect("l_gir_struc")%>
        </td></tr>
    <tr><td>гипертрофия</td>
        <td colspan="2"><%=r.getSelect("l_gipertr")%>
        </td></tr>
    <tr><td colspan="3"><b>Боковые связки</b></td></tr>
    <tr><td>структура</td>
        <td colspan="2"><%=r.getSelect("l_strucbok")%>
        </td></tr>
    <tr><td colspan="3"><b>Суставные поверхности бедренной и большеберцовой костей</b> <%=r.getSelect("l_pov_kost")%></td></tr>
    <tr><td>костные разрастания</td>
        <td colspan="2"><%=r.getSelect("l_opred_razr")%>
        </td></tr>
    <tr><td colspan="3"><b>Гиалиновый хрящ</b></td></tr>
    <tr><td>контуры</td>
        <td colspan="2"><%=r.getSelect("l_kontur")%>
        </td></tr>
    <tr><td>толщина</td>
        <td><%=r.getSelect("l_tolsh")%></td>
        <td><%=r.getChangeHidden("l_tolsh", "13", "376")%>до <%=r.getSizeInput("l_tolsh_size")%> мм</div></td></tr>
    <tr><td colspan="3"><b>Мениски</b></td></tr>
    <tr><td><b>Наружный</b></td>
        <td>форма</td>
        <td><%=r.getSelect("l_n_menisk_forma")%></td></tr>
    <tr><td>&nbsp;</td>
        <td>структура</td>
        <td><%=r.getSelect("l_n_menisk_struc")%></td></tr>
    <tr><td>&nbsp;</td>
        <td>контуры</td>
        <td><%=r.getSelect("l_n_menisk_kon")%></td></tr>
    <tr><td>&nbsp;</td>
        <td>фрагментация</td>
        <td><%=r.getSelect("l_n_menisk_frag")%>
            <%=r.getChangeHidden("l_n_menisk_frag", "14", "351")%> <%=r.getSelect("l_n_frag_opred")%></div>
        </td></tr>
    <tr><td>&nbsp;</td>
        <td>кальцинаты</td>
        <td><%=r.getSelect("l_n_menisk_kal")%></td></tr>
    <tr><td>&nbsp;</td>
        <td>наличие жидкостных образований в паракапсулярной зоне</td>
        <td><%=r.getSelect("l_n_menisk_para")%></td></tr>
    <tr><td><b>Внутренний</b></td>
        <td>форма</td>
        <td><%=r.getSelect("l_v_menisk_forma")%></td></tr>
    <tr><td>&nbsp;</td>
        <td>структура</td>
        <td><%=r.getSelect("l_v_menisk_struc")%></td></tr>
    <tr><td>&nbsp;</td>
        <td>контуры</td>
        <td><%=r.getSelect("l_v_menisk_kon")%></td></tr>
    <tr><td>&nbsp;</td>
        <td>фрагментация</td>
        <td><%=r.getSelect("l_v_menisk_frag")%>
            <%=r.getChangeHidden("l_v_menisk_frag", "15", "351")%> <%=r.getSelect("l_v_frag_opred")%></div>
        </td></tr>
    <tr><td>&nbsp;</td>
        <td>кальцинаты</td>
        <td><%=r.getSelect("l_v_menisk_kal")%></td></tr>
    <tr><td>&nbsp;</td>
        <td>наличие жидкостных образований в паракапсулярной зоне</td>
        <td><%=r.getSelect("l_v_menisk_para")%></td></tr>
    <tr><td colspan="3">Киста Бейкера в подколенной области <%=r.getSelect("l_beker")%>
            <%=r.getChangeHidden("l_beker", "16", "351")%> <%=r.getSelect("l_beker_opred")%>
                <%=r.getSizeInput("l_beker_size1")%> мм
                <%=r.getSizeInput("l_beker_size2")%> мм
            </div>
        </td></tr>
</table>
<%@include file="footer.jsp"%>
