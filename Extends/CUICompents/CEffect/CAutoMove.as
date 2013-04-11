package Extends.CUICompents.CEffect
{
	import Extends.CEvent.CustomEvent;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;

	public class CAutoMove extends CEffect
	{
		static public const EFFECT_EVENT_COMPLETE:String = "EFFECT_EVENT_COMPLETE";
		private var ms_srcPt:Point = null;
		private var ms_desPt:Point = null;
		private var ms_retPt:Point = null;
		
		private var ms_Speed:Number  = 0;
		private var ms_xSpeed:Number = 0;
		private var ms_ySpeed:Number = 0;
		private var ms_xTotal:Number = 0;
		private var ms_yTotal:Number = 0;
		
		private var ms_timeEndFunc:Function = null;
		private var ms_timeEndFuncArgs:Object = null;
		
		private var ms_srcX:Number 	=	0;
		private var ms_srcY:Number	=	0;
		private var ms_desX:Number	=	100;
		private var ms_desY:Number	=	100;
		private var ms_speed:Number	=	5;
		public function CAutoMove(target:DisplayObject)
		{
			super(target);
		}
		
		
		override public function onPlay():void 
		{
			ms_srcX = ms_Target.x;
			ms_srcY = ms_Target.y;
			ms_Target.addEventListener(Event.ENTER_FRAME, onMoveHandle);
		}
		
		protected function onMoveHandle(event:Event):void
		{
			var dx:Number = ms_desX - ms_Target.x;
			var dy:Number = ms_desY - ms_Target.y;
			var radius:Number = Math.atan2(dy, dx);
			ms_xSpeed = Math.cos(radius) * ms_speed;
			ms_ySpeed = Math.sin(radius) * ms_speed;
			ms_Target.x += ms_xSpeed;
			ms_Target.y += ms_ySpeed;
		}
		
		
		
		public function set target(value:DisplayObject):void
		{
			this.ms_Target = value;
		}
		
		public function setMoveInfo(des_pt:Point,src_pt:Point=null,speed:Number=0,endfun:Function=null,rectify_pt:Point = null):void
		{
			ms_desPt = des_pt;
			ms_Speed = speed;
			ms_timeEndFunc = endfun;
			if(src_pt)
			{
				ms_srcPt = src_pt;
			}
			else
			{
				ms_srcPt = new Point(ms_Target.x,ms_Target.y);
			}
			ms_retPt = rectify_pt;
		}
		/*
		public function Play():Number
		{
			var speed:Number = ms_Speed;
			var need_time:Number = int(Point.distance(ms_srcPt,ms_desPt)/speed);
			need_time = need_time==0?1:need_time;
			ms_xTotal = int((ms_desPt.x - ms_srcPt.x)/speed);
			ms_yTotal = int((ms_desPt.y - ms_srcPt.y)/speed);
			ms_xSpeed = ms_desPt.x - ms_srcPt.x>0?1:-1;
			ms_ySpeed = ms_desPt.y - ms_srcPt.y>0?1:-1;
			trace("[move_effect] target:",ms_Target,"from:",ms_srcPt,"to:",ms_desPt,"need_time:",need_time)
			if(this.running)
			{
				this.Stop();
			}
			ms_Timer  = new Timer(ms_fraps,ms_xTotal>ms_yTotal?ms_xTotal:ms_yTotal);
			ms_Timer.addEventListener(TimerEvent.TIMER,OnMoveEffect);
			ms_Timer.addEventListener(TimerEvent.TIMER_COMPLETE,OnMoveEffectEnd);
			ms_Timer.start();
			return (need_time);
		}*/
		/*
		private function OnMoveEffect(evt:TimerEvent):void
		{
			if(ms_retPt)
			{
				if(Math.abs(ms_Target.x - ms_retPt.x)<ms_xSpeed || Math.abs(ms_Target.y - ms_retPt.y)<ms_ySpeed)
				{
					ms_Timer.stop();
					if(ms_timeEndFunc!=null)
					{
						var event:CustomEvent = new CustomEvent(EFFECT_EVENT_COMPLETE);
						event.event_data = ms_Target;
						event.src_Pt       = ms_srcPt;
						event.des_Pt	   = ms_desPt;
						event.ret_Pt	   = ms_retPt;
						event.crt_Pt	   = new Point(ms_Target.x,ms_Target.y);
						ms_timeEndFunc(event)
					}
					//ms_xSpeed = ms_ySpeed = 0;
				}
			}
			if(ms_Timer.currentCount <= ms_xTotal)
			{
				ms_Target.x += ms_xSpeed;
			}
			if(ms_Timer.currentCount <= ms_yTotal)
			{
				ms_Target.y += ms_ySpeed;
			}
		}*/
		public function Play():Number
		{
			var speed:Number = ms_Speed;
			var need_time:Number = int(Point.distance(ms_srcPt,ms_desPt)/speed);
			need_time = need_time==0?1:need_time;
			ms_xSpeed = (ms_desPt.x - ms_srcPt.x)/need_time;
			ms_ySpeed = (ms_desPt.y - ms_srcPt.y)/need_time;
			trace("[move_effect] target:",ms_Target,"from:",ms_srcPt,"to:",ms_desPt,"rectify",ms_retPt,"need_time:",need_time)
			if(this.running)
			{
				this.Stop();
			}
			ms_Timer  = new Timer(ms_fraps,need_time);
			ms_Timer.addEventListener(TimerEvent.TIMER,OnMoveEffect);
			ms_Timer.addEventListener(TimerEvent.TIMER_COMPLETE,OnMoveEffectEnd);
			ms_Timer.start();
			return (need_time);
		}
		
		private function OnMoveEffect(evt:TimerEvent):void
		{
			ms_Target.x += ms_xSpeed;
			ms_Target.y += ms_ySpeed;
		}
		
		private function OnMoveEffectEnd(evt:TimerEvent):void
		{
			ms_Timer.removeEventListener(TimerEvent.TIMER_COMPLETE,OnMoveEffectEnd);
			ms_Target.x = ms_desPt.x;
			ms_Target.y = ms_desPt.y;
			if(ms_timeEndFunc!=null)
			{
				var event:CustomEvent = new CustomEvent(EFFECT_EVENT_COMPLETE);
				event.event_data = ms_Target;
				event.src_Pt       = ms_srcPt;
				event.des_Pt	   = ms_desPt;
				event.ret_Pt	   = ms_retPt?ms_retPt:ms_desPt;
				event.crt_Pt	   = new Point(ms_Target.x,ms_Target.y);
				ms_timeEndFunc(event)
			}
		}
		
		public function get running():Boolean
		{
			return ms_Timer ? ms_Timer.running : false;
		}
		
		public function Stop():void
		{
			if(ms_Timer && this.running)
			{
				ms_Timer.reset();
				ms_Timer = null;
			}
		}
	}
}