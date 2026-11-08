<%@page import="java.text.*" import="my_pack.beans.*" import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%RequestWrapper r = new RequestWrapper(request);%>
<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>

<%if(!r.empty("aorta") || !r.empty("aorta_vos")){%>
    <table width="100%" border="0">
        <tr><td width="25%"><%if(!r.empty("aorta")){%>Аорта<%}%></td>
            <td width="25%"><%if(!r.empty("aorta")){%><%=r.get("aorta")%> см<%}%></td>
            <td width="25%"><%if(!r.empty("aorta_vos")){%>в восходящем отделе<%}%></td>
            <td width="25%"><%if(!r.empty("aorta_vos")){%><%=r.get("aorta_vos")%> см <%}%></td>
        </tr>
    </table>
<%}%>

<%if(!r.empty("left_p") || !r.empty("right_p1") ||!r.empty("right_p2")){%>
    <table width="100%" border="0">
        <tr><td width="25%"><%if(!r.empty("left_p")){%>Левое предсердие<%}%></td>
            <td width="25%"><%if(!r.empty("left_p")){%><%=r.get("left_p")%> см<%}%></td>
            <td width="25%"><%if(!r.empty("right_p1") || !r.empty("right_p2")){%>правое предсердие <%}%></td>
            <td width="25%"><%if(!r.empty("right_p1")){%><%=r.get("right_p1")%><%}%>
                            <%if(!r.empty("right_p1") || !r.empty("right_p2")){%> * <%}%>
                            <%if(!r.empty("right_p2")){%><%=r.get("right_p2")%> <%}%>
                            <%if(!r.empty("right_p1") || !r.empty("right_p2")){%> см<%}%>
            </td>
        </tr>
    </table>
<%}%>

<%if(!r.empty("kdr") || !r.empty("right_jel")){%>
    <table width="100%" border="0">
        <tr><td width="25%"><%if(!r.empty("kdr")){%>КДР <%}%></td>
            <td width="25%"><%if(!r.empty("kdr")){%><%=r.get("kdr")%> см <%}%></td>
            <td width="25%"><%if(!r.empty("right_jel")){%>правый желудочек <%}%></td>
            <td width="25%"><%if(!r.empty("right_jel")){%><%=r.get("right_jel")%> см <%}%></td>
        </tr>
    </table>
<%}%>

<%if(!r.empty("ksr") || !r.empty("kdo") || !r.empty("kso")){%>
    <table width="100%" border="0">
        <tr><td width="25%"><%if(!r.empty("ksr")){%>КСР <%=r.get("ksr")%> см <%}%></td>
            <td width="25%"><%if(!r.empty("kdo")){%>КДО <%=r.get("kdo")%> мл <%}%></td>
            <td width="25%"><%if(!r.empty("kso")){%>КСО <%=r.get("kso")%> мл <%}%></td>
        </tr>
    </table>
<%}%>

<%if(!r.empty("fv") || !r.empty("fy") || !r.empty("ydar_v")){%>
    <table width="100%" border="0">
        <tr><td width="25%"><%if(!r.empty("fv")){%>ФВ <%=r.get("fv")%> % <%}%></td>
            <td width="25%"><%if(!r.empty("fy")){%>ФУ <%=r.get("fy")%> % <%}%></td>
            <td width="25%"><%if(!r.empty("ydar_v")){%>ударный объем <%=r.get("ydar_v")%> мл <%}%></td>
        </tr>
    </table>
<%}%>

<%if(!r.empty("mjld_tol") || !r.empty("mjld_eks")){%>
    <table width="100%" border="0">
        <tr><td width="50%">Межжелудочковая перегородка</td>
            <td width="25%"><%if(!r.empty("mjld_tol")){%>толщина <%=r.get("mjld_tol")%> см <%}%></td>
            <td width="25%"><%if(!r.empty("mjld_eks")){%>экскурсия <%=r.get("mjld_eks")%> см <%}%></td>
        </tr>
    </table>
<%}%>

<%if(!r.empty("zslj_tol") || !r.empty("zslj_eks")){%>
    <table width="100%" border="0">
        <tr><td width="50%">Задняя стенка левого желудочка </td>
            <td width="25%"><%if(!r.empty("zslj_tol")){%>толщина <%=r.get("zslj_tol")%> см<%}%></td>
            <td width="25%"><%if(!r.empty("zslj_eks")){%>экскурсия <%=r.get("zslj_eks")%> см<%}%></td>
        </tr>
    </table>
<%}%>

<%if(!r.empty("massa") || !r.empty("index_mm")){%>
    <table width="100%" border="0">
        <tr><td width="30%"><%if(!r.empty("massa")){%>Масса миокарда <%=r.get("massa")%> г<%}%></td>
            <td width="70%"><%if(!r.empty("index_mm")){%>индекс массы миокарда <%=r.get("index_mm")%> г/см2 (М-режим) <%}%></td>
        </tr>
    </table>
<%}%>

<%if(!r.empty("trans_mit_g") || !r.empty("trans_mit_v") || !r.empty("trans_aort_v") || !r.empty("trans_aort_g") || !r.empty("trans_pul_v") || !r.empty("trans_pul_g") || !r.empty("trans_trik_v") || !r.empty("trans_trik_g") || !r.empty("ea") || !r.empty("ivrt")){%>
    <table width="100%" border="0">
        <tr><td align="center"><b>Допплерография и ЦДК</b></td></tr>
    </table>
<%}%>

<%if(!r.empty("trans_mit_v") || !r.empty("trans_mit_g")){%>
    <table width="100%" border="0">
        <tr><td width="30%">Трансмитральный поток </td>
            <td width="30%"><%if(!r.empty("trans_mit_v")){%>скорость <%=r.get("trans_mit_v")%> м/с <%}%></td>
            <td width="40%"><%if(!r.empty("trans_mit_g")){%>пиковый градиент <%=r.get("trans_mit_g")%> мм.рт.ст. <%}%></td>
        </tr>
    </table>
<%}%>

<%if(!r.empty("trans_aort_v") || !r.empty("trans_aort_g")){%>
    <table width="100%" border="0">
        <tr><td width="30%">Трансаортальный поток </td>
            <td width="30%"><%if(!r.empty("trans_aort_v")){%>скорость <%=r.get("trans_aort_v")%> м/c <%}%></td>
            <td width="40%"><%if(!r.empty("trans_aort_g")){%>пиковый градиент <%=r.get("trans_aort_g")%> мм.рт.ст. <%}%></td>
        </tr>
    </table>
<%}%>

<%if(!r.empty("trans_pul_v") || !r.empty("trans_pul_g")){%>
    <table width="100%" border="0">
        <tr><td width="30%">Транспульмональный поток </td>
            <td width="30%"><%if(!r.empty("trans_pul_v")){%>скорость <%=r.get("trans_pul_v")%> м/с <%}%></td>
            <td width="40%"><%if(!r.empty("trans_pul_g")){%>пиковый градиент <%=r.get("trans_pul_g")%> мм.рт.ст. <%}%></td>
        </tr>
    </table>
<%}%>

<%if(!r.empty("trans_trik_v") || !r.empty("trans_trik_g")){%>
    <table width="100%" border="0">
        <tr><td width="30%">Транстрикуспидальный поток </td>
            <td width="30%"><%if(!r.empty("trans_trik_v")){%>скорость <%=r.get("trans_trik_v")%> м/c <%}%></td>
            <td width="40%"><%if(!r.empty("trans_trik_g")){%>пиковый градиент <%=r.get("trans_trik_g")%> мм.рт.ст. <%}%></td>
        </tr>
    </table>
<%}%>

<%if(!r.empty("ea") || !r.empty("ivrt")){%>
    <table width="100%" border="0">
        <tr><td width="30%"><%if(!r.empty("ea")){%>E/A <%=r.get("ea")%> <%}%></td>
            <td width="70%"><%if(!r.empty("ivrt")){%>IVRT <%=r.get("ivrt")%> <%}%></td>
        </tr>
    </table>
<%}%>
<%if(!r.empty("polost")){%>Полость <%=r.get("polost")%>.<%}%>
<%if(!r.empty("stenki")){%>Стенки <%=r.get("stenki")%>.<%}%>
<%if(!r.empty("aorta_text")){%>Аорта <%=r.get("aorta_text")%>.<%}%>
<%if(!r.empty("stvorki")){%>Створки <%=r.get("stvorki")%>.<%}%>
<%if(!r.empty("perikard")){%>Перикард <%=r.get("perikard")%>.<%}%>
<%if(!r.empty("miokard")){%>Сократительная способность миокарда <%=r.get("miokard")%>.<%}%>
<%if(!r.empty("dg")){%>При ДГ <%=r.get("dg")%>.<%}%>
