package Extends.CEvent
{
	import flash.utils.Timer;
	
	public class CustemTimer extends Timer
	{
		public var argsList:*;
		public function CustemTimer(delay:Number,repeatCount:int=0,args:*=null)
		{
			super(delay, repeatCount);
			argsList =  args;
		}
	}
}