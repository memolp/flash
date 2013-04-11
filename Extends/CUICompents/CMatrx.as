package Extends.CUICompents
{
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Point;

	public class CMatrx
	{
		public function CMatrx()
		{
		}
		
		static public function HorizontalTurnOver(target:DisplayObject,TurnOver:Boolean=false):void
		{
			var mat:Matrix = new Matrix();
			//var cx:Number = target.x;
			//var cy:Number = target.y;
			if(TurnOver)
			{
				mat.scale(-1,1);
				mat.tx = target.width;
				
			}
			else
			{
				mat.scale(1,1);
			}
			target.transform.matrix = mat;
			//target.x = cx;
			//target.y = cy;
		}
	}
}