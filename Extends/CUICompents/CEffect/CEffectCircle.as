package Extends.CUICompents.CEffect 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	/**
	 * ...
	 * @author JeffXun
	 */
	public class CEffectCircle extends CEffect 
	{
		private var ms_oldXPos:Number = 0;
		private var ms_oldYPos:Number = 0;
		private var ms_angle:Number = 0;
		private var ms_Xradius:Number = 50;
		private var ms_Yradius:Number = 150;
		private var ms_speed:Number = 0.1;
		public function CEffectCircle(target:DisplayObject) 
		{
			super(target);
		}
		
		override public function onPlay():void 
		{
			ms_oldXPos = ms_Target.x;
			ms_oldYPos = ms_Target.y;
			ms_Target.addEventListener(Event.ENTER_FRAME, OnCircleMoveHandle);
		}
		
		protected  function OnCircleMoveHandle(event:Event):void
		{
			ms_Target.x  = ms_oldXPos + Math.sin(ms_angle) * ms_Xradius;
			ms_Target.y  = ms_oldYPos + Math.cos(ms_angle) * ms_Yradius;
			ms_angle += ms_speed;
			if (ms_angle > 100)
			{
				ms_angle = 0;
			}
		}
		
		public function set circleXRadius(value:Number):void
		{
			ms_Xradius = value;
		}
		
		public function set circleYRadius(value:Number):void
		{
			ms_Yradius = value;
		}
		
		public function set moveSpeed(value:Number):void
		{
			ms_speed = value;
		}
	}

}