package ;
import flash.Vector;
/**
 * ...
 * @author sonygod
 */

 typedef Vector<T> = #if flash10
 	flash.Vector<T>
#elseif neko
	neko.NativeArray<T>
#elseif cs
	cs.NativeArray<T>
#elseif java
	java.NativeArray<T>
#else
	Array<T>
#end
 