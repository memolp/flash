package Extends.CUICompents.CText
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class CDriftText extends CMText
	{
		private var ms_Timer:Timer = null;
		public function CDriftText(text:String,isExtend:String,delay:Number=30)
		{
			super();
			ms_Timer = new Timer(100,delay);
			ms_Timer.addEventListener(TimerEvent.TIMER,OnDriftTimer);
			ms_Timer.addEventListener(TimerEvent.TIMER_COMPLETE,OnRemoveSelf);
			ms_Timer.start();
			var color:uint =int(isExtend)==0? 0x0000FF:0xFF0000;
			this.setTextStyle(null,color,true,20+5*int(isExtend));
			this.text = text;
		}
		private function OnDriftTimer(evt:TimerEvent):void
		{
			this.y -=2; 
		}
		private function OnRemoveSelf(evt:TimerEvent):void
		{
			this.parent.removeChild(this);
		}
	}
}