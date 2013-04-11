package Extends.CGame.MapCtrl
{
	import flash.events.EventDispatcher;
	import flash.display.DisplayObject;
	public class CMapManager extends EventDispatcher
	{
		static protected var s_one_intance:CMapManager = null;
		
		protected var ms_mapCanvas:CMapCanvas = null;
		
		public function CMapManager(cls:CMapCanvas)
		{
			ms_mapCanvas = cls;
		}
		
		/**
		 * 创建地图管理器，传入地图可视的最大范围和缓存的额外范围
		 * @param	viewWidth
		 * @param	viewHeight
		 * @param	exDestance
		 * @return  返回地图管理器对象
		 */
		public static function onCreateMapManager(viewWidth:Number,viewHeight:Number,exDestance:Number):CMapManager
		{
			if (s_one_intance == null)
			{
				//创建地图(地图宽，高分别是可视范围 + 额外显示范围)
				s_one_intance = new CMapManager(new CMapCanvas(viewWidth,viewHeight,exDestance));
			}
			return s_one_intance;
		}
		
		public function onInitMapCanvas(mapTiles:Array,mw:Number,mh:Number):void
		{
			ms_mapCanvas.onSetMapTiles(mapTiles, mw, mh);
		}
		public function addMapCanvas():DisplayObject
		{
			ms_mapCanvas.onDrawMap(0, 0);
			return ms_mapCanvas;
		}
	}
}

import flash.display.DisplayObject;
import flash.display.Shape;
class CMapCanvas extends DisplayObject
{
	protected var ms_mapWidth:Number	=	0;
	protected var ms_mapHeight:Number	=	0;
	protected var ms_viewWidth:Number	=	0;
	protected var ms_viewHeight:Number	=	0;
	protected var ms_exDestance:Number	=	0;
	protected var ms_mapTilesArr:Array  =	[];
	public function CMapCanvas(viewWidth:Number, viewHeight:Number,exDestance:Number)
	{
		ms_viewWidth 	= viewWidth;
		ms_viewHeight 	= viewHeight;
		ms_exDestance 	= exDestance;
	}
	
	public function onSetMapTiles(mapTiles:Array,mapwidth:Number,mapheight:Number):void
	{
		ms_mapTilesArr 	= mapTiles;
		ms_mapWidth  	= mapwidth;
		ms_mapHeight 	= mapheight;
	}
	
	public function onMoveMap(desX:Number, desY:Number):void
	{
		
	}
	
	public function onDrawMap(startX:Number, startY:Number):void
	{
		if (startX - ms_viewWidth < 0 )
		{
			startX = 0;
		}
		
	}
}

class MapTile extends Shape
{
	public var cx:Number	= 	0;
	public var cy:Number	=	0;
	public var id:String	=	"";
	public function MapTile(color:uint)
	{
		this.graphics.clear() ;
		this.graphics.lineStyle(1)
		this.graphics.beginFill(color, 1);
		this.graphics.drawRect( 0, 0, 10, 10);
		this.graphics.endFill();
	}
}