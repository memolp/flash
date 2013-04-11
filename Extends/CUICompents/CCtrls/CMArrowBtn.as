package Extends.CUICompents.CCtrls 
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	
	/**
	 * ...
	 * @author ...
	 */
	public class CMArrowBtn extends Sprite 
	{
		static public var LEFT_ARROW_BTN:String = "LEFT_ARROW_BTN";
		static public var RIGHT_ARROW_BTN:String = "RIGHT_ARROW_BTN";
		static public var UP_ARROW_BTN:String = "UP_ARROW_BTN";
		static public var DOWN_ARROW_BTN:String = "DOWN_ARROW_BTN";
		public function CMArrowBtn(w:Number,h:Number,style:String="LEFT_ARROW_BTN") 
		{
			super();
			this.addChild(this.DrawArrowRect(w, h));
			switch(style)
			{
				case LEFT_ARROW_BTN:
					this.addChild(this.DrawArrawLeft(w, h));
					break;
				case RIGHT_ARROW_BTN:
					this.addChild(this.DrawArrawRight(w, h));
					break;
				case UP_ARROW_BTN:
					this.addChild(this.DrawArrawUp(w, h));
					break;
				case DOWN_ARROW_BTN:
					this.addChild(this.DrawArrawDown(w, h));
					break;
				default:break;
			}
			this.addEventListener(MouseEvent.ROLL_OVER, OnMouseOver);
			this.addEventListener(MouseEvent.ROLL_OUT, OnMouseOut);
		}
		
		/**
		 * 
		 * @param	w
		 * @param	h
		 * @return
		 */
		protected function DrawArrowRect(w:Number, h:Number):DisplayObject
		{
			var rect:Shape = new Shape();
			rect.graphics.lineStyle(1);
			rect.graphics.drawRect(0, 0, w, h);
			return rect;
		}
		
		/**
		 * 向左箭头
		 * @param	w
		 * @param	h
		 * @return
		 */
		protected function DrawArrawLeft(w:Number, h:Number):DisplayObject
		{
			var arrow:Shape = new Shape();
			arrow.graphics.beginFill(0, 1);
			arrow.graphics.lineStyle(1);
			arrow.graphics.moveTo(w/3,h/2);
			arrow.graphics.lineTo(w*2/3,h/3);
			arrow.graphics.lineTo(w*2/3,h*2/3);
			arrow.graphics.lineTo(w/3,h/2);
			arrow.graphics.endFill();
			return arrow;
		}
		
		/**
		 * 向右箭头
		 * @param	w
		 * @param	h
		 * @return
		 */
		protected function DrawArrawRight(w:Number, h:Number):DisplayObject
		{
			var arrow:Shape = new Shape();
			arrow.graphics.beginFill(0, 1);
			arrow.graphics.lineStyle(1);
			arrow.graphics.moveTo(w/3,h/3);
			arrow.graphics.lineTo(w*2/3,h/2);
			arrow.graphics.lineTo(w/3,h*2/3);
			arrow.graphics.lineTo(w/3,h/3);
			arrow.graphics.endFill();
			return arrow;
		}
		
		/**
		 * 向上箭头
		 * @param	w
		 * @param	h
		 * @return
		 */
		protected function DrawArrawUp(w:Number, h:Number):DisplayObject
		{
			var arrow:Shape = new Shape();
			arrow.graphics.beginFill(0, 1);
			arrow.graphics.lineStyle(1);
			arrow.graphics.moveTo(w*1/3,h*2/3);
			arrow.graphics.lineTo(w*1/2,h*1/3);
			arrow.graphics.lineTo(w*2/3,h*2/3);
			arrow.graphics.lineTo(w*1/3,h*2/3);
			arrow.graphics.endFill();
			return arrow;
		}
		
		/**
		 * 向下箭头
		 * @param	w
		 * @param	h
		 * @return
		 */
		protected function DrawArrawDown(w:Number, h:Number):DisplayObject
		{
			var arrow:Shape = new Shape();
			arrow.graphics.beginFill(0, 1);
			arrow.graphics.lineStyle(1);
			arrow.graphics.moveTo(w*1/3,h*1/3);
			arrow.graphics.lineTo(w*2/3,h*1/3);
			arrow.graphics.lineTo(w*1/2,h*2/3);
			arrow.graphics.lineTo(w*1/3,h*1/3);
			arrow.graphics.endFill();
			return arrow;
		}
		
		protected function OnMouseOver(event:MouseEvent):void
		{
			this.filters = [new GlowFilter(0x000000)];

		}
		
		protected function OnMouseOut(event:MouseEvent):void
		{
			this.filters = [];
		}
	}

}