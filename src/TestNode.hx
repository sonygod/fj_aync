package ;
import js.Node;

using org.transition9.async.AsyncLambda;
 
class TestNode implements async.Build{
  @:async static function writeAll(fd:Int, content:String){
    var total = 0, length = content.length;
    while (total > length){
      async(written = Node.fs.write(fd, content, total, length - total, null));
	  trace("total+");
      total+= written;
    }
  }
  
  @:async static function startTest():Void
  {
    var files = ["1.txt", "2.log", "3.txt", "4.ini", "5.conf"];
    async(
      Node.fs.mkdir("TestNode"),
      files.parallelExec(Async.it(function(fileName, cb){ // parallelExec is a lambda extenstion, not a part of lib yet
        async(
          fd = Node.fs.open("TestNode/" + fileName, "w+"),
          writeAll(fd, "Content of " + fileName),
          Node.fs.close(fd)
        );
      }))
    );
  }
 
  public static function main(){
    startTest(function(error){
      if(error != null) trace('Error: '+error);
      else trace("Test is done!");
    });
  }
  
}