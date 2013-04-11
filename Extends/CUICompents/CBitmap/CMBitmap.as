package Extends.CUICompents.CBitmap
{
	import Extends.CLoader.CMLoader;
	import Extends.CLoader.CMLoaderMethod;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	public class CMBitmap extends Bitmap
	{
		private var ms_source:String = null;
		public function CMBitmap(src:String=null,cx:Number=0,cy:Number=0,cwidth:Number=1,cheight:Number=1)
		{
			var bit:BitmapData = new BitmapData(cwidth,cheight,true,0);
			super(bit);
			if(src)
			{
				this.source = src;
			}
			this.x = cx;
			this.y = cy;
		}
		
		private function OnLoadImageEnd(loadinfo:*):void
		{
			//trace("OnLoadImageEnd",loadinfo.url,this.x,this.y);
			var bit:BitmapData = CMLoader.CLoader.onGetBitData(ms_source);
			if(bit)
			{
				this.bitmapData = bit;
			}
		}
		
		public function set source(value:String):void
		{
			if(value)
			{
				ms_source = value;
				//trace("source",value);
				CMLoader.CLoader.startLoadsrc(value,CMLoaderMethod.LOAD_IMAGE,OnLoadImageEnd);
			}
			else
			{
				throw new Error("image url not empty");
			}
		}
		public function get source():String
		{
			return ms_source;
		}
		
		/*[Bindable]
		public override function get bitmapData():BitmapData
		{
			return super.bitmapData;
		}
		
		public override function set bitmapData(value:BitmapData):void
		{
			super.bitmapData = value;	
		}*/
	}
}
