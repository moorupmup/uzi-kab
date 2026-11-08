<%@page import = "java.util.Date" import="my_pack.beans.*" import="my_pack.tools.* java.text.*" contentType="text/html; charset=Windows-1251" errorPage="/jsp/error.jsp"%>
<%@include file="header.jsp"%>
<H3 class="p_title" align="center"><%=r.get("research")%></H3>


                              <H3 class="p_title">Мазок на степень чистоты</H3>

  <table width="90%" border="1">
    <tr><td><br><b><%=r.getCheckbox("mygh")%></b></td></tr>
  </table>

  
 <div id="display63" style="display:none;position:relative; left:0;">


<table width="100%" border="1">
    <tr><td width="25%"> Реакция отделяемого</td> 
        <td width="25%" colspan="1"> Уретры</td> 
        <td width="25%" colspan="1"> Шейки матки</td> 
        <td width="25%" colspan="1"> Вагины</td> 
    </tr>


    <tr><td width="25%"> Лейкоциты </td> 
        <td width="25%"> <%=r.getSizeInput("leiko_yr")%></td> 
        <td width="25%"> <%=r.getSizeInput("leiko_shei")%></td> 
        <td width="25%"> <%=r.getSizeInput("leiko_vag")%></td> 
        
    </tr>
    <tr><td width="25%"> Эпителий</td> 
        <td width="25%"> <%=r.getTextInput("epi_yr")%></td> 
        <td width="25%"> <%=r.getTextInput("epi_shei")%></td> 
        <td width="25%"> <%=r.getTextInput("epi_vag")%></td> 
            </tr>

              
    <tr><td width="25%"> Слизь </td> 
        <td width="25%"> <%=r.getSizeInput("sliz_yr")%></td>
        <td width="25%"> <%=r.getSizeInput("sliz_shei")%></td>
        <td width="25%"> <%=r.getSizeInput("sliz_vag")%></td>
            </tr>

    <tr><td width="25%"> Эритроциты </td> 
        <td width="25%"> <%=r.getSizeInput("eri_yr")%></td>
        <td width="25%"> <%=r.getSizeInput("eri_shei")%></td>
        <td width="25%"> <%=r.getSizeInput("eri_vag")%></td>
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
        <td width="75%" colspan="3"> <%=r.getSelect("rerere")%> <%=r.getTextInput("aaa11")%>  </td>
            </tr>
    
    <tr><td width="25%"> Кокки </td> 
        <td width="75%" colspan="3"> <%=r.getSelect("siDAD_sr")%> <%=r.getTextInput("bbb11")%> </td>
            </tr>

     <tr><td width="25%"> Палочки </td> 
        <td width="75%" colspan="3"> <%=r.getSelect("palochki")%> <%=r.getTextInput("ccc11")%>  </td>
            </tr>

     <tr><td width="25%"> Candida alb. </td> 
        <td width="75%" colspan="3"> <%=r.getSelect("kandidi")%> <%=r.getTextInput("ddd11")%></td>
            </tr>


    <tr><td width="25%"> Степень чистоты </td> 
        <td width="75%" colspan="3"> <%=r.getSelect("stepen_chist")%></td>
    </tr>
       
</table>

<%=r.get("svobpole")%><br> 

</div>



<div id="display100" style="display:none;position:relative; left:0;">


<table width="100%" border="1">
    <tr><td width="50%"> Реакция отделяемого</td> 
        <td width="50%" colspan="1"> Уретры</td> 
    </tr>

    <tr><td width="50%"> Лейкоциты </td> 
        <td width="50%"> <%=r.getSizeInput("lllll")%></td> 
    </tr>
   `
    <tr><td width="50%"> Эпителий </td> 
        <td width="50%"> <%=r.getTextInput("eputelii")%></td>
    </tr>
            
    <tr><td width="50%"> Слизь </td> 
        <td width="50%"> <%=r.getSizeInput("clizb")%></td>
    </tr>

      
   `      
    <tr><td width="50%"> Эритроциты </td> 
        <td width="50%"> <%=r.getSizeInput("eritrociti")%></td>
    </tr>

    <tr><td width="50%"> Гонококк Нейсера</td> 
        <td width="50%"> <%=r.getSelect("siSAD_o_sr2")%></td>
    </tr>

    <tr><td width="50%"> Трихоманада</td> 
        <td width="50%"> <%=r.getSelect("trihoman_o2")%></td>
    </tr>

    <tr><td width="50%"> Грам +/- коккобактерии </td> 
        <td width="50%" colspan="3"> <%=r.getSelect("rerere2")%> <%=r.getTextInput("aaaaa")%>  </td>
    </tr>
                              
    <tr><td width="50%"> Кокки </td> 
        <td width="50%" colspan="3"> <%=r.getSelect("kokki")%> <%=r.getTextInput("bbbbb")%> </td>
    </tr>

    <tr><td width="50%"> Палочки </td> 
        <td width="50%" colspan="3"> <%=r.getSelect("palochki2")%> <%=r.getTextInput("ccccc")%>  </td>
    </tr>

    <tr><td width="50%"> Candida alb. </td> 
        <td width="50%" colspan="3"> <%=r.getSelect("kandidi2")%> <%=r.getTextInput("ddddd")%></td>
    </tr>


    <tr><td width="50%"> Степень чистоты </td> 
        <td width="50%" colspan="3"> <%=r.getSelect("stepen_chist2")%></td>
    </tr>
       
</table>


<%=r.get("svobpole2")%><br> 

</div>

<SCRIPT LANGUAGE="JavaScript">
    changeHidden200();
    document.protocol.mygh.onclick  = changeHidden200
    function changeHidden200()
    {
        if(document.protocol.mygh.checked == true){
            display100.style.display = "";
            display63.style.display = "none";

        }else{
            display63.style.display = "";
            display100.style.display = "none";

       }
    }
</SCRIPT>




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

