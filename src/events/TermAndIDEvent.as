package events
{
	import flash.events.Event;

	public class TermAndIDEvent extends Event
	{
		public static const TERM_And_ID:String = "termAndID";
		public var term:String;
		public var studentID:String;
		
		public function TermAndIDEvent(type:String, term:String, studentID:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.term = term;
			this.studentID = studentID;
		}
		public override function clone():Event{
			return new TermAndIDEvent(type, term, studentID);
		}
		
	}
}