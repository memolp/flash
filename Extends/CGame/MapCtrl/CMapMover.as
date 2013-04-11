package Extends.CGame.MapCtrl 
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	/**
	 * ...
	 * @author ...
	 */
	public class CMapMover 
	{
		public static const STOP:String	=	"mover_can_not_move";
		public static const MOVE:String	=	"mover_can_move";
		public static const	MOVING:String	=	"mover_is_moving";
		
		protected var ms_mover:DisplayObject;
		protected var ms_desPt:Point;
		protected var ms_speed:Number;
		protected var ms_isRemove:Boolean	=	false;
		protected var ms_isMapMove:Boolean	=	false;
		protected var ms_moveStatus:String	=	CMapMover.STOP;
		public function CMapMover(mapInfo:CMapMoveInfo) 
		{
		}
		
		public function setDesPt(pt:Point):void
		{
			ms_desPt = pt;
			trace("setDesPt",pt,this.moveStatus)
		}
		public function setDesXY(cx:Number, cy:Number):void
		{
			ms_desPt =  new Point(cx, cy);
			trace("setDesXY",cx,cy,this.moveStatus)
		}
		public function get mx():Number
		{
			return ms_mover.x;
		}
		public function get my():Number
		{
			return ms_mover.y;
		}
		public function set mx(value:Number):void
		{
			ms_mover.x = value;
		}
		public function set my(value:Number):void
		{
			ms_mover.y = value;
		}
		public function get dx():Number
		{
			return ms_desPt.x;
		}
		public function get dy():Number
		{
			return ms_desPt.y;
		}
		
		public function get moveSpeed():Number
		{
			return ms_speed;
		}
		public function get isRemove():Boolean
		{
			return ms_isRemove;
		}
		public function set isRemove(bool:Boolean):void
		{
			ms_isRemove = bool;
		}
		public function get isMapMove():Boolean
		{
			return ms_isMapMove;
		}
		public function set isMapMove(bool:Boolean):void
		{
			ms_isMapMove = bool;
		}
		public function set moveStatus(status:String):void
		{
			trace("set_move_status",status)
			ms_moveStatus = status;
		}
		public function get moveStatus():String
		{
			return ms_moveStatus;
		}
	}

}