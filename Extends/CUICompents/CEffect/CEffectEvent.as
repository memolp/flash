package Extends.CUICompents.CEffect
{
	import flash.events.Event;
	
	public class CEffectEvent extends Event
	{
		static public const EFFECT_COMPLETE:String = "COMPLETE";
		public function CEffectEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}