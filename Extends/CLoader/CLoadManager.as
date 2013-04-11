package Extends.CLoader
{
	import Extends.CUtils.md5.MD5;
	
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
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import Extends.CEvent.CustomEvent;
	
	public class CLoadManager extends EventDispatcher
	{
		
		static public const LOAD_EVENT_COMPLETE:String = "LOAD_EVENT_COMPLETE";
		
		static public const LOAD_TYPE_FILE:String="LOAD_TYPE_FILE";
		static public const LOAD_TYPE_BIN_FILE:String ="LOAD_TYPE_BIN_FILE";
		static public const LOAD_TYPE_SWF:String = "LOAD_TYPE_SWF";
		static public const LOAD_TYPE_IMAGE:String = "LOAD_TYPE_IMAGE";
		
		static protected const LOAD_STATUS_UNLOAD:String = "LOAD_STATUS_UNLOAD";
		static protected const LOAD_STATUS_LOADING:String = "LOAD_STATUS_LOADING";
		static protected const LOAD_STATUS_LOADEND:String = "LOAD_STATUS_LOADEND";
		static protected const LOAD_STATUS_LOADERROR:String = "LOAD_STATUS_LOADERROR";
		
		static protected var cacheAList:Dictionary = new Dictionary(true);
		
		static protected var only_one_instance:CLoadManager = null;
		
		private var ms_curLoadinfo:Object = null;
		private var ms_loadingStatus:Boolean = false;
		private var ms_loadList:Array = new Array();
		
		public function CLoadManager(cls:privateClass) 
		{
			
		}
		
		static public function get CLoader():CLoadManager
		{
			if (only_one_instance == null)
			{
				only_one_instance = new CLoadManager(new privateClass());
			}
			return only_one_instance;
			
		}
		public function addURLLoad(src:String,id:String,type:String=LOAD_TYPE_FILE):void
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
		
		/**
		 * @param src 文件路径
		 * @param id  设置的存储唯一ID
		 * @param type 加载文件类型
		 * @param handle 设置加载完城调用函数
		 */ 
		public function addLoad(src:String,id:String,type:String=LOAD_TYPE_IMAGE,handle:Function=null):void
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
					loadinfo.id 		= src;
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
		
		public function onLoad(src:String,handle:Function,type:String=LOAD_TYPE_IMAGE):void
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
		
		public function startLoad():void
		{
			if (ms_loadList.length >= 1)
			{
				if(!ms_loadingStatus)
				{
					ms_loadingStatus = true;
					var loadinfo:Object = ms_loadList.shift();
					this._load(loadinfo);
				}
			}
			else
			{
				var evt:CustomEvent = new CustomEvent(LOAD_EVENT_COMPLETE);
				this.dispatchEvent(evt);
			}
			
		}
		
		public function stopLoad():void
		{
			
		}
		
		protected function _load(loadinfo:Object):void
		{
			var load:* = null;
			switch(loadinfo.type)
			{
				case LOAD_TYPE_FILE:
					load = new URLLoader();
					trace("load:",LOAD_TYPE_FILE);
					load.addEventListener(Event.COMPLETE,onLoadFileEnd);
					load.addEventListener(IOErrorEvent.IO_ERROR,onLoadError);
					break;
				case LOAD_TYPE_BIN_FILE:
					load = new URLLoader();
					trace("load:",LOAD_TYPE_BIN_FILE);
					load.dataFormat = URLLoaderDataFormat.BINARY;
					load.addEventListener(Event.COMPLETE,onLoadBinFileEnd);
					load.addEventListener(IOErrorEvent.IO_ERROR,onLoadError);
					break;
				case LOAD_TYPE_IMAGE:
					load = new Loader();
					//trace("load:",LOAD_TYPE_IMAGE);
					load.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadImage);
					load.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onLoadError);
					break;
				case LOAD_TYPE_SWF:
					load = new Loader();
					//trace("load:",LOAD_TYPE_SWF);
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
			ms_loadingStatus = false;
			var load:URLLoader = evt.target as URLLoader;
			cacheAList[ms_curLoadinfo.id] = evt.target.data;
			//trace(evt.target.data);
			load.removeEventListener(Event.COMPLETE,onLoadFileEnd);
			this.startLoad();
		}
		
		protected function onLoadBinFileEnd(evt:Event):void
		{
			ms_loadingStatus = false;
			var load:URLLoader = evt.target as URLLoader;
			cacheAList[ms_curLoadinfo.id] = load.data as ByteArray;
			trace(cacheAList[ms_curLoadinfo.id]);
			trace(ms_curLoadinfo.id)
			load.removeEventListener(Event.COMPLETE, onLoadBinFileEnd);
			/*if(ms_curLoadinfo.isCallBack)
			{
				ms_curLoadinfo.callfun(ms_curLoadinfo.id);
			}*/
			this.startLoad();
		}
		
		protected function onLoadSwfEnd(evt:Event):void
		{
			ms_loadingStatus = false;
			var load:Loader = (evt.currentTarget as LoaderInfo).loader as Loader;
			cacheAList[ms_curLoadinfo.id] = load.contentLoaderInfo.applicationDomain;
			load.contentLoaderInfo.removeEventListener(Event.INIT, onLoadSwfEnd);
			if(ms_curLoadinfo.isCallBack)
			{
				ms_curLoadinfo.callfun(ms_curLoadinfo.id);
			}
			this.startLoad();
		}
		
		protected function onLoadImage(evt:Event):void
		{
			ms_loadingStatus = false;
			var load:Loader = (evt.currentTarget as LoaderInfo).loader as Loader;
			cacheAList[ms_curLoadinfo.id] = (load.content as Bitmap).bitmapData;
			load.contentLoaderInfo.removeEventListener(Event.COMPLETE,onLoadImage);
			if(ms_curLoadinfo.isCallBack)
			{
				ms_curLoadinfo.callfun(ms_curLoadinfo.id);
			}
			this.startLoad();
		}
		protected function onLoadError(evt:IOErrorEvent):void
		{
			var load:LoaderInfo = evt.currentTarget as LoaderInfo;
			trace("加载失败", evt.text);
			ms_loadingStatus = false;
			this.startLoad();
		}
		
		public function onGetClass(id:String,className:String):Class
		{
			if (cacheAList.hasOwnProperty(id))
			{
				return cacheAList[id].getDefinition(className) as Class;
			}
			return null;
		}
		
		public function onGetBitData(id:String):BitmapData
		{
			if (cacheAList.hasOwnProperty(id))
			{
			//	trace(id,cacheAList[id])
				return (cacheAList[id] as BitmapData).clone();
			}
			return null;
		}
		
		public function onGetFileData(id:String):*
		{
			if(cacheAList.hasOwnProperty(id))
			{
				return cacheAList[id];
			}
			trace("[waring]:onGetFileData has not id",id)
			return null;
		}
		
	}
}

class privateClass
{
	
}

