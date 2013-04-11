package Extends.CUICompents.CCtrls 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	
	/**
	 * 水平滑动条
	 * @author ...
	 */
	public class CMHScollBar extends Sprite 
	{
		protected var ms_leftStepBtn:CMArrowBtn = null;
		protected var ms_rightStepBtn:CMArrowBtn = null;
		protected var ms_scollBtn:CMScollBtn = null;
		protected var ms_width:Number = 0;
		protected var ms_height:Number = 0;
		public function CMHScollBar() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, OnInitBar);
			this.addEventListener(MouseEvent.ROLL_OVER, OnMouseOver);
			this.addEventListener(MouseEvent.ROLL_OUT, OnMouseOut);
		}
		
		/**
		 * 
		 * @param	event
		 */
		private function OnInitBar(event:Event):void
		{
			trace("OnInitBar")
			this.removeEventListener(Event.ADDED_TO_STAGE, OnInitBar);
			if (ms_width == 0)
			{
				ms_width= this.parent.width;
			}
			if (ms_height == 0)
			{
				ms_height = 15;
			}
			trace(this.width, this.height);
			ms_leftStepBtn = new CMArrowBtn(ms_height, ms_height, CMArrowBtn.LEFT_ARROW_BTN);
			ms_rightStepBtn = new CMArrowBtn(ms_height, ms_height, CMArrowBtn.RIGHT_ARROW_BTN);
			ms_scollBtn = new CMScollBtn(ms_width / 2, ms_height);
			
			ms_leftStepBtn.x  = 0;
			ms_rightStepBtn.x = this.width - ms_rightStepBtn.width;
			ms_scollBtn.x = ms_leftStepBtn.x + ms_leftStepBtn.width +1 ;
			this._drawBack(ms_width, ms_height);
			
			this.addChild(ms_leftStepBtn);
			this.addChild(ms_rightStepBtn);
			this.addChild(ms_scollBtn);
		}
		
		/**
		 * 
		 * @param	w
		 * @param	h
		 */
		private function _drawBack(w:Number, h:Number):void
		{
			this.graphics.lineStyle(1, 0x6f6f6f, 0.5);
			this.graphics.beginFill(0x6f6f6f, 0.3);
			this.graphics.drawRect(0, 0, w, h);
			this.graphics.endFill();
		}
		
		protected function OnMouseOver(event:MouseEvent):void
		{
			if (event.currentTarget != this && this.contains(event.currentTarget as DisplayObject))
			{
				event.currentTarget.filters = [new BlurFilter()];
			}
		}
		
		protected function OnMouseOut(event:MouseEvent):void
		{
			if (event.currentTarget != this && this.contains(event.currentTarget as DisplayObject))
			{
				event.currentTarget.filters = [];
			}
		}
		override public function get width():Number 
		{
			return ms_width;
		}
		
		override public function set width(value:Number):void 
		{
			trace("ms_width")
			ms_width = value;
		}
		
		override public function get height():Number 
		{
			return ms_height;
		}
		
		override public function set height(value:Number):void 
		{
			ms_height = value;
		}
	}

}