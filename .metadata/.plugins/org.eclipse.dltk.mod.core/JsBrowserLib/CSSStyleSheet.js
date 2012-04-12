/* @org.ebayopensource.dsf.resource.utils.CodeGen("VjoGenerator") */
vjo.ctype('CSSStyleSheet') //< public
.inherits('StyleSheet')
.protos({
    cssText:null, //< public String
    ownerRule:null, //< public CSSRule
    cssRules:null, //< public [[CSSRule+CSSMediaRule+CSSStyleRule+CSSFontFaceRule+CSSCharsetRule+CSSImportRule+CSSPageRule][]+CSSRuleList]
    //> public Number insertRule(String rule,int index)
    insertRule:function(rule,index){
    },
    //> public void deleteRule(int index)
    deleteRule:function(index){
    },
    //> public int addRule(String sSelector)
    //> public int addRule(String sSelector,String sStyle)
    //> public int addRule(String sSelector,String sStyle,int iIndex)
    addRule:function(sSelector){
    },
    //> public void removeRule()
    //> public void removeRule(int iIndex)
    removeRule:function(){
    },
    //> public void addImport(String sURL)
    //> public void addImport(String sURL,int iIndexRequest)
    addImport:function(sURL){
    },
    //> public int addPageRule(String sSelector,String sStyle,int iIndex)
    addPageRule:function(sSelector,sStyle,iIndex){
    },
    //> public void removeImport(int iIndex)
    removeImport:function(iIndex){
    }
})
.endType();