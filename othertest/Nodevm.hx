package ;
import js.Node;
import async.Build;
import org.transition9.async.Step;


/**
 * ...
 * test nodevm in async excute 
 * @author sonygod
 */
class Nodevm implements Build
{

  

   

	public function new() 
	{
		 var offer = {title:'fdsfds',price:323,value:150};
    var initSandbox = {
    http: 123,
    offer: offer,
    done : function(offer) {
        trace('sanbox done!'+offer.value);
    },
    setTimeout: Node.setTimeout,
    say:say
    };
    var vm2 :NodeVM = Node.require("vm");
	var fs = Node.fs;
      var context2 = vm2.createContext(initSandbox);

      
	 
	    var step = new Step();
		  step.chain([
		  
		       function () {
				  fs.readFile('bitmapdata2.js', NodeC.UTF8, step.cb);
			   },
			   function (err, content:String) {
				 
				 
				
				  
				
				  doFooParallel(vm2, content, step.cb);
				  trace("end?");
			   },
			   
			    function (err,?content) {
				   trace("finish!");	
				}
			   
			   
				  
		  
		  ]);
	  
	  trace("start or end hero haha?");
	}
	
	 @async(var b:Bool) static function doFooParallel(vm:NodeVM, content:String) {
		  trace("async vm2.runInThisContext start"); 
		 vm.runInThisContext(content); 
		 return true;
	 }
	 
	 
	
	function say(value:String):Void {
		trace("say:"+value);
	}
	
}