package Extends.CUICompents.CText 
{
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	/**
	 * ...
	 * @author ...
	 */
	public class CMLabel extends CMText
	{
		private var ms_filer:GlowFilter;
		public function CMLabel(label:String="") 
		{
			super();
			if (text)
			{
				this.text = label;
			}
		}
		
		/**
		 * 设置Label的属性
		 */
		override protected function onInitCanvas():void 
		{
			super.onInitCanvas();
			this.setLabelTextStyle();
		}
		
		/**
		 * 设置背景色
		 */
		public function set backgroundColor(color:uint):void
		{
			ms_text.backgroundColor = color;
		}
		
		/**
		 * 获取背景色
		 */
		public function get backgroundColor():uint
		{
			return ms_text.backgroundColor;
		}
		
		/**
		 * 设置边框颜色
		 */
		public function set borderColor(color:uint):void
		{
			ms_text.borderColor = color;
		}
		
		/**
		 * 获取边框颜色
		 */
		public function get borderColor():uint
		{
			return ms_text.borderColor;
		}
		
		/**
		 * 设置Label的默认样式
		 */
		protected function setLabelTextStyle():void
		{
			ms_text.background = true;
			ms_text.border = true;
			ms_text.mouseEnabled = false;
			ms_text.mouseWheelEnabled = false;
			ms_text.text = "Label";
		}
		
		public function setMouseStatus(color:uint = 0xFF0000):void
		{
			ms_filer = new GlowFilter(color,1,6,6,2,1,true);
			this.addEventListener(MouseEvent.ROLL_OVER, OnMouseOver);
			this.addEventListener(MouseEvent.ROLL_OUT, OnMouseOut);
		}
		
		private function OnMouseOver(evt:MouseEvent):void
		{
			this.filters = [ms_filer];
		}
		
		private function OnMouseOut(evt:MouseEvent):void
		{
			this.filters = [];
		}
	}

}