/* @org.ebayopensource.dsf.resource.utils.CodeGen("VjoGenerator") */
vjo.ctype('MediaList') //< public
.inherits('Object')
.protos({
    mediaText:null, //< public String
    length:0, //< public long
    //> public long item(long index)
    item:function(index){
    },
    //> public void deleteMedium(String oldMedium)
    deleteMedium:function(oldMedium){
    },
    //> public void appendMedium(String newMedium)
    appendMedium:function(newMedium){
    }
})
.endType();