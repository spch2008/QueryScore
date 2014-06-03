/* File:LoginEvent.as
 * ==================
 * this event is created by Sun Pengcheng on 2010-01-16 16:03
 * to send info to main procedure
 */
package events
{
	import flash.events.Event;
	
	public class LoginEvent extends Event
	{
		public static const RECEIVE_INFO:String = "receiveInfo";  //事件名
		public var isLogin:Boolean;
		public var userID:String;
		public var isTrust:Boolean;
		
		public function LoginEvent(type:String, isL:Boolean, user:String, isTrust:Boolean)
		{
			super(type, false, false);
			isLogin = isL;
			userID = user;
			this.isTrust = isTrust;
		}
		public override function clone():Event{
			return new LoginEvent(type, isLogin, userID,isTrust);
		}

	}
}