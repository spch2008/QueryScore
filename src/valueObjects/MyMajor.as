/* File:MyMajor.as
 * ===============
 * this class is created by Sun Pengcheng on 2011-01-19 10:40
 * to contain classes
 */
package valueObjects
{
	import mx.collections.ArrayCollection;
	
	public class MyMajor
	{
		public var classContainer:ArrayCollection;
		public var majorName:String;
		public function MyMajor(majorName:String)
		{
			classContainer = new ArrayCollection();
			this.majorName = majorName;
			var obj:MyClass = new MyClass("全部");
			classContainer.addItem(obj);
		}
		public function removeAllClass():void{
			for each (var prop:MyClass in classContainer){
				prop.removeAllStudent();
			}
			classContainer.removeAll();
		}
		public static function buildInstance(majorName:String):MyMajor{
        	return new MyMajor(majorName);
        }
        public function getClassByName(className:String):MyClass{
        	return findClassByName(className);
        }
		public function addClass(item:MyClass):void{
			var index:int = classContainer.getItemIndex(item);
			if(index == -1){
				classContainer.addItem(item);
			}
		}
        public function findClassByName(className:String):MyClass{
        	var myClass:MyClass;
        	for(var i:int = 0; i < classContainer.length; i++){
        		myClass = MyClass(classContainer.getItemAt(i));
        		if(className == myClass.className){
        			return myClass;
        		}
        	}
        	return null;
        }
        
        
	}
}