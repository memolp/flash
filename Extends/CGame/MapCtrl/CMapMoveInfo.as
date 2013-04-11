package Extends.CGame.MapCtrl 
{
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	import Extends.CUICompents.CMath;
	/**
	 * ...
	 * @author ...
	 */
	public class CMapMoveInfo 
	{
		public static const MOVE_LINE:String = "";
		public static const MOVE_POINTS:String = "";
		
		protected var ms_mapCanvas:DisplayObject;
		protected var ms_mapWidth:Number;
		protected var ms_mapHeight:Number;
		protected var ms_viewRect:Rectangle;
		protected var ms_xSpeed:Number;
		protected var ms_ySpeed:Number;
		protected var ms_desX:Number;
		protected var ms_desY:Number;
		protected var ms_srcX:Number;
		protected var ms_srcY:Number;
		protected var ms_Destance:Number;
		protected var ms_moveMethod:String = CMapMoveInfo.MOVE_LINE;
		public function CMapMoveInfo(mapDisplay:DisplayObject,mwidth:Number,mheight:Number) 
		{
			ms_mapCanvas = mapDisplay;
			ms_mapWidth  = mwidth;
			ms_mapHeight = mheight;
		}
		public function get mapWidth():Number
		{
			return ms_mapWidth;
		}
		
		public function get mapHeight():Number
		{
			return ms_mapHeight;
		}
		public function set viewRect(rect:Rectangle):void
		{
			ms_viewRect = rect;
		}
		public function get viewRect():Rectangle
		{
			return ms_viewRect;
		}
		public function set xSpeed(value:Number):void
		{
			ms_xSpeed = value;
		}
		public function set ySpeed(value:Number):void
		{
			ms_ySpeed = value;
		}
		public function set destance(value:Number):void
		{
			ms_Destance = value;
		}
		public function get destance():Number
		{
			return ms_Destance;
		}
		public function get mapCanvas():DisplayObject
		{
			if (!ms_mapCanvas)
			{
				ms_mapCanvas = new DisplayObject();
			}
			return ms_mapCanvas;
		}
		
		public function get mapMoveMode():String
		{
			return ms_moveMethod;
		}
		
		public function set mapMoveMode(value:String):void
		{
			ms_moveMethod = value;
		}
		public function xMove(desX:Number):Boolean
		{
			ms_desX = desX;
			ms_srcX = ms_mapCanvas.x;
			if (ms_desX < ms_viewRect.width * 0.5)
			{
				if (Math.abs(this.mapLeftX()) <= 1)
				{
					return false;
				}
				return true
			}
			else if(ms_desX > ms_viewRect.width * 0.5)
			{
				if (Math.abs(this.mapRightX()) <= 1)
				{
					return false;
				}
				return true
			}
			return false;
		}
		public function yMove(desY:Number):Boolean
		{
			ms_desY = desY;
			ms_srcY = ms_mapCanvas.y;
			if (ms_desY < ms_viewRect.height * 0.5)
			{
				if (Math.abs(this.mapLeftY()) <= 1)
				{
					return false;
				}
				return true
			}
			else if(ms_desY > ms_viewRect.height * 0.5)
			{
				if (Math.abs(this.mapRightY()) <= 1)
				{
					return false;
				}
				return true
			}
			return false;
		}
		
		public function setMove():Boolean
		{
			ms_mapCanvas.x += ms_xSpeed;
			ms_mapCanvas.y += ms_ySpeed;
			return true;
		}
		
		protected function mapCenterX():Number
		{
			return ms_viewRect.x - ms_mapCanvas.x + ms_viewRect.width * 0.5;
		}
		protected function mapCenterY():Number
		{
			return ms_viewRect.y - ms_mapCanvas.y + ms_viewRect.height * 0.5;
		}
		
		protected function mapLeftX():Number
		{
			return ms_viewRect.x - ms_mapCanvas.x;
		}
		protected function mapLeftY():Number
		{
			return ms_viewRect.y - ms_mapCanvas.y;
		}
		
		protected function mapRightX():Number
		{
			return ms_viewRect.x - ms_mapCanvas.x + ms_viewRect.width;
		}
		protected function mapRightY():Number
		{
			return ms_viewRect.y - ms_mapCanvas.y + ms_viewRect.height;
		}
		
	}

}