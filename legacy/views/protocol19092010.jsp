<%@page import="my_pack.tools.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file = "header.jsp"%>

<%for(int i = 1; i <= fileAry.length; i++){%>
    <%if(fileAry.length > 1){%><H2 align="center"><%=r.get("research_" + i)%></H2><%}%>
    <%String filename="";
    String countStr="";
    countStr = r.get("jpg_amount_" + i).toString();
    long kol = Long.parseLong(countStr);
    for(long val=1; val<=kol; val++){
        filename = "/uzi/img/" + r.get("protocol_id_" + i).toString() + "_img_" + Long.toString(val-1) + ".bmp";%>


        <img src="<%=filename%>" name="img<%=i%>" id="" style="float: right; all">
        <%if(kol>0){%><script>menu.img<%=i%>.id = "remove";</script><%}
    }%>
    <jsp:include page="<%=fileAry[i-1]%>" flush="true">
        <jsp:param name="count" value="<%=i%>"></jsp:param>
    </jsp:include>
    <%String dateEndStr;
    String dateEnd = "";
    dateEndStr = r.get("date_end_" + i).toString();
    array = dateEndStr.split("-");
    for(int count = array.length - 1; count >= 0; count--) if(count != 0) dateEnd += array[count] + "."; else dateEnd += array[count];
    %>
    <b>Дата исследования:</b> <%=dateEnd%>
    <b>Врач: </b><%=r.get("doctor_" + i)%><br>
    <%if(fileAry.length > 1){
        if(Long.parseLong(r.get("jpg_amount_" + i).toString()) > 0){%><input id="remove" type="checkbox" name="hidden_print<%=i%>" onClick="preparePrint(menu.hidden_print<%=i%>, menu.img<%=i%>);"><input id="remove" type="text" size="23" value="печатать изображение"><%}
        if(Long.parseLong(r.get("avi_amount_" + i).toString()) > 0){%><a id="remove" href="/uzi/img/<%=r.get("protocol_id_" + i).toString()%>_clip_0.avi">клип</a><%}
    }%>
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
    <input type="hidden" name="protocol_id" value="<%=r.get("protocol_id_1")%>">
    <input type="hidden" name="esc_close" value="<%=r.get("esc_close")%>">
    <input type="hidden" name="id_reg" value="<%=r.get("id_reg")%>">
    <table width="700" border="0">
        <tr>
            <td>
                <input id="remove" type="submit" value="Редактировать"  onClick="setAction('edit_protocol')">
                <%if(!r.empty("protocol_edit")){%>
                    <input id="remove" type="submit" value="Сохранить и напечатать" onClick="setAction('save_and_print_protocol');<%if(r.empty("esc_close")){%>window.print();<%}else{%>printProtocol();window.close();<%}%>submit();">
                    <%if(r.empty("esc_close")){%><input id="remove" type="submit" value="Отложить" onClick="setAction('choice_research');submit();"><%}%>
                <%}else{%>
                    <input id="remove" type="button" value="Печатать" onClick="printProtocol()">
                <%}%>
                <%if(Long.parseLong(r.get("jpg_amount_1").toString()) > 0){%>
                    <input id="remove" type="button" value="Удалить изображение" onClick="if(DeleteConfirm()){ setAction('delete_image'); submit();}">
                    <input id="remove" type="checkbox" name="hidden_print1" onClick="preparePrint(menu.hidden_print1, menu.img1);"><input id="remove" type="text" size="23" value="печатать изображение">
                <%}%>
                <%if(Long.parseLong(r.get("avi_amount_1").toString()) > 0){%><a id="remove" href="/uzi/img/<%=r.get("protocol_id_1").toString()%>_clip_0.avi">клип</a><%}%>
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
        if(eval(hidden).checked=="1") eval(img).id = ""; else eval(img).id = "remove";
        return true;
    }
  function printProtocol(){
    window.print();
    window.onfocus = close_protocol;
  }
  function close_protocol(){
    window.close();
  }
  function hiddenField(val, check)
  {
      field = eval(val);
      checkField = eval(check);
      if(checkField.checked=="1") field.display = ""; else field.display = "none";
      return true;
  }
</Script>
</form>
<%@include file="../footer.jsp"%>