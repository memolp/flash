package Extends.CUICompents.CEffect 
{
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.utils.Timer;

	/**
	 * ...
	 * @author JeffXun
	 */
	public class CEffect extends EventDispatcher
	{
		protected var ms_Timer:Timer = null;
		protected var ms_Target:DisplayObject = null;
		
		protected var ms_fraps:Number = 100;
		
		public function CEffect(target:DisplayObject) 
		{
			ms_Target = target;
		}
		
		
		public function set fraps(value:Number):void
		{
			ms_fraps = value;
		}
		
		public function onPlay():void
		{
			
		}
		
		public function onStop():void
		{
			
		}
	}

}