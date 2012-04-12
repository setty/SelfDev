/* @org.ebayopensource.dsf.resource.utils.CodeGen("VjoGenerator") */
vjo.ctype('Blob') //< public
.inherits('Object')
.protos({
    size:0, //< public long
    type:null, //< public String
    //> public Blob slice(long start,long end,String content)
    //> public Blob slice(long start,long end)
    //> public Blob slice(long start)
    slice:function(start,end,content){
    }
})
.endType();