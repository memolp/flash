package Extends.CUICompents.CAnimate
{
	import Extends.CLoader.CMLoaderMethod;
	
	import flash.display.DisplayObject;
	
	public class CMAnimate extends DisplayObject
	{
		protected static var ms_default:DisplayObject = null;
		
		protected var ms_url:String = null;
		protected var ms_animate:DisplayObject = null;
		public function CMAnimate(url:String)
		{
			super();
		}
	}
}