<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<SCRIPT language="JavaScript" src="/uzi/js/validations.js"></SCRIPT>
<SCRIPT language="JavaScript" src="/uzi/js/tabnext.js "></SCRIPT>
<H3 class="p_title">ЭХОКАРДИОГРАФИЯ</H3>
<table width="90%" border="1">
    <tr>
        <td class="bold_str" width="25%">ЧСС
            <%=r.getSizeInput("chss")%>
            <SCRIPT LANGUAGE="JavaScript">
               document.protocol.chss.focus();
            </script>

        </td>
        <td class="bold_str" width="20%">Рост
            <%=r.getSizeInput("rost")%>
        </td>
        <td class="bold_str" width="69%">Вес
            <%=r.getSizeInput("ves")%>
        </td>
    </tr>
    <tr> 
        <td width="11%" class="bold_str">Аорта
        </td>
        <td colspan="2"> 
            <%=r.getSelect("aorta")%>
        </td>
    </tr>
    <tr> 
        <td width="11%">&nbsp;
        </td>
        <td width="20%" class="simple_str">корень аорты
        </td>
        <td width="69%"> 
            <%=r.getSizeInput("koren")%>
            <font class="ed_izm">см</font>
        </td>
    </tr>
    <tr> 
        <td width="11%">&nbsp;
        </td>
        <td width="20%" class="simple_str">восх.отдел
        </td>
        <td width="69%"> 
            <%=r.getSizeInput("otdel")%>
            <font class="ed_izm">см</font>
        </td>
    </tr>
</table>

<table width="90%" border="1">
    <tr> 
        <td class="bold_str" width="25%">Левое предсердие
        </td>
        <td colspan="6"> 
            <%=r.getSelect("predserdie")%>
            <%=r.getSizeInput("lpred")%>
            <font class="ed_izm">см</font>
        </td>
    </tr>
    <tr> 
        <td width="25%"><span class="bold_str">Левый желудочек</span>
        </td>
        <td colspan="6"> 
            <%=r.getSelect("jeludochek")%>
        </td>
    </tr>
    <tr> 
        <td class="simple_str" width="25%">КДР
        </td>
        <td width="16%"> 
            <%=r.getSizeInput("kdr")%>
            <font class="ed_izm">см</font>
        </td>
        <td class="simple_str" width="13%">КДО
        </td>
        <td width="16%"> 
            <%=r.getHidden("kdo")%>
            <font class="ed_izm">мл</font>
        </td>
        <td width="12%">УО
        </td>
        <td width="18%">
            <%=r.getHidden("yo")%>
            <font class="ed_izm">мл</font>
        </td>
    </tr>
    <tr> 
        <td class="simple_str" width="25%">КСР
        </td>
        <td> 
            <%=r.getSizeInput("kcr")%>
            <font class="ed_izm">см</font>
        </td>
        <td class="simple_str" width="13%">КСО
        </td>
        <td width="16%"> 
            <%=r.getHidden("kco")%>
            <font class="ed_izm">мл</font>
        </td>
        <td width="12%">МО
        </td>
        <td width="18%">
            <%=r.getHidden("mo")%>
            <font class="ed_izm">л/мин</font>
        </td>
    </tr>
    <tr> 
        <td class="simple_str" width="22%">МЖП (диаст.)
        </td>
        <td colspan="6"> 
            <%=r.getSizeInput("mpj")%>
            <span class="ed_izm">см</span>
        </td>
    </tr>
    <tr> 
        <td class="simple_str" width="22%">Задняя стенка ЛЖ (диаст.)
        </td>
        <td colspan="6"> 
            <%=r.getSizeInput("zs_lj")%>
            <font class="ed_izm">см</font>
        </td>
    </tr>
</table>

<table width="90%" border="1">
    <tr> 
        <td width="25%" class="bold_str">Правое предсердие
        </td>
        <td width="75%"> 
            <%=r.getSizeInput("ppred1")%>*
            <%=r.getSizeInput("ppred2")%>
            <font class="ed_izm">см</font>
        </td>
    </tr>
    <tr> 
        <td width="25%" class="bold_str">Правый желудочек
        </td>
        <td width="75%"> 
            <%=r.getSizeInput("pjel")%>
            <font class="ed_izm">см</font>
        </td>
    </tr>
</table>

<table width="90%" border="1">
    <tr> 
        <td colspan="6" class="bold_str">Сократительная способность миокарда: 
            <%=r.getSelect("frakcija")%>
        </td>

    </tr>
        <tr> 
        <td width="7%">&nbsp;
        </td>
        <td class="simple_str" width="22%">Фракция выброса 
        </td>
        <td colspan="4"> 
            <%=r.getSizeInput("vibros")%>
            <font class="ed_izm">%</font>
        </td>
    </tr>
        <tr> 
        <td width="7%">&nbsp;
        </td>
        <td class="simple_str" width="22%">Фракция укорочения ЛЖ 
        </td>
        <td colspan="4"> 
            <%=r.getHidden("ykor")%>
            <font class="ed_izm">%</font>
        </td>
    </tr>
        <tr> 
            <td colspan="2" class="simple_str">Масса миокарда ЛЖ
            </td>
             <td colspan="4"> 
            <%=r.getHidden("massa_mk")%>
            <font class="ed_izm">г</font>
        </td>
    </tr>
    <tr> 
        <td colspan="2" class="simple_str">Фиброзное кольцо АК 
        </td>
        <td colspan="4"> 
            <%=r.getSizeInput("fk_ak")%>
            <span class="ed_izm">см</span>
        </td>
    </tr>
    <tr> 
        <td colspan="2" class="simple_str">Фиброзное кольцо МК
        </td>
        <td colspan="4"> 
            <%=r.getSizeInput("fk_mk")%>
            <font class="ed_izm">см</font>
        </td>
    </tr>
    <tr> 
        <td colspan="2" class="simple_str">Фиброзное кольцо ЛА
        </td>
        <td colspan="4"> 
            <%=r.getSizeInput("fk_la")%>
            <span class="ed_izm">см</span>
        </td>
    </tr>
    <tr> 
        <td colspan="2" class="simple_str">Фиброзное кольцо ТК
        </td>
        <td colspan="4"> 
            <%=r.getSizeInput("fk_tk")%>
            <font class="ed_izm">см</font>
        </td>
    </tr>
    <tr> 
        <td colspan="2" class="simple_str">Митральный клапан 
        </td>
        <td colspan="4">
            <%=r.getSelect("mitralnii")%>
            <%=r.getSizeInput("mit_klap")%>
            <span class="ed_izm">мм </span>
        </td>
    </tr>
    <tr> 
        <td colspan="2" class="simple_str">Движение створок
        </td>
        <td colspan="4"> 
            <%=r.getSelect("dvizenie")%>
            <%=r.getTextInput("dvizenie_text")%>
        </td>
    </tr>
    <tr> 
        <td colspan="2" class="simple_str">Размеры митрального отверстия 
        </td>
        <td colspan="4"> 
            <%=r.getSizeInput("rmo1")%>
            <font class="simple_str">*</font> 
            <%=r.getSizeInput("rmo2")%>             
            <font class="ed_izm">см</font>
        </td>
    </tr>
    <tr> 
        <td colspan="5" class="simple_str">Площадь митрального отверстия (планиметрически) 
        </td>
        <td width="41%"> 
            <%=r.getSizeInput("pl_mo")%>
            <font class="ed_izm">см2</font>
        </td>
    </tr>
    <tr> 
        <td colspan="2" class="simple_str">Аортальный клапан
        </td>
        <td colspan="4"> 
            <%=r.getSelect("aortalnii")%>
        </td>
    </tr>
    <tr> 
        <td colspan="2" class="simple_str">Зоны гипокинеза
        </td>
        <td colspan="4"> 
            <%=r.getSelect("zoniy")%> 
            <%=r.getSelect("gipokinez")%>
        </td>
    </tr>
    <tr>
        <td colspan="2" class="simple_str">Септальные дефекты
        </td>
        <td colspan="4"> 
            <%=r.getSelect("defect")%> 
            <%=r.getSelect("sept")%> 
            <%=r.getTextInput("sept_how")%>
        </td>
    </tr>
    <tr> 
        <td colspan="2" class="simple_str">Листки перикарда
        </td>
        <td colspan="4"> 
            <%=r.getSelect("listki")%>
            <font class="simple_str">до</font> 
            <%=r.getSizeInput("listki_do")%>
            <font class="ed_izm">мм</font>
        </td>
    </tr>
    <tr> 
        <td colspan="6" class="simple_str">Эхосвободное пространство 
            <%=r.getSelect("sneg")%> до 
            <%=r.getSizeInput("prostranstvo")%>
            <font class="ed_izm">мм </font> 
            <font class="simple_str">в диастолу</font>
        </td>
    </tr>
    <tr>
        <td colspan="6"> 
            <%=r.getCheckbox("chhorda")%>
            <%=r.getSelect("horda")%>
            <font class="simple_str">отделе</font> 
        </td>
    </tr>
    <tr> 
        <td colspan="6" class="bold_str">Допплерометрия:
            <%=r.getSelect("doplero")%>
            <%=r.getSelect("trans")%>
        </td>
    </tr>
    <tr>
        <td colspan="2" class="simple_str">Скорость сист. аортального потока
        </td>
        <td colspan="4">
            <%=r.getSizeInput("ssap")%>
            <span class="simple_str">м/с</span>
            ГД=<%=r.getHidden("ssap_gd")%>
            <span class="ed_izm">мм рт.ст.</span>
        </td>
    </tr>
    <tr> 
        <td colspan="2" class="simple_str">Скорость сист. пульмонального потока
        </td>
        <td colspan="4"> 
            <%=r.getSizeInput("sspp")%>
            <span class="simple_str">м/с</span>
            ГД=<%=r.getHidden("sspp_gd")%>
            <span class="ed_izm">мм рт.ст.</span>
        </td>
    </tr>
    <tr> 
        <td colspan="2" class="simple_str">Скорость диаст. митрального потока
        </td>
        <td colspan="4"> 
            E = <%=r.getSizeInput("sdmp_e")%>
            <span class="simple_str">м/с</span> 
            A = <%=r.getSizeInput("sdmp_a")%>
            <span class="simple_str">м/с</span> 
            ГД=<%=r.getHidden("sdmp_gd")%>
            <span class="ed_izm"> мм рт.ст.</span>
            E/A=<%=r.getHidden("sdmp_ea")%>
            <span class="ed_izm"></span>
        </td>
    </tr>
    <tr> 
        <td colspan="2" class="simple_str">Скорость шунтируемого потока
        </td>
        <td colspan="4"> 
            <%=r.getSizeInput("sshp")%>
            <span class="simple_str">м/с</span>
            ГД=<%=r.getHidden("sshp_gd")%>
            <span class="ed_izm">мм рт.ст.</span>
        </td>
    </tr>
</table>

<table width="90%" border="1">
    <tr>
        <td>
            <%=r.getCheckbox("chrhmk_pr")%>
            <%=r.getSelect("rhmk_pr")%>
            <br>
            <span class="simple_str">при цветном картировании площадь регургитации занимает </span>
            <%=r.getSelect("rhmkp_pr")%>
            <span class="simple_str">площади предсердия</span> <br>
            <%=r.getCheckbox("chrhmk_int")%>
            <%=r.getSelect("rhmk_int")%>
            <br>
            <span class="simple_str">при цветном картировании площадь струи регургитации составляет </span>
            <%=r.getSizeInput("rhmkp_int")%>см2<br>

            <%=r.getCheckbox("chrhak")%>
            <%=r.getSelect("rhak")%>
            <br>
            <%=r.getCheckbox("chrhtk_pr")%>
            <%=r.getSelect("rhtk_pr")%>
            <br>
            <span class="simple_str">при цветном картировании площадь регургитации занимает</span> 
            <%=r.getSelect("rhtkp_pr")%>
            <span class="simple_str">площади предсердия </span>
            <br>
            <%=r.getCheckbox("chrhtk_int")%>
            <%=r.getSelect("rhtk_int")%>
            <br>
            <span class="simple_str">при цветном картировании площадь струи регургитации составляет</span> 
            <%=r.getSizeInput("rhtkp_int")%>см2
            <br>
            <%=r.getCheckbox("chrhkla")%>
            <%=r.getSelect("rhkla")%>
            <br>
        </td>
    </tr>
</table>

<Script LANGUAGE="JavaScript">
  document.protocol.kdr.onchange = ExecutKdo
  document.protocol.kcr.onchange = ExecutKco
  document.protocol.mpj.onchange = ExecutMpj
  document.protocol.zs_lj.onchange = ExecutZs
  document.protocol.ssap.onchange = ExecutSsap
  document.protocol.sspp.onchange = ExecutSspp
  document.protocol.sdmp_e.onchange = ExecutSdmp
  document.protocol.sdmp_a.onchange = ExecutSdmp
  document.protocol.sshp.onchange = ExecutSshp
  document.protocol.chss.onchange = ExecutChss
  document.protocol.kdo.onfocus = tab
  document.protocol.yo.onfocus = tab
  document.protocol.kco.onfocus = tab
  document.protocol.mo.onfocus = tab
  document.protocol.ykor.onfocus = tab
  document.protocol.massa_mk.onfocus = tab  
  document.protocol.ssap_gd.onfocus = tab  
  document.protocol.sspp_gd.onfocus = tab  
  document.protocol.sdmp_gd.onfocus = tab  
  document.protocol.sdmp_ea.onfocus = tab  
  document.protocol.sshp_gd.onfocus = tab  

  function tab(){
    tabNext(this);      
  }
  function ExecutChss(){
    StrToFloat(document.protocol.chss);
    var kdo = parseFloat(document.protocol.kdo.value);
    var kco = parseFloat(document.protocol.kco.value);
    var chss = parseFloat(document.protocol.chss.value);
    if(!isNumeric(document.protocol.chss.value, 'задано неверно') && !isBlank(document.protocol.chss.value)) {
        document.protocol.chss.value = "";
        document.protocol.mo.value = "";
        document.protocol.chss.focus();
    }
      else if (document.protocol.kdo.value!="" && document.protocol.kco.value!="") {
                val = Math.round((((kdo - kco)*chss)/1000)*100);
                val = val/100; 
                document.protocol.mo.value = val;
           } else NullKdr();
  }

  function ExecutKdo(){
    StrToFloat(document.protocol.kdr);
    var kdr = parseFloat(document.protocol.kdr.value);
    if(!isNumeric(document.protocol.kdr.value, 'задано неверно') && !isBlank(document.protocol.kdr.value)) {
        NullKdr();
    }
      else if (document.protocol.kdr.value!="") {
                val = Math.round(((7/(2.4 + kdr))*(kdr*kdr*kdr))*100);
                val = val/100 
                document.protocol.kdo.value = val;
                if (document.protocol.kdo.value != "" && document.protocol.kco.value != "") Exect();
                if (document.protocol.mpj.value!="" && document.protocol.kdr.value!="" && document.protocol.zs_lj.value!="") massa();
           } else NullKdr();
  }
  function ExecutKco(){
    StrToFloat(document.protocol.kcr);
    var kcr = parseFloat(document.protocol.kcr.value);
    if(!isNumeric(document.protocol.kcr.value, 'задано неверно') && !isBlank(document.protocol.kcr.value)) {
        NullKcr();
    }
      else if (document.protocol.kcr.value!="") {
                val = Math.round(((7/(2.4 + kcr))*(kcr*kcr*kcr))*100);
                val = val/100 
                document.protocol.kco.value = val;
                if (document.protocol.kdo.value != "" && document.protocol.kco.value != "") Exect();
           } else NullKcr();
  }
  function Exect(){
        kdo = parseFloat(document.protocol.kdo.value);
        kco = parseFloat(document.protocol.kco.value);
        yo = kdo - kco;
        if(document.protocol.chss.value != "") ExecutChss();
        val = Math.round(yo*100);
        val = val/100 
        document.protocol.yo.value = val;
        frakciy();
        frakciy_ykor();
  }
  function NullKcr(KcrOrKdr){
        document.protocol.kcr.value = ""; 
        document.protocol.kco.value=""; 
        document.protocol.yo.value="";
        document.protocol.ykor.value = "";
        document.protocol.vibros.value = "";

  }
  function NullKdr(){
        document.protocol.kdr.value = ""; 
        document.protocol.kdo.value="";  
        document.protocol.yo.value="";
        document.protocol.vibros.value = "";
        document.protocol.ykor.value = "";
        document.protocol.massa_mk.value = ""
  }
  function frakciy(){
     yo = parseFloat(document.protocol.yo.value);
     kdo = parseFloat(document.protocol.kdo.value);
    val = Math.round(((yo/kdo)*100)*100);
    val = val/100 
     document.protocol.vibros.value = val;
  }
  function frakciy_ykor(){
     kdr = parseFloat(document.protocol.kdr.value);
     kcr = parseFloat(document.protocol.kcr.value);
    val = Math.round((((kdr - kcr)/kdr)*100)*100);
    val = val/100 
     document.protocol.ykor.value = val;
  }
  function ExecutMpj(){
    StrToFloat(document.protocol.mpj);
    if(!isNumeric(document.protocol.mpj.value, 'задано неверно')) {document.protocol.mpj.value = ""; document.protocol.massa_mk.value="";}
      else if (!isBlank(document.protocol.mpj.value) && !isBlank(document.protocol.kdr.value) && !isBlank(document.protocol.zs_lj.value)) {
            massa();
           } else document.protocol.massa_mk.value = "";
  }
  function ExecutZs(){
    StrToFloat(document.protocol.zs_lj);
    if(!isNumeric(document.protocol.zs_lj.value, 'задано неверно')) {document.protocol.zs_lj.value = ""; document.protocol.massa_mk.value=""; return;}
      else if (!isBlank(document.protocol.mpj.value) && !isBlank(document.protocol.kdr.value) && !isBlank(document.protocol.zs_lj.value)) {
            massa();
           } else document.protocol.massa_mk.value = "";
  }

  function massa(){
     var kdr = parseFloat(document.protocol.kdr.value);
     var zs = parseFloat(document.protocol.zs_lj.value);
     var mjp = parseFloat(document.protocol.mpj.value);
     massa_miok = 1.04*((kdr + zs + mjp)*(kdr + zs + mjp)*(kdr + zs + mjp) - kdr*kdr*kdr) - 13.6;   
    val = Math.round(massa_miok*100);
    val = val/100 
     document.protocol.massa_mk.value = val;
  }

  function ExecutSsap(){
    StrToFloat(document.protocol.ssap);
    speed = parseFloat(document.protocol.ssap.value);
    if(isBlank(document.protocol.ssap.value)) {
        document.protocol.ssap_gd.value = ""; 
        return;
    }
    if(!isNumeric(document.protocol.ssap.value, 'задано неверно')) {
        document.protocol.ssap.value = ""; 
        document.protocol.ssap_gd.value = ""; 
        return;
    }
    val = Math.round((4*speed*speed)*100);
    val = val/100 
    document.protocol.ssap_gd.value = val;
  }
  function ExecutSspp(){
    StrToFloat(document.protocol.sspp);
    speed = parseFloat(document.protocol.sspp.value);
    if(isBlank(document.protocol.sspp.value)) {
        document.protocol.sspp_gd.value = ""; 
        return;
    }
    if(!isNumeric(document.protocol.sspp.value, 'задано неверно')) {
        document.protocol.sspp.value = ""; 
        document.protocol.sspp_gd.value = ""; 
        return;
    }
    val = Math.round((4*speed*speed)*100);
    val = val/100 
    document.protocol.sspp_gd.value = val;
  }
  
  function ExecutSdmp(){
    StrToFloat(document.protocol.sdmp_e);
    StrToFloat(document.protocol.sdmp_a);
    e = parseFloat(document.protocol.sdmp_e.value);
    a = parseFloat(document.protocol.sdmp_a.value);
    if(isBlank(document.protocol.sdmp_e.value)) {document.protocol.sdmp_gd.value = ""; return;}
    if(!isNumeric(document.protocol.sdmp_e.value, 'E задано неверно')) {document.protocol.sdmp_e.value = ""; document.protocol.sdmp_gd.value = ""; return;}
    if(!isBlank(document.protocol.sdmp_a.value) && !isNumeric(document.protocol.sdmp_a.value, 'A задано неверно')) {document.protocol.sdmp_a.value = ""; document.protocol.sdmp_gd.value = "";}
      if (!isBlank(document.protocol.sdmp_a.value) && !isBlank(document.protocol.sdmp_e.value)) {
                if(a==0) e_a = 0; else e_a = (Math.round((e/a)*100))/100;
                document.protocol.sdmp_ea.value = e_a;
                val = Math.round((4*e*e)*100);
                val = val/100;
                document.protocol.sdmp_gd.value = val;
           } else if (isBlank(document.protocol.sdmp_a.value) && !isBlank(document.protocol.sdmp_e.value)) {
                val = Math.round((4*e*e)*100);
                val = val/100;
                document.protocol.sdmp_gd.value = val;
           } else document.protocol.sdmp_gd.value = "";
  }
  function ExecutSshp(){
    StrToFloat(document.protocol.sshp);
    speed = parseFloat(document.protocol.sshp.value);
    if(isBlank(document.protocol.sshp.value)) {
        document.protocol.sshp_gd.value = ""; 
        return;
    }
    if(!isNumeric(document.protocol.sshp.value, 'задано неверно')) {
        document.protocol.sshp.value = ""; 
        document.protocol.sshp_gd.value = ""; 
        return;
    }
    val = Math.round((4*speed*speed)*100);
    val = val/100 
    document.protocol.sshp_gd.value = val;
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
</Script>

<%@include file="footer.jsp"%>
