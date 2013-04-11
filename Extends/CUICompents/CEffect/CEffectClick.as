package Extends.CUICompents.CEffect
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class CEffectClick extends Sprite
	{
		private var ms_Timer:Timer = null;
		private var ms_fraps:uint  = 100;
		private var ms_subTime:Number = 0;
		public function CEffectClick(sub_time:uint = 3)
		{
			this.mouseEnabled = false;
			this.ms_subTime = sub_time;
			this.addEventListener(Event.ADDED_TO_STAGE,OnAddToStage);
		}
		private function OnAddToStage(evt:Event):void
		{
			ms_Timer = new Timer(ms_fraps,ms_subTime);
			ms_Timer.addEventListener(TimerEvent.TIMER,OnTimer);
			ms_Timer.addEventListener(TimerEvent.TIMER_COMPLETE,OnTimerEnd);
			ms_Timer.start();
		}
		private function OnTimer(evt:TimerEvent):void
		{
			
		}
		private function OnTimerEnd(evt:TimerEvent):void
		{
			
		}
	}
}