package Extends.CUICompents.CEffect 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	/**
	 * ...
	 * @author JeffXun
	 */
	public class CEffectHouseFly extends CEffect 
	{
		private var ms_oldXPos:Number = 0;
		private var ms_oldYPos:Number = 0;
		private var ms_angleX:Number = 0;
		private var ms_angleY:Number = 0;
		private var ms_moveXDestance:Number = 100;
		private var ms_moveYDestance:Number = 200;
		private var ms_xSpeed:Number = 0.05;
		private var ms_ySpeed:Number = 0.01;
		public function CEffectHouseFly(target:DisplayObject) 
		{
			super(target);
		}
		
		override public function onPlay():void 
		{
			ms_oldXPos = ms_Target.x;
			ms_oldYPos = ms_Target.y;
			ms_Target.addEventListener(Event.ENTER_FRAME, OnHouseFlyHandle);
		}
		
		protected function OnHouseFlyHandle(event:Event):void
		{
			ms_Target.x = ms_oldXPos + Math.sin(ms_angleX) * ms_moveXDestance;
			ms_Target.y = ms_oldYPos + Math.sin(ms_angleY) * ms_moveYDestance;
			ms_angleX += ms_xSpeed;
			ms_angleY += ms_ySpeed;
			if (ms_angleX > 100)
			{
				ms_angleX = 0;
			}
			if (ms_angleY > 100)
			{
				ms_angleY = 0;
			}
		}
		
		public function set xSpeed(value:Number):void
		{
			ms_xSpeed = value;
		}
		
		public function set xDestance(value:Number):void
		{
			ms_moveXDestance = value;
		}
		
		public function set ySpeed(value:Number):void
		{
			ms_ySpeed	= value;
		}
		
		public function set yDestance(value:Number):void
		{
			ms_moveYDestance = value;
		}
	}

}