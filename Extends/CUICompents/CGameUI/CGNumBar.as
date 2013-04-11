package Extends.CUICompents.CGameUI 
{
	import Extends.CustomApp.CustomEvent;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author JeffXun
	 */
	public class CGNumBar extends Sprite 
	{
		static public const CM_NUMBAR_UPDATE:String = "CM_NUMBAR_UPDATE";
		
		private var ms_maxNum:Number = 0;
		private var ms_minNum:Number = 0;
		private var ms_width:Number  = 100;
		private var ms_height:Number = 2;
		private var ms_pos:Number = 0;
		private var ms_shape:Shape = new Shape();
		private var ms_foreColor:uint = 0xFF0000;
		private var ms_backColor:uint = 0;
		private var ms_visibleBar:Boolean = true;
		public function CGNumBar(maxValue:Number=100,minValue:Number=0) 
		{
			super()
			
			ms_maxNum = maxValue;
			ms_minNum = minValue;
		
			this.addChild(ms_shape);
			this.addEventListener(CM_NUMBAR_UPDATE, update) ;
			this.addEventListener(Event.ADDED_TO_STAGE, OnAddToStage);
		}
		
		private function OnAddToStage(evt:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, OnAddToStage);
			this.dispatchEvent(new CustomEvent(CM_NUMBAR_UPDATE));
		}
		
		public function set maxValue(value:Number):void
		{
			ms_maxNum = value;
			this.dispatchEvent(new CustomEvent(CM_NUMBAR_UPDATE));
		}
		public function get maxValue():Number
		{
			return ms_maxNum;
		}
		public function set minValue(value:Number):void
		{
			ms_minNum = value;
			this.dispatchEvent(new CustomEvent(CM_NUMBAR_UPDATE));
		}
		
		public function set value(val :Number):void
		{
			ms_pos = val;
			this.dispatchEvent(new CustomEvent(CM_NUMBAR_UPDATE));
		}
		
		public function get value():Number
		{
			return ms_pos;
		}
		
		private function update(evt:CustomEvent = null):void
		{
			ms_shape.graphics.clear();
			if (ms_visibleBar)
			{
				ms_shape.graphics.beginFill(ms_backColor, 1);
				ms_shape.graphics.drawRect(0, 0, ms_width, ms_height);
				ms_shape.graphics.endFill();
				ms_shape.graphics.beginFill(ms_foreColor, 1);
				ms_shape.graphics.drawRect(0, 0, ms_width * ms_pos/(ms_maxNum - ms_minNum) , ms_height);
				ms_shape.graphics.endFill();
			}
		}

		public function set NumBarVisible(bool:Boolean):void
		{
			ms_visibleBar = bool;
			this.dispatchEvent(new CustomEvent(CM_NUMBAR_UPDATE));
		}
		
		override public function get width():Number 
		{
			return ms_width;
		}
		
		override public function set width(value:Number):void 
		{
			ms_width = value;
			this.dispatchEvent(new CustomEvent(CM_NUMBAR_UPDATE));
		}
		
		override public function get height():Number 
		{
			return ms_height;
		}
		
		override public function set height(value:Number):void 
		{
			ms_height = value;
			this.dispatchEvent(new CustomEvent(CM_NUMBAR_UPDATE));
		}
		
		public function setLineColor(foreColor:uint, backColor:uint):void
		{
			ms_foreColor = foreColor;
			ms_backColor = backColor;
			this.dispatchEvent(new CustomEvent(CM_NUMBAR_UPDATE));
		}
	}

}