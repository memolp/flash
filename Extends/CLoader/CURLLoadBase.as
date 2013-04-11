package Extends.CLoader
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class CURLLoadBase extends URLLoader
	{
		private var ms_saveData:* = null;
		public function CURLLoadBase(saveData:* = null)
		{
			if(saveData)
			{
				ms_saveData = saveData;
			}
			super(null);
		}
		
		public function get saveDate():*
		{
			return ms_saveData;
		}
	}
}