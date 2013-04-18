package ;

/**
 * ...
 * @author sonygod
 */

import async.Build;
import async.Async;
import haxe.Timer;
import org.transition9.async.Step;
using org.transition9.async.AsyncLambda;
class Test implements Build
{

  static function asyncGet2<T1, T2>(v1:T1, v2:T2, cb){
    cb(null, v1, v2);
  }
	
	@async(var ret: Array<Float>) public static function bubblesort(array : Array<Float>)  {
		
		
		var swapping = false;
		var temp : Float;
		while (!swapping) {
			swapping = true;
			for (i in 0...array.length) {
			
				[]=delay(1);
				if (array[i] > array[i+1]) {
					temp = array[i+1];
					array[i+1] = array[i];
					array[i] = temp;
					swapping = false;
				}
			}
		}
		
	
		return array;
	}

 
    @async(var ret: Array<Float>) static function asynchronous(){
      var arry:Array<Float>;
	  
       [ arry] = bubblesort([1337, 1, -465, 3.141592653589793, 789, 69, 789, -132, 3.141592653589793, 465, 789, 0, 27]);
	   
	 
	   
	  
	    return arry;

    }
	
	

	static function bubblesortSync(array : Array<Float>)  {
		
		
		var swapping = false;
		var temp : Float;
		while (!swapping) {
			swapping = true;
			for (i in 0...array.length) {
			
				
				if (array[i] > array[i+1]) {
					temp = array[i+1];
					array[i+1] = array[i];
					array[i] = temp;
					swapping = false;
				}
			}
		}
		
	
		return array;
	}
	
	public static function getResult(err:NodeErr, data:Array<Float>) {
		trace("end"+(Timer.stamp()*1000-startTime));
		trace(data);
		
			
	}
	
	 @async(var ret:Bool) public static function doFooParallel(arrayData:Array<Float>) {
		trace(Timer.stamp() * 10000 + "" + arrayData);
	return true;
	};
	
	//
	@async(var ret:Bool) public static function doFooGroup(?arg1:String) {
		trace(Timer.stamp() * 10000 + "doFooGroup" + arg1);
	return true;
	};
	
	 @async(var ret:Bool)public static function  doSomethingElseAsync(array) {
		trace(Timer.stamp() * 10000 + " doSomethingElseAsync" + array);
	return true;
	};
	
	 @async(var ret:Int) public static function  doSomethingElseAsync2(element:Int ) {
		trace(element);
		return  element;
	
	};
	
	 @async(var ret:Int,var ret2:String) public static function  doSomethingElseAsync3(element:Int ) {
		
	   return many(element, "1");
	
	};
	
	public static var startTime:Float;
    public static function main() {
	
		 
		 
		
          var step = new Step();
		  step.chain([
		  
		       function () {
				   bubblesort([2, 1, 4, 7], step.cb);
			   },
			   function (err, arrayData) {
				 
				 
				 doFooParallel(arrayData, step.parallel());
				 doFooParallel(arrayData, step.parallel());
				 doFooParallel(arrayData, step.parallel());
				  
				  
			   }
			   ,function (err, ?arg1,?arg2,?arg3) {
				  // trace("finish now..."+Timer.stamp()+"arg"+arg1+arg2+arg3);
			     doFooGroup("group1", step.group());
				  doFooGroup("group1", step.group());
				   doFooGroup("group1", step.group());
				  }
				  ,function (err, args) {
					  trace("finish"+args);
				  }
		  
		  ]);
		   
        
		  
		 var fromArray = [1, 2, 3, 4];

var onElement = function (element :Int, cb :String->Int->Void) {
   platformDelay(100,function () {
        cb("Some int=" + element,1);
    });

}

var onFinish = function (err :Dynamic, result1:String->Int->Void) {
    if (err != null) trace("Oh no: " + err);
    trace("result=" + result1);
}

//AsyncLambda.map( fromArray,onElement , onFinish);




      doSomethingElseAsync3(1, function(err:String, e:Int,s:String):Void { trace("e=========="+e); } );
	  
	
	
    }
    static inline function delay(ms:Int, cb){
        platformDelay(ms, function(){ trace(ms+' passed'); cb(null); });
    }

    static inline function platformDelay(ms:Int, fun){
#if (cpp || neko || php) fun(); #else haxe.Timer.delay(fun, ms); #end
    }
}

typedef NodeErr = Null<String>;