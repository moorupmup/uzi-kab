<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title">Протокол скринингового УЗИ в 11-14 недель беременности </H3>



<table width="90%" border="1">
    <tr> 
        <td class="simple_str" width="35%">1-й день последней менструации
        </td>
        <td colspan="2">
            <%=r.getTextInput("last_mens")%>
            <SCRIPT LANGUAGE="JavaScript">
                document.protocol.last_mens.focus();
                document.protocol.last_mens.onkeyup = point
                function point(){
                    checkDate("document.protocol.last_mens");
                }
            </script>
        </td>
    </tr>
    <tr> 
        <td class="simple_str" width="35%">Срок беременности
        </td>
        <td colspan="2"> 
            <%=r.getSizeInput("srok_ber")%>  
            <font class="simple_str">нед.</font>
            <%=r.getSizeInput("srok_ber_day")%>
            <font class="simple_str">дн.</font>
        </td>
    </tr>
    <tr> 
        <td class="simple_str" width="35%">Предполагаемая дата родов
        </td>
        <td colspan="2"> 
            <%=r.getTextInput("eeeee")%> 
        </td>
    </tr>
    <tr>
        <td>Вид исследования</td>
        <td colspan="2">
            <%=r.getSelect("vid_iss")%>
        </td>
    </tr>
    <tr>
        <td colspan="3">
            В полости матки <%=r.getSelect("vizual")%> <%=r.getSizeInput("kol_plod")%> <%=r.getSelect("plod")%>
        </td>
    </tr>
    <tr>
        <td colspan="3">
            Копчико-теменной размер плода <%=r.getSizeInput("kop_tem_size")%> мм, 
            <%=r.getSelect("kop_tem_soot")%> менструальному сроку беременности <%=r.getTextInput("kop_tem_text")%>
        </td>
    </tr>
    <tr> 
        <td class="simple_str" width="35%">Частота сердечных сокращений плода
        </td>
        <td colspan="2"> 
            <%=r.getSizeInput("chss")%> уд./мин 
        </td>
    </tr>
    <tr> 
        <td class="simple_str" width="35%">Толщина воротникового пространства плода
        </td>
        <td colspan="2"> 
            <%=r.getSizeInput("tol_vor_pr")%> мм 
        </td>
    </tr>
    <tr> 
        <td class="simple_str" width="35%">Кости носа: <%=r.getSelect("kosti_viz")%>
        </td>
        <td colspan="2"> 
            длина <%=r.getSizeInput("kosti_size")%> мм 
        </td>
    </tr>
    <tr>
        <td colspan="3">
            <b>АНАТОМИЯ ПЛОДА</b>:
        </td>
    </tr>
    <tr>
        <td>Кости свода черепа</td>
        <td colspan="2">
            <%=r.getSelect("kosti_ch")%> <%=r.getTextInput("kosti_ch_text")%>
        </td>
    </tr>
    <tr>
        <td>Головной мозг</td>
        <td colspan="2">
            <%=r.getSelect("mozg")%> <%=r.getTextInput("mozg_text")%>
        </td>
    </tr>
    <tr>
        <td>Позвоночник</td>
        <td colspan="2">
            <%=r.getSelect("pozv")%> <%=r.getTextInput("pozv_text")%>
        </td>
    </tr>
    <tr>
        <td>Сердце</td>
        <td colspan="2">
            <%=r.getSelect("serdz")%> <%=r.getTextInput("serdz_text")%>
        </td>
    </tr>
    <tr>
        <td>Желудок</td>
        <td colspan="2">
            <%=r.getSelect("jelud")%> <%=r.getTextInput("jelud_text")%>
        </td>
    </tr>
    <tr>
        <td>Передняя брюшная стенка</td>
        <td colspan="2">
            <%=r.getSelect("brush")%> <%=r.getTextInput("brush_text")%>
        </td>
    </tr>
    <tr>
        <td>Мочевой пузызь и почки</td>
        <td colspan="2">
            <%=r.getSelect("mochev")%> <%=r.getTextInput("mochev_text")%>
        </td>
    </tr>
    <tr>
        <td>Конечности</td>
        <td colspan="2">
            <%=r.getSelect("konech")%> <%=r.getTextInput("konech_text")%>
        </td>
    </tr>
    <tr>
        <td>Желточный мешок</td>
        <td colspan="2">
            <%=r.getSelect("meshok")%>
        </td>
    </tr>
    <tr> 
        <td class="simple_str" width="35%">Средний внутренний диаметр желточного мешка
        </td>
        <td colspan="2"> 
            <%=r.getSizeInput("dia_jel_size")%> мм 
        </td>
    </tr>
    <tr>
        <td>Преимущественная локализация хориона:</td>
        <td colspan="2">
            <%=r.getSelect("lok_hori")%>
        </td>
    </tr>
    <tr>
        <td>Структура хориона</td>
        <td colspan="2">
            <%=r.getSelect("str_hori")%> <%=r.getTextInput("str_hori_text")%>
        </td>
    </tr>
    <tr>
        <td>Придатки матки</td>
        <td colspan="2">
            <%=r.getSelect("prid_mat")%> <%=r.getTextInput("prid_mat_text")%>
        </td>
    </tr>
    <tr>
        <td>Строение стенок матки</td>
        <td colspan="2">
            <%=r.getSelect("sten_mat")%> <%=r.getTextInput("sten_mat_text")%>
        </td>
    </tr>
    <tr>
        <td>Визуализация:</td>
        <td colspan="2">
            <%=r.getSelect("vizual")%> <%=r.getTextInput("vizual_text")%>
        </td>
    </tr>
    <tr>
        <td colspan="3">Особенности:
        </td>
    </tr>
    <tr>
        <td colspan="3"><%=r.get("osob")%>
        </td>
    </tr>
    <tr>
        <td>Кровоток в венозном протоке</td>
        <td colspan="2">
            <%=r.getSelect("krovot")%>
        </td>
    </tr>
    <tr>
        <td>Трикуспидальная регургитация:</td>
        <td colspan="2">
            <%=r.getSelect("trikus")%> <%=r.getTextInput("trikus_text")%>
        </td>
    </tr>



</table>


<%@include file="footer.jsp"%>
