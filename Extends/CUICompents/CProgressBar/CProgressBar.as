package Extends.CUICompents.CProgressBar 
{
	import Extends.CUICompents.CText.CMText;
	import Extends.CEvent.CustomEvent;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author JeffXun
	 */
	public class CProgressBar extends Sprite 
	{
		
		protected var ms_Label:CMText = new CMText();
		protected var ms_Back:Shape   = new Shape();
		private var ms_width:Number = 0;
		private var ms_height:Number = 0;
		private var ms_maxnum:int = 0;
		private var ms_curnum:int = 0;
		private var ms_color:uint = 0x00FF00;
		private var ms_strLabel:String = "";
		public function CProgressBar(width:Number,height:Number,color:uint,maxnum:int,curnum:int) 
		{
			ms_width = width;
			ms_height = height;
			ms_color  = color;
			ms_maxnum = maxnum;
			ms_curnum = curnum;
			this.addChild(ms_Back);
			this.addChild(ms_Label);
			this.addEventListener(Event.ADDED_TO_STAGE, OnAddToStage);
			this.addEventListener("WM_CM_PROGRESS_UPDATE", update);
		}
		
		protected function OnAddToStage(evt:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, OnAddToStage);
			this.dispatchEvent(new CustomEvent("WM_CM_PROGRESS_UPDATE"));
		}
		
		public function set curValue(value:int):void
		{
			ms_curnum = value;
			this.dispatchEvent(new CustomEvent("WM_CM_PROGRESS_UPDATE"));
		}
		
		public function get curValue():int
		{
			return ms_curnum;
		}
		
		public function set maxValue(value:int):void
		{
			ms_maxnum = value;
			this.dispatchEvent(new CustomEvent("WM_CM_PROGRESS_UPDATE"));
		}
		
		public function get maxValue():int
		{
			return ms_maxnum;
		}
		
		public function set Label(value:String):void
		{
			ms_strLabel = value;
			this.dispatchEvent(new CustomEvent("WM_CM_PROGRESS_UPDATE"));
		}
		public function setLabelStyle(font:String=null,color:uint=0,size:int=12,bold:Boolean=false):void
		{
			ms_Label.setTextStyle(font,color,bold,size);
		}
		
		private function update(evt:CustomEvent):void
		{
			
			ms_Label.text = ms_strLabel + ":" + ms_curnum.toString() + "/" + ms_maxnum.toString();
			
			ms_Label.x = (ms_width - ms_Label.width) / 2;
			ms_Label.y = (ms_height - ms_Label.height) / 2;
			
			ms_Back.graphics.clear();
			ms_Back.graphics.beginFill(ms_color,1);
			//ms_Back.graphics.drawRect(0, 0, ms_width * (ms_curnum / ms_maxnum), ms_height);
			//ms_Back.graphics.drawRoundRect(0, 0, ms_width * (ms_curnum / ms_maxnum), ms_height, ms_height, ms_height);
			this.drawProgress(0,0,ms_width * (ms_curnum / ms_maxnum), ms_height, ms_height, ms_height);
			ms_Back.graphics.endFill();
		}
		
		protected function drawProgress(x:Number, y:Number, width:Number, height:Number, swidth:Number, sheight:Number):void
		{
			ms_Back.graphics.drawRoundRect(x, y, width, height, swidth, sheight);
		}
	}

}