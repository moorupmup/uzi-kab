var WAITMESSAGE = "Ждите...";
var LEVELDOWN   = "Enter - переход ниже на 1 уровень. Пробел - пометить/снять пометку";
var SELECTKEY   = "Enter - выбор. Пробел - пометить/снять пометку";
var LEVELUP = "Enter - переход выше на 1 уровень";
var count = 0;
var i = 0;
var vstav = 0;
var pometka = ["","","","","","","","","",""];
var otm = 0;
var stek = ["","","","","","","","","","","","","","","","","","","",""];
var printRow = "";

String.prototype.trim = function() {
 return this.replace(/(^\s+)/g, "").replace(/\s+$/g, "");
}



function ReferenceList() {
 this.show      = show;
 this.request       = request;
 this.setLevelId    = setLevelId;
 this.getLevelId    = getLevelId; 
 this.getListHolder = getListHolder;
 this.setListHolder = setListHolder;
 this.getEditElement    = getEditElement;
 this.setEditElement    = setEditElement;
 this.getServer     = getServer;
 this.setServer     = setServer;
 this.processData   = processData;
 this.done      = done;
 this.setData       = setData;
 this.getData       = getData;
 this.setBookMode       = setBookMode;
 this.getBookMode       = getBookMode;
 this.getRow        = getRow;
 this.getRowIndex   = getRowIndex;
 this.setRowIndex   = setRowIndex;
 this.open      = open;
 this.close     = close;
 this.headerIndexOf = headerIndexOf;
 this.init      = init;
 this.setKeyField   = setKeyField;
 this.getKeyField   = getKeyField;
 this.setTopLevel   = setTopLevel;
 this.getTopLevel   = getTopLevel;
 this.mark       = mark;
 this.nullStek  = nullStek;

 function setTopLevel(newLevel) {
  this.toplevel = newLevel;
 }

 function getTopLevel() {
  return this.toplevel;
 }

 function setKeyField(newField) {
  this.keyfield = newField;
 }

 function getKeyField() {
  return this.keyfield;
 }

 function init(win,newLevel) {
  this.win = win;

  with(this) 
   with(win.document) {
    setData(null);

    setServer(getElementById("server"));
    setListHolder(getElementById("listholder"));
    getListHolder().owner = this;
    setRequestParam(newLevel?"level":null);
    setLevelId(newLevel);
    show("");

    request();
   }
 }

 function mark(row) {
   for(i=0;i<=stek.length;i++)
   {
     if((row == stek[i]) && (row != "")) {return i;}
     }
   return -1;
 }

 function nullStek() {
   for(var i=0; i<stek.length; i++) stek[i] = "";
   printRow = "";
   count = 0;
 }
 /**
  * Returns a column index by name
  *
  * @param String name
  * @return int i
  */
 function headerIndexOf(name) {
  var header    = ["id","name","key_name","level_id","position","status_hidden","status_root","value"];

  for(var i=0; i<header.length; i++)
   if(header[i].trim()==name.trim())
    return i;

  return -1;
 }

 /**
  * Opens a dialog window to select value from reference
  * and returns a selected value
  *
  */
 function open(newLevel) {
  this.setTopLevel(newLevel);
   nullStek();
  if(document.all)
   window.showModalDialog("http://srv-uzi:8080/uzi/reference.html",{owner:this,level:newLevel},"dialogWidth=750px;dialogHeight=400px;status=no");
  else
   alert("Use an IE5+");
 }

 /**
  * Sets a request parameter
  *
  * @param String newParam
  */
 function setRequestParam(newParam) {
  this.requestParam = newParam;
 }

 /**
  * Returns a request parameter
  *
  * @return String requestParam
  */
 function getRequestParam() {
  return this.requestParam;
 }

 /**
  * Sets a data received from server
  *
  * @param String[][] newData
  */
 function setData(newData) {
  this.data = newData;
 }

 /**
  * Returns a data received from server
  *
  * @return String[][] data
  */
 function getData() {
  return this.data;
 }

  /**
  * Sets a data received from server
  *
  * @param String[][] newData
  */
 function setBookMode(bookMode) {
  this.bookMode = bookMode;
 }

 /**
  * Returns a data received from server
  *
  * @return String[][] data
  */
 function getBookMode() {
  return this.bookMode;
 }


 /**
  * Sets a current index of row
  *
  * @param int newIndex
  */
 function setRowIndex(newIndex) {
  this.rowIndex = newIndex;
 }

 /**
  * Returns a current index of row
  *
  * @return int rowIndex
  */
 function getRowIndex() {
  return this.rowIndex;
 }

 /**
  * Returns a current row
  *
  * @return String[] row
  */
 function getRow(index) {
  var result = null;
  try {
   result = this.getData()[index || this.getRowIndex()];
  }
  catch(e) {}
  return result;
 }

 function processData(newData) {

  with(this) {

   if(newData && newData.length && newData[0]); else return;
   setData(newData);

   var j = this.headerIndexOf("name");
   var k = this.headerIndexOf("status_root");

   if(j==-1 || k==-1) return;

   var sb = [];

   sb[sb.length] = "<option selected>" + (getRow(1) && getRow(1)[this.headerIndexOf("level_id")]!=getTopLevel()? "..":"") + "</option>";

   for(var i=1; i<getData().length; i++)
     if (mark(getRow(i)[0])!=-1) {
        sb[sb.length] = "<option selected>" + getRow(i)[j] + (getRow(i)[k]=="1"?"...+++":"+++") + "</option>";
     }else {sb[sb.length] = "<option>" + getRow(i)[j] + (getRow(i)[k]=="1"?" ...":"") + "</option>";}
   show(sb.join(""));
   with(getListHolder().firstChild) {
    focus();

    selectedIndex = 0;
    onchange();
   }
  }
 }


 /**
  * Sets a server frame
  *
  * @param Object newServer
  */
 function setServer(newServer) {
  this.server = newServer;
 }

 /**
  * Returns a server frame
  *
  * @param Object newServer
  */
 function getServer() {
  return this.server;
 }


 /**
  * Returns a edit text element
  *
  * @return Object editelement
  */
 function getEditElement() {
  return this.editelement;
 }

 /**
  * Sets a edit text element
  *
  * @param Object newElement
  */
 function setEditElement(newElement) {
  this.editelement = newElement;
 }

 /**
  * Sets a level's id
  *
  * @param String newId
  */
 function setLevelId(newId) {
  this.levelId = newId;
 }

 /**
  * Returns a level's id
  *
  * @return String id
  */
 function getLevelId() {
  return this.levelId;
 }

 /**
  * Returns a list holder
  *
  * @return Object listholder
  */
 function getListHolder() { 
  return this.listholder;
 }

 /**
  * Sets a list holder
  *
  * @param Object listholder
  */
 function setListHolder(newHolder) { 
  this.listholder = newHolder;
 }

 /**
  * Out puts a list to a list holder
  *
  * @param String newOptions
  */
 function show(newOptions) {
  with(this.getListHolder()) {

   var w = offsetWidth-2;

   innerHTML = "<select multiple size=\"18\" style=\"width:" + w + "\">" + newOptions + "</select>";

   firstChild.onkeyup = function(e) {

    with(this.parentNode) {
     var keyCode = owner.win.document.all? owner.win.event.keyCode : e.which;
     switch(keyCode) {
      case 13: vstav = 0; owner.done();  break;
      case 27: owner.close(); break;
      case 32: vstav = 1; owner.done(); break;
     }
    }
   }

   firstChild.onchange= function() {

    with(this.parentNode.owner) {
     setRowIndex(this.selectedIndex);
     var showstr;

     var colIndex = headerIndexOf("status_root");

     win.document.getElementById("statusBar").innerHTML = getRowIndex()>0 && getRow()[headerIndexOf("status_root")]!="1"? printRow: getRowIndex()>0? printRow: this.options[this.selectedIndex].innerHTML!=""? printRow: "";
     var levelDown = getRowIndex()>0;

try {
      setLevelId(levelDown? getRow()[headerIndexOf("id")] : getRow(1)[headerIndexOf("level_id")]);
} catch(e) {alert("Справочник пуст.");}

     setRequestParam(levelDown?"level":"levelup");
    }
   }
  }
 }

 /**
  * Does a closing dialog window
  *
  */
 function close() {
  var w = this.win;
  this.win = null;
  this.getListHolder().owner = null;
  this.setEditElement(null);
  this.setKeyField(null);
  this.setServer(null);
  w.close();
 }

 function done() {
  with(this)   
   if(getRowIndex()>0 && getRow()[headerIndexOf("status_root")]!="1") {
     if(getBookMode() == 0){ 
        getEditElement().value = getRow()[headerIndexOf("name")];
        if(getKeyField())
            getKeyField().value = getRow()[headerIndexOf("id")];
     } else {
        if(getBookMode() == 1){ 
          getEditElement().value += getRow()[headerIndexOf("name")];
          getEditElement().value += " ";
        }
            
        if(getBookMode() == 2){
          stek[count] = getRow()[headerIndexOf("name")];
          out = true;
          for(var i = 0; i < stek.length; i++){
            if (out && stek[i] != "") {getEditElement().value += stek[i];
                getEditElement().value += " ";out = false;}
                else out = true;
          }
          nullStek();
          count = 0;
        }
      }
     close();
   }
   else {
     if(getRowIndex()>0){
              if (mark(getRow()[headerIndexOf("id")])!=-1){
                cr = mark(getRow()[0]);
                stek[cr] = "";
                stek[cr-1] = "";
              } else {
                stek[count] = getRow()[headerIndexOf("name")];
                count++;
                stek[count] = getRow()[headerIndexOf("id")];
                count++;
              }
     }
     if (mark(getRow()[headerIndexOf("id")])==-1 && getBookMode() == 0){
        stek[count] = "";
        stek[count-1] = "";
        stek[count-2] = "";
        count = count - 2;
     }
     out = true;
     printRow = "";
     for(var i = 0; i < stek.length; i++){
       if (out && stek[i] != "") 
       {
            printRow += stek[i];
            printRow += " ";out = false;
       } else out = true;
     }
     if (getRow()[headerIndexOf("status_root")]!="1" && getRow(1)[this.headerIndexOf("level_id")]!=getTopLevel()){
     }
     if(getRowIndex()>0 || getRow(1)[this.headerIndexOf("level_id")]!=getTopLevel()){
       if (vstav == 0) {request();}
       if (vstav == 1) {if (stek[count-2]!="") {stek[count-2] +=",";} setLevelId(getRow(1)[headerIndexOf("level_id")]);request();}
     }
   }
 }

 /**
  * Requests a data from server
  *
  */
 function request() {
   with(this) {
     var requestStr = "http://srv-uzi:8080/uzi/reference.jsp" + (getRequestParam() && getLevelId()? "?" + getRequestParam() + "=" + getLevelId() : "");
     getServer().src = requestStr;
   }
 }

}
