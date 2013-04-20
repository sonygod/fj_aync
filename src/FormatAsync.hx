package ;

/**
 * ...
 * @author sonygod
 */
typedef CallBackObj = {
    id:String,
	name:String,
	
}
typedef CallBackObjWithFun = {
    >CallBackObj,
	callBack:Dynamic,
}
typedef JsRecall = {
    cbF:Dynamic->Dynamic->CallBackObj->Void,
	obj:CallBackObj,
}