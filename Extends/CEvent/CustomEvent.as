package Extends.CEvent
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author JeffXun
	 */
	dynamic public class CustomEvent extends Event 
	{
		public var event_data:*;
		public function CustomEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new CustomEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("CustomEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}