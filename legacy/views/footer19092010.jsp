    <%if(!r.empty("addition")){%>
    <%if(r.empty("research_id") || !r.get("research_id").equals("2245")){%>
                    <br><b>Дополнительные признаки:</b>
                <%}%>
            <%=r.get("addition")%>
            <%}%>
            <br><b>Ультразвуковая картина характерна для:</b> <%=r.get("decision")%> <%=r.get("decision_text")%><br>
            <b>Дата исследования:</b> <%=formatter.format(r.get("date_end"))%><br>
            <b>Врач: </b><%=r.get("doctor")%><br>
</p>
<input type="hidden" name="action" value="">
<input type="hidden" name="protocol_id" value="<%=r.get("protocol_id")%>">
<input type="hidden" name="esc_close" value="<%=r.get("esc_close")%>">
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
            <%if(count>0){%>
                <input id="remove" type="button" value="Удалить изображение" onClick="if(DeleteConfirm()){ setAction('delete_image'); submit();}">
                <input id="remove" type="checkbox" name="hidden_print" onClick="preparePrint();"><input id="remove" type="text" size="23" value="печатать изображение">
            <%}%>
            <%if(count_avi > 0){%><a id="remove" href="/picture/<%=r.get("protocol_id").toString()%>_clip_0.avi">клип</a><%}%>
        </td>
    </tr>
</table>
<Script>

  function DeleteConfirm(){
  var yes = confirm("Вы действительно хотите удалить изображение?");
    if (yes) return true;
        else return false;
    }
    function preparePrint(){
        if(menu.hidden_print.checked=="1") menu.img.id = ""; else menu.img.id = "remove";
        return true;
    }
  function printProtocol(){
    window.print();
    window.onfocus = close_protocol;
  }
  function close_protocol(){
    window.close();
  }
</Script>
</form>
<%@include file="../footer.jsp"%>