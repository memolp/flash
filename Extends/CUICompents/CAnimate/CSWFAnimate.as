package Extends.CUICompents.CAnimate
{
	import Extends.CLoader.CMLoader;
	import Extends.CLoader.CMLoaderMethod;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class CSWFAnimate extends Sprite
	{
		protected static var ms_default:DisplayObject = null;
		
		private var ms_url:String = null;
		private var ms_className:String = null;
		private var ms_animate:DisplayObject = null;
		public function CSWFAnimate(url:String,className:String=null)
		{
			ms_url = url;
			ms_className = className;
			CMLoader.CLoader.startLoadsrc(url,CMLoaderMethod.LOAD_SWF,this.onLoadAnimateEnd);
			this.addChild(this.Animate);
		}
		
		private function onLoadAnimateEnd(loadinfo:*):void
		{
			var res:DisplayObject = CMLoader.CLoader.onGetSWF(ms_url,ms_className) as DisplayObject;
			if (res)
			{
				this.Animate = res;
			}
		}
		protected function set Animate(value:DisplayObject):void
		{
			if(ms_animate && this.contains(ms_animate))
			{
				this.removeChild(ms_animate);	
			}
			ms_animate = value;
			this.addChild(ms_animate);
			
		}
		
		protected function get Animate():DisplayObject
		{
			if(ms_animate == null)
			{
				if(ms_default == null)
				{
					ms_default = new Sprite();
				}
				ms_animate = ms_default;
			}
			return ms_animate;
		}
		
		public function set className(value:String):void
		{
			ms_className = value;
			var res:DisplayObject = CMLoader.CLoader.onGetSWF(ms_url,ms_className) as DisplayObject;
			if (res)
			{
				this.Animate = res;
			}
		}
		
		public static function set DefaultAnimate(value:DisplayObject):void
		{
			ms_default = value;
		}
	}
}