package Extends.CUICompents 
{
	/**
	 * ...
	 * @author JeffXun
	 */
	public class CMath 
	{
		
		public function CMath() 
		{
			
		}
		/**
		 * 度 转换为 弧度
		 * @param	value
		 * @return
		 */
		public static function DegreesToRadians(value:Number):Number
		{
			return value * Math.PI / 180;
		}
		
		/**
		 * 弧度 转换为 度
		 * @param	value
		 * @return
		 */
		public static function RadiansToDegrees(value:Number):Number
		{
			return value * 180 / Math.PI;
		}
		
		/**
		 * 对 obj进行旋转 之 des方向 即 把物体向某点方向旋转。
		 * @param	desX
		 * @param	desY
		 * @param	objX
		 * @param	objY
		 * @return
		 */
		public static function rotationTo(desX:Number, desY:Number, objX:Number, objY:Number):Number
		{
			return RadiansToDegrees(Math.atan2(desY - objY, desX - objX));
		}
		
		/**
		 * 计算点src到点des的距离 即 两点间距离
		 * @param	srcX
		 * @param	srcY
		 * @param	desX
		 * @param	desY
		 * @return
		 */
		public static function Destance(srcX:Number, srcY:Number, desX:Number, desY:Number):Number
		{
			return Math.sqrt(Math.pow(srcX - desX, 2) + Math.pow(srcY - desY, 2));
		}
	}

}