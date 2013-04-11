package Extends.CUICompents.CCanvas 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author JeffXun
	 */
	public class CMIcon extends Sprite 
	{
		
		public function CMIcon(bit:Bitmap) 
		{
			this.addChild(bit);
			this.mouseChildren = false;
		}
		
	}

}