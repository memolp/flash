package Extends.CUICompents.CAnimation.CQuencePic 
{
	import Extends.CustomApp.CLoadManager;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	
	/**
	 * ...
	 * @author JeffXun
	 */
	public class CPicQuence extends Sprite 
	{
		private var ms_PicQuenceMode:CPicQuenceMode = null;
		
		public function CPicQuence() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onDisplayerUpdateHandle);
		}
		
		private function onDisplayerUpdateHandle(evt:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onDisplayerUpdateHandle);
			var mload:CLoadManager = CLoadManager.CLoader;
			mload.addLoad("./act.png", "act", CLoadManager.LOAD_TYPE_IMAGE);
			mload.addLoad("./人物1.swf", "s", CLoadManager.LOAD_TYPE_SWF);
			mload.addURLLoad("./index.html", "a", CLoadManager.LOAD_TYPE_BIN_FILE);
			mload.startLoad();
			mload.addEventListener(CLoadManager.LOAD_EVENT_COMPLETE, OnLoadSwfEnd);
		}
		
		private function OnLoadSwfEnd(evt:Event):void
		{
			var load:CLoadManager = evt.target as CLoadManager;
			var app:MovieClip = new (load.onGetClass("s", "wait"));
			this.addChild(app);
		}
	}

}