/* File: ClassificationManager.as
 * ==============================
 * this class is created by Sun Pengcheng on 2011-01-19 10:16
 * to classify students according to class and major
 */
package managers
{
	import valueObjects.*;
	public class ClassificationManager
	{
		public var majorContainer:Array;      //专业盛放器
		
		public function ClassificationManager()
		{
			majorContainer = new Array();    //选择框放一个全部标签
		    var obj:MyMajor = new MyMajor("全部");
			majorContainer.push(obj);
		}
		
		public function addStudent(stu:Student):void{
			managerAddStudent(stu);
		}
		public function getMajorByName(majorName:String):MyMajor{
			return findMajorByName(majorName);
		}
		public function removeAllMajor():void{
			for each (var prop:MyMajor in majorContainer){
				prop.removeAllClass();
			}
			majorContainer.splice(0,majorContainer.length);
		}
        
		/*  总管学生的添加 */
		private function managerAddStudent(stu:Student):void{
			var currMajor:MyMajor = findMajorByName(stu.major);
			if(currMajor == null){                  //专业不存在
				currMajor = buildMajor(stu.major);
				majorContainer.push(currMajor);
			}
			var currClass:MyClass = currMajor.findClassByName(stu.grade);
			if(currClass == null){
				currClass = buildClass(stu.grade);
				currMajor.addClass(currClass);
			}
			//最低一层，直接将学生添加进去即可
			currClass.addStudent(stu);
		}
		
		/* 查找列表中是否有 当前的班级  */
		private function findMajorByName(majorName:String):MyMajor{
			for each (var prop:MyMajor in majorContainer){
				if(prop.majorName == majorName){
					return prop;
				}
			}
			return null;
			
		}
		/*  创建专业 */
		private function buildMajor(majorName:String):MyMajor{
			var myMajor:MyMajor = MyMajor.buildInstance(majorName);
			return myMajor;
		}
		private function buildClass(className:String):MyClass{
			return MyClass.buildInstance(className);
		}
	}
}