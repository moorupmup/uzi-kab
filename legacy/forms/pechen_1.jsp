<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title" colspan="center">Исследование печеночного кровотока</H3>

<table width="100%" border="1">
    <tr>
        <td colspan="2"><b>Воротная вена</b></td>
    </tr>
    <tr>
        <td>Диаметр <%=r.getSizeInput("vorot_diametr_how")%> мм</td>
        <SCRIPT LANGUAGE="JavaScript">
              document.protocol.vorot_diametr_how.focus();
        </script>
        <td>(N - менее 13 мм.)</td>
    </tr>
    <tr>
        <td>Направление кровотока:</td>
        <td><%=r.getSelect("napr_krovotok")%></td>
    </tr>
    <tr>
        <td>Вид спектра:</td>
        <td><%=r.getSelect("vid_spectra_vorot")%></td>
    </tr>
    <tr>
        <td colspan="2">Средняя линейная скорость кровотока (N - не ниже 15 см/сек.):<%=r.getSizeInput("sred_v_krovotok_how")%> см/сек</td>
    </tr>
    <tr>
        <td colspan="2">Vvol (объемная скорость кровотока):<%=r.getSizeInput("o_v_krovotok_how")%> л/мин <br>*измеряется в л/мин (мл/мин) N - для женщин 0.8 - 1 л/мин N - для мужчин 0.9 - 1.1 л/мин</td>
    </tr>
    <tr>
        <td>Реакция на пробу с пищевой нагрузкой:</td>
        <td><%=r.getSelect("reakciya")%></td>
    </tr>
    <tr>
        <td colspan="2"><b>Селезеночная вена</b></td>
    </tr>
    <tr>
        <td>Диаметр <%=r.getSizeInput("selez_diametr_how")%> мм</td>
        <td>(N 8 мм.)</td>
    </tr>
    <tr>
        <td colspan="2">Линейная скорость кровотока (в норме чуть меньше, чем ВВ, в среднем 17 - 20 см/сек.):<%=r.getSizeInput("v_krovotok_how")%> см/сек</td>
    </tr>
    <tr>
        <td colspan="2">Vvol (примерно 50% от Vvol ВВ или Vvol CB/Vvol BB не более 50%):<%=r.getSizeInput("selez_v_krovotok_how")%> л/мин <br>*измеряется в л/мин (мл/мин) N - для женщин 0.8 - 1 л/мин N - для мужчин 0.9 - 1.1 л/мин</td>
    </tr>
    <tr>
        <td colspan="2"><b>Печеночная артерия</b></td>
    </tr>
    <tr>
        <td>Диаметр <%=r.getSizeInput("pechen_diametr_how")%> мм</td>
        <td>(N 2 - 2.5 мм.)</td>
    </tr>
    <tr>
        <td>Вид спектра:</td>
        <td><%=r.getSelect("vid_spectra_pechen")%></td>
    </tr>
    <tr>
        <td colspan="2">Систолическая скорость <%=r.getSizeInput("sistol_how")%></td>
    </tr>
    <tr>
        <td colspan="2">Диастолическая скорость <%=r.getSizeInput("diastol_how")%></td>
    </tr>
    <tr>
        <td colspan="2"><b>Печеночные вены</b></td>
    </tr>
    <tr>
        <td>Диаметр <%=r.getSizeInput("pechen_veny_diametr_how")%> мм</td>
        <td>(N 1 см.)</td>
    </tr>
    <tr>
        <td colspan="2"><%=r.getSelect("pechen_veny")%></td>
    </tr>
    <tr>
        <td colspan="2">Направление кровотока: <%=r.getSelect("napr_krovotok")%></td>
    </tr>
    <tr>
        <td colspan="2"><b>Нижняя полая вена</b></td>
    </tr>
    <tr>
        <td>Диаметр <%=r.getSizeInput("nign_polaya_vena_how")%> мм</td>
        <td>(N 17 - 20 мм.)</td>
    </tr>
    <tr>
        <td colspan="2">Реакция на пробу Вальсалова: <%=r.getSelect("valsav")%></td>
    </tr>
    <tr>
        <td colspan="2"><b>Визуализация партокавальных шунтов</b></td>
    </tr>
    <tr>
        <td><%=r.getSelect("partokaval")%></td>
        <td><%=r.getChangeHidden("partokaval", "1", "6303")%>
                <%=r.getSelect("bassejn")%>
            </div>
        </td>
    </tr>
    <tr>
        <td colspan="2"><b>Визуализация партопортальных шунтов</b></td>
    </tr>
    <tr>
        <td colspan="2"><%=r.getSelect("partoport")%></td>
    </tr>

</table>

<%@include file="footer.jsp"%>
