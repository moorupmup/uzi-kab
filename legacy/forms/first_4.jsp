<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>

 <H3 class="p_title">ПРОТОКОЛ ПЕРВОГО ТРИМЕСТРА БЕРЕМЕННОСТИ (ДО 12 НЕДЕЛЬ)</H3>
<br><br>

<table width="90%" border="1">
  <tr> 
    <td colspan="2" class="bold_str">1 день последней менструации 
      <%=r.getSizeInput("priznak")%>
      <SCRIPT LANGUAGE="JavaScript">
        document.protocol.priznak.focus();
        document.protocol.priznak.onkeyup = point
        function point(){
            checkDate("document.protocol.priznak");
        }

      </script>
    </td>
  </tr>
  <tr> 
    <td colspan="2" class="simple_str">В полости матки 
      <%=r.getSelect("polost")%>
      <font class="simple_str">определяется плодное яйцо диаметром </font> 
        <%=r.getSizeInput("diametr")%>мм
    </td>
  </tr>
  <tr> 
    <td width="30%" class="bold_str">Плодное яйцо</td>
    <td width="70%"> 
      <%=r.getSelect("jaico")%>
    </td>
  </tr>
  <tr> 
    <td width="30%" class="bold_str">Хорион</td>
    <td width="70%"> 
      <%=r.getSelect("horion")%>
    </td>
  </tr>
  <tr> 
    <td class="simple_str" width="30%">Отслойка хориона</td>
    <td width="70%"> 
      <%=r.getSelect("horion_ot")%>
    </td>
  </tr>
  <tr> 
    <td width="30%" class="bold_str">Эмбрион</td>
    <td width="70%"> 
      <%=r.getSelect("embrion")%>
    </td>
  </tr>
  </table>
  <%=r.getChangeHidden("embrion", "0", "899")%>
      <table width="90%" border="1">
          <tr> 
            <td class="simple_str" width="30%">Копчико-теменной размер</td>
            <td width="70%"> 
              <%=r.getSizeInput("kopchik")%>мм
            </td>
          </tr>  
          <tr> 
            <td class="simple_str" width="30%">Диаметр желточного мешка</td>
            <td width="70%"> 
              <%=r.getSizeInput("jeltok")%>мм
            </td>
          </tr>
      </table>
  </div>
  <table width="90%" border="1">
  <tr> 
    <td class="simple_str" width="30%">Структура миометрия </td>
    <td width="70%"> 
      <%=r.getSelect("meom")%>
    </td>
  </tr>
  <tr> 
    <td class="simple_str" width="30%">Шейка матки </td>
    <td width="70%"> 
      <%=r.getSelect("matka")%>
      <%=r.getSizeInput("matka_how")%>мм
    </td>
  </tr>

  <tr> 
    <td class="simple_str" width="30%">Внутренний зев</td>
    <td width="70%"> 
      <%=r.getSelect("zev")%>
      <%=r.getSizeInput("zev_how")%>мм
    </td>
  </tr>
  <tr> 
    <td class="simple_str" width="30%">Придатки</td>
    <td width="70%"> 
      <%=r.getSelect("pridat")%>
    </td>
  </tr>


<tr> 
       <td class="simple_str" width="30%">Почки беременной</td>
    <td width="70%"> 
      <%=r.getSelect("pochki_berem")%>
    </td>
          
               <td colspan="2"> 
            <%=r.getChangeHidden("pochki_berem", "2", "9549")%>
                <%=r.getCheckbox("chkalik")%> 
                <%=r.getSelect("kalik")%><%=r.getSizeInput("chkalik_how")%>мм
                <br>
                <%=r.getCheckbox("chpoliek")%> 
                <%=r.getSelect("poliek")%><%=r.getSizeInput("chpoliek_how")%>мм
                <br>
                <%=r.getCheckbox("chtransform")%> 
                <%=r.getSelect("transform")%>
           </div>
        </td>
    </tr>

  </table><br>



<%@include file="footer.jsp"%>
