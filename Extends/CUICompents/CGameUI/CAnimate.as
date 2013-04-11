package Extends.CUICompents.CGameUI
{
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.utils.Dictionary;

	public class CAnimate
	{
		private var ms_AnimateList:Dictionary = new Dictionary(true);
		private var ms_defaultAnimate:* = new Shape();
		public function CAnimate()
		{
		}
		public function addAnimate(type:String,animate:*):void
		{
			if(ms_AnimateList.hasOwnProperty(type))
			{
				delete ms_AnimateList[type];
			}
			ms_AnimateList[type] = animate;
		}
		public function getAnimate(type:String,isHTurn:Boolean=false,isVTurn:Boolean=false):*
		{
			if(ms_AnimateList.hasOwnProperty(type))
			{
				return this.HorizontalTurnOver(ms_AnimateList[type],isHTurn);
			}
			else
			{
				trace("not ms_defaultAnimate")
				return ms_defaultAnimate;
			}
		}
		public function setDefaultAnimate(animate:*):void
		{
			ms_defaultAnimate = animate;
		}
		
		protected function HorizontalTurnOver(animate:*,isHTurn:Boolean):*
		{
			var mat:Matrix = new Matrix();
			if(isHTurn)
			{
				mat.scale( -1, 1);
				mat.tx = animate.width;
			}
			else
			{
				mat.scale( 1, 1);
			}
			animate.transform.matrix = mat;
			return animate;
		}
		
	}
}