<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title">Пункция предстательной железы</H3>



<font class="underline_str"><b>Предстательная железа</b></font> 
    <%=r.getSelect("predstat")%><br>


<div id="display63" style="display:none;position:relative; left:0;">
<table width="100%" border="1">
    <tr> 
        <td class="simple_str" width="24%">Размеры 
        </td>
        <td width="22%"> 
          <%=r.getSizeInput("jeleza_r1")%>*
          <%=r.getSizeInput("jeleza_r2")%>*
          <%=r.getSizeInput("jeleza_r3")%>
        </td>
        <td class="simple_str" width="54%">Объем 
          <%=r.getSizeInput("jeleza_obem")%>мл
        </td>
    </tr>
    <tr> 
        <td class="simple_str" width="24%">Форма 
        </td>
        <td colspan="2"> 
            <%=r.getSelect("forma")%>
        </td>
    <tr> 
        
        <td width="24%">
            <%=r.getSelect("vdaetsja")%>
        </td>
        <td colspan="2" class="simple_str">в просвет мочевого пузыря
        </td>
    </tr>
    <tr> 
        <td class="simple_str" width="24%">Капсула на всем протяжении 
        </td>
        <td colspan="2"> 
            <%=r.getSelect("kapsula")%>
        </td>
    </tr>
    <tr> 
        <td class="simple_str" width="24%">Контур 
        </td>
        <td width="22%"> 
            <%=r.getSelect("kontur")%>
        </td>
        <td width="54%"> 
            <%=r.getSelect("kontursim")%>
        </td>
    </tr>   
    <tr>
        <td class="simple_str" width="24%">Эхогенность 
        </td>
        <td colspan="2">
            <%=r.getSelect("ehogennost")%>
        </td>
    </tr>
    <tr> 
        <td class="simple_str" width="24%">
            <span class="simple_str">Эхоструктура</span>
            <%=r.getSelect("ehostru")%>
        </td>
        <td colspan="2"> 
            <%=r.getChangeHidden("ehostru", "3", "9326")%>
                <%=r.getCheckbox("cgvpz")%>
                <br>
                <%=r.getCheckbox("ppebat")%>
                <br>
                <%=r.getCheckbox("gy")%>
                <br>
                <%=r.getCheckbox("jv")%>
                <br>
                <%=r.getCheckbox("ret")%>
                <br>
                <%=r.getCheckbox("mr")%>
                <br>
                <%=r.getCheckbox("pdafz")%>
                <br>
                <%=r.getCheckbox("paej")%>
                <br>
                <%=r.getCheckbox("kp")%>
                <%=r.getTextInput("poloct_kistoz_how")%><br>
                <%=r.getCheckbox("pmpbooj")%>
                <br>                                                            
                <%=r.getCheckbox("kk")%>
                <%=r.getTextInput("big_kalcinat_how")%><br>
            </div>
        </td>
    </tr>
    <tr> 
        <td colspan="3" class="simple_str">Простатическая часть уретры
            <%=r.getSelect("yretra")%>
            <font class="simple_str">на всем протяжении</font>
        </td>
    </tr>
    <tr>
        <td colspan="3" class="simple_str">Уретро-простатический угол      
            <%=r.getSelect("yretra_ygol")%>
        </td>
    </tr>
    <tr>
        <td colspan="3" class="simple_str">Везикуло-простатические углы
            <%=r.getSelect("vezikylo_ygol")%>
        </td>
    </tr>
    <tr> 
        <td colspan="3" class="simple_str">Парапростатическое венозное сплетение
            <%=r.getSelect("spletenie")%>
        </td>
    </tr>
    <tr> 
        <td class="simple_str" width="24%">Гиперплазия 
            <%=r.getSelect("giperplaz")%>
        </td>
        <td colspan="2"> 
            <%=r.getChangeHidden("giperplaz", "7", "9420")%>
                за счет<br>
                <%=r.getCheckbox("cz")%>
                <br>
                <%=r.getCheckbox("zpj")%>
                <br>
                <%=r.getCheckbox("pz")%>
                <br>
                <%=r.getCheckbox("ipz")%>
                <br>
                <%=r.getCheckbox("withy")%>
                <%=r.getTextInput("yzloobraz_how")%><br>
                <%=r.getCheckbox("perehod")%>
            </div>
        </td>
    </tr>
    <tr>
        <td colspan="3"> 
            <%=r.getCheckbox("perefir")%>
        </td>
    </tr>
    <tr>
        <td width="24%" class="simple_str">Очаговые изменения 
            <%=r.getSelect("ochagi")%>
        </td>
        <td colspan="2">
            <%=r.getChangeHidden("ochagi", "8", "9341")%>
                <%=r.getCheckbox("inpz")%>
                <br>
                <%=r.getCheckbox("incz")%>
                <br>
                <%=r.getCheckbox("inpfz")%>
                <br>
                <%=r.getCheckbox("pebchkr")%>
                <%=r.getSizeInput("ehogennosti_how")%>мм<br>
            </div>
        </td>
    </tr>
</table>
</div><br>

<SCRIPT LANGUAGE="JavaScript">
    changeHidden63();
    document.protocol.predstat.onchange  = changeHidden63
    function changeHidden63()
    {
        if(document.protocol.predstat.value == "9312"){
            display63.style.display = "none";
        }else{
            display63.style.display = "";
        }
    }
</SCRIPT>

<table width="100%" border="1">
    <tr> 
        <td class="underline_str">Семенные пузырьки
            <%=r.getSizeInput("puzirki_how")%>мм
            <%=r.getSelect("puzirkisim")%>
        </td>
    </tr>
</table>

<font class="underline_str"><b>Мочевой пузырь</b></font>
    <%=r.getSelect("mochpuzir")%><br>

<table width="100%" border="1">
    <tr> 
        <td class="simple_str">Стенка
        </td>
        <td>
            <%=r.getSelect("stenka")%>
        </td>
    </tr>
    <tr>
        <td class="simple_str">Содержимое
        </td>
        <td>
            <%=r.getSelect("soderjimoe")%>
        </td>   
    <tr> 
        <td class="simple_str">Объемные образования
        </td>
        <td>
            <%=r.getSelect("obrazovanija")%>
            <%=r.getSizeInput("obrazov1")%>
            <%=r.getSizeInput("obrazov2")%>
        </td>
    </tr>
    <tr>
        <td class="simple_str">Конкременты
        </td>
        <td>
            <%=r.getSelect("konkrimenti")%>
            <%=r.getSizeInput("konkrim1")%>
            <%=r.getSizeInput("konkrim2")%>
        </td>
    </tr>
    <tr> 
        <td class="simple_str">Шейка мочевого пузыря
        </td>
        <td>
            <%=r.getSelect("sheika")%>
        </td>
    </tr>
    <tr> 
        <td class="simple_str">Объем остаточной мочи составляет
        </td>
        <td><%=r.getSizeInput("obiem_mochi")%>мл
        </td>
    </tr>
</table>
<Script>
  document.protocol.jeleza_r1.onchange = executeRange
  document.protocol.jeleza_r2.onchange = executeRange
  document.protocol.jeleza_r3.onchange = executeRange
  function executeRange()
  { jeleza_r1 = parseFloat(document.protocol.jeleza_r1.value);
    jeleza_r2 = parseFloat(document.protocol.jeleza_r2.value);
    jeleza_r3 = parseFloat(document.protocol.jeleza_r3.value);

    if (isNaN(parseFloat(document.protocol.jeleza_r1.value)) && document.protocol.jeleza_r1.value!="") {notFloat(); document.protocol.jeleza_obem.value = "";}
    if (isNaN(parseFloat(document.protocol.jeleza_r2.value)) && document.protocol.jeleza_r2.value!="") {notFloat(); document.protocol.jeleza_obem.value = "";}
    if (isNaN(parseFloat(document.protocol.jeleza_r3.value)) && document.protocol.jeleza_r3.value!="") {notFloat(); document.protocol.jeleza_obem.value = "";}

    if(document.protocol.jeleza_r1.value != "" && document.protocol.jeleza_r2.value != "" && document.protocol.jeleza_r3.value != ""){
        document.protocol.jeleza_obem.value = cut(((jeleza_r1 * jeleza_r2 * jeleza_r3)/1000)*0.479);
    }
  }
  function cut(arg){
    arg = arg.toString();
    array_arg = arg.split(".");
    if (array_arg[1]){
      vr = array_arg[1];
      vr = vr.substring(0,2);
      arg = array_arg[0] + "." + vr;
    }
    return arg;
  }
  function notFloat(){
    alert("Необходимо ввести число. Знаком разделения целой и дробной части служит точка.")
  }
</Script>

<%@include file="footer.jsp"%>
