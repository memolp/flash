package Extends.CUICompents.CAnimation.CPicList 
{
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author JeffXun
	 */
	public class CPicLists 
	{
		private var ms_picList:Object = new Object();
		private var ms_keyList:Array = new Array();
		public function CPicLists() 
		{
			
		}
		public function appendProperty(key:String,value:Object):void
		{
			ms_picList[key] = value;
			ms_keyList.push(key);
		}
		public function getPicByProperty(key:String):Object
		{
			if (ms_picList.hasOwnProperty(key))
			{
				return ms_picList[key];
			}
			else
			{
				throw new Error("key error");
			}
		}
		public function get keys():Array
		{
			return ms_keyList;
		}
	}

}