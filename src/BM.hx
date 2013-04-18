package ;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import haxe.ds.ObjectMap;
import haxe.io.Error;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.display.MovieClip;
import flash.events.Event;
import flash.display.DisplayObjectContainer;
using  flash.Lib;
using Lambda;
using Std;
using Reflect;


class Event2 {
	
	
	public var listener :Event->Void;
	public var	useCapture :Bool;
	public var	priority :Int;
	public var	useWeakReference:Bool;
	public var type:String;
	public var target:IEventDispatcher;
	public function new (target:IEventDispatcher,type:String,listener:Event->Void, ?useCapture:Bool = false, ?priority:Int = 0, ?useWeakReference:Bool = false) {
		this.target = target;
		this.type = type;
		this.listener = listener;
		this.useCapture = useCapture;
		this.priority = priority;
		this.useWeakReference = useWeakReference;
	}
}
/**
 * BaseAssetsGCManager
 * sonygodx@gmail.com
 */

class Bm {
	
	public static var bitmapdatas:Array<BitmapData> = [];
	public static var bitmapPool:ObjectMap<BitmapData,Bitmap>=new ObjectMap<BitmapData,Bitmap>();
	
	public static var mcPool:ObjectMap<String,MovieClip>=new ObjectMap<String,MovieClip>();
	
	public static var eventMap:ObjectMap < IEventDispatcher, Array<Event2> >= new ObjectMap < IEventDispatcher, Array<Event2> > ();
	
	//public static v
	public static function addBitmapData(data:BitmapData):Void {
		
		bitmapdatas.push(data);
	}
	/**
	 *  use other way to overrride  some native function,same as base it's owen method
	 * @param	target
	 * @param	type
	 * @param	listener
	 * @param	?useCapture
	 * @param	?priority
	 * @param	?useWeakReference
	 */
	public static function addEventListener(target:IEventDispatcher,type:String, listener:Event->Void, ?useCapture:Bool = false, ?priority:Int = 0, ?useWeakReference:Bool = false):Void {
		
		
		var eventsArray:Array<Event2> = [];
		if (eventMap.exists(target)) {
			eventsArray = eventMap.get(target);
		}else {
			eventMap.set(target, eventsArray);
		}
		var e:Event2 = new Event2(target,type,listener,useCapture,priority,useWeakReference);
		eventsArray.push(e);
		target.addEventListener(type, listener, useCapture, priority, useWeakReference);
	}
	
	
	/** use other way to overrride  some native function,same as base it's owen method
	 * 
	 * @param	target
	 * @param	type
	 * @param	listener
	 * @param	useCapture
	 */
	public static function removeEventListener(target:IEventDispatcher,type : String, listener : Dynamic -> Void, useCapture : Bool = false) : Void {
		
		 if (eventMap.exists(target)) {
			var events = eventMap.get(target);
			
			 events.map(function (e:Event2) {
				 
				 if (e.type == type && e.listener == listener && e.useCapture == useCapture) {
					 
					
					
					 events.remove(e);
					 e = null;
					 
					 if (events.length == 0) {
						 eventMap.remove(target);
					 }
				 }
				
			   e = null;
			 }
			 
		);
		
		events = null;
	
			
		}
		
		
		
		target.removeEventListener(type, listener, useCapture);
	}
	/**
	 * 
	 * @param	target may be sprite mc,bitmap ,all impl IEventDspatcher , looks like bitmapdata.dispose();
	 * don't forget recall gc() finally .
	 */
	public static function dispose(target:IEventDispatcher):Void {
		
	
		cleanTargetEvents(target);
		if(target.is(DisplayObjectContainer))
		cleanChildAndParent(target.as(DisplayObjectContainer));
		
	
	    if (target.is(Bitmap)) {
			cleanBitmap(target.as(Bitmap));
		}
		
		target = null;
		
	}
	
	public static function cleanBitmap(target:Bitmap):Void {
			
		
			if(target.parent!=null)
			target.parent.removeChild(target);
			target.bitmapData.dispose();
			
		
			
		target = null;
		
	}
	
	public static function cleanChildAndParent(target:DisplayObjectContainer):Void {
			
		
			if(target.parent!=null)
			target.parent.removeChild(target);
			
		
			
		target = null;
		
	}
	
	public static function cleanTargetEvents(target:IEventDispatcher):Void {
			//clean all event
		if (eventMap.exists(target)) {
			var events = eventMap.get(target);
			
			 events.map(function (e:Event2) {
			   
			   if(e.target.hasEventListener(e.type))
			   e.target.removeEventListener(e.type, e.listener, e.useCapture);
			  
			 
			   e.target = null;
			   e = null;
		   });
		   
		  eventMap.remove(target);
	   
		 
		}
		target = null;
	}
	
	/**
	 * use dispose instead of clear all, not usual for use .becase flash GC could not be clear all immediately
	 */
	public static function clearAll():Void {
		
		//用处不大，建议用dispose();
		
		cleanEvens();
		
	        
	      
	   
	}
	
	public  static function cleanEvens():Void {
		for ( key in eventMap.keys()) {
			
			dispose(key);
		}
		   	eventMap = new ObjectMap < IEventDispatcher, Array<Event2> > ();
	}
	
	public static function cleanBitmapDatas():Void {
		bitmapdatas.map(function (data:BitmapData):Void {
			
			
			 var b:Bitmap;
			if (bitmapPool.exists(data)) {
			
			   b= bitmapPool.get(data);
			   if (b.parent!=null) {
				   b.parent.removeChild(b);
				   
			   }
			} 
		
			data.dispose();
			
			data = null;
			b = null; } );
			
		
			
		

		bitmapdatas = [];
		bitmapPool=new ObjectMap<BitmapData,Bitmap>();
		
	}
	
	public static function addBitmap(data:Bitmap):Void {
		
		bitmapPool.set(data.bitmapData, data);
	}
	
	
	
	
	
}


abstract BitmapData2(BitmapData) to BitmapData {
  private inline function new(a:BitmapData) {
	      this = a;
		  Bm.addBitmapData(a);
  }
  
  @:from static public inline function fromBitmapData(a:BitmapData):BitmapData2 {
	 
    return new BitmapData2(a);
  }

 
}


abstract Bitmap2(Bitmap) to Bitmap {
  private inline function new(a:Dynamic) {
	      this = a;
		  Bm.addBitmapData(a.bitmapData);
  }
  
  
  
  
}
/**
 * mc:MovieClip2= Lib.as(xxx,MovieClip);
 */
abstract MovieClip2(MovieClip)  {
  private inline function new(a:MovieClip) {
	      this = a;
		
		 a = null;
  }
  
  @:from static public inline function fromMovieClip(a:MovieClip):MovieClip2 {
	 
    return new  MovieClip2(a);
  }
  
   @:to public inline function toMovieClip():MovieClip {
	 
        return this;
   }
   
   
    
  }


	 