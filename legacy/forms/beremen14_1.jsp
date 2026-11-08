<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title" align="center"><%=r.get("research")%></H3>
<table width="80%" border="1">
    <tr><td>Дата последней менструации </td>
        <td><%=r.getTextInput("mens_text")%> </td>
        <SCRIPT LANGUAGE="JavaScript">
            document.protocol.mens_text.focus();
        </script>
    </tr>
    <tr><td>Срок беременности по менструации</td>
        <td><%=r.getTextInput("srok_ber")%></td>
    </tr>
    <tr><td>Предполагаемая дата родов </td>
        <td><%=r.getTextInput("data_roda")%> </td>
    </tr>
    <tr><td>В полости матки </td>
        <td><%=r.getSelect("plod")%> </td>
    </tr>

  
    
    <tr><td> КТР <%=r.getSizeInput("razm_gol")%> мм </td>
        <td> <%=r.getSelect("ktr")%> </td>
    </tr>
    <tr><td>BPD <%=r.getSizeInput("okr_golov")%> мм HC <%=r.getSizeInput("lob_zat")%> мм </td>
        <td> FL <%=r.getSizeInput("okr_jiv")%> мм AC <%=r.getSizeInput("ac")%> мм </td>
    </tr>


     <tr><td>Толщина воротникового пространства <%=r.getSizeInput("tol_pr")%> мм </td>
        <td> Длина носовой кости <%=r.getSizeInput("dl_nos_kost")%> мм </td>
    </tr>
   


  </table>
<table width="80%" border="1">
    <tr><td colspan="2" align="center"><b>Анатомия плода:</b></tr>
    <tr><td>Кости черепа </td>
        <td><%=r.getSelect("sel_mozg")%> <%=r.getTextInput("mozg")%></td>
    </tr>
 <tr><td>Структуры головного мозга </td>
        <td><%=r.getSelect("sel_legkie")%> <%=r.getTextInput("legkie")%></td>
    </tr>
   
    <tr><td>Позвоночник</td>
        <td><%=r.getSelect("sel_pozv")%> <%=r.getTextInput("pozv")%></td>
    </tr>
    <tr><td>Четырехкамерный срез сердца</td>
        <td><%=r.getSelect("sel_serdce")%> <%=r.getTextInput("serdce")%></td>
    </tr>


 <tr><td>ЧCC плода</td>
        <td><%=r.getSizeInput("css")%> уд. мин</td>
    </tr>
   
    <tr><td>Желудок</td>
        <td><%=r.getSelect("sel_jelud")%> <%=r.getTextInput("jelud")%></td>
    </tr>
    <tr><td>Мочевой пузырь </td>
        <td><%=r.getSelect("sel_mocha")%>  <%=r.getTextInput("mocha")%></td>
    </tr>

    <tr><td>Передняя брюшная стенка</td>
        <td><%=r.getSelect("stenka")%> <%=r.getTextInput("kishki")%></td>
    </tr>
    <tr><td>Место прикрепления пуповины </td>
        <td><%=r.getSelect("pupo")%> <%=r.getTextInput("pochki")%></td>
    </tr>
   







</table>
<table width="80%" border="1">
  
    <tr><td colspan="2"><b>Врожденные пороки развития плода:</b> <%=r.getSelect("poroki")%><br>
        <%=r.getTextAreaInput("poroki_text",3,80)%></td></tr>

     <tr><td colspan="2"><b>Преимущественная локализация хориона:</b> <%=r.getSelect("loc_hor")%><br>
        <%=r.getTextAreaInput("loc_text",3,80)%></td></tr>

       <tr><td colspan="2"><b>Структура хориона:</b> <%=r.getSelect("horion")%><br>
        <%=r.getTextAreaInput("hor_text",3,80)%></td></tr>













    <tr><td colspan="2"><b>Особенности строения шейки и стенок матки</b> <%=r.getSelect("osob_stroi")%><br>
        <%=r.getTextAreaInput("stenki_text",3,80)%></td></tr>    
    <tr><td colspan="2"><b>Область придатков</b> <%=r.getSelect("obl_pr")%><br>
        <%=r.getTextAreaInput("pridatki",3,80)%></td></tr>    
    <tr><td colspan="2"><b>Визуализация</b> <%=r.getSelect("vizual")%><br>
        <%=r.getTextAreaInput("viz_text",3,80)%></td></tr>    
  
  <tr><td colspan="2">Почки беременной <%=r.getSelect("pochki_ber")%><br>
        чашечки расширенные до <%=r.getSizeInput("chash")%> мм <%=r.getSelect("chash_gde")%>
        лоханка расширенна до <%=r.getSizeInput("loh")%> мм <%=r.getSelect("loh_gde")%><br>
        <%=r.get("pochki_text")%></td>
    </tr>
   
</table>
<%@include file="footer.jsp"%>
