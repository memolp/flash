package Extends.CUICompents.CCtrls 
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	/**
	 * ...
	 * @author ...
	 */
	public class CMScollBtn extends CMButton 
	{
		
		protected var ms_mouseDown:Boolean = false;
		public function CMScollBtn(w:Number,h:Number) 
		{
			var state:DisplayObject = this.upState(w, h);
			var state1:DisplayObject = this.overState(w, h);
			super(state, state1, state, state);
			this.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, OnMouseUp);
			this.addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove);
		}
		
		private function OnMouseDown(event:MouseEvent):void
		{
			ms_mouseDown = true;
		}
		
		private function OnMouseUp(event:MouseEvent):void
		{
			ms_mouseDown = false;
		}
		
		private function OnMouseMove(event:MouseEvent):void
		{
			if (ms_mouseDown)
			{
				
			}
		}
		
		/**
		 * 
		 * @param	w
		 * @param	h
		 * @return
		 */
		protected function upState(w:Number,h:Number):DisplayObject
		{
			var rect:Shape = new Shape();
			rect.graphics.lineStyle(1);
			rect.graphics.drawRect(0, 0, w, h);
			return rect;
		}
		
		/**
		 * 
		 * @param	w
		 * @param	h
		 * @return
		 */
		protected function overState(w:Number, h:Number):DisplayObject
		{
			var rect:Shape = new Shape();
			rect.graphics.lineStyle(1);
			rect.graphics.drawRect(0, 0, w, h);
			rect.filters = [new GlowFilter()];
			return rect;
		}
	}

}