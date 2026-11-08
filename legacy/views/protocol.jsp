<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file = "header.jsp"%>

<%for(int i = 1; i <= fileAry.length; i++){%>
    <%if(fileAry.length > 1){%><H2 align="center"><%=r.get("research" + i)%></H2><%}%>
    <jsp:include page="<%=fileAry[i-1]%>" flush="true"/>
    <%if(!r.empty("addition" + i)){%>
        <br><b>Комментарии:</b> <%=r.get("addition" + i)%>
    <%}%>
    <br><b>Заключение:</b>УЗ признаки: <%=r.get("decision" + i)%> <%=r.get("decision_text" + i)%>
    <%String filename="";
    String countStr="";
    countStr = r.get("jpg_amount" + i).toString();
    long kol = Long.parseLong(countStr);
    if(kol > 0){%>
    </tr></td></table>
    <div id="img_display_<%=i%>" style="display:none;position:relative; left:12;">
    <%if(kol > 2){%>
        <DIV style="page-break-after:always">&nbsp;</DIV>
        <table width="700" cellpadding="0" cellspacing="0">
        <tr>
            <td colspan="3" align="center">
                <p style="line-height:15pt; font-size:100%; font-family: Arial Narrow; font-style:normal; font-weight:normal; font-size:14pt;" align="center">
                    МУЗ "Городской клинический перинатальный центр"<br>
                    Отделение лучевой и функциональной диагностики
                </p>
            </td>
        </tr>
        <tr>
            <td colspan="3" align="center" height="10" >
                <%if(s.indexOf('+') == -1){%><p style="font-size: 24px; font-family: Arial Narrow; font-style:normal; font-weight:normal;"><%=r.get("research")%></p><%}%>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="left">
                <p style="line-height:15pt; font-size:100%; font-family: Arial Narrow; font-style:normal; font-weight:normal;" align=justify>
                Пациент <b><%=r.get("fio")%></b><br>
                Дата рождения: <b><%=r.get("birthdate")%> г.</b>&nbsp;&nbsp;Пол: <b><%=(r.get("gender").equals("M") ? "М" : "Ж")%></b><br>
                Адрес: <b><%=r.get("city")%> <%=r.get("street")%> <%=r.get("house")%> <%=r.get("flat")%></b><br>
                </p>
            </td>
            <td align="left" valign="bottom" width="20%">&nbsp;</td>
        </tr>
        </table>

    <%}%>
    <%if(kol <= 2){%><br><br><br><%}%>
        <table width="700" cellpadding="0" cellspacing="0">
            <tr><td valign="top">
            <%for(long val=1; val<=kol; val++){
                filename = "p:/" + r.get("protocol_id" + i).toString() + "_img_" + Long.toString(val-1) + ".bmp";%>
                <img src="<%=filename%>" name="img_<%=val%>" id="" style="float: right; all; width: 225px; height: 225px">
            <%}%>
            </td></tr>
        </table>
  </div>
  <%}%>

  <%if(fileAry.length > 1){
      if(Long.parseLong(r.get("avi_amount" + i).toString()) > 0){%><a id="remove" href="/uzi/img/<%=r.get("protocol_id" + i).toString()%>_clip_0.avi">клип</a><%}
  }%>
    <br><br><b>Дата исследования:</b> <%=r.get("date_end" + i)%>
    <b>Врач: </b><%=r.get("doctor" + i)%><br>
<%}%>

<%if(fileAry.length > 1){%>
    <table width="700" border="0">
        <tr>
            <td>
                 <input id="remove" type="button" value="Печатать" onClick="printProtocol()">   
            </td>
        </tr>
    </table>
<%}%>
<%if(fileAry.length == 1){%>
    <input type="hidden" name="action" value="">
    <input type="hidden" name="protocol_id" value="<%=r.get("protocol_id")%>">
    <input type="hidden" name="esc_close" value="<%=r.get("esc_close")%>">
    <input type="hidden" name="id_reg" value="<%=r.get("id_reg")%>">
    <table width="700" border="0">
        <tr>
            <td>
                <input id="remove" type="submit" value="Редактировать"  onClick="setAction('edit_protocol')">
                <%if(!r.empty("protocol_edit")){%>
                    <input id="remove" type="submit" value="Сохранить и напечатать" onClick="setAction('save_and_print_protocol');<%if(r.empty("esc_close")){%>window.print();<%}else{%>printProtocol();window.close();<%}%>submit();">
                    <%if(r.empty("esc_close")){%><input id="remove" type="submit" value="Отложить" onClick="setAction('protocol');submit();"><%}%>
                <%}else{%>
                    <input id="remove" type="button" value="Печатать" onClick="printProtocol()">
                <%}%>
                <%if(Long.parseLong(r.get("jpg_amount1").toString()) > 0){%>
                    <!--input id="remove" type="button" value="Удалить изображение" onClick="if(DeleteConfirm()){ setAction('delete_image'); submit();}"-->
                    <input id="remove" name="img_button_1" type="button" value="изображение" onClick="hiddenFieldView('img_display_1', 'document.menu.img_button_1');">
                <%}%>
                <%if(Long.parseLong(r.get("avi_amount1").toString()) > 0){%><a id="remove" href="/uzi/img/<%=r.get("protocol_id1").toString()%>_clip_0.avi">клип</a><%}%>
            </td>
        </tr>
    </table>
<%}%>
<Script>
    function DeleteConfirm(){
    var yes = confirm("Вы действительно хотите удалить изображение?");
      if (yes) return true;
          else return false;
      }
      function preparePrint(hidden, img){
      <%
      long kol2 = Long.parseLong(r.get("jpg_amount1").toString());
      %>
      if(eval(hidden).checked=="1"){
              <%for(long val=1; val<=kol2; val++){%>
              menu.img_<%=val%>.id = "";
          <%}%>
          <%if(kol2 > 0){%>display.style.display = "";<%}%>
      }else{
          <%for(long val=1; val<=kol2; val++){%>
              menu.img_<%=val%>.id = "remove";
          <%}%>
          <%if(kol2 > 0){%>display.style.display = "none";<%}%>

      }

          return true;
      }
    function printProtocol(){
      window.print();
      window.onfocus = close_protocol;
    }
    function close_protocol(){
      window.close();
    }
    function hiddenFieldView(val, check)
    {
        field = eval(val);
        imgButton = eval(check);

        if(imgButton.style.border == "inset"){
            imgButton.style.border = "outset";
            field.style.display = "none";
        }else{
            imgButton.style.border = "inset";
            field.style.display = "block";
        }
        
        return true;
    }
</Script>
</form>
<%@include file="../footer.jsp"%>