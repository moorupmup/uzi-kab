<%@page import = "java.util.Date" import="my_pack.beans.*" import="my_pack.tools.* java.text.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title" align="center"><%=r.get("research")%></H3>


  <H3 class="p_title">Мазок на степень чистоты</H3>




<table width="100%" border="1">
    <tr><td width="25%"> Реакция отделяемого</td> 
        <td width="25%" colspan="1"> Уретры</td> 
        <td width="25%" colspan="1"> Шейки матки</td> 
        <td width="25%" colspan="1"> Вагины</td> 
    </tr>




    <tr><td width="25%"> Лейкоциты </td> 
        <td width="25%"> <%=r.getSizeInput("sistAD_o_sr")%></td> 
        <td width="25%"> <%=r.getSizeInput("sistAD_o_mi")%></td> 
        <td width="25%"> <%=r.getSizeInput("sistAD_o_ma")%></td> 
        
    </tr>
    <tr><td width="25%"> Эпителий</td> 
        <td width="25%"> <%=r.getTextInput("diastAD_o_sr")%></td> 
        <td width="25%"> <%=r.getTextInput("diastAD_o_mi")%></td> 
        <td width="25%"> <%=r.getTextInput("diastAD_o_ma")%></td> 
            </tr>

              
    <tr><td width="25%"> Слизь </td> 
        <td width="25%"> <%=r.getSizeInput("ivSAD_o_sr")%></td>
        <td width="25%"> <%=r.getSizeInput("ivSAD_o_mi")%></td>
        <td width="25%"> <%=r.getSizeInput("ivSAD_o_ma")%></td>
            </tr>



    <tr><td width="25%"> Эритроциты </td> 
        <td width="25%"> <%=r.getSizeInput("ivDAD_o_sr")%></td>
        <td width="25%"> <%=r.getSizeInput("ivDAD_o_mi")%></td>
        <td width="25%"> <%=r.getSizeInput("ivDAD_o_ma")%></td>
            </tr>

    <tr><td width="25%"> Гонококк Нейсера</td> 
        <td width="25%"> <%=r.getSelect("siSAD_o_sr")%></td>
        <td width="25%"> <%=r.getSelect("siSAD_o_mi")%></td>
        <td width="25%"> <%=r.getSelect("siSAD_o_ma")%></td>
            </tr>

   <tr><td width="25%"> Трихоманада</td> 
        <td width="25%"> <%=r.getSelect("trihoman_o")%></td>
        <td width="25%"> <%=r.getSelect("trihoman_a")%></td>
        <td width="25%"> <%=r.getSelect("trihoman_e")%></td>
            </tr>

   <tr><td width="25%"> Грам +/- коккобактерии </td> 
        <td width="75%" colspan="3"> <%=r.getSelect("rerere")%> <%=r.getTextInput("aaa")%>  </td>
            </tr>
                              

    
    <tr><td width="25%"> Кокки </td> 
        <td width="75%" colspan="3"> <%=r.getSelect("siDAD_sr")%> <%=r.getTextInput("bbb")%> </td>
            </tr>

     <tr><td width="25%"> Палочки </td> 
        <td width="75%" colspan="3"> <%=r.getSelect("palochki")%> <%=r.getTextInput("ccc")%>  </td>
            </tr>

     <tr><td width="25%"> Candida alb. </td> 
        <td width="75%" colspan="3"> <%=r.getSelect("kandidi")%> <%=r.getTextInput("ddd")%></td>
            </tr>


    <tr><td width="25%"> Степень чистоты </td> 
        <td width="75%" colspan="3"> <%=r.getSelect("stepen_chist")%></td>
            </tr>

   
      
       
</table>

<%=r.get("svobpole")%><br> 






Врач:<%=r.get("doctor_fio")%><br>
<input type="hidden" name="from_doctor_id" value="0">
<input type="hidden" name="decision" value="">
<input type="hidden" name="decision_id" value="2">
<input type="hidden" name="addition" value="">
<table width="100%" border="0">
    <tr>
        <td><input type="submit" value="Просмотр">
        <input type="button" value="Отмена" onClick="document.protocol.pacient_id.value = ''; setAction('choice_research'); submit();"></td></tr>
</table>
</form>
<%@include file="../footer.jsp"%>

