package Extends.CUICompents.CText 
{
	/**
	 * ...
	 * @author ...
	 */
	import flash.text.TextFieldType
	
	public class CMInput extends CMLabel
	{
		
		public function CMInput() 
		{
			super();
		}
		
		override protected function onInitCanvas():void 
		{
			super.onInitCanvas();
			
		}
		
		/**
		 * 设置输入框的样式，去掉自动对齐
		 */
		override protected function setLabelTextStyle():void 
		{
			super.setLabelTextStyle();
			ms_text.type  = TextFieldType.INPUT;
			ms_text.mouseEnabled = true;
			ms_text.mouseWheelEnabled = true;
			ms_text.text = "TextInput";
			this.width = this.width;
			this.height = this.height;
			this.setTextNone();
			
		}
		
		/**
		 * 设置允许输入的最大字符数量
		 */
		public function set maxChars(num:Number):void
		{
			ms_text.maxChars = num;
		}
		
		/**
		 * 设置允许输入的字符
		 * 例如:
		 * A-Z|a-z|0-9 允许输入大小写字母和数字
		 * ^A-Z 不允许输入大写字母
		 */
		public function set restrict(value:String):void
		{
			ms_text.restrict = value;
		}
		
		public function set displayAsPassword(value:Boolean):void
		{
			ms_text.displayAsPassword = value;
		}
	}

}