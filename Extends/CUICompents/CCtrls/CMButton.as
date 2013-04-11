package Extends.CUICompents.CCtrls 
{
	import Extends.CUICompents.CText.CMLabel;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author ...
	 */
	public class CMButton extends Sprite 
	{
		protected var ms_Button:SimpleButton;
		protected var ms_Label:CMLabel;
		public function CMButton(upState:DisplayObject, 
				overState:DisplayObject, 
				downState:DisplayObject, 
				hitTestState:DisplayObject) 
		{

			ms_Button = new SimpleButton(upState, overState, downState, hitTestState);
			this.addChild(ms_Button);
		}
		

	}

}