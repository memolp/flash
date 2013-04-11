package Extends.CUICompents.CAnimation.CPicList 
{
	import Extends.CustomApp.CustomEvent;
	import Extends.CustomApp.LoadManager;
	import Extends.CUICompents.CAnimation.CPicList.CMBmpMethod;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author JeffXun
	 */
	public class CMPicAnimation extends Sprite 
	{
		//[Embed(source = "")]
		//static protected const ms_defualtBmp:Class;
		
		static public const ANIMATE_EVENT_READY:String = "ANIMATE_EVENT_READY";
		static public const ANIMATE_STYLE_ONLY_ONE:String = "ANIMATE_STYLE_ONLY_ONE";
		static public const ANIMATE_STYLE_REPLAY:String = "ANIMATE_STYLE_REPLAY";
		
		private var ms_imageInfo:CMPicStruct = null;
		private var ms_imageList:CPicLists = new CPicLists();
		
		private var ms_bmp:Bitmap = new Bitmap()//new ms_defualtBmp;
		private var ms_Tmpbmp:Bitmap = null;
		private var ms_bmpList:Array = new Array();
		
		private var ms_Time:Timer = null;
		private var ms_Fraps:int = 100;
		private var ms_curStatus:String = null;
		private var ms_playStyle:String = null;
		private var ms_defaultStatus:String = null;
		
		private var ms_width:Number = 0;
		private var ms_height:Number = 0;
		
		/**
		 * 
		 * @param	image_info CMPicStruct对象
		 * @param	fraps 动画频率单位毫秒
		 */
		public function CMPicAnimation(image_info:CMPicStruct, fraps:int = 100/*minseconds*/) 
		{
			ms_imageInfo = image_info;
			ms_Fraps     = fraps;
			ms_defaultStatus = "0";

			this.OnInitPicAnimation();
			//this.addEventListener(Event.ADDED_TO_STAGE, OnInitPicAnimation);
		}
		
		protected function OnInitPicAnimation(evt:Event=null):void
		{
			//this.removeEventListener(Event.ADDED_TO_STAGE, OnInitPicAnimation);
			ms_Time      = new Timer(ms_Fraps);
			ms_Time.addEventListener(TimerEvent.TIMER, OnPicTimerShow);
			LoadManager.LoadSource(ms_imageInfo.source, LoadPicSourceEnd, null);
		}
		
		private function LoadPicSourceEnd(evt:Event):void
		{
			if (ms_imageInfo.xmlContent)
			{
				LoadManager.LoadSource(ms_imageInfo.xmlContent, LoadPicXmlContentEnd, null, LoadManager.FILE);
				ms_Tmpbmp = Bitmap(evt.target.content);
			}
			else
			{
				this.splitSimpleImage(Bitmap(evt.target.content));
				//trace("ss")
				this.dispatchEvent(new CustomEvent(CMPicAnimation.ANIMATE_EVENT_READY));
			}
		}
		
		private function LoadPicXmlContentEnd(evt:Event):void
		{
			var bmpXml:XML = new XML(evt.target.data);
			this.splitContenImage(ms_Tmpbmp, CMBmpMethod.CAnimationXml(bmpXml));
			this.dispatchEvent(new CustomEvent(CMPicAnimation.ANIMATE_EVENT_READY));
		}
		
		private function splitContenImage(bmp:Bitmap, content:Array):void
		{
			for each (var linestyle:Object in content)
			{
				var bitArray:Array = new Array();
				for each (var rect:Rectangle in linestyle.bitArray)
				{
					bitArray.push(CMBmpMethod.splitBmpData(bmp.bitmapData, rect));
				}
				ms_imageList.appendProperty(linestyle.style,bitArray);
			}
			if (ms_curStatus)
			{
				this._OnAnimate(ms_curStatus, ANIMATE_STYLE_REPLAY);
			}
			else if(ms_defaultStatus) 
			{
				this._OnAnimate(ms_defaultStatus, ANIMATE_STYLE_REPLAY);
			}
		}
		
		private function splitSimpleImage(bmp:Bitmap):void
		{
			var line:int = ms_imageInfo.imageLine;
			var row:int  = ms_imageInfo.imageRow;
			var rdex:Number  = bmp.width / row;
			var ldex:Number  = bmp.height / line;
			for (var l:int = 0; l < line; l++)
			{
				var nlist:Array = new Array();
				for (var r:int = 0; r < row; r++)
				{
					var rt:Rectangle = new Rectangle(r*rdex, ldex*l, rdex , ldex );
					nlist.push(CMBmpMethod.splitBmpData(bmp.bitmapData, rt));
				}
				ms_imageList.appendProperty(l.toString(), nlist);
			}
			if (ms_curStatus)
			{
				this._OnAnimate(ms_curStatus, ANIMATE_STYLE_REPLAY);
			}
			else if(ms_defaultStatus) 
			{
				this._OnAnimate(ms_defaultStatus, ANIMATE_STYLE_REPLAY);
			}
		}

		private function _OnAnimate(status:String,type:String=ANIMATE_STYLE_ONLY_ONE):void
		{
			ms_curStatus = status;
			ms_playStyle = type;
			ms_bmpList = ms_imageList.getPicByProperty(ms_curStatus) as Array
			if (ms_Time.running)
			{
				this.OnTimerStop();
			}
			ms_bmp.bitmapData = ms_bmpList[0];
			ms_Time.start();
			this.addChild(ms_bmp);
			var evt:CustomEvent = new CustomEvent("WM_ANIMATION_SIZE");
			evt.width = ms_bmp.width;
			evt.height = ms_bmp.height;
			this.dispatchEvent(evt);
		}
		
		public function OnAnimate(status:String, type:String = ANIMATE_STYLE_ONLY_ONE):void
		{
			this._OnAnimate(status, type);
		}
		
		public function get AnimationStatus():Array
		{
			return ms_imageList.keys;
		}
		
		private function OnPicTimerShow(evt:TimerEvent):void
		{
			ms_bmp.bitmapData = ms_bmpList[ms_Time.currentCount - 1];
			if (ms_Time.currentCount >= ms_bmpList.length)
			{
				if (ms_playStyle == ANIMATE_STYLE_REPLAY)
				{
					this.OnTimerReset();
				}
				else 
				{
					this.OnTimerStop();
				}
			}
		}
		
		private function OnTimerReset():void
		{
			ms_Time.stop();
			ms_Time.reset();
			ms_Time.start();
		}
		
		private function OnTimerStop():void
		{
			ms_Time.stop();
			ms_Time.reset();
		}
		
		/*public function clone():CMPicAnimation
		{
			//return  new CMPicAnimation(ms_imageInfo,ms_defaultStatus,ms_Fraps,ms_imageList);
		}*/
		
		override public function get width():Number 
		{
			if (ms_bmp)
			{
				return ms_bmp.width;
			}
			else
			{
				return super.width;
			}
		}
		
		override public function set width(value:Number):void 
		{
			super.width = value;
		}
		
		override public function get height():Number 
		{
			if (ms_bmp)
			{
				return ms_bmp.height;
			}
			else
			{
				return super.height;
			}
		}
		
		override public function set height(value:Number):void 
		{
			super.height = value;
		}
	}

}