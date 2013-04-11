package Extends.CLoader
{
	import Extends.CEvent.CustomEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	
	public class CMLoader extends EventDispatcher
	{
		static protected var LOAD_SINGLE_END:String = "LOAD_SINGLE_END";
		
		static protected var cacheAList:Dictionary = new Dictionary(false);
		static protected var only_one_instance:CMLoader = null;
		
		private var ms_curLoadinfo:eLoadInfo = null;
		private var ms_loadingStatus:Boolean = false;
		private var ms_loadList:Array = new Array();
		
		public function CMLoader(cls:eLoadInfo) 
		{
			this.addEventListener(LOAD_SINGLE_END,onLoadSingleEnd);
		}
		
		static public function get CLoader():CMLoader
		{
			if (only_one_instance == null)
			{
				only_one_instance = new CMLoader(new eLoadInfo());
			}
			return only_one_instance;
			
		}
		
		/**
		 * 添加加载内容
		 * @param src 文件路径
		 * @param type 加载文件类型
		 * @param keyword 设置关键字访问
		 */ 
		public function addLoadsrc(url:String,type:String=CMLoaderMethod.LOAD_IMAGE,keyword:String=null):void
		{
			if(!cacheAList.hasOwnProperty(url))
			{
				var loadinfo:eLoadInfo = new eLoadInfo();
				loadinfo.url		= url;
				loadinfo.type		= type;
				loadinfo.status		= CMLoaderMethod.LOAD_STATUS_NONE;;
				if(keyword)
				{
					loadinfo.key 		= keyword;
				}
				ms_loadList.push(loadinfo);
			}
			
		}
		
		/**
		 * 直接加载内容
		 * @param src 文件路径
		 * @param type 加载文件类型
		 * @param keyword 设置关键字访问
		 */ 
		public function startLoadsrc(url:String,type:String=CMLoaderMethod.LOAD_IMAGE,endfunc:Function=null,keyword:String=null):void
		{
			if(!cacheAList.hasOwnProperty(url))
			{
				var loadinfo:eLoadInfo = new eLoadInfo();
				loadinfo.url		= url;
				loadinfo.type		= type;
				loadinfo.status		= CMLoaderMethod.LOAD_STATUS_NOW;
				if(endfunc != null)
				{
					loadinfo.endfunc = endfunc;
				}
				if(keyword)
				{
					loadinfo.key 		= keyword;
				}
				this._load(loadinfo);
			}
			else
			{
				if(endfunc != null)
				{
					endfunc(cacheAList[url])
				}
				else
				{
					this._loadAllEnd();
				}
			}
		}
		
		public function startLoad():void
		{
			if (!ms_loadingStatus && ms_loadList.length >= 1)
			{
				this._load(ms_loadList.shift());
			}
		}
		
		public function stopLoad():void
		{
			ms_loadingStatus = true;
		}
		
		protected function onLoadSingleEnd(event:CustomEvent):void
		{
			if (!ms_loadingStatus && ms_loadList.length >= 1)
			{
				this._load(ms_loadList.shift());
			}
			else
			{
				this._loadAllEnd();
			}
		}
		
		protected function _loadAllEnd():void
		{
			var evt:CustomEvent = new CustomEvent(CMLoaderMethod.LOAD_EVENT_COMPLETE);
			this.dispatchEvent(evt);
		}
		protected function _load(loadinfo:eLoadInfo):void
		{
			ms_loadingStatus = true;
			var load:* = null;
			switch(loadinfo.type)
			{
				case CMLoaderMethod.LOAD_FILE:
					load = new URLLoader();
					load.addEventListener(Event.COMPLETE,onLoadFileEnd);
					load.addEventListener(IOErrorEvent.IO_ERROR,onLoadError);
					break;
				case CMLoaderMethod.LOAD_BIN_FILE:
					load = new URLLoader();
					load.dataFormat = URLLoaderDataFormat.BINARY;
					load.addEventListener(Event.COMPLETE,onLoadBinFileEnd);
					load.addEventListener(IOErrorEvent.IO_ERROR,onLoadError);
					break;
				case CMLoaderMethod.LOAD_IMAGE:
					//trace(loadinfo.url);
					load = new CLoaderBase(loadinfo);
					load.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadImage);
					load.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onLoadError);
					break;
				case CMLoaderMethod.LOAD_SWF:
					load = new CLoaderBase(loadinfo);
					load.contentLoaderInfo.addEventListener(Event.INIT,onLoadSwfEnd);
					load.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onLoadError);
					break;
				default:break;
			}
			if(load)
			{
				ms_curLoadinfo = loadinfo;
				load.load(new URLRequest(loadinfo.url));
			}
		}
		
		protected function onLoadFileEnd(evt:Event):void
		{
			var load:URLLoader = evt.target as URLLoader;
			load.removeEventListener(Event.COMPLETE,onLoadFileEnd);
			
			ms_curLoadinfo.data = load.data;
			cacheAList[ms_curLoadinfo.url] = ms_curLoadinfo;
			this.onLoadEnd(ms_curLoadinfo);
		}
		
		protected function onLoadBinFileEnd(evt:Event):void
		{
			var load:URLLoader = evt.target as URLLoader;
			load.removeEventListener(Event.COMPLETE, onLoadBinFileEnd);
			
			ms_curLoadinfo.data = load.data;
			cacheAList[ms_curLoadinfo.url] = ms_curLoadinfo;
			this.onLoadEnd(ms_curLoadinfo);
		}
		
		protected function onLoadSwfEnd(evt:Event):void
		{
			var load:CLoaderBase = (evt.currentTarget as LoaderInfo).loader as CLoaderBase;
			load.contentLoaderInfo.removeEventListener(Event.INIT, onLoadSwfEnd);
			
			ms_curLoadinfo.data = load.contentLoaderInfo.applicationDomain;
			cacheAList[ms_curLoadinfo.url] = ms_curLoadinfo;
			this.onLoadEnd(ms_curLoadinfo);
		}
		
		protected function onLoadImage(evt:Event):void
		{
			
			var load:CLoaderBase = (evt.currentTarget as LoaderInfo).loader as CLoaderBase;
			load.contentLoaderInfo.removeEventListener(Event.COMPLETE,onLoadImage);
			
			var eloadInfo:eLoadInfo = load.saveData;
			//trace(eloadInfo.url);
			eloadInfo.data = (load.content as Bitmap).bitmapData;
			cacheAList[eloadInfo.url] = eloadInfo;
			this.onLoadEnd(eloadInfo);
		}
		
		protected function onLoadEnd(loadinfo:eLoadInfo):void
		{
			ms_loadingStatus = false;
			if(loadinfo.hasOwnProperty("endfunc"))
			{
				loadinfo.endfunc(loadinfo);
			}
			else
			{
				var event:CustomEvent = new CustomEvent(LOAD_SINGLE_END,false,true);
				event.loadinfo = loadinfo;
				this.dispatchEvent(event);
			}
		}
		
		protected function onLoadError(evt:IOErrorEvent):void
		{
			trace("[CMLoader] error=加载失败", evt.text);
			this.onLoadEnd(ms_curLoadinfo);
		}
		
		public function onGetSWF(url:String,className:String = null):*
		{
			if(cacheAList.hasOwnProperty(url) && cacheAList[url].hasOwnProperty("data"))
			{
				var app:ApplicationDomain = cacheAList[url].data;
				if (className && app.hasDefinition(className))
				{
					var cls:Class = app.getDefinition(className) as Class;
					return new cls();
				}
				else
				{
					return app;
				}
			}
			return null;
		}
		
		public function onGetClass(url:String,className:String):Class
		{
			if (cacheAList.hasOwnProperty(url))
			{
				return cacheAList[url].data.getDefinition(className) as Class;
			}
			return null;
		}
		public function onGetClassKwd(kwd:String,className:String):Class
		{
			for each(var eload:eLoadInfo in cacheAList)
			{
				if(eload.hasOwnProperty("key") && eload.key == kwd)
				{
					var bit:ApplicationDomain = eload.data as ApplicationDomain;
					if (bit)
					{
						return bit.getDefinition(className) as Class;
					}
					return null;
				}
			}
			return null;
		}
		
		public function onGetBitData(id:String):BitmapData
		{
			if (cacheAList.hasOwnProperty(id))
			{
				var bit:BitmapData = cacheAList[id].data as BitmapData;
				if (bit)
				{
					return bit.clone();
				}
				trace("[onGetBitData] no bitmapData")
				return null;
			}
			return null;
		}
		
		public function onGetBitDataKwd(kwd:String):BitmapData
		{
			for each(var eload:eLoadInfo in cacheAList)
			{
				if(eload.hasOwnProperty("key") && eload.key == kwd)
				{
					var bit:BitmapData = eload.data as BitmapData;
					if (bit)
					{
						return bit.clone();
					}
					return null;
				}
			}
			return null;
		}
		
		public function onGetFileData(url:String):*
		{
			if(cacheAList.hasOwnProperty(url))
			{
				return cacheAList[url].data;
			}
			trace("[waring]:onGetFileData has not id",url)
			return null;
		}
		
		public function onGetFileDataKwd(kwd:String):*
		{
			for each(var eload:eLoadInfo in cacheAList)
			{
				if(eload.hasOwnProperty("key") && eload.key == kwd)
				{
					return eload.data;
				}
			}
			return null;
		}
		
		/*public function addURLLoad(src:String,id:String,type:String=LOAD_TYPE_FILE):void
		{
		if(!cacheAList.hasOwnProperty(src))
		{
		if (type == LOAD_TYPE_FILE || type == LOAD_TYPE_BIN_FILE)
		{
		var loadinfo:Object = new Object();
		loadinfo.url 		= src;
		loadinfo.type		= type;
		loadinfo.status		= LOAD_STATUS_UNLOAD;
		loadinfo.id 		= id;
		ms_loadList.push(loadinfo);
		}
		}
		}
		*/
		/**
		 * @param src 文件路径
		 * @param id  设置的存储唯一ID
		 * @param type 加载文件类型
		 * @param handle 设置加载完城调用函数
		 */ 
		/*public function addLoad(src:String,id:String,type:String=LOAD_TYPE_IMAGE,handle:Function=null):void
		{
		//trace(src);
		if(!cacheAList.hasOwnProperty(src))
		{
		if (type == LOAD_TYPE_IMAGE || type == LOAD_TYPE_SWF)
		{
		var loadinfo:Object = new Object();
		loadinfo.url		= src;
		loadinfo.type		= type;
		loadinfo.status		= LOAD_STATUS_UNLOAD;
		loadinfo.id 		= id;
		if(Boolean(handle))
		{
		loadinfo.isCallBack = true;
		loadinfo.callfun	= handle;
		}
		else
		{
		loadinfo.isCallBack = false;
		}
		ms_loadList.push(loadinfo);
		}
		}
		}
		*/
		/*public function onLoad(src:String,handle:Function,type:String=LOAD_TYPE_IMAGE):void
		{
		if(!cacheAList.hasOwnProperty(src))
		{
		if (type == LOAD_TYPE_IMAGE || type == LOAD_TYPE_SWF)
		{
		var loadinfo:Object = new Object();
		loadinfo.url		= src;
		loadinfo.type		= type;
		loadinfo.status		= LOAD_STATUS_UNLOAD;
		loadinfo.isCallBack = true;
		loadinfo.callfun	= handle;
		loadinfo.id 		= src;
		//ms_loadList.push(loadinfo);
		this._load(loadinfo);
		}
		}
		else
		{
		handle(src)
		}
		}
		*/
		
	}
}

dynamic class eLoadInfo
{
	public var url:String = null;
	public var type:String = null;
	public var status:String = null;
	public function eLoadInfo()
	{
		
	}
}

