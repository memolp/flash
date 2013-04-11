package Extends.CUICompents.CAnimation.CPicList 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author JeffXun
	 */
	public class CMBmpMethod 
	{
		
		public function CMBmpMethod() 
		{
			
		}
		
		static public function splitBmpData(bit:BitmapData, rect:Rectangle):BitmapData
		{
			var bitData:BitmapData = new BitmapData(rect.width, rect.height, true, 0xFFFFFFFF);
		    bitData.copyPixels(bit, rect, new Point(0, 0));
			return bitData;
		}
		
		static public function CAnimationXml(xml:XML):Array
		{
			var ms_LineStyle:Array = new Array();
			for each (var style:XML in xml.children())
			{
				var styleAttr:Object = new Object();
				styleAttr.style = style.@style.toString();
				styleAttr.bitArray = new Array();
				for each (var anima:XML in style.children())
				{
					var rect:Rectangle = new Rectangle(int(anima.@x), int(anima.@y), int(anima.@width), int(anima.@height));
					styleAttr.bitArray.push(rect);
				}
				ms_LineStyle.push(styleAttr);
			}
			return ms_LineStyle;
		}

	}

}