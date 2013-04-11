package Extends.CLoader
{
	import flash.display.Loader;
	
	public class CLoaderBase extends Loader
	{
		private var ms_saveData:* = null;
		public function CLoaderBase(saveData:* = null)
		{
			if(saveData)
			{
				ms_saveData = saveData;
			}
			super();
		}
		public function get saveData():*
		{
			return ms_saveData;
		}
	}
}