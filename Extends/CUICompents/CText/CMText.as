package Extends.CUICompents.CText
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class CMText extends Sprite
	{
		protected var ms_text:TextField = new TextField();
		public function CMText()
		{
			super();
			this.onInitCanvas();
		}
		
		/**
		 * 初始化
		 */
		protected function onInitCanvas():void
		{
			this.onTextDefaultType();
			this.addChild(ms_text);
			//trace("CMText.onInitCanvas");
		}
		
		/**
		 * 设置文本默认效果
		 */
		protected function onTextDefaultType():void
		{
			ms_text.htmlText = "TextSimple";
			ms_text.autoSize = TextFieldAutoSize.LEFT;
		}
		
		/**
		 * 左对齐
		 */
		public function setTextLeft():void
		{
			ms_text.autoSize = TextFieldAutoSize.LEFT;
		}
		
		/**
		 * 居中对齐
		 */
		public function setTextCenter():void
		{
			ms_text.autoSize = TextFieldAutoSize.CENTER;
		}
		
		/**
		 * 右对齐
		 */
		public function setTextRight():void
		{
			ms_text.autoSize = TextFieldAutoSize.RIGHT;
		}
		
		/**
		 * 不自动对齐，默认大小100*100像素
		 */
		public function setTextNone():void
		{
			ms_text.autoSize = TextFieldAutoSize.NONE;
		}
		
		public function set text(value:String):void
		{
			ms_text.htmlText = value;
			//ms_text.text = value;
		}
		
		public function get text():String
		{
			return ms_text.htmlText;
		}
		
		public function appendText(text:String):String
		{
			//ms_text.htmlText += text;
			ms_text.appendText(text);
			return ms_text.htmlText;
		}
		
		/**
		 * 字体效果设置
		 * @param	filter  渲染的方式BlueFilter等等
		 * @param	isReplace 是否替换已经存在的效果
		 */
		public function setTextFilter(filter:Object,isReplace:Boolean=false):void
		{
			var oldfter:Array = ms_text.filters;
			if (isReplace)
			{
				oldfter = [];
			}
			oldfter.push(filter);
			ms_text.filters = oldfter;
		}
		
		/**
		 * 设置字体颜色
		 */
		public function set TextColor(color:uint):void
		{
			ms_text.textColor = color;
		}
		
		/**
		 * 设置图片背景
		 * @param bit 图片的BitmapData
		 * @param cx 设置文本控件的x偏移量
		 * @param cy 设置文本控件的y偏移量
		 */
		public function setBmpData(bit:BitmapData,cx:Number=0,cy:Number=0):void
		{
			var bmp:Bitmap = new Bitmap(bit);
			ms_text.x = cx;
			ms_text.y = cy;
			ms_text.background = false;
			ms_text.border = false;
			this.addChildAt(bmp,0);
		}
		
		override public function get width():Number 
		{
			return ms_text.width;
		}
		
		override public function set width(value:Number):void 
		{
			ms_text.width = value;
			//super.width = value;
		}
		
		override public function get height():Number 
		{
			return ms_text.height;
		}
		
		override public function set height(value:Number):void 
		{
			ms_text.height = value;
			//super.height = value;
		}
		
		public function setTextStyle(font:String = null,color:uint=0x000000, bold:Boolean = false, size:int = 12):void
		{
			var textF:TextFormat = new TextFormat();
			textF.font = font;
			textF.bold = bold;
			textF.size = size;
			textF.color = color;
			//this.setTextFormat(textF);
			ms_text.defaultTextFormat = textF;
		}
		
		public function setTextFormat(fmt:TextFormat):void
		{
			ms_text.setTextFormat(fmt);
		}
		
		public function set autoWarp(value:Boolean):void
		{
			ms_text.multiline = value;
			ms_text.wordWrap = value;
			//this.width = 300;
		}
		
	}
}