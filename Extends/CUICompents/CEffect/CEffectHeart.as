package Extends.CUICompents.CEffect 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	/**
	 * ...
	 * @author JeffXun
	 */
	public class CEffectHeart extends CEffect 
	{
		private var ms_angle:Number = 0;
		private var ms_HeartRadius:Number = 0.5;
		private var ms_oldScaleX:Number = 1;
		private var ms_oldScaleY:Number = 1;
		private var ms_Speed:Number = 0.1;
		public function CEffectHeart(target:DisplayObject) 
		{
			super(target);
		}
		
		override public function onPlay():void 
		{
			ms_oldScaleX = ms_Target.scaleX;
			ms_oldScaleY = ms_Target.scaleY; 
			ms_Target.addEventListener(Event.ENTER_FRAME, onHeartBitsHandle);
		}
		
		protected function onHeartBitsHandle(event:Event):void
		{
			ms_Target.scaleX =  ms_oldScaleX + Math.sin(ms_angle) * ms_HeartRadius;
			ms_Target.scaleY =  ms_oldScaleY + Math.sin(ms_angle) * ms_HeartRadius;
			ms_angle += ms_Speed;
			if (ms_angle > 100)
			{
				ms_angle = 0;
			}
		}
		
		public function set heartRadius(value:Number):void
		{
			ms_HeartRadius = value;
		}
		
		public function set heartSpeed(value:Number):void
		{
			ms_Speed = value;
		}
	}

}