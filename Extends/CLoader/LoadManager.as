package Extends.CLoader
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class LoadManager extends Sprite
	{
		static public const BMP:String = "BMP";
		static public const SWF:String = "SWF";
		static public const FILE:String = "FILE";
		static protected var ms_LoadSource:Array = new Array();
		static protected var ms_Loading:Boolean = false;
		static protected var ms_current:Function = null;
		
		public function LoadManager()
		{
			super();
		}
		
		/**
		 * content
		 */ 
		static public function LoadSource(url:String, fun:Function, progress:Function = null, type:String = "BMP"):void
		{
			var source:Object = new Object();
			source['url'] = url;
			source['type'] = type;
			source['fun'] = fun;
			source['progress'] = progress;
			ms_LoadSource.push(source);
			if (!ms_Loading)
			{
				LoadManager._Loader();
			}
		}
		
		static private function _Loader():void
		{
			if (ms_LoadSource.length <= 0)
			{
				ms_Loading = false;
				return
			}
			var source:Object = ms_LoadSource.shift();
			ms_current = source['fun'];
			ms_Loading = true
			if (source['type'] == LoadManager.SWF)
			{
				var swfload:Loader = new Loader();
				swfload.contentLoaderInfo.addEventListener(Event.INIT, LoadManager.OnLoadSwfEnd);
				swfload.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, LoadManager.OnLoadError);
				if (source['progress'])
				{
					swfload.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, source['progress']);
				}
				swfload.load(new URLRequest(source['url']));
			}
			else if (source['type'] == LoadManager.BMP)
			{
				var bmpload:Loader = new Loader();
				bmpload.contentLoaderInfo.addEventListener(Event.COMPLETE, LoadManager.OnLoadBmpEnd);
				bmpload.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, LoadManager.OnLoadError);
				if (source['progress'])
				{
					bmpload.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, source['progress']);
				}
				bmpload.load(new URLRequest(source['url']));
			}
			else if (source['type'] == LoadManager.FILE)
			{
				var fileload:URLLoader = new URLLoader();
				fileload.addEventListener(Event.COMPLETE, LoadManager.OnLoadSourceEnd);
				fileload.addEventListener(IOErrorEvent.IO_ERROR, LoadManager.OnLoadError);
				if (source['progress'])
				{
					fileload.addEventListener(ProgressEvent.PROGRESS, source['progress']);
				}
				fileload.load(new URLRequest(source['url']));
			}
		}
		
		static private function OnLoadSwfEnd(evt:Event):void
		{
			ms_current(evt);
			ms_current = null
			LoadManager._Loader();
		}
		
		static private function OnLoadBmpEnd(evt:Event):void
		{
			ms_current(evt);
			ms_current = null
			LoadManager._Loader();
		}
		
		static private function OnLoadSourceEnd(evt:Event):void
		{
			ms_current(evt);
			ms_current = null
			LoadManager._Loader();
		}
		
		static private function OnLoadError(evt:IOErrorEvent):void
		{
			trace(evt.text,evt.type);
			LoadManager._Loader();
		}
	}
}