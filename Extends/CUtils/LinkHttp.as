package Extends.CUtils
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;
	
	public class LinkHttp
	{
		private var ms_IP:String;
		private var ms_urlValue:URLVariables = new URLVariables();
		public function LinkHttp()
		{
		}
		public function set httpHost(ip:String):void
		{
			ms_IP = ip;
		}
		public function set httpVariables(argsList:Array):void
		{
			if(argsList.length%2 != 0)
			{
				throw(new Error("argsList is not format"));
			}
			else
			{
				
				for(var index:int=0;index<argsList.length;index+=2)
				{	
					ms_urlValue[argsList[index]] = argsList[index+1]
				}
			}
		}
		public function HttpGet():URLLoader
		{
			var url:String = this.GetURL(ms_IP);
			var urlRqust:URLRequest = new URLRequest();
			urlRqust.url = url;
			urlRqust.data = ms_urlValue.toString();
			urlRqust.method = URLRequestMethod.GET;
			var urlLoad:URLLoader = new URLLoader();
			urlLoad.load(urlRqust);
			trace(urlRqust.data,urlRqust.url);
			return urlLoad;
		}
		public function HttpGets(ip:String,username:String,password:String):URLLoader
		{
			var url:String = GetURL(ip);
			var tm:Date    = new Date()
			var urlValue:URLVariables = new URLVariables();
			var utf:ByteArray = new ByteArray();
			utf.writeUTFBytes(username);
			utf.position =0;
			urlValue.username = utf.readUTFBytes(utf.length);
			urlValue.passwd   = password;
			urlValue.act      = "check";
			urlValue.para     = tm.getTime();
			
			var urlReq:URLRequest = new URLRequest();
			urlReq.url        = url;
			urlReq.data       = urlValue.toString();
			urlReq.method     = URLRequestMethod.GET;
			trace(url);
			trace(urlValue);
			var urlLoad:URLLoader = new URLLoader();
			trace(urlReq);
			urlLoad.load(urlReq);
			return urlLoad;
		}
		
		private function GetURL(host:String):String
		{
			if(!host.match("^http://"))
			{
				host = "http://"+host;
			}
			if(host.charAt(host.length-1) !=("/"))
			{
				host += "/cgi-bin/entry.cgi";
			}
			else
			{
				host += "cgi-bin/entry.cgi";
			}
			return host
		}
	}
}