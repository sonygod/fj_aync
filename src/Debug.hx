package ;

/**
 * ...
 * @author sonygod
 */
class Debug


{
	
	public static  var debug;
	
   
	private static  inline function __debug(args:Array<Dynamic>) {
		 #if firefoxDebug
		trace(args);
		#end
	}
	
	private static function __init__() : Void {
    debug = Reflect.makeVarArgs(__debug);
 
 }
	
}