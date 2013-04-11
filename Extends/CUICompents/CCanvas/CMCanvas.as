package Extends.CUICompents.CCanvas 
{
	import Extends.CUICompents.CCtrls.CMHScollBar;
	import Extends.CLoader.LoadManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class CMCanvas extends Sprite 
	{
		protected var ms_HScollBar:CMHScollBar =  new CMHScollBar();
		protected var ms_backImage:Bitmap = new Bitmap();
		public function CMCanvas() 
		{
			super();
			this.addChild(ms_backImage);
			//this.onInitCanvas();
		}
		
		protected function onInitCanvas():void
		{
			this.addChild(ms_HScollBar);
		}
		
		public function set bitData(value:BitmapData):void
		{
			ms_backImage.bitmapData = value;
		}
		
		public function set backBmp(value:Bitmap):void
		{
			ms_backImage.bitmapData = value.bitmapData;
		}
		
		public function set backBmpSrc(value:String):void
		{
			LoadManager.LoadSource(value, onLoadBackBmpEnd, null);
		}
		
		private function onLoadBackBmpEnd(evt:Event):void
		{
			this.backBmp = Bitmap(evt.target.content);
		}
	}

}