<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title">Дуплексное ИЗИ мошонки при Варикоцеле</H3>
<table width="90%" border="1">
    <tr><td colspan="2"><b>Диаметр ВСВ в области наружного пахового кольца в положении стоя</b></td></tr>
    <tr><td>в покое <%=r.getSizeInput("vsv_pokoi")%> мм</td>
            <SCRIPT LANGUAGE="JavaScript">
            document.protocol.vsv_pokoi.focus();
            </script>
        <td>при натуживании <%=r.getSizeInput("vsv_natug")%> мм</td>
    </tr>
    <tr><td colspan="2">Рефлюкс Продолжительность<%=r.getSelect("diametr")%></td></tr>
    <tr><td colspan="2">Скорость <%=r.getSizeInput("speed")%> см/c</td></tr>
    <tr><td>Размер правого яичка:</td>
        <td><%=r.getSizeInput("razm_prav_yaichka1")%> мм
            <%=r.getSizeInput("razm_prav_yaichka2")%> мм
            <%=r.getSizeInput("razm_prav_yaichka3")%> мм
        </td></tr>
    <tr><td>Размер левого яичка:</td>
        <td><%=r.getSizeInput("razm_lev_yaichka1")%> мм
            <%=r.getSizeInput("razm_lev_yaichka2")%> мм
            <%=r.getSizeInput("razm_lev_yaichka3")%> мм
        </td></tr>
    <tr><td>Индекс резистентности</td>
        <td>Справа:<%=r.getSizeInput("r_rezis_how")%> (норма 0.6 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 0.05)</td>
    </tr>
    <tr><td>&nbsp;</td>
        <td>Слева:<%=r.getSizeInput("l_rezis_how")%> (норма 0.6 <font face="MsoNormal" class="font-family: MsoNormal;" >&#177</font> 0.05)</td>
    </tr>
    <tr><td colspan="2"><b>При проведении пробы Тробетта</b></td></tr>
    <tr><td colspan="2">При компрессии в положении стоя диаметр ВСВ</td></tr>
    <tr><td>в покое <%=r.getSizeInput("komp_vsv_pokoi")%> мм</td>
        <td>при натуживании <%=r.getSizeInput("komp_vsv_natug")%> мм</td>
    </tr>
    <tr><td>После снятия компрессии диаметр ВСВ</td>
        <td><%=r.getSizeInput("posle_vsv")%> мм</td>
    </tr>
    <tr><td colspan="2"><b><%=r.getCheckbox("visual", "1")%></b>
            <table width="90%" border="1">
                <tr><td colspan="2"><b>Диаметр ВСВ:</b></td></tr>
                <tr><td>в покое <%=r.getSizeInput("visual_vsv_pokoi")%> мм</td>
                    <td>при натуживании <%=r.getSizeInput("visual_vsv_natug")%> мм</td>
                </tr>
                <tr><td colspan="2">Рефлюкс Продолжительность:<%=r.getSelect("diametr_vis")%></td></tr>
                <tr><td colspan="2"><b>Диаметр ЛПВ:</b></td></tr>
                <tr><td>Проксимальная часть:</td>
                    <td><%=r.getSizeInput("proks_chast")%> мм</td>
                </tr>
                <tr><td>Аорто - мезентериальный сегмент:</td>
                    <td><%=r.getSizeInput("aorta_mez")%> мм</td>
                </tr>
                <tr><td>Дистальная часть:</td>
                    <td><%=r.getSizeInput("dist_chast")%> мм</td>
                </tr>
                <tr><td>Характер кровотока по ЛПВ</td>
                    <td><%=r.getSelect("haracter")%></td>
                </tr>
                <tr><td><b>Диаметр ППВ <%=r.getSizeInput("diamtr_ppv")%> мм</b></td>
                    <td><b>Диаметр НПВ <%=r.getSizeInput("diamtr_npv")%> мм</b></td>
                </tr>
                <tr><td colspan="2"><b>Линейная скорость кровотока</b></td></tr>
                <tr><td>по ЛПВ <%=r.getSizeInput("linel_skor_lpv")%> см/c</td>
                    <td>по ППВ <%=r.getSizeInput("linel_skor_ppv")%> см/c</td>
                </tr>
            </table>
        </td></tr>
</table>
<%@include file="footer.jsp"%>
