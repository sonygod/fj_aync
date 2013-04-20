package ;
import tink.lang.Cls;
import ExternalConnectionAsync;
class Forwarder implements Cls implements IHelloServer {
    var fields:Hash<Dynamic> = new Hash<Dynamic>();


    @:forward(!multiply) var target:ExternalConnectionAsync;

    @:forward function fwd2(hello:HelloService) {
        get: fields.get($name),
        set: fields.set($name, param),


        call:target.resolve("main").resolve("onData").call($argsRemoting)

    }

    public function new(target:ExternalConnectionAsync,name:String,callBackClass:Dynamic) {

        this.target=target;
        target.getcallBackList().set(name, {id:name,name:"",sn:"",callBack:callBackClass});

    }
}
