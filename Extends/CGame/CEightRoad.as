package Extends.CGame 
{
	/**
	 * ...
	 * @author ...
	 */
	public class CEightRoad 
	{
		protected var ms_openList:Array	= []
		protected var ms_closeList:Array = []
		
		protected var ms_mapData:Object;
		public function CEightRoad(MapInfo:Object) 
		{
			ms_mapData = MapInfo;
		}
		
		public function getRoad(startX:Number, startY:Number, endX:Number, endY:Number):Array
		{
			var currentRoad:roadNode = ms_mapData[startX][startY];
			ms_openList.push(currentRoad);
			currentRoad.open = true;
			while (!this.isEnd())
			{
				
			}
		}
		
		protected function onGroundRoad()
		
		protected function isEnd():Boolean
		{
			return false;
		}
	}

}

class roadNode
{
	protected var ms_isOpen:Boolean = false;
	public function roadNode()
	{
		
	}
	public function get open():Boolean
	{
		return ms_isOpen;
	}
	public function set open(bool:Boolean):void
	{
		ms_isOpen = bool;
	}
}