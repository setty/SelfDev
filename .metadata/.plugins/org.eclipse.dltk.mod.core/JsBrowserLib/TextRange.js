/* @org.ebayopensource.dsf.resource.utils.CodeGen("VjoGenerator") */
vjo.ctype('TextRange') //< public
.inherits('Object')
.protos({
    htmlText:null, //< public String
    text:null, //< public String
    boundingWidth:0, //< public int
    boundingHeight:0, //< public int
    boundingLeft:0, //< public int
    boundingTop:0, //< public int
    offsetLeft:0, //< public int
    offsetTop:0, //< public int
    //> public void collapse()
    //> public void collapse(boolean start)
    collapse:function(){
    },
    //> public int compareEndPoints(String sType,TextRange oRange)
    compareEndPoints:function(sType,oRange){
    },
    //> public TextRange duplicate()
    duplicate:function(){
    },
    //> public boolean execCommand(String sCommand,boolean bUserInterface,Object vValue)
    //> public boolean execCommand(String sCommand,boolean bUserInterface)
    //> public boolean execCommand(String sCommand)
    execCommand:function(sCommand,bUserInterface,vValue){
    },
    //> public void execCommandShowHelp(String cmdID,Function pfRet)
    execCommandShowHelp:function(cmdID,pfRet){
    },
    //> public boolean expand(String sUnit)
    expand:function(sUnit){
    },
    //> public boolean findText(String sText,int iSearchScope,int iFlags)
    //> public boolean findText(String sText,int iSearchScope)
    //> public boolean findText(String sText)
    findText:function(sText,iSearchScope,iFlags){
    },
    //> public String getBookmark()
    getBookmark:function(){
    },
    //> public TextRectangle getBoundingClientRect()
    getBoundingClientRect:function(){
    },
    //> public TextRectangleList getClientRects()
    getClientRects:function(){
    },
    //> public boolean inRange(TextRange oRange)
    inRange:function(oRange){
    },
    //> public boolean isEqual(TextRange oRange)
    isEqual:function(oRange){
    },
    //> public int move(String sUnit,int iCount)
    //> public int move(String sUnit)
    move:function(sUnit,iCount){
    },
    //> public int moveEnd(String sUnit,int iCount)
    //> public int moveEnd(String sUnit)
    moveEnd:function(sUnit,iCount){
    },
    //> public int moveStart(String sUnit,int iCount)
    //> public int moveStart(String sUnit)
    moveStart:function(sUnit,iCount){
    },
    //> public boolean moveToBookmark(String sBookmark)
    moveToBookmark:function(sBookmark){
    },
    //> public void moveToElementText(HTMLElement oElement)
    moveToElementText:function(oElement){
    },
    //> public void moveToPoint(int iX,int iY)
    moveToPoint:function(iX,iY){
    },
    //> public HTMLElement parentElement()
    parentElement:function(){
    },
    //> public void pasteHTML(String sHTMLText)
    pasteHTML:function(sHTMLText){
    },
    //> public boolean queryCommandEnabled(String sCmdID)
    queryCommandEnabled:function(sCmdID){
    },
    //> public boolean queryCommandIndeterm(String sCmdID)
    queryCommandIndeterm:function(sCmdID){
    },
    //> public boolean queryCommandState(String sCmdID)
    queryCommandState:function(sCmdID){
    },
    //> public boolean queryCommandSupported(String sCmdID)
    queryCommandSupported:function(sCmdID){
    },
    //> public String queryCommandText(String cmdID)
    queryCommandText:function(cmdID){
    },
    //> public Object queryCommandValue(String sCmdID)
    queryCommandValue:function(sCmdID){
    },
    //> public void scrollIntoView(boolean bAlignToTop)
    //> public void scrollIntoView()
    scrollIntoView:function(bAlignToTop){
    },
    //> public void select()
    select:function(){
    },
    //> public void setEndPoint(String sType,TextRange oTextRange)
    setEndPoint:function(sType,oTextRange){
    },
    //> public Object valueOf(String type)
    valueOf:function(type){
    }
})
.endType();