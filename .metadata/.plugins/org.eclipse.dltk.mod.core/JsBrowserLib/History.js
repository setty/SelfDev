/* @org.ebayopensource.dsf.resource.utils.CodeGen("VjoGenerator") */
vjo.ctype('History') //< public
.inherits('Object')
.protos({
    length:0, //< public int
    //> public void back()
    back:function(){
    },
    //> public void forward()
    forward:function(){
    },
    //> public void go(int number)
    //> public void go(String url)
    go:function(number){
    },
    //> public void pushState(Object state,String title,String URL)
    //> public void pushState(Object state,String title)
    //> public void pushState(Object state)
    pushState:function(state,title,URL){
    },
    //> public void replaceState(Object state,String title,String URL)
    //> public void replaceState(Object state,String title)
    //> public void replaceState(Object state)
    replaceState:function(state,title,URL){
    }
})
.endType();