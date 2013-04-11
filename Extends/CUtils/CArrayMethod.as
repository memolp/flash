package Extends.CUtils
{
	public class CArrayMethod
	{
		public function CArrayMethod()
		{
		}
		/**
		 * 根据desArr保存的内容，提取srcArr中不同于desArr的数据创建新的数组返回
		 * key 只有当保存内容为字典时，根据key进行比较
		 */ 
		public static function extractArray(srcArr:Array,desArr:Array,key:String=null):Array
		{
			if(key == null)
			{
				var res:Array = new Array();
				for each(var node:Object in srcArr)
				{
					if(desArr.indexOf(node) == -1)
					{
						res.push(node);
					}
				}
				return res;
			}
			else
			{
				return _extractArrayKey(srcArr,desArr,key);
			}
			return null;
		}
		
		protected static function _extractArrayKey(srcArr:Array,desArr:Array,key:String):Array
		{
			var res:Array = new Array();
			for each(var node:Object in srcArr)
			{
				var find:int = 0;
				for each(var snode:Object in desArr)
				{
					//trace("node.key",node[key],"snode.key",snode[key]);
					if(node[key] == snode[key])
					{
						find = 1;
						break;
					}
				}
				if(find == 0)
				{
					res.push(node);
				}
			}
			return res;
		}
	}
}