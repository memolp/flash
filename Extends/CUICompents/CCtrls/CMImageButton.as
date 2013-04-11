package Extends.CUICompents.CCtrls
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	
	public class CMImageButton extends Sprite
	{
		private var ms_image:Bitmap = null;
		private var ms_isDown:Boolean = false;
		private var ms_overColor:uint = 0xFFFF00;
		private var ms_downColor:uint = 0xFF0000;
		
		public function CMImageButton(image:Bitmap)
		{
			ms_image= image;
			this.addChild(ms_image);
			this.addEventListener(MouseEvent.ROLL_OVER,OnMouveOver);
			this.addEventListener(MouseEvent.ROLL_OUT,OnMouseOut);
			this.addEventListener(MouseEvent.MOUSE_DOWN,OnMouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP,OnMouseUp);
		}
		private function OnMouveOver(evt:MouseEvent):void
		{
			if(!ms_isDown)
			{
				ms_image.filters = [new GlowFilter(ms_overColor)];
			}
		}
		private function OnMouseOut(evt:MouseEvent):void
		{
			if(!ms_isDown)
			{
				ms_image.filters = [];
			}
		}
		private function OnMouseDown(evt:MouseEvent):void
		{
			ms_image.filters = [new GlowFilter(ms_downColor)];
			ms_isDown = true;
		}
		private function OnMouseUp(evt:MouseEvent):void
		{
			ms_isDown = false;
		}
		
		public function set overColor(value:uint):void
		{
			ms_overColor = value;
		}
		
		public function set downColor(value:uint):void
		{
			ms_downColor = value;
		}
	}
}