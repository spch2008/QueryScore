/* File:Student.as
 * ===============
 * this class is a valueObject created on 2010-01-15 19:29 by Sun Pengcheng
 * to transfer data
 */
package valueObjects
{
	import mx.collections.ArrayCollection;
	
	public class Student
	{
		public var name:String;
		public var major:String;
		public var grade:String;
		public var ID:String;
		public var averageMajor:String;      //专业课平均分
		public var averagePublic:String;     //公选课平均分
		public var subjectContainer:ArrayCollection; //课程存放
		public var position:int;                  //学生名次
		
		private const FACTOR:Number = 0.003;  //选修课比例系数
		
		public function Student(name:String, major:String, grade:String, ID:String ,subjectArr:Array)
		{
			this.name = name;
			this.major = major;
			this.grade = grade;
			this.ID = ID;
			this.subjectContainer = new ArrayCollection();
			buildSubject(subjectArr);
		}
		private function buildSubject(subjArr:Array):void{
			for each(var prop:Object in subjArr){
				var subject:Subject = Subject.buildInstance(prop,this.name);
				this.subjectContainer.addItem(subject);
			}
		}
		public static function buildInstance(o:Object, subjectArr:Array):Student{
			return new Student(o.studentName, o.major, o.grade, o.studentID, subjectArr);
		}

		public function addSubject(subj:Subject):void{
			var index:int = subjectContainer.getItemIndex(subj);
			if(index == -1){
				subjectContainer.addItem(subj);
			}
			
		}
		public function toString():String{
			return "[Student] " + this.name;
		}
/*		public function getAverage():Object{
			//计算平均成绩
			var subject:Subject;
			var totalCredit:Number = 0;
			var totalScore:Number = 0;
			var additionScore:Number = 0;
			var averageObj:Object = {};
			
			for(var i:int=0; i<subjectContainer.length; i++){
				subject = Subject(subjectContainer.getItemAt(i));
				if(subject.kind == "任选"){
					additionScore += Number(subject.score) * FACTOR * Number(subject.credit);
				}else{
					totalScore += Number(subject.score) * Number(subject.credit);
					totalCredit += Number(subject.credit);
				}
				//有问题这个地方，如果只出了两门成绩，全是公选的，那么这样出现了0/0，发生错误
				if(totalCredit == 0){
					averagePublic = additionScore.toFixed(6).toString();
					averageMajor = "0";
				}else{
					averageMajor = (totalScore/totalCredit).toFixed(6).toString();
					averagePublic = additionScore.toFixed(6).toString();
				}
				averageObj.averagePublic = averagePublic;
				averageObj.averageMajor = averageMajor;
				
			}
			return averageObj;
		}
        */
	}
}