/* File:ReceivedDataEvent.as
 * =========================
 * this event is created by Sun Pengcheng on 2011-01-15 20:21 
 * to send received data from upc.edu.cn to main procedure
 */
package events
{
	import flash.events.Event;

	public class ReceivedDataEvent extends Event
	{
		public static const RECEIVE_DATA:String = "receiveData";
		public var student:Object;                //携带学生信息
		public var subjects:Array;                //携带课程信息
		
		public function ReceivedDataEvent(type:String, student:Object, subjects:Array)
		{
			super(type, bubbles, cancelable);
			this.student = student;
			this.subjects = subjects;
		}
		public override function clone():Event{
			return new ReceivedDataEvent(type, student, subjects);
		}
	}
}