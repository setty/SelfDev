/* @org.ebayopensource.dsf.resource.utils.CodeGen("VjoGenerator") */
vjo.ctype('HTMLMediaElement') //< public
.inherits('HTMLElement')
.protos({
    error:null, //< public MediaError
    src:null, //< public String
    currentSrc:null, //< public String
    readyState:0, //< public short
    networkState:0, //< public short
    preload:null, //< public String
    buffered:null, //< public TimeRanges
    seeking:false, //< public boolean
    currentTime:0, //< public double
    initialTime:0, //< public double
    duration:0, //< public double
    startOffsetTime:null, //< public Date
    paused:false, //< public boolean
    defaultPlaybackRate:0, //< public double
    playbackRate:0, //< public double
    played:null, //< public TimeRanges
    seekable:null, //< public TimeRanges
    ended:false, //< public boolean
    autoplay:false, //< public boolean
    mediaGroup:null, //< public String
    controller:null, //< public MediaController
    volume:0, //< public double
    muted:false, //< public boolean
    defaultMuted:false, //< public boolean
    controls:false, //< public boolean
    audioTracks:null, //< public MultipleTrackList
    videoTracks:null, //< public ExclusiveTrackList
    textTracks:null, //< public TextTrack[]
    //> public void load()
    load:function(){
    },
    //> public String canPlayType(String type)
    canPlayType:function(type){
    },
    //> public void play()
    play:function(){
    },
    //> public void pause()
    pause:function(){
    },
    //> public MutableTextTrack addTextTrack(String kind,String label,String language)
    //> public MutableTextTrack addTextTrack(String kind,String label)
    //> public MutableTextTrack addTextTrack(String kind)
    addTextTrack:function(kind,label,language){
    }
})
.endType();