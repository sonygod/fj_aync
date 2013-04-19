package ;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.display.MovieClip;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.Lib;
import flash.events.Event;
import flash.net.URLRequest;
import flash.system.LoaderContext;
import flash.errors.Error;
import flash.net.LocalConnection;
import flash.system.System;
import Type;
import flash.system.ApplicationDomain;
import flash.events.MouseEvent;
import Vector;
using Lambda;
using Bm;
/**
 * ...
 * @author sonygod
 */

class Main {
    public static var max:Int =30;
    public static var no:Int = 0;
	public static var  tt:Int = 0;
    public static var assetDomain:ApplicationDomain=new ApplicationDomain();
    static function main2() {
        var stage = Lib.current.stage;
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;



        for (i in 0...max) {
            var loader:Loader = new Loader();

            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoad);

      var cu = new LoaderContext();
    cu.applicationDomain = assetDomain;
            loader.load(new URLRequest("group.swf"),cu);
            loader = null;


        }

    }
	
	
	static function main() {
		
		
		Test.main();
	
	  
	
	 
      
		/**
		 * var fs = require("fs");
fs.readFile("./testfile", "utf8", function(error, file) {  
     if (error) throw error;  
     console.log("我读完文件了！");
});
console.log("我不会被阻塞！");

		 */

		 
		 
	}


    public static function onLoad(event:Event):Void {
        no++;
        event.target.removeEventListener(Event.COMPLETE, onLoad);
        var loader:LoaderInfo = event.currentTarget;
        
		
	
		
		var mc:MovieClip2= Lib.as( Type.createInstance( assetDomain.getDefinition( "Group_money"), new Array() ),MovieClip);
		//var mc:MovieClip2 = _mc;
    mc.addEventListener(MouseEvent.CLICK,  onMouseClick);
	  
		mc.addEventListener(MouseEvent.MOUSE_OUT, function(e) {
			tt = 0;
			} );
		
		mc.addEventListener(MouseEvent.MOUSE_MOVE, function(e) { tt = 1; } );
		
		mc.addEventListener(MouseEvent.MOUSE_WHEEL , function(e) { tt = 2; } );
	// mc.dispose();
	//mc.removeEventListener(MouseEvent.CLICK,  onMouseClick);
		Lib.current.stage.addChild(mc);
      GlobalTimer.setTimeout(test, 1000 + (no * 10), [loader,mc]);
		
      loader = null;

    }

	
	public static function onMouseClick(e):Void {
		
	}
	 
    public static function test(loader:LoaderInfo,mc:MovieClip):Void {

        var bitmap:MovieClip= Lib.as(loader.content, MovieClip);
     


        bitmap = null;
       
        loader.loader.unloadAndStop();
      
        loader = null;
		 mc.dispose();
        no--;
//trace(no);
        if (no <= 10) {
//much >1 gc
            gc();
        }
		if (no == 0) {
			
			
			assetDomain = null;
			
			gc();
		}

    }

    public static function gc() {

       // trace("清理之前" + System.totalMemory);
	  
        try {
            new LocalConnection().connect('foo');
           new LocalConnection().connect('foo');
        } catch (e:Error) {

        }

       trace("清理之后" + System.totalMemory);
    }


}