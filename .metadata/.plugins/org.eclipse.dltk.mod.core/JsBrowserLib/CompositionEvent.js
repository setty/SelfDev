/* @org.ebayopensource.dsf.resource.utils.CodeGen("VjoGenerator") */
vjo.ctype('CompositionEvent') //< public
.inherits('UIEvent')
.protos({
    data:null, //< public String
    locale:null, //< public String
    //> public void initCompositionEvent(String eventType,boolean canBubble,boolean canCancel,Window viewArg,String data,String locale)
    initCompositionEvent:function(eventType,canBubble,canCancel,viewArg,data,locale){
    }
})
.endType();