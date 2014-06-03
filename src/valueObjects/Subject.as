/* File: Subject.as
 * ================
 * this class is a valueObject created by Sun Pengcheng 
 * on 2010-01-15 19:31 to transfer data
 */
 
package valueObjects
{
	public class Subject
	{
		public var studentName:String;
		
		public var subjectName:String;
		public var subjectScore:String;
		public var subjectCredit:String;
		public var subjectKind:String;
		
		public function Subject(name:String, score:String, credit:String, kind:String, studentName:String)
		{
			this.subjectName = name;
			this.subjectScore = score;
			this.subjectCredit = credit;
			this.subjectKind = kind;
			this.studentName = studentName;
		}
		
		public static function buildInstance(o:Object, studentName:String):Subject{
			return new Subject(o.subjectName, o.subjectScore, o.subjectCredit, o.subjectKind,studentName);
		}
		
		public function toString():String{
			return "[Subject] "+ this.subjectName;
		}

	}
}