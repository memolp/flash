package Extends.CUtils
{
	public class CDateTime
	{
		public function CDateTime()
		{
		}
		
		public static function get LocalTime():Number
		{
			var date:Date = new Date();
			return date.getTime();
		}
	}
}