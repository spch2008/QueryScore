/* File:MyClass.as
 * ===============
 * this class is a VO created by Sun Pengcheng on 2011-1-17 11:53
 * to build a class(班级)
 */
 
package valueObjects
{
	import mx.collections.ArrayCollection;
	
    
	public class MyClass
	{
		public var className:String;
		public var studentContainer:ArrayCollection;
		
		public function MyClass(className:String)
		{
			this.className = className;
			studentContainer = new ArrayCollection();
		}
		public static function buildInstance(className:String):MyClass{
			return new MyClass(className);
		}
		
		public function removeAllStudent():void{
			studentContainer.removeAll();
		}
		public function addStudent(stu:Student):void{
			var found:Boolean = isExist(stu);
			
			if(!found){	
				studentContainer.addItem(stu);
			}
			
		}
		public function toString():String{
			return "[MyClass] " + this.className;
		}
		private function isExist(student:Student):Boolean{
			var stu:Student = getStudentByID(student.ID);
			if(stu == null) return false;
			else return true;
		}
		public function getStudentByID(studentID:String):Student{
			for each(var stu:Student in studentContainer){
				if(studentID == stu.ID) return stu;
			}
			return null;
		}
        
	}
}