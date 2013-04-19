(function () { "use strict";
    var http=require("http")
var IntIterator = function(min,max) {
	this.min = min;
	this.max = max;
};
IntIterator.__name__ = true;
IntIterator.prototype = {
	next: function() {
		return this.min++;
	}
	,hasNext: function() {
		return this.min < this.max;
	}
}
var Main = function() { }
Main.__name__ = true;
Main.main = function() {
	Test.main();
}
var Std = function() { }
Std.__name__ = true;
Std.string = function(s) {
	return js.Boot.__string_rec(s,"");
}
var async = {}
async.Build = function() { }
async.Build.__name__ = true;
var Test = function() { }
Test.__name__ = true;
Test.__interfaces__ = [async.Build];
Test.bubblesort = function(array,__cb) {
	var swapping = false;
	var temp;
	var _afterLoop4 = function() {
		__cb(null,array);
	};
	var _loop3 = (function($this) {
		var $r;
		var _loop31 = null;
		_loop31 = function() {
			if(!swapping) {
				swapping = true;
				var _afterLoop1 = function() {
					_loop31();
				};
				var _iter2 = new IntIterator(0,array.length);
				var _loop0 = (function($this) {
					var $r;
					var _loop01 = null;
					_loop01 = function() {
						if(_iter2.hasNext()) {
							var i = _iter2.next();
							Test.delay(100,function(__error) {
								if(__error == null) {
									if(array[i] > array[i + 1]) {
										temp = array[i + 1];
										array[i + 1] = array[i];
										array[i] = temp;
										swapping = false;
									}
									_loop01();
								} else __cb(__error,null);
							});
						} else _afterLoop1();
					};
					$r = _loop01;
					return $r;
				}(this));
				_loop0();
			} else _afterLoop4();
		};
		$r = _loop31;
		return $r;
	}(this));
	_loop3();
}
Test.doFooParallel = function(arrayData,__cb) {
	console.log(haxe.Timer.stamp() * 10000 + "" + Std.string(arrayData));
	__cb(null,true);
}
Test.doFooGroup = function(arg1,__cb) {
	console.log(haxe.Timer.stamp() * 10000 + "doFooGroup" + arg1);
	__cb(null,true);
}
Test.doSomethingElseAsync3 = function(element,__cb) {
	__cb(null,element,"1");
}
Test.main = function() {
	console.log("start step");
	var step = new org.transition9.async.Step();
	step.chain([function() {
		Test.bubblesort([2,1,4,7],$bind(step,step.cb));
	},function(err,arrayData) {
		Test.doFooParallel(arrayData,step.parallel());
		Test.doFooParallel(arrayData,step.parallel());
		Test.doFooParallel(arrayData,step.parallel());
	},function(err,arg1,arg2,arg3) {
		Test.doFooGroup("group1",step.group());
		Test.doFooGroup("group1",step.group());
		Test.doFooGroup("group1",step.group());
	},function(err,args) {
		console.log("finish" + args);
	}]);
	var fromArray = [1,2,3,4];
	var onElement = function(element,cb) {
		haxe.Timer.delay(function() {
			cb("Some int=" + element,1);
		},100);
	};
	var onFinish = function(err,result1) {
		if(err != null) console.log("Oh no: " + Std.string(err));
		console.log("result=" + Std.string(result1));
	};
	Test.doSomethingElseAsync3(1,function(err,e,s) {
		console.log("e==========" + e);
	});
}
Test.delay = function(ms,cb) {
	haxe.Timer.delay(function() {
		console.log(ms + " passed");
		cb(null);
	},ms);
}
var haxe = {}
haxe.Timer = function(time_ms) {
	var me = this;
	this.id = setInterval(function() {
		me.run();
	},time_ms);
};
haxe.Timer.__name__ = true;
haxe.Timer.delay = function(f,time_ms) {
	var t = new haxe.Timer(time_ms);
	t.run = function() {
		t.stop();
		f();
	};
	return t;
}
haxe.Timer.stamp = function() {
	return new Date().getTime() / 1000;
}
haxe.Timer.prototype = {
	run: function() {
		console.log("run");
	}
	,stop: function() {
		if(this.id == null) return;
		clearInterval(this.id);
		this.id = null;
	}
}
var js = {}
js.Boot = function() { }
js.Boot.__name__ = true;
js.Boot.__string_rec = function(o,s) {
	if(o == null) return "null";
	if(s.length >= 5) return "<...>";
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) t = "object";
	switch(t) {
	case "object":
		if(o instanceof Array) {
			if(o.__enum__) {
				if(o.length == 2) return o[0];
				var str = o[0] + "(";
				s += "\t";
				var _g1 = 2, _g = o.length;
				while(_g1 < _g) {
					var i = _g1++;
					if(i != 2) str += "," + js.Boot.__string_rec(o[i],s); else str += js.Boot.__string_rec(o[i],s);
				}
				return str + ")";
			}
			var l = o.length;
			var i;
			var str = "[";
			s += "\t";
			var _g = 0;
			while(_g < l) {
				var i1 = _g++;
				str += (i1 > 0?",":"") + js.Boot.__string_rec(o[i1],s);
			}
			str += "]";
			return str;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e ) {
			return "???";
		}
		if(tostr != null && tostr != Object.toString) {
			var s2 = o.toString();
			if(s2 != "[object Object]") return s2;
		}
		var k = null;
		var str = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) { ;
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str.length != 2) str += ", \n";
		str += s + k + " : " + js.Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str += "\n" + s + "}";
		return str;
	case "function":
		return "<function>";
	case "string":
		return o;
	default:
		return String(o);
	}
}
var org = {}
org.transition9 = {}
org.transition9.async = {}
org.transition9.async.Step = function() {
	this._chain = [];
	this._callId = -1;
};
org.transition9.async.Step.__name__ = true;
org.transition9.async.Step.prototype = {
	callNext: function(args) {
		this._callId++;
		if(this._groupedCall != null) {
			this._groupedCall.shutdown();
			this._groupedCall = null;
		}
		try {
			this._chain.shift().apply(null,args);
		} catch( e ) {
			console.log("Step caught exception: " + Std.string(e));
			if(this._chain != null && this._chain.length > 0) this.callNext([e,null]); else throw e;
		}
	}
	,createCallback: function(isParallel) {
		if(this._groupedCall == null) this._groupedCall = new org.transition9.async.GroupedCall(this._callId,isParallel,$bind(this,this.callNext)); else null;
		return this._groupedCall.createCallback();
	}
	,group: function() {
		return this.createCallback(false);
	}
	,parallel: function() {
		return this.createCallback(true);
	}
	,cb: function(err,result) {
		this.callNext([err,err == null?result:null]);
	}
	,chain: function(arr) {
		var _g = 0;
		while(_g < arr.length) {
			var f = arr[_g];
			++_g;
			this._chain.push(f);
		}
		this.callNext([]);
	}
}
org.transition9.async.GroupedCall = function(callId,isParallel,callNext) {
	this.callId = callId;
	this.isParallel = isParallel;
	this._groupedFunctionIndex = this._pending = 0;
	this._pendingResults = [];
	this.callNext = callNext;
};
org.transition9.async.GroupedCall.__name__ = true;
org.transition9.async.GroupedCall.prototype = {
	calledGroupCallback: function() {
		if(this._pending == 0 && !this.finished) {
			this.finished = true;
			if(this.isParallel) {
				this._pendingResults.unshift(this._err);
				this.callNext(this._pendingResults);
			} else this.callNext(this._err == null?[null,this._pendingResults]:[this._err,null]);
		}
	}
	,createCallback: function() {
		var _g = this;
		var index = this._groupedFunctionIndex++;
		this._pending++;
		return function(err,result) {
			_g._pending--;
			if(_g.finished) return;
			if(err != null || _g._err != null) {
				_g._pendingResults[index] = null;
				if(_g._err == null) _g._err = err;
			} else _g._pendingResults[index] = result;
			if(_g._pending == 0) haxe.Timer.delay($bind(_g,_g.calledGroupCallback),0);
		};
	}
	,shutdown: function() {
		this._pendingResults = null;
		this.callNext = null;
		this._err = null;
	}
}
var $_;
function $bind(o,m) { var f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; return f; };
String.__name__ = true;
Array.__name__ = true;
Date.__name__ = ["Date"];
Test.__meta__ = { statics : { bubblesort : { async : null}, doFooParallel : { async : null}, doFooGroup : { async : null}, doSomethingElseAsync3 : { async : null}}};
Main.main();
})();
