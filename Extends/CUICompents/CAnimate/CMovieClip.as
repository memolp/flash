package Extends.CUICompents.CAnimate 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author JeffXun
	 */
	public class CMovieClip extends DisplayObject 
	{
		
		public function CMovieClip() 
		{
			
		}
		
		public function OnPlay():void
		{
			this.addEventListener(Event.ENTER_FRAME,OnEnterFrame)
		}
		
		public function OnStop():void
		{
			this.removeEventListener(Event.ENTER_FRAME,OnEnterFrame)
		}
		
		protected function OnEnterFrame(event:Event):void
		{
			
		}
	}

}