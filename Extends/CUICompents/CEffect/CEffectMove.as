package Extends.CUICompents.CEffect
{
	import Extends.CEvent.CustomEvent;
	import flash.events.Event;
	
	import flash.display.DisplayObject;

	public class CEffectMove extends CEffect
	{
		private var ms_vx:Number	=	0	//x轴方向的速度
		private var ms_vy:Number 	=	0	//y轴方向的速度
		private var ms_speed:Number	=	0	//实际速度
		private var ms_srcX:Number	=	0	//原物体x坐标点
		private var ms_srcY:Number  =	0 	//
		private var ms_desX:Number	=	0	//目标x坐标点
		private var ms_desY:Number	=	0	//
		private var ms_addVX:Number	=	0	//x轴方向的加速度
		private var ms_addVY:Number	=	0	//
		private var ms_addSpeed:Number	=	0	//实际加速度
		private var ms_addEarth:Number	=	0	//重力加速
	
		public function CEffectMove(target:DisplayObject,speed:Number=0,addspeed:Number=0)
		{
			super(target);
		}
		
		override public function onPlay():void 
		{
			ms_srcX = ms_Target.x;
			ms_srcY = ms_Target.y;
			ms_Target.addEventListener(Event.ENTER_FRAME, onMouseHandle);
		}
		
		override public function onStop():void 
		{
			ms_Target.removeEventListener(Event.ENTER_FRAME, onMouseHandle);
		}
		
		protected function onMouseHandle(event:Event):void
		{
			var dx:Number = ms_Target.x - ms_srcX;
			var dy:Number = ms_Target.y - ms_srcY;
			var angle:Number  = Math.atan2(dy, dx);
			ms_vx 	= Math.cos(angle) * ms_speed;
			ms_vy   = Math.sin(angle) * ms_speed;
			ms_addVX = Math.cos(angle) * ms_addSpeed;
			ms_addVY = Math.sin(angle) * ms_addSpeed;
			ms_srcX = ms_Target.x;
			ms_srcY = ms_Target.y;
			ms_Target.x += ms_vx + ms_addVX ;
			ms_Target.y += ms_vy + ms_addVY + ms_addEarth;
		}
		
		public function set moveSpeed(value:Number):void
		{
			ms_speed	= value;
		}
		public function set moveAddSpeed(value:Number):void
		{
			ms_addSpeed	=	value;
		}
		public function set earthSpeed(value:Number):void
		{
			ms_addEarth = value;
		}
	}
}