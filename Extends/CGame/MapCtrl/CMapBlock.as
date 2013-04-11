package Extends.CGame.MapCtrl 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	
	/**
	 * 地图元素(用于:场景背景图片tile,动态元素)
	 * 
	 * @author jeffxun
	 */
	dynamic public class CMapBlock extends DisplayObject 
	{
		protected var ms_isCanWalk:Boolean	=	true; //是否是可行走
		protected var ms_isCanJiaoHu:Boolean	=	false;//是否可以交互
		protected var ms_isCanVisible:Boolean		=	true;//是否可以显示
		
		public function CMapBlock() 
		{
			super(null);
		}

		public function set canWalk(bool:Boolean):void
		{
			ms_isCanWalk = bool;
		}
		public function get canWalk():Boolean
		{
			return ms_isCanWalk;
		}
		
		public function set canJiaoHu(bool:Boolean):void
		{
			ms_isCanJiaoHu = bool;
		}
		public function get canJiaoHu():Boolean
		{
			return ms_isCanJiaoHu;
		}
		
		public function set canVisible(bool:Boolean):void
		{
			ms_isCanVisible = bool;
		}
		public function get canVisible():Boolean
		{
			return ms_isCanVisible;
		}
	}

}