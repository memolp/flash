package Extends.CUICompents.CText
{
	import flash.text.TextFormat;

	public class CRollTextModel
	{
		public static var ROLL_WAIT_TIME:uint =  5000;
		public static var ROLL_SPEED_TIME:uint = 100;
		public static const TEXT_STYLE_HROLL:String = "TEXT_STYLE_HROLL";
		public static const TEXT_STYLE_VROLL:String = "TEXT_STYLE_VROLL";
		public static const TEXT_STYLE_HROLL_ONCE:String = "TEXT_STYLE_HROLL_ONCE";
		public static const TEXT_STYLE_VROLL_ONCE:String = "TEXT_STYLE_VROLL_ONCE";
		
		private var ms_Content:String = null;
		private var ms_txtFmt:TextFormat = null;
		private var ms_rollWaitTime:uint = ROLL_WAIT_TIME;
		private var ms_rollSpeedTime:uint = ROLL_SPEED_TIME;
		private var ms_rollStyle:String = null;
		
		public function CRollTextModel(txt:String,font:String=null,color:uint=0,size:uint=12,bold:Boolean=true,
										rollStyle:String=TEXT_STYLE_HROLL)
		{
			this.txt = txt;
			ms_rollStyle = rollStyle;
			ms_txtFmt = new TextFormat(font,size,color,bold);
		}
		
		public function set txt(value:String):void
		{
			ms_Content = value;
		}
		
		public function get txt():String
		{
			return ms_Content;
		}
		
		public function get textFmt():TextFormat
		{
			return ms_txtFmt;
		}
		
		public function set waitTime(value:uint):void
		{
			ms_rollWaitTime = value;	
		}
		
		public function get waitTime():uint
		{
			return ms_rollWaitTime;
		}
		
		public function set speedTime(value:uint):void
		{
			ms_rollSpeedTime = value;	
		}
		
		public function get speedTime():uint
		{
			return ms_rollSpeedTime;
		}
		
		public function set rollStyle(value:String):void
		{
			ms_rollStyle = value;
		}
		
		public function get rollStyle():String
		{
			return ms_rollStyle;
		}
	}
}