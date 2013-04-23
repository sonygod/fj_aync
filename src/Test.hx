package ;

/**
 * ...
 * @author sonygod
 */

import async.Build;
import async.Async;
import haxe.Timer;


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
			
				[]=delay(200);
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
		//trace("end"+(Timer.stamp()*1000-startTime));
		//trace(data);
		
			
	}
	
	 @async(var ret:BoolErr ) public static function doFooParallel(arrayData:Array<Float>) {
		//trace(Timer.stamp() * 10000 + "" + arrayData);
	return true;
	};
	
	//
	@async(var ret:BoolErr ) public static function doFooGroup(?arg1:String) {
		//trace(Timer.stamp() * 10000 + "doFooGroup" + arg1);
	return true;
	};
	
	 @async(var ret:BoolErr )public static function  doSomethingElseAsync(array) {
		//trace(Timer.stamp() * 10000 + " doSomethingElseAsync" + array);
	return true;
	};
	
	 @async(var ret:Int) public static function  doSomethingElseAsync2(element:Int ) {
		//trace(element);
		return  element;
	
	};
	
	 @async(var ret:Int,var ret2:String) public static function  doSomethingElseAsync3(element:Int ) {
		
	   return many(element, "1");
	
	};
	
	public static var startTime:Float;
    public static function main(callBack2) {
	
		 
		 
		
        /*  var step = new Step();
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
				  // //trace("finish now..."+Timer.stamp()+"arg"+arg1+arg2+arg3);
			     doFooGroup("group1", step.group());
				  doFooGroup("group1", step.group());
				   doFooGroup("group1", step.group());
				  }
				  ,function (err, args) {
					   callBack2(err, args);
				  }
		  
		  ]);*/
		   
        
	
	  
	
	
    }
	//the same result as main.
	@async(var rect:Array<Dynamic>) public static function main2() {
		
		//step
		[var arrayData] = bubblesort([2, 1, 4, 7]);
		
		//paraller
		[
		  [var a] = doFooParallel(arrayData),
		  [var b] = doFooParallel(arrayData),
		  [var c] = doFooParallel(arrayData),
		
		];
		
		//group
		var arr:Array<Dynamic> = [null, null, null];
		
		[arr[0]] = doFooGroup("group1");
		[arr[1]] = doFooGroup("group2");
		[arr[2]] = doFooGroup("group3");
		
		return arr;
		
	}
    static inline function delay(ms:Int, cb){
        platformDelay(ms, function(){cb(null); });
    }

    static inline function platformDelay(ms:Int, fun){
#if (cpp || neko || php) fun(); #else haxe.Timer.delay(fun, ms); #end
    }
}

typedef NodeErr = Null<String>;
typedef BoolErr = Null<Bool>;