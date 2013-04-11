package Extends.CUtils
{
	import Extends.CEvent.CustomEvent;
	import Extends.CLoader.CURLLoadBase;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	public class CHttpClient extends EventDispatcher
	{
		public static const HX_EVENT_LOAD_COMPLETE:String = "HX_EVENT_LOAD_COMPLETE";
		protected var ms_host:String = null;
		protected var ms_port:uint   = 0;
		protected var ms_loader:CURLLoadBase = null;
		public function CHttpClient()
		{
			super(null);
			ms_loader = new CURLLoadBase();
			ms_loader.addEventListener(Event.COMPLETE,onLoadUrlEnd);
			ms_loader.addEventListener(IOErrorEvent.IO_ERROR,onLoadUrlError);
			ms_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onLoadSecuriyeError);
		}
		
		public function onGetRequest(url:String,port:uint,data:Object):void
		{
			var urlrequst:URLRequest = new URLRequest();
			urlrequst.url = url;
			urlrequst.data = onFormatData(data);
			urlrequst.method = URLRequestMethod.GET;
			ms_loader.load(urlrequst);
			
		}
	
		protected function onLoadUrlEnd(event:Event):void
		{
			var evt:CustomEvent = new CustomEvent(HX_EVENT_LOAD_COMPLETE);
			evt.event_data = event.target.data;
			this.dispatchEvent(evt);
		}
		
		protected function onLoadUrlError(event:IOErrorEvent):void
		{
			trace(event.text);
		}
		
		protected function onLoadSecuriyeError(event:SecurityErrorEvent):void
		{
			trace(event.text);
		}
		
		public static function onFormatData(data:Object):URLVariables
		{
			var res:URLVariables = new URLVariables();
			for (var key:String in data)
			{
				res[key] = data[key];
			}
			return res;
		}
		
	}
}