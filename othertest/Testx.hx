package ;

/**
 * ...
 * @author sonygod
 */
class Testx
{

	public function new() 
	{
		
	}
	/**
	 * function compare(x, y) {
    return x - y;
};

function swap (array, i, j) {
    var t = array[i];
    array[i] = array[j];
    array[j] = t;
};

function bubbleSort(array) {
    for (var i = 0; i < array.length; i++) {
        for (var j = 0; j < array.length - i; j++) {
            var r = compare(array[j], array[j + 1]));
            if (r > 0) swap(array, j, j + 1);
        }
    }
}
	 * @param	x
	 * @param	y
	 */
	
	function compare(x, y) {
    return x - y;
};

function swap (array, i, j) {
    var t = array[i];
    array[i] = array[j];
    array[j] = t;
};

	public function bubbleSort(array:Array<Int>) {
    for (i in 0...array.length) {
        for ( j in 0...array.length-i) {
            var r = compare(array[j], array[j + 1]);
			trace(r);
            if (r > 0) swap(array, j, j + 1);
        }
    }
}
	
}