/* File:FilterEvent.as
 * ===================
 * this event is created by Sun Pengcheng on 2011-01-17 10:15 
 * to send filtered data to main procedure
 */
package events
{
	import flash.events.Event;
	
	import mx.events.FileEvent;

	public class FilterEvent extends Event
	{
		public static const FILTER_DATA:String = "filterData";
		public var filterArr:Array;
		
		public function FilterEvent(type:String, filterArr:Array, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.filterArr = filterArr;
		}
		public override function clone():Event{
			return new FilterEvent(type, filterArr);
		}
		
	}
}