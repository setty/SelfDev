/* @org.ebayopensource.dsf.resource.utils.CodeGen("VjoGenerator") */
vjo.ctype('TextTrackCue') //< public
.protos({
    track:null, //< public TextTrack
    id:null, //< public String
    startTime:0, //< public double
    endTime:0, //< public double
    pauseOnExit:false, //< public boolean
    onenter:null, //< public Object
    onexit:null, //< public Object
    //> public String getCueAsSource()
    getCueAsSource:function(){
    },
    //> public DocumentFragment getCueAsHTML()
    getCueAsHTML:function(){
    }
})
.endType();