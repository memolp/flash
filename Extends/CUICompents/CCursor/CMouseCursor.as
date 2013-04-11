package Extends.CUICompents.CCursor
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import flash.utils.Dictionary;
	
	public class CMouseCursor
	{
		protected static var ms_MouseCursor:ImageCursor = null;
		protected static var ms_stage:Stage = null;
		protected static var ms_MouseStatus:Dictionary = new Dictionary(true);
		
		public function CMouseCursor(imageCursor:ImageCursor)
		{
		}
		
		public static function addCursor(type:String,bit:BitmapData,hotPt:Point):void
		{
			ms_MouseStatus[type] = new ImageCursor(bit,hotPt.x,hotPt.y);
		}

		public static function setCursor(type:String,root:Stage):void
		{
			if(ms_MouseStatus.hasOwnProperty(type))
			{
				Mouse.hide();
				if(ms_MouseCursor)
				{
					if(ms_MouseCursor != ms_MouseStatus[type])
					{
						root.removeChild(ms_MouseCursor);
						ms_MouseCursor = ms_MouseStatus[type];
						root.addChild(ms_MouseCursor);
						root.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
					}
					else
					{
						return;
					}
				}
				else
				{
					ms_MouseCursor = ms_MouseStatus[type];
					root.addChild(ms_MouseCursor);
					root.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
				}
				ms_stage = root;
			}
			
		}
		public static function resetCursor():void
		{
			if(ms_stage && ms_MouseCursor && ms_stage.contains(ms_MouseCursor))
			{
				ms_stage.removeChild(ms_MouseCursor);
				Mouse.show();
				ms_MouseCursor = null;
			}
		}
		
		public static function onMouseMove(evt:MouseEvent):void
		{
			if(ms_MouseCursor)
			{
				ms_MouseCursor.x = evt.stageX;
				ms_MouseCursor.y = evt.stageY;
			}
		}
	}
}
import flash.display.Bitmap;
import flash.display.BitmapData;

class ImageCursor extends Bitmap
{
	private var ms_cx:Number = 0;
	private var ms_cy:Number = 0;
	
	public function ImageCursor(bit:BitmapData,cx:Number,cy:Number)
	{
		super(bit);
		ms_cx = cx;
		ms_cy = cy;
	}

	public override function set x(value:Number):void
	{
		super.x = value + ms_cx;
	}
	public override function set y(value:Number):void
	{
		super.y = value + ms_cy;
	}
}