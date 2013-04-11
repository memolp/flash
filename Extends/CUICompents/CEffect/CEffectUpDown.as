package Extends.CUICompents.CEffect 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	/**
	 * ...
	 * @author JeffXun
	 */
	public class CEffectUpDown extends CEffect 
	{
		private var ms_moveSpeed:Number = 0.1;
		private var ms_angle:Number = 0;
		private var ms_destacne:Number = 50;
		private var ms_statusYPos:Number = 0;
		public function CEffectUpDown(target:DisplayObject) 
		{
			super(target);
		}
		override public function onPlay():void 
		{
			ms_statusYPos = ms_Target.y;
			ms_Target.addEventListener(Event.ENTER_FRAME, onUpDownHandle);
		}
		
		protected function onUpDownHandle(event:Event):void
		{
			ms_Target.y = ms_statusYPos + Math.sin(ms_angle) * ms_destacne;
			ms_angle += ms_moveSpeed;
			if (ms_angle > 100)
			{
				ms_angle = 0;
			}
		}
		
		public function set moveSpeed(value:Number):void
		{
			ms_moveSpeed = value;
		}
		
		public function set moveDestance(value:Number):void
		{
			ms_destacne = value;
		}
	}

}