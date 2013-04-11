package Extends.CUICompents.CCtrls 
{
	import Extends.CUICompents.CText.CMLabel;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author ...
	 */
	public class CMLinkBtn extends CMLabel 
	{
		
		public function CMLinkBtn() 
		{
			super("Linkbar");
		}
		
		override protected function onInitCanvas():void 
		{
			super.onInitCanvas();
			
		}
		
		override protected function setLabelTextStyle():void 
		{
			super.setLabelTextStyle();
			ms_text.background = false;
			ms_text.border = false;
			this.buttonMode = true;
			this.useHandCursor = true;
		}
	}

}