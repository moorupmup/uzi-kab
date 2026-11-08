<%@page import = "java.util.Date" import="my_pack.beans.*" import="my_pack.tools.* java.text.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title" align="center"><%=r.get("research")%></H3>
<table width="90%" border="1">
    <tr><td colspan="4"></td></tr>
    <tr><td>Аорта</td>
        <td><%=r.getSizeInput("aorta")%> см</td>
        <td>в восходящем отделе</td>
        <td><%=r.getSizeInput("aorta_vos")%> см</td>
    </tr>
        <SCRIPT LANGUAGE="JavaScript">
            document.protocol.aorta.focus();
        </script>
    <tr><td>Левое предсердие</td>
        <td><%=r.getSizeInput("left_p")%> см</td>
        <td> правое предсердие</td>
        <td><%=r.getSizeInput("right_p1")%> * <%=r.getSizeInput("right_p2")%> см</td>
    </tr>
    <tr><td>КДР</td>
        <td><%=r.getSizeInput("kdr")%> см</td>
        <td>правый желудочек</td>
        <td><%=r.getSizeInput("right_jel")%> см</td>
    </tr>
    <tr><td>КСР <%=r.getSizeInput("ksr")%> см</td>
        <td>КДО <%=r.getHidden("kdo")%> мл</td>
        <td colspan="2"> КСО <%=r.getHidden("kso")%> мл</td>
    </tr>
    <tr><td>ФВ <%=r.getHidden("fv")%> %</td>
        <td>ФУ <%=r.getHidden("fy")%> %</td>
        <td colspan="2">ударный объем <%=r.getHidden("ydar_v")%> мл</td>
    </tr>
</table>

<table width="90%" border="1">
    <tr><td>Межжелудочковая перегородка</td>
        <td> толщина <%=r.getSizeInput("mjld_tol")%> см </td>
        <td> экскурсия <%=r.getSizeInput("mjld_eks")%> см</td>
    </tr>
    <tr><td>Задняя стенка левого желудочка </td>
        <td>толщина <%=r.getSizeInput("zslj_tol")%> см </td>
        <td>экскурсия <%=r.getSizeInput("zslj_eks")%> см</td>
    </tr>
    <tr><td>Масса миокарда <%=r.getHidden("massa")%> г</td>
        <td colspan="2"> индекс массы миокарда <%=r.getSizeInput("index_mm")%> г/см2 (М-режим)</td>
    </tr>
</table>

<table width="90%" border="1">
    <tr><td colspan="4"><b>Допплерография и ЦДК</b></td></tr>
    <tr><td>Трансмитральный поток</td>
        <td>скорость <%=r.getSizeInput("trans_mit_v")%> м/с</td>
        <td>пиковый градиент <%=r.getSizeInput("trans_mit_g")%> мм.рт.ст.</td>
    </tr>
    <tr><td>Трансаортальный поток</td>
        <td>скорость <%=r.getSizeInput("trans_aort_v")%> м/c</td>
        <td> пиковый градиент <%=r.getSizeInput("trans_aort_g")%> мм.рт.ст.</td>
    </tr>
    <tr><td>Транспульмональный поток</td>
        <td>скорость <%=r.getSizeInput("trans_pul_v")%> м/с</td>
        <td>пиковый градиент <%=r.getSizeInput("trans_pul_g")%> мм.рт.ст.</td>
    </tr>
    <tr><td>Транстрикуспидальный поток</td>
        <td>скорость <%=r.getSizeInput("trans_trik_v")%> м/c</td>
        <td> пиковый градиент <%=r.getSizeInput("trans_trik_g")%> мм.рт.ст.</td>
    </tr>
    <tr><td>E/A <%=r.getSizeInput("ea")%> </td>
        <td colspan="2">IVRT <%=r.getSizeInput("ivrt")%> </td>
    </tr>
</table>

<table width="90%" border="1">
    <tr><td>Полость<br> <%=r.get("polost")%></td></tr>
    <tr><td>Стенки<br> <%=r.get("stenki")%></td></tr>
    <tr><td>Аорта<br> <%=r.get("aorta_text")%></td></tr>
    <tr><td>Створки<br> <%=r.get("stvorki")%></td></tr>
    <tr><td>Перикард<br> <%=r.get("perikard")%></td></tr>
    <tr><td>Сократительная способность миокарда<br> <%=r.get("miokard")%></td></tr>
    <tr><td>При ДГ<br> <%=r.get("dg")%></td></tr>
</table>
<script>
    document.protocol.kdr.onchange = F_kdo
    document.protocol.ksr.onchange = F_kso
    document.protocol.mjld_tol.onchange = F_massa
    document.protocol.zslj_tol.onchange = F_massa


    function F_kdo()
    {
        StrToFloat(document.protocol.kdr);
        var val=0;
        var kdr = parseFloat(document.protocol.kdr.value);
        if(document.protocol.kdr.value != ""){
            val = Math.round((7/(2.4+kdr)*kdr*kdr*kdr));
            document.protocol.kdo.value = val;
        } else document.protocol.kdo.value = 0;
        F_fv(); 
        F_fy();
        F_massa();
    }
    
    function F_kso()
    {
        StrToFloat(document.protocol.ksr);
        var val=0;
        var ksr = parseFloat(document.protocol.ksr.value);
        if(document.protocol.ksr.value != ""){
            val = Math.round((7/(2.4+ksr)*ksr*ksr*ksr));
            document.protocol.kso.value = val;
        }else  document.protocol.kso.value = 0;
        F_fv();
        F_fy();
    }

    function F_fv()
    {
        StrToFloat(document.protocol.kdo);
        StrToFloat(document.protocol.kso);
        var val=0;
        var kdo = parseFloat(document.protocol.kdo.value);
        var kso = parseFloat(document.protocol.kso.value);
        if(document.protocol.kdo.value != "" && document.protocol.kso.value != ""){
            val = Math.round((((kdo-kso)/kdo)*100));
            document.protocol.fv.value = val;
        } else document.protocol.fv.value = 0;
        if(document.protocol.kdo.value != "" && document.protocol.kso.value != ""){
            val = Math.round(kdo-kso);
            document.protocol.ydar_v.value = val;
        } else document.protocol.ydar_v.value = 0;

    }

    function F_fy()
    {
        StrToFloat(document.protocol.kdr);
        StrToFloat(document.protocol.ksr);
        var val=0;
        var kdr = parseFloat(document.protocol.kdr.value);
        var ksr = parseFloat(document.protocol.ksr.value);
        if(document.protocol.kdr.value != "" && document.protocol.ksr.value != ""){
            val = Math.round((((kdr-ksr)/kdr)*100));
            document.protocol.fy.value = val;
        }else document.protocol.fy.value = 0;
    }

    function F_massa()
    {
        StrToFloat(document.protocol.mjld_tol);
        StrToFloat(document.protocol.zslj_tol);
        StrToFloat(document.protocol.kdr);        
        var val=0;
        var mjld_tol = parseFloat(document.protocol.mjld_tol.value);
        var zslj_tol = parseFloat(document.protocol.zslj_tol.value);
        var kdr = parseFloat(document.protocol.kdr.value);
        if(document.protocol.mjld_tol.value != "" && document.protocol.zslj_tol.value != "" && document.protocol.kdr.value != ""){
            val = Math.round((1.04*((kdr+zslj_tol+mjld_tol)*(kdr+zslj_tol+mjld_tol)*(kdr+zslj_tol+mjld_tol)-kdr*kdr*kdr)-1.36));
            document.protocol.massa.value = val;
        }else document.protocol.massa.value = 0;
    }

    function StrToFloat(f_name){
      var val;
      var field;
      var array;
      field = eval(f_name);
      val = field.value;
      field.value = "";
      array = val.split(",");
      for(var i = 0; i < array.length; i++) if(i != array.length - 1) field.value += array[i] + "."; else field.value += array[i];
    }

</script>
<%@include file="footer.jsp"%>
