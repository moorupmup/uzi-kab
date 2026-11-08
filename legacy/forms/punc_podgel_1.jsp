<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>

<H3 class="p_title">Пункция поджелудочной железы</H3>
<br>
 
<font class="underline_str"><b>Поджелудочная железа</b></font> 
    <%=r.getSelect("jelez")%>
<br>

<table width="90%" border="1">
  <tr> 
    <td width="13%" class="simple_str">Размер</td>
    <td width="12%" class="simple_str">головка</td>
    <td> 
      <%=r.getSizeInput("golov")%>
  <SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.golov.value == "") document.protocol.golov.value = "25";
  </script>

      <span class="ed_izm">мм</span></td>
  </tr>
  <tr> 
    <td width="13%" class="simple_str">&nbsp;</td>
    <td width="12%" class="simple_str">тело</td>
    <td> 
      <%=r.getSizeInput("telo")%>
  <SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.telo.value == "") document.protocol.telo.value = "12";
  </script>

      <span class="ed_izm">мм</span></td>
  </tr>
  <tr> 
    <td width="13%" class="simple_str">&nbsp;</td>
    <td width="12%" class="simple_str">хвост</td>
    <td> 
      <%=r.getSizeInput("hvost")%>
  <SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.hvost.value == "") document.protocol.hvost.value = "19";
  </script>

      <span class="ed_izm">мм</span></td>
  </tr>
  <tr> 
    <td colspan="2" class="simple_str">Контур</td>
    <td> 
        <%=r.getSelect("kontur_jel")%>
    </td>
  </tr>
  <tr> 
    <td colspan="2" class="simple_str">Структура</td>
    <td> 
        <%=r.getSelect("strukt_jel")%>
    </td>
  </tr>
  <tr> 
    <td colspan="2" class="simple_str">Эхогенность</td>
    <td> 
        <%=r.getSelect("ehog")%>
    </td>
  </tr>
  <tr> 
    <td colspan="2" class="simple_str">Вирсунгов проток</td>
    <td> 
        <%=r.getSelect("prot")%>
      <%=r.getSizeInput("rash")%>
      <span class="ed_izm">мм</span></td>

    </td>
  </tr>
  <tr> 
    <td colspan="2" class="simple_str">Диаметр селезеночной вены </td>
    <td> 
      <%=r.getSizeInput("diam_selez")%>мм
  <SCRIPT LANGUAGE="JavaScript">
    if (document.protocol.diam_selez.value == "") document.protocol.diam_selez.value = "7";
  </script>

    </td>
  </tr>
</table>



<%@include file="footer.jsp"%>
