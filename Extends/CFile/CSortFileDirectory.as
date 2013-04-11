package Extends.CFile
{
	import flash.filesystem.File;

	public class CSortFileDirectory
	{
		private static var ms_instance:CSortFileDirectory = null;
		public function CSortFileDirectory(cls:privateClass)
		{
		}
		
		static public function get instance():CSortFileDirectory
		{
			if(!CSortFileDirectory.ms_instance)
			{
				CSortFileDirectory.ms_instance = new CSortFileDirectory(new privateClass());
			}
			return CSortFileDirectory.ms_instance;
		}
		
		public function seekFile(path:String,filetype:Array):Array
		{
			var file:File = new File(path);
			return _seek(file.getDirectoryListing(),filetype);
		}
		
		private function _seek(dictArray:Array,filetype:Array):Array
		{
			var res:Array = new Array();
			for(var i:uint = 0;i<dictArray.length;i++)
			{
				var file:File = dictArray[i];
				var obj:Object = new Object();
				if(file.isDirectory)
				{
					obj.name = file.name;
					obj.isFolder = 1;
					//obj.extension =file.extension;
					var dict:Array = file.getDirectoryListing();
					var list:Array = _seek(dict,filetype);
					if(list.length>0)
					{
						obj.children = list;
						res.push(obj);
					}
				}
				else
				{
					if(filetype.indexOf(file.extension) != -1)
					{
						//trace(file.name,file.size,file.nativePath);
						obj.isFolder = 0;
						obj.name = file.name;
						obj.src  = file.nativePath;
						obj.extension =file.extension;
						res.push(obj);
					}
				}
			}
			//trace(res.toString());
			return res;
		}
		
	}
}
class privateClass
{
	
}